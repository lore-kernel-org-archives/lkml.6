Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB303C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741492081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741492081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeLKAGN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:06:13 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:59229 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeLKAGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:06:12 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wBB02c1M027846
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 09:02:38 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wBB02cti013400;
        Tue, 11 Dec 2018 09:02:38 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wBB01p4H002374;
        Tue, 11 Dec 2018 09:02:38 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-513664; Tue, 11 Dec 2018 09:00:51 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Tue,
 11 Dec 2018 09:00:50 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "chansen3@cisco.com" <chansen3@cisco.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "rientjes@google.com" <rientjes@google.com>
Subject: Re: [PATCH] tools/vm/page-types.c: fix "kpagecount returned fewer
 pages than expected" failures
Thread-Topic: [PATCH] tools/vm/page-types.c: fix "kpagecount returned fewer
 pages than expected" failures
Thread-Index: AQHUjB+8Q0loeO8VgkakJeKYQ9HUO6V4GgaA
Date:   Tue, 11 Dec 2018 00:00:49 +0000
Message-ID: <20181211000049.GA19806@hori1.linux.bs1.fc.nec.co.jp>
References: <1543962269-26116-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1543962269-26116-1-git-send-email-anthony.yznaga@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E8B28FAEE810064EA748D114065562DB@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:24:29PM -0800, Anthony Yznaga wrote:
> Because kpagecount_read() fakes success if map counts are not being
> collected, clamp the page count passed to it by walk_pfn() to the pages
> value returned by the preceding call to kpageflags_read().
> 
> Fixes: 7f1d23e60718 ("tools/vm/page-types.c: include shared map counts")
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  tools/vm/page-types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
> index 37908a83ddc2..1ff3a6c0367b 100644
> --- a/tools/vm/page-types.c
> +++ b/tools/vm/page-types.c
> @@ -701,7 +701,7 @@ static void walk_pfn(unsigned long voffset,
>  		if (kpagecgroup_read(cgi, index, pages) != pages)
>  			fatal("kpagecgroup returned fewer pages than expected");
>  
> -		if (kpagecount_read(cnt, index, batch) != pages)
> +		if (kpagecount_read(cnt, index, pages) != pages)
>  			fatal("kpagecount returned fewer pages than expected");
>  
>  		for (i = 0; i < pages; i++)
> -- 
> 1.8.3.1
> 
> 
