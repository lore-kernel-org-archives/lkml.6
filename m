Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E65ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4EA214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4EA214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIQRZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbeIQRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:25:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 347ED8762B;
        Mon, 17 Sep 2018 11:58:40 +0000 (UTC)
Received: from o.ww.redhat.com (ovpn-204-160.brq.redhat.com [10.40.204.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE27677E84;
        Mon, 17 Sep 2018 11:58:32 +0000 (UTC)
Subject: Re: [dm-devel] [PATCH] dm raid: Remove bogus const from
 decipher_sync_action() return type
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20180917080234.10909-1-geert@linux-m68k.org>
From:   Heinz Mauelshagen <heinzm@redhat.com>
Message-ID: <3623d6d7-a94f-2a35-83a9-dd475136d936@redhat.com>
Date:   Mon, 17 Sep 2018 13:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917080234.10909-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 17 Sep 2018 11:58:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the compiler is right to warn about a meaningless 'const' return by 
value.

Acked-by: Heinz Mauelshagen <heinzm@redhat.com>


On 09/17/2018 10:02 AM, Geert Uytterhoeven wrote:
> With gcc-4.1.2:
>
>      drivers/md/dm-raid.c:3357: warning: type qualifiers ignored on function return type
>
> Remove the "const" keyword to fix this.
>
> Fixes: 36a240a706d43383 ("dm raid: fix RAID leg rebuild errors")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drivers/md/dm-raid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 5ba067fa0c729bc8..c44925e4e4813d24 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3353,7 +3353,7 @@ static const char *sync_str(enum sync_state state)
>   };
>   
>   /* Return enum sync_state for @mddev derived from @recovery flags */
> -static const enum sync_state decipher_sync_action(struct mddev *mddev, unsigned long recovery)
> +static enum sync_state decipher_sync_action(struct mddev *mddev, unsigned long recovery)
>   {
>   	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
>   		return st_frozen;
