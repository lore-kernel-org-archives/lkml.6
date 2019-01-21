Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64231C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3B020989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="NgRQ18NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfAUSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:14:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37133 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfAUSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:14:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so16187503lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XNrborbmkLyj7MOhD2bckHByezP7aYEcGysoydwhEo=;
        b=NgRQ18NTRUyhLp3qzGxSMdowUrCdv51jK3ncUZ82RANd93NGMosdDlxxe0oBOxPGUm
         CgIqhboKV864ypRZCvt1xgtjbVNJhjBxgr6sEp+PjUSyI7MhFmzD3HY8TMLUeU0ZlVV8
         +uA1g9TKoJ/G7BICzpzWweJL1T9oJ9mfEcpphwo3CCdrEP7mfR0N4XKxxJYWOmaLI5T5
         JR97ecKaQVVvTJb1pLS4va2yr9cVZM6hAyNrFJldngCQr5F5s6rTj+6k/Zqa/GEpFNCt
         n6FaYGo0wLZyPT7BW4rOq+CXijlxHkxZctrG7wE/Jcfj5ooVCeOaJOy4zM9zBxhuJhzn
         2HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8XNrborbmkLyj7MOhD2bckHByezP7aYEcGysoydwhEo=;
        b=MoD3mBIDIuBsHm6RrcbaLBR726USAeL87eJfIYGoHIpMBE/Dk7/fLbSxmK1la5PVou
         /2FRDF/+Mt/1eD1SjXzrt7IoPv1Kwc8/EP2HLA74JHNRKZhKHYv/67VoAQSYmYVNk1Wd
         PmoVHJDU+FBsh6mWIzl4DfTPbEeOHi+iSMBVtGiVYOLVFKHKlu5uYkKHs1XqhcqLPZz8
         MbGxX5++S1hVguVboH3DvvS7G5ilgaqsHtTcZYpWLJU4eRZPtGcGgxh1H2UDeTSrka5s
         O30O6mZ/lWoS0zHkAeXlgBrjCoiLUdZ1Trr76bkdnh/wn0HjVf5GEvGdtzKjSvxnXUZ6
         l+Ag==
X-Gm-Message-State: AJcUukcKyt5kdXe0E4HXPCQick6hcAIMi+rNhLEr+hrvZOPGqw+fKMCU
        vMFCQ+4FJtCZwR7AiE6YigIOBQ==
X-Google-Smtp-Source: ALg8bN6PPqPkACxJcoENfP9z2sJI1gD7slSarXUhSNl1mxBSaA5Dm/v+UAsap3xsCRL2ndOtKnGZkw==
X-Received: by 2002:a19:5601:: with SMTP id k1mr17101442lfb.99.1548094475001;
        Mon, 21 Jan 2019 10:14:35 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.215])
        by smtp.gmail.com with ESMTPSA id s3-v6sm2430201lje.73.2019.01.21.10.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:14:34 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v6 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
 <f4665653-503c-e1a1-a211-b8b322225bd6@cogentembedded.com>
 <OFE50FED81.5C117A38-ON48258389.0012FCE2-48258389.00139BD2@mxic.com.tw>
Organization: Cogent Embedded
Message-ID: <5440645d-6b52-ad72-1c98-2d140f1cd15d@cogentembedded.com>
Date:   Mon, 21 Jan 2019 21:14:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFE50FED81.5C117A38-ON48258389.0012FCE2-48258389.00139BD2@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/21/2019 06:34 AM, masonccyang@mxic.com.tw wrote:

>> > +#define RPC_SMENR      0x0030   // R/W
>> > +#define RPC_SMENR_CDB(o)   (((o) & 0x2) << 30)
>> > +#define RPC_SMENR_OCDB(o)   (((o) & 0x2) << 28)
>> > +#define RPC_SMENR_ADB(o)   (((o) & 0x2) << 24)
>> > +#define RPC_SMENR_OPDB(o)   (((o) & 0x2) << 20)
>> > +#define RPC_SMENR_SPIDB(o)   (((o) & 0x2) << 16)
>>
>>    Ugh, s/0x2/0x3/! :-/
>>
>> [...]
>> > +#define RPC_SMDRENR      0x0064   // R/W
>> > +#define RPC_SMDRENR_HYPE   (0x5 << 12)
>>
>>    s/0x5/0x7/, and this is a field, not value.
>>
> 
> okay, both 0x2 and 0x5 are just make sure these registers was
> writing a correct value rather than a prohibited value.
> anyway, I will patch them.

   TIA.

>> [...]
>> > +static int rpc_spi_probe(struct platform_device *pdev)
>> > +{
>> > +   struct spi_controller *ctlr;
>> > +   struct resource *res;
>> > +   struct rpc_spi *rpc;
>> > +   const struct regmap_config *regmap_config;
>> > +   struct device_node *rpc_if;
>> > +   int ret;
>> > +
>> > +   rpc_if = of_find_compatible_node(pdev->dev.of_node, NULL,
>> > +                "jedec,spi-nor");
>>
>>    I doubt that this is a correct function to check for the child node's
>> "compatible" prop...

   You need of_get_next_child() or of_get_next_available_child().

>>
>> [...]
>> > +   regmap_config = &rpc_spi_regmap_config;
>>
>>    Doesn't look like this variable is needed...
> 
> why ?

   Why not just use &rpc_spi_regmap_config below?

>> > +   rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
>> > +                   regmap_config);
[...]

> Mason

MBR, Sergei
