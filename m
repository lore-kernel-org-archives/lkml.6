Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250762156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJOniD2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250762156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeI0OKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:10:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38283 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeI0OJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:09:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id x8-v6so4182111eds.5;
        Thu, 27 Sep 2018 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LI8PXdDDVmehR+0BPZ/5/vkxTrnjhp9MHlO0hn9PT2c=;
        b=tJOniD2PTwR1lPX/vT14Bg4y3b9ZB7jfQj3b90Nsxgip+m5aUP6IkaKi7HAg3xpcVU
         Cr2dKJ5cau+LjdpY9nLAnjFNElofaltxfK61nQYjumE+ALIV4MM0bjwpCYR1RooYfp6o
         VDbK5gRe3XJ9hcUV/Xdub67y7z989IOwo0qEGCU4bDJBFoR8bolag06edIvXSzQ+NvqM
         Cg0p1UuP0dszMRraCh8MW2+pINvkwevtxYqh3Em8GeHh6v0Xji9ApRRZF3ZFdHHe/FHv
         rQ1u9gnYA+lEbZVWphN0HmzfBybN46IwoHOeg/fdiI6OXUfRn3ckDQSEBxFjqXIn9pS7
         3loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LI8PXdDDVmehR+0BPZ/5/vkxTrnjhp9MHlO0hn9PT2c=;
        b=TY6HvxNesuCDT/Wf4JmeMf0EqiWJguAsFlVcxFbFq32e9mtJr8tiXTmX0kxS8dfNzi
         5kSeoWJci9aKF+xm6skCUl8EQap7QQuqVxS8xvPizuR6gF736h7cz0/zVRjoZG4jAMuS
         Fln9/Qim3u94TFLaK7V9an7K3FCuVbs/i8OS57bAWEYM3wc9nMdK2VHT+WzyWhDd/tgh
         o0ZcWAqZTqHVmNHOHOqu3qx+9taIur/sfC6F54JxJjB4TlBGgsLd+Kw8EpAtJcfjm/Uo
         dkRPmvtRRcC3aRoTYWs6gaIJKAUJ2YTPMMmm2dvCAPLaLaWvrSfMw9PP5pxT4Q79moRo
         LqGQ==
X-Gm-Message-State: ABuFfogLdqqIt2CUB3pEXhphFvW4sEDEPmeK4CDmv8vsTIPNPTT6qT4t
        Ml33Htt8DaCIinsazLIhoA8=
X-Google-Smtp-Source: ACcGV60v4XQNV4AvsRrzyqWK+GmJ/gzKfz13XAZGZ5M2RyNtXJoVRlFs7A/5jL8q/I931mAPoMEurQ==
X-Received: by 2002:a50:e68c:: with SMTP id z12-v6mr14471726edm.275.1538034781735;
        Thu, 27 Sep 2018 00:53:01 -0700 (PDT)
Received: from ziggy.stardust ([93.176.144.101])
        by smtp.gmail.com with ESMTPSA id b9-v6sm1060530edk.62.2018.09.27.00.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 00:53:00 -0700 (PDT)
Subject: Re: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
To:     houlong wei <houlong.wei@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <Bibby.Hsieh@mediatek.com>,
        =?UTF-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
        =?UTF-8?B?RGFveXVhbiBIdWFuZyAo6buD6YGT5Y6fKQ==?= 
        <Daoyuan.Huang@mediatek.com>,
        =?UTF-8?B?SmlhZ3VhbmcgWmhhbmcgKOW8oOWKoOW5vyk=?= 
        <Jiaguang.Zhang@mediatek.com>,
        =?UTF-8?B?RGVubmlzLVlDIEhzaWVoICjorJ3lroflk7Ip?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        =?UTF-8?B?TW9uaWNhIFdhbmcgKOeOi+Wtn+Wptyk=?= 
        <monica.wang@mediatek.com>,
        =?UTF-8?B?SHMgTGlhbyAo5buW5a6P56WlKQ==?= <Hs.Liao@mediatek.com>,
        =?UTF-8?B?R2lubnkgQ2hlbiAo6Zmz5rK75YKRKQ==?= 
        <ginny.chen@mediatek.com>,
        =?UTF-8?B?RW56aHUgV2FuZyAo546L5oGp5p+xKQ==?= 
        <enzhu.wang@mediatek.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
 <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
 <1538013431.17514.31.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <3773f620-e135-578d-5307-08483436f4c2@gmail.com>
Date:   Thu, 27 Sep 2018 09:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1538013431.17514.31.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2018 03:57, houlong wei wrote:
[...]
>>> +	}
>>> +
>>> +	return client;
>>> +}
>>> +EXPORT_SYMBOL(cmdq_mbox_create);
>>> +
>>> +void cmdq_mbox_destroy(struct cmdq_client *client)
>>> +{
>>> +	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>> +		spin_lock(&client->lock);
>>> +		del_timer_sync(&client->timer);
>>> +		spin_unlock(&client->lock);
>>> +	}
>>> +	mbox_free_channel(client->chan);
>>> +	kfree(client);
>>> +}
>>> +EXPORT_SYMBOL(cmdq_mbox_destroy);
>>> +
>>> +int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt **pkt_ptr,
>>> +		    size_t size)
>>
>> I suppose you are not returning the allocated cmdq_pkt to avoid checks for
>> IS_ERR() logic in the consumer of this API. Am I correct?
>> Do we really need a pointer to a pointer here? Can't we just use a struct
>> cmdq_pkt *pkt as argument? That would make things easier.
> 
> Do you mean we change the argument 'struct cmdq_pkt **pkt_ptr' to
> 'struct cmdq_pkt *pkt', and the consumer allocate a struct cmdq_pkt
> *pkt, then pass pkt as argument of this API?
> If yes, the consumer still need to check the return value of this API.
> For the current implementation, the consumer doesn't need check
> IS_ERR(*pkt_ptr) if the return value equals to 0.
> 
> Since the consumer has to check the return value of this API once, to
> make it simpler, I shall change the prototype to 
> 'struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t
> size)' and change its implementation.
> 

Exactly that's what I proposed. Sorry for not explaining myself :)

>>
>>> +{
>>> +	struct cmdq_pkt *pkt;
>>> +	struct device *dev;
>>> +	dma_addr_t dma_addr;
>>> +
>>> +	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
>>> +	if (!pkt)
>>> +		return -ENOMEM;
>>> +	pkt->va_base = kzalloc(size, GFP_KERNEL);
>>> +	if (!pkt->va_base) {
>>> +		kfree(pkt);
>>> +		return -ENOMEM;
>>> +	}
>>> +	pkt->buf_size = size;
>>> +	pkt->cl = (void *)client;
>>> +
>>> +	dev = client->chan->mbox->dev;
>>> +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
>>> +		DMA_TO_DEVICE);
>>> +	if (dma_mapping_error(dev, dma_addr)) {
>>> +		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
>>> +		kfree(pkt->va_base);
>>> +		kfree(pkt);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	pkt->pa_base = dma_addr;
>>> +	*pkt_ptr = pkt;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(cmdq_pkt_create);
>>> +
>>> +void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
>>> +{
>>> +	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>> +
>>> +	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
>>> +			 DMA_TO_DEVICE);
>>> +	kfree(pkt->va_base);
>>> +	kfree(pkt);
>>> +}
>>> +EXPORT_SYMBOL(cmdq_pkt_destroy);
>>> +
>>> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>>> +				   u32 arg_a, u32 arg_b)
>>> +{
>>> +	u64 *cmd_ptr;
>>> +
>>> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>>> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
>>
>> Why do we update the cmd_buf_size here?
> 
> Because in developing phase of consumer driver, the consumer has to know
> the real command buffer size after adding command failure. Then the
> consumer will increase the size and run the cmdq flow (cmdq_pkt_create,
> cmdq_pkt_write/wfe...) again. Finally, the consumer get the real size
> and fix it.
> 

But the consumer should know the size it needs for it's buffer and if not it
should be able to decide on it's own how much space it needs. If he get's a
-ENOMEM he implicitly knows that he has to increase the buf_size. Now the size
depends on how many command he has pending and wasn't able to write to the cmdq_pkt.

Regards,
Matthias
