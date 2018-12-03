Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE42C64EB4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD672145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD672145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLCAsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:48:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbeLCAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 401483082125;
        Mon,  3 Dec 2018 00:48:52 +0000 (UTC)
Received: from redhat.com (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3178C1019630;
        Mon,  3 Dec 2018 00:48:50 +0000 (UTC)
Date:   Sun, 2 Dec 2018 19:48:49 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mm/hmm: remove set but not used variable 'devmem'
Message-ID: <20181203004848.GA21092@redhat.com>
References: <1543629971-128377-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543629971-128377-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 03 Dec 2018 00:48:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 02:06:11AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> mm/hmm.c: In function 'hmm_devmem_ref_kill':
> mm/hmm.c:995:21: warning:
>  variable 'devmem' set but not used [-Wunused-but-set-variable]
> 
> It not used any more since commit 35d39f953d4e ("mm, hmm: replace
> hmm_devmem_pages_create() with devm_memremap_pages()")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/hmm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 50fbaf8..361f370 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -992,9 +992,6 @@ static void hmm_devmem_ref_exit(void *data)
>  
>  static void hmm_devmem_ref_kill(struct percpu_ref *ref)
>  {
> -	struct hmm_devmem *devmem;
> -
> -	devmem = container_of(ref, struct hmm_devmem, ref);
>  	percpu_ref_kill(ref);
>  }
> 
> 
> 
