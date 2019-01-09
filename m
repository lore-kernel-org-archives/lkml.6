Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBA1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31DD206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poQIYTSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfAICDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:03:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46093 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfAICDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:03:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so2780023ply.13;
        Tue, 08 Jan 2019 18:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zq+022OUiAcpEDpkSUFVyaVWu7HbsGwR/IRWCAVsXzk=;
        b=poQIYTSeUR1rGwcnNq9bcu8XFVL0WyWS2pQlQvEppQlNbnisuMLwYMw2G0UPgJXzCo
         aotIo7Jn6Sxaxb9jLN4ut8ShsuJXlatldrsVi0y3E35LCcFB1ao4+mrHVtW0o6uQF4yz
         QD2sXJ5HgLyh1qAKVjIjK5OK90pEcsT+vP2JLES6Ds+NRnvqdC9iQFUQrpykyA+CtGI4
         QwZZcTH0WJYbn6ZpmCv/ADZikZxOEpiqOXH2fStrpayNQRZZ42FTnQvfUkh2CbCVdfSp
         bMQnHrQ3qOjoPTMrHqtORj7SYQ+k1tmQTtakGOM8HDwGwVGwOEx548HjFBtAU0gnfejM
         M7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zq+022OUiAcpEDpkSUFVyaVWu7HbsGwR/IRWCAVsXzk=;
        b=VJ43fI6yl2Ic8P5b6uZHzwgcSqPcFRQ3FpobdwYiwgkt5bn7J+I+2Hy8UwTDTrvP3C
         zGluw4j2feKP3H8UIKmrOaHPuRNhkzexg1//EGKGdWvZexm68Aa9pYC5PCC3E7wGGowI
         mtXNZjcNL1MBlAkVeHx4k8trwo6XJBI3W1REC0vgiv0U5HkEC0BfxdBZByOH9xxtI/Bu
         PEaXaKH16834KhQnxQo83p4sZfl1nHpp9hhdoERx3fTMpV05o2tU47YDwz5iGAifhMcJ
         2CgrNLXnrUVNyf3RqLFaBTjnrA/ZpExsfY8Su+Q84JE7euLrnl6s7n006a+ioGaQ5q3r
         fPGg==
X-Gm-Message-State: AJcUukdBQy8YYIkvR0tb/6e8PiCqiMzOR/QLN6BvD/+/h+DgBu1v9t4p
        zU2lfLOimC7LeuOnDRe+gZEUElqD
X-Google-Smtp-Source: ALg8bN6sNoXs8MNLhrC8ua+Hs7qGfdAlXKrXq8HR8FqG27EA3Rb9jkX+f54suOpcV5RsVqdw7JaHpw==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr4123795plo.133.1546999416043;
        Tue, 08 Jan 2019 18:03:36 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id 6sm148891698pfv.30.2019.01.08.18.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 18:03:35 -0800 (PST)
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Yanjun Zhu <yanjun.zhu@oracle.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
 <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
 <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
 <f87bd4b7-81d5-1f0c-137e-ecbc02753257@oracle.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <a1a71d06-9c1c-7e18-0e24-103fa89facf2@gmail.com>
Date:   Wed, 9 Jan 2019 10:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <f87bd4b7-81d5-1f0c-137e-ecbc02753257@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/9 9:24, Yanjun Zhu wrote:
>
> On 2019/1/8 20:57, Jia-Ju Bai wrote:
>>
>>
>> On 2019/1/8 20:54, Zhu Yanjun wrote:
>>>
>>> 在 2019/1/8 20:45, Jia-Ju Bai 写道:
>>>> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
>>>> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
>>>> executed with nv_poll_controller().
>>>>
>>>> nv_start_xmit
>>>>    line 2321: prev_tx_ctx->skb = skb;
>>>>
>>>> nv_start_xmit_optimized
>>>>    line 2479: prev_tx_ctx->skb = skb;
>>>>
>>>> nv_poll_controller
>>>>    nv_do_nic_poll
>>>>      line 4134: spin_lock(&np->lock);
>>>>      nv_drain_rxtx
>>>>        nv_drain_tx
>>>>          nv_release_txskb
>>>>            line 2004: dev_kfree_skb_any(tx_skb->skb);
>>>>
>>>> Thus, two possible concurrency use-after-free bugs may occur.
>>>>
>>>> To fix these possible bugs,
>>>
>>>
>>> Does this really occur? Can you reproduce this ?
>>
>> This bug is not found by the real execution.
>> It is found by a static tool written by myself, and then I check it 
>> by manual code review.
>
> Before "line 2004: dev_kfree_skb_any(tx_skb->skb); ",
>
> "
>
>                 nv_disable_irq(dev);
>                 nv_napi_disable(dev);
>                 netif_tx_lock_bh(dev);
>                 netif_addr_lock(dev);
>                 spin_lock(&np->lock);
>                 /* stop engines */
>                 nv_stop_rxtx(dev);   <---this stop rxtx
>                 nv_txrx_reset(dev);
> "
>
> In this case, does nv_start_xmit or nv_start_xmit_optimized still work 
> well?
>

nv_stop_rxtx() calls nv_stop_tx(dev).

static void nv_stop_tx(struct net_device *dev)
{
     struct fe_priv *np = netdev_priv(dev);
     u8 __iomem *base = get_hwbase(dev);
     u32 tx_ctrl = readl(base + NvRegTransmitterControl);

     if (!np->mac_in_use)
         tx_ctrl &= ~NVREG_XMITCTL_START;
     else
         tx_ctrl |= NVREG_XMITCTL_TX_PATH_EN;
     writel(tx_ctrl, base + NvRegTransmitterControl);
     if (reg_delay(dev, NvRegTransmitterStatus, NVREG_XMITSTAT_BUSY, 0,
               NV_TXSTOP_DELAY1, NV_TXSTOP_DELAY1MAX))
         netdev_info(dev, "%s: TransmitterStatus remained busy\n",
                 __func__);

     udelay(NV_TXSTOP_DELAY2);
     if (!np->mac_in_use)
         writel(readl(base + NvRegTransmitPoll) & 
NVREG_TRANSMITPOLL_MAC_ADDR_REV,
                base + NvRegTransmitPoll);
}

nv_stop_tx() seems to only write registers to stop transmitting for 
hardware.
But it does not wait until nv_start_xmit() and nv_start_xmit_optimized() 
finish execution.
Maybe netif_stop_queue() should be used here to stop transmitting for 
network layer, but this function does not seem to wait, either.
Do you know any function that can wait until ".ndo_start_xmit" finish 
execution?


Best wishes,
Jia-Ju Bai


