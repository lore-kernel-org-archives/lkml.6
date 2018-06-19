Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20623C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3C7204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTQ2AZpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3C7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeFSWlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:41:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37420 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFSWlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:41:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so565122pfn.4;
        Tue, 19 Jun 2018 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+N14IqHj1JWJbTCF4/bBR+wUorZz0gsx/CWimG9i/Jc=;
        b=vTQ2AZpVLAQowc5U9qSGXMp/DMkzaGSZdo1lNOO+DngXbN+yvfPGaqe/OvnWNiD8r2
         QlWZDMqNIl/o1sA+eN0l41H9t5bmjLaICdnUH9JM64jImHkw3P2l3rzzKf6i7h5w5CnN
         4qaQ7lldFK6H3O8D2kOz/rbuoi+leloREXkzZaEOtRyNo759dbFCRKSpiFYX6BxGY4Bw
         y1zcgGPs1tkKxuqLiUNUL/GgQ4LbFCvxLgv2OyeaLMu7aXZ2ydEfRMbu5iURbeJo8Pmw
         9dA8WH3ILdz8LHocyv7t5lSJmngN4V3TOn256URUrND3OLG+4KbPtxDqPdcC+0hwTSyl
         IJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+N14IqHj1JWJbTCF4/bBR+wUorZz0gsx/CWimG9i/Jc=;
        b=GI8fv4IqZNnWqbHrmjOPPPRbPCohi3b536ia12Lf2Na1Lv8EaDM8/LVDyWREvQGZ0L
         FqNKWVbKkSZ9a0yW6vqUpiidTDrkrvj/17gSbC5E8HAf8xRQIPljmpIEqyMySbCispP5
         SZFO97dLeOLh3OHO9IEfF1gMGLxohE/JhOMM48U2wNrTRUIeGBG6kaCdKCx6SORcV2bD
         /8k9u6kq+H/4yU4gNvNUF7gclHFYPCm+2w3NMiea57diRTa3zCD6mte1Qs9ow2iRAXkR
         QyqzjKNeukqhS2EkgNqoH9J8Ede8xBRHO+y+mvn6FEbdE7Hvc8cwevK9RWOGfDG3iSnf
         7+Ww==
X-Gm-Message-State: APt69E18qmPZsbnGbrHD5kokRCDJl5riedmlkZQoQvzlvlg+PYQYjdVn
        uJWJ0nJavgTGGKgX4r4zUAk=
X-Google-Smtp-Source: ADUXVKLDnHthNrRTL1qWynkUmFF0LfvTUsUIt1wSHmIIJp83ITw7fpbCrB/PxwRmAv0tG0qhe68BJg==
X-Received: by 2002:a63:6b84:: with SMTP id g126-v6mr16489664pgc.139.1529448060440;
        Tue, 19 Jun 2018 15:41:00 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id k10-v6sm1081931pfj.29.2018.06.19.15.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:40:59 -0700 (PDT)
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
 <e1790720-911b-4d04-2215-752ec612e3d7@gmail.com>
 <05645b90-d3bc-466d-116f-548f3ee39de9@gmail.com> <87lgbav24y.fsf@igel.home>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <03721d75-8705-b1f1-af30-388d36512be6@gmail.com>
Date:   Tue, 19 Jun 2018 15:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87lgbav24y.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 03:32 PM, Andreas Schwab wrote:
> On Jun 19 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
>> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..672d6748ab44f0890e92d5ca55d6ff6834c20dc9 100644
>> --- a/drivers/net/ethernet/sun/sungem.c
>> +++ b/drivers/net/ethernet/sun/sungem.c
>> @@ -60,8 +60,7 @@
>>  #include <linux/sungem_phy.h>
>>  #include "sungem.h"
>>  
>> -/* Stripping FCS is causing problems, disabled for now */
>> -#undef STRIP_FCS
>> +#define STRIP_FCS
>>  
>>  #define DEFAULT_MSG    (NETIF_MSG_DRV          | \
>>                          NETIF_MSG_PROBE        | \
>> @@ -435,7 +434,7 @@ static int gem_rxmac_reset(struct gem *gp)
>>         writel(desc_dma & 0xffffffff, gp->regs + RXDMA_DBLOW);
>>         writel(RX_RING_SIZE - 4, gp->regs + RXDMA_KICK);
>>         val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
>> -              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
>> +              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
>>         writel(val, gp->regs + RXDMA_CFG);
>>         if (readl(gp->regs + GREG_BIFCFG) & GREG_BIFCFG_M66EN)
>>                 writel(((5 & RXDMA_BLANK_IPKTS) |
>> @@ -857,6 +856,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
>>  
>>                 csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
>>                 skb->csum = csum_unfold(csum);
>> +               {
>> +               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
>> +               if (csum != csum_fold(rsum) && net_ratelimit())
>> +                       pr_err("sungem wrong csum : %x/%x, len %u bytes\n",
>> +                               csum, csum_fold(rsum), len);
>> +                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,
>> +                                           16, 1, skb->data, len, true);
>> +               }
>>                 skb->ip_summed = CHECKSUM_COMPLETE;
>>                 skb->protocol = eth_type_trans(skb, gp->dev);
>>  
>> @@ -1761,7 +1768,7 @@ static void gem_init_dma(struct gem *gp)
>>         writel(0, gp->regs + TXDMA_KICK);
>>  
>>         val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
>> -              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
>> +              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
>>         writel(val, gp->regs + RXDMA_CFG);
>>  
>>         writel(desc_dma >> 32, gp->regs + RXDMA_DBHI);
> 
> With that patch I still get the wrong csum messages, but no longer the
> hw csum failure messages (tested on a PowerMac G5).
> 
> [  662.659767] sungem: sungem wrong csum : 8359/7ca6, len 86 bytes, c0000001fee9cc02
> [  662.659775] raw data: 00000000: 00 0d 93 43 81 62 d4 3d 7e 4c 48 b7 86 dd 61 01  ...C.b.=~LH...a.
> [  662.659778] raw data: 00000010: 1c 1e 00 20 06 40 20 01 0a 62 17 11 88 01 00 00  ... .@ ..b......
> [  662.659780] raw data: 00000020: 00 00 00 00 0a 38 20 01 0a 62 17 11 88 01 00 00  .....8 ..b......
> [  662.659783] raw data: 00000030: 00 00 00 00 00 07 9a 18 00 16 c1 9a 7e ea ea 44  ............~..D
> [  662.659785] raw data: 00000040: fb 4a 80 10 05 93 44 08 00 00 01 01 08 0a 59 68  .J....D.......Yh
> [  662.659788] raw data: 00000050: ba e2 0e bb ac ae                                ......
> 
> Andreas.
> 

Note that 8359 and 7ca6 are the same really (a missing ~ to invert csum_partial())

So the bug was that :

1) Driver programmed a wrong start offset for the csum  (7 bytes instead of 14 bytes to skip Ethernet Header)

2) FCS was not stripped.

Basically CHECKSUM_COMPLETE support never worked, but this was hidden by the fact that linux stack
had to throw away this CHECKSUM_COMPLETE because the FCS had to be removed.

Thanks !
