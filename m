Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358FC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC7020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9jCNbAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC7020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967221AbeFSUK7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:10:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41353 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966695AbeFSUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:10:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so359276pgl.8;
        Tue, 19 Jun 2018 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gRCrZ0q1kLRuLWZyGmcEl8XBBXPaF8yR8s0LnK5blw=;
        b=X9jCNbAE8SnLKao3vbemdQJJAK5Hk8wnC8SY3uEOkIJRRJhbI9gCCvLDUDJfU00VnY
         nY9vZ9YENQnTYbSILeMnXjSbFo75TeMZ/hR6tAVNNWlXz6vdKpVh8JACj1ysUtZiPVnN
         sTWbQeLqBGam5cve21NuxGT8mhrHBE+JZ8QcD7EP6Nml9opwjBSPC3JJd7YcAwwcB6Vk
         3UCpWIigVU1MGkKY3556wtPz30hKvVSqcf01nnFJcJOHdhZ2LDuDn9OLpa25i7/Jyxbw
         DpKIjPvEqKWh3GxVhYzTQjvP3TKw9Y3SDA48PL0nFXnVutKGHOd4FS1Eu+Z6NFFftHhB
         +6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gRCrZ0q1kLRuLWZyGmcEl8XBBXPaF8yR8s0LnK5blw=;
        b=bruIQ1NcphIy1w4QxUg2DqNIYlfR19+y1+pcS2W2tUrxrV10MdeliuqQhPZxrJZ4ed
         D2RZH5lUNfLgWrin+BRXHZcgmCg4Ecs7EtZhw9kusa0M3qusw5CG5PeLx3XHDR7bgG7F
         0lUkE8/LIZgXu6JjaeVC/YWXXDilaf9/beRtx7P/KGGJWks5x8M/xUsbNIAdx63+Db6Q
         EN6w4DzjcV4VT1oy3+D0Q0o2XuxXEF/4t9Nw0r4iQyQ5+ICOJlbSAmswaCafhE7Lkj6Y
         2158QoORdHhxkRjS2saIMTKlftYma2eFg0NYoElAyXQvMXIMa5JcODHTvchivhf19Pvv
         8/rA==
X-Gm-Message-State: APt69E139qi2Qb2hGVzuhM7M/5hkACzXc2ucP21srVFzQZ02N8Ps/ZgH
        wtM7ziKlG2U6YDilOrcthkPk9+Pj
X-Google-Smtp-Source: ADUXVKLsJa5oLQbQObXof9Ez55x3dTOx5cowJK/tIbpmFLwEqhxBakLS5HhhY4NacmEYoseT7E4N9w==
X-Received: by 2002:a65:62d9:: with SMTP id m25-v6mr15872107pgv.371.1529439057266;
        Tue, 19 Jun 2018 13:10:57 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 76-v6sm654093pfr.172.2018.06.19.13.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 13:10:56 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
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
 <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
 <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com> <87po0mvbgl.fsf@igel.home>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e1790720-911b-4d04-2215-752ec612e3d7@gmail.com>
Date:   Tue, 19 Jun 2018 13:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87po0mvbgl.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 12:10 PM, Andreas Schwab wrote:
> On Jun 18 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> DUMP_PREFIX_ADDRESS might give us more information (say alignment problem, or crossing page boundaries)
> 
> DUMP_PREFIX_ADDRESS is useless for that purpose.
> 
> Here are some samples of broken csums:
> 
> [  853.849225] sungem: sungem wrong csum : 9886/07be, len 94 bytes, c0000001fa187e02
> [  853.849232] raw data: 00000000: 00 0d 93 43 81 62 18 d6 c7 51 b8 1c 08 00 45 10  ...C.b...Q....E.
> [  853.849235] raw data: 00000010: 00 4c cb a0 40 00 40 11 d9 97 c0 a8 0a 01 c0 a8  .L..@.@.........
> [  853.849237] raw data: 00000020: 0a 07 00 7b 00 7b 00 38 69 e1 1c 03 0c f7 00 00  ...{.{.8i.......
> [  853.849240] raw data: 00000030: 08 f0 00 00 15 f0 c0 35 67 67 de d3 ca c9 d9 5b  .......5gg.....[
> [  853.849242] raw data: 00000040: 1f ff de d3 d2 86 8f 67 fa f2 de d3 d2 86 8f 38  .......g.......8
> [  853.849244] raw data: 00000050: 2f ff de d3 d2 86 8f 3b ff ff d1 93 bc 50        /......;.....P

Thanks.

4 bytes in excess.

Might be the FCS, and it does not look like provided csum has a relation with it.

For some reason FCS stripping was disabled by :

commit 3e32011d4da6424b3bc65b1e1a047e30ac9882c7
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon May 19 09:39:11 2003 -0700

    [SUNGEM]: Updates from PowerPC people.
    
    Support more chips and split out all the complex PHY
    handling into a seperate file.


Since this NIC never had CHECKSUM_COMPLETE support (since we have to trim each skb,
thus were forcing ip_summed to CHECKSUM_NONE) we probably should remove it and be happy.

Unless you guys find a way to let the NIC strip the FCS, and double check the csum is a real csum ;)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..85439308375e95c3854e4a1561697d69ec85399b 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -760,7 +760,6 @@ static int gem_rx(struct gem *gp, int work_to_do)
        struct net_device *dev = gp->dev;
        int entry, drops, work_done = 0;
        u32 done;
-       __sum16 csum;
 
        if (netif_msg_rx_status(gp))
                printk(KERN_DEBUG "%s: rx interrupt, done: %d, rx_new: %d\n",
@@ -855,9 +854,6 @@ static int gem_rx(struct gem *gp, int work_to_do)
                        skb = copy_skb;
                }
 
-               csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
-               skb->csum = csum_unfold(csum);
-               skb->ip_summed = CHECKSUM_COMPLETE;
                skb->protocol = eth_type_trans(skb, gp->dev);
 
                napi_gro_receive(&gp->napi, skb);

