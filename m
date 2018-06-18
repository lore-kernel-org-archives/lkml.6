Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32721C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF62620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRA1rscO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF62620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937012AbeFRX3R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:29:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38307 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbeFRX3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:29:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so8244334pgf.5;
        Mon, 18 Jun 2018 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBspoApW8op0Gz/z7wQnmvhFQ4ZJzRfQZdiyva1ko1w=;
        b=uRA1rscOjaaZWED/1dRIA84/BbzUZquJx1x4FBMsWvA0y10oa6AaYrjvifG9gQMSKI
         EYwdAWLmklBkLkJogxW2niN+JI1aqfOZpGyej5quGOvxZ58PnEwSVBRd3HRCDHnqgV2c
         A8rGFhTKcs+zxTWES0cKPLDjjF/z5DgiLVk2+70E5Mas2uEzVjOfPT5ElVEdimRe7smP
         D6ZbZ43VES+O1gK1O8z8p2SxIIYF2fq3lROFLEgtNUCiVmUcc8lsnOslN7SU1drDVPHQ
         lP9VyZqqVe1oJCoyc3oVAuKTBeWSJY0nyxpyv47Z7XmuA3gmcCE3ikav0232IABOBRba
         w18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBspoApW8op0Gz/z7wQnmvhFQ4ZJzRfQZdiyva1ko1w=;
        b=Yqo7p7Skx5VuuDTT5dDT0wOJf2Z5Cin4okdI4D7M8Isy5PaAZRtNap90XAN+NHnbM0
         T7Q1331Y05gPt8dxLqESRF7b8cUGZuX6+tDw2iDMMd7XvT45NeEK6dzkbWa8Vqh2veMy
         cSbTwHas6VQIkp8qFiga9fQTCyJfE2VcCGhdOJenc/lfcKE7zwmW7YIez6HDRkWJr6/7
         GfQgbx47J5YpULNnAr3UX1ZartazapaC8Ny8ViTg/RuNrK0PFnwwcMQV4yrMaPvk+R1C
         +EYSg0u7OrX48TWZnQGFoPODd7p1pr1Kr2Lbat5pO7RUmuYEZgCpZjImMghw36edmiiT
         Cosw==
X-Gm-Message-State: APt69E3u6rvTEoCLr1Qih7uZonJVi9AWK2z+Nr4pz1eshe7kDlaALNZf
        S7tap3/saeX7OkijLwZuhxhN3ndm
X-Google-Smtp-Source: ADUXVKJQOIEaEcRrEpsi0nDxfHvKyoKWTStSelvhaZBhJt3G/1V9cVMtRW4M6URaHUJ24FQ1QnE4Qg==
X-Received: by 2002:a62:a09c:: with SMTP id p28-v6mr15619460pfl.9.1529364554647;
        Mon, 18 Jun 2018 16:29:14 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id r11-v6sm28585861pfb.139.2018.06.18.16.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:29:13 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Mathieu Malaterre <malat@debian.org>
Cc:     schwab@linux-m68k.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, netdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> <87o9g8geu0.fsf@igel.home>
 <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
 <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
Date:   Mon, 18 Jun 2018 16:29:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/18/2018 11:45 AM, Mathieu Malaterre wrote:

> 
> Here is what I get on my side
> 
> [   53.628847] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
> [   53.667063] sungem: sungem wrong csum : eea8/6eec, len 149 bytes
> [   58.648952] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
> [   58.669414] sungem: sungem wrong csum : 5245/b50, len 149 bytes
> [   63.674451] sungem: sungem wrong csum : 2d8/5abd, len 149 bytes
> [   68.678233] sungem: sungem wrong csum : b8fc/a498, len 149 bytes
> [   73.685771] sungem: sungem wrong csum : 374/5a21, len 149 bytes
> [   78.689089] sungem: sungem wrong csum : d81/5014, len 149 bytes
> [   83.683261] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
> [   83.690193] sungem: sungem wrong csum : c2f7/9a9d, len 149 bytes
> [   88.692511] sungem: sungem wrong csum : f4d8/68bc, len 149 bytes
> [   93.699915] sungem: sungem wrong csum : 1370/4a25, len 149 bytes
> [   98.703136] sungem: sungem wrong csum : e1b5/7bdf, len 149 bytes
> [  103.704230] sungem: sungem wrong csum : 5321/a74, len 149 bytes
> [  108.688912] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
> [  108.706559] sungem: sungem wrong csum : ddbc/7fd8, len 149 bytes
> [  113.713189] sungem: sungem wrong csum : 5a65/330, len 149 bytes
> [  113.891697] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
> [  118.717151] sungem: sungem wrong csum : f7c8/65cc, len 149 bytes
> [  123.722680] sungem: sungem wrong csum : 3d7a/201b, len 149 bytes
> [  128.726524] sungem: sungem wrong csum : c8fd/9497, len 149 bytes
> [  133.732045] sungem: sungem wrong csum : de0d/7f87, len 149 bytes
> [  135.529163] sungem: sungem wrong csum : 3089/b6dd, len 96 bytes
> [  135.529208] eth0: hw csum failure
> [  135.529220] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #7
> [  135.529226] Call Trace:
> [  135.529243] [dffedbe0] [c069ddac]
> __skb_checksum_complete+0xf0/0x108 (unreliable)

Thanks, then I guess next step would be to dump the content of the frames
having a wrong checksum, hoping we find an easy way to discard the CHECKSUM_COMPLETE
in a selective way.

Otherwise, we will need to remove CHECKSUM_COMPLETE setting in this driver.

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..77a761f95be788bb86c8d917f613c9084818f826 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -857,6 +857,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
 
                csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
                skb->csum = csum_unfold(csum);
+               {
+               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
+               if (csum != csum_fold(rsum) && net_ratelimit())
+                       pr_err("sungem wrong csum : %04x/%04x, len %u bytes\n",
+                               csum, csum_fold(rsum), len);
+                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,
+                                           16, 1, skb->data, len, true);
+               }
                skb->ip_summed = CHECKSUM_COMPLETE;
                skb->protocol = eth_type_trans(skb, gp->dev);
 

