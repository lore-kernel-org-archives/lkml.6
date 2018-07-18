Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A692075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA76PHQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A692075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeGRIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:04:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43485 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeGRIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:04:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so3392617edt.10;
        Wed, 18 Jul 2018 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GUD/NT14sjnts4JvEEAOFei8OWLjRswEy0wBZTY8apM=;
        b=uA76PHQEwslPTmpQLG+PBVN3LdTXTRN/HM4oYrgsQtRGNSs3OaGJUzkWJajSebmV2W
         GDKGAL+VH0bOWrmAx5/mgkJwTdWMhHs8iKhpMj5zXnkTGQvohAPI/bNQgH/m86UWk0bf
         bSAOopGPkTu6ixn+ZODbT4AGCWXuonHkzOWpTdl51Cd1WoZ2wJaJDCKPnBfiFAcwXt/B
         MgnDFdnz+zEYcWMsh5kRJ0RcfDVGlUA6tcDwQZToAPDVnf0S5/fPGLH9sdVG8gyn8P8c
         9cDAiJJcarTwZT1dpqgIJg8mPAioa272u2PZC33Ma3W3mAk75PtKjodD0kYMY+unExjI
         p86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GUD/NT14sjnts4JvEEAOFei8OWLjRswEy0wBZTY8apM=;
        b=snF9LjU0eYDRZ6+O4Fg4hPDBDBmhZYfSQSfnNMBad8XNFHo1N2IcPV0NIfe4gWNhXj
         DIcSzgeB5/caaYgNFejwx35e/bE6/cW608KREHK5LeqFm9RTJokg6+l7NE8EhoMEAlzY
         mN6AyZ/6/qhusH4Q/IYGM4q1vvOqimLWumXkx0egDtIv5JYiZMHCksyXmxtZeiL8/uJq
         13FvRjTdRopgMGQ+pb0/A90Ao1eoqUO3K8hrJgPv/zPEoLcwcnKTg/MjkCmnmTAtkvmb
         CBffpRjnHflq4AlkMPi9p7rd4JtaQ84ApZZQCceJCPvj/Y/If/X7l6IJ5/hFdyXqfocg
         FPSw==
X-Gm-Message-State: AOUpUlGGRKFf2hzdvGV7CEeNgtCuhgp5qcAONbZUnw2duaOdk56RonzN
        N92/ywXQtwZc2rK5QADyvvw=
X-Google-Smtp-Source: AAOMgpfPhncn9nDBFau+LAE6/dnJLYD2dMEKk4MWfI8Ot8rDq/iHDPMn+Un7+NFivjFRxxi8hqC7xQ==
X-Received: by 2002:a50:b723:: with SMTP id g32-v6mr5936771ede.139.1531898871249;
        Wed, 18 Jul 2018 00:27:51 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id x8-v6sm2171468edr.24.2018.07.18.00.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 00:27:50 -0700 (PDT)
Subject: Re: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through
 a pdev
To:     Sean Wang <sean.wang@mediatek.com>, matthias.bgg@kernel.org
Cc:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, pi-cheng.chen@linaro.org,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
 <20180717220328.792-5-matthias.bgg@kernel.org>
 <1531882655.8953.83.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <50c93f6d-c546-1479-62c1-adc0b40d5dab@gmail.com>
Date:   Wed, 18 Jul 2018 09:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531882655.8953.83.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 18/07/18 04:57, Sean Wang wrote:
> On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> The MMSYS subsystem includes clocks and drm components.
>> This patch adds an initailization path through a platform device
>> for the clock part, so that both drivers get probed from the same
>> device tree compatible.
>>
> 
> Sorry for that I should have a response earlier for the series.
> 
> Some points I felt they're not exactly right and should be fixed up
> before we're moving on
> 
> Currently, drm driver have a wrong reference to the dt-binding,
> "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
> for the subsystem exporting clock and reset line such common resource to
> its sub-devices. Every subsystem has a similar shape. I hope mmsys
> shouldn't be an exception.

I'm not sure if I understand what you mean. You proposed to use a platform
device [1] and now you say we should change the DTS?

What do you mean by "drm driver has a wrong reference to the dt-binding"? How
would you want to name it and most important, what would be your approach to
have backwards compatibility to older device tree bindings?

> 
> DRM device needs to have its own dt-binding show how connections between
> DRM components being made and its node should be put under mmsys node.
> > In this way, it becomes easy to see how the topology of the subsystem is
> and grows, like a tree "device tree", instead of hiding the details in
> the implementation.
> 
> The similar example we already did for audsys on mt2701 and mt7623 as
> below
> 
> 	audsys: clock-controller@11220000 {
> 		compatible = "mediatek,mt7623-audsys",
> 			     "mediatek,mt2701-audsys",
> 			     "syscon";
> 			...
> 
> 		afe: audio-controller {
> 			compatible = "mediatek,mt7623-audio",
> 				     "mediatek,mt2701-audio";
> 			
> 			...
> 		};
> 	};
> 

I think this approach is not working as, due to backwards compatibility, we have
to make sure that the DRM driver gets probed with the mmsys binding.

Regards,
Matthias

> 	
> 	Sean
> 
> 
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 18 ++++++++++++++++++
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index dd249cf5121e..c946aea722e5 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -173,6 +173,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>>  	.ext_path = mt2701_mtk_ddp_ext,
>>  	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
>>  	.shadow_register = true,
>> +	.clk_drv_name = "clk-mt2701-mm",
>>  };
>>  
>>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>> @@ -180,6 +181,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
>>  	.ext_path = mt8173_mtk_ddp_ext,
>>  	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
>> +	.clk_drv_name = "clk-mt8173-mm",
>>  };
>>  
>>  static int mtk_drm_kms_init(struct drm_device *drm)
>> @@ -411,6 +413,19 @@ static int mtk_drm_probe(struct platform_device *pdev)
>>  	if (IS_ERR(private->config_regs))
>>  		return PTR_ERR(private->config_regs);
>>  
>> +	if (private->data->clk_drv_name) {
>> +		private->clk_dev = platform_device_register_data(dev,
>> +						private->data->clk_drv_name, -1,
>> +						NULL, 0);
>> +
>> +		if (IS_ERR(private->clk_dev)) {
>> +			pr_err("failed to register %s platform device\n",
>> +						private->data->clk_drv_name);
>> +
>> +			return PTR_ERR(private->clk_dev);
>> +		}
>> +	}
>> +
>>  	/* Iterate over sibling DISP function blocks */
>>  	for_each_child_of_node(dev->of_node->parent, node) {
>>  		const struct of_device_id *of_id;
>> @@ -515,6 +530,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
>>  	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
>>  		of_node_put(private->comp_node[i]);
>>  
>> +	if (private->clk_dev)
>> +		platform_device_unregister(private->clk_dev);
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
>> index 86cec19193c4..200eee5de419 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
>> @@ -34,11 +34,13 @@ struct mtk_mmsys_driver_data {
>>  	const enum mtk_ddp_comp_id *ext_path;
>>  	unsigned int ext_len;
>>  	bool shadow_register;
>> +	const char *clk_drv_name;
>>  };
>>  
>>  struct mtk_drm_private {
>>  	struct drm_device *drm;
>>  	struct device *dma_dev;
>> +	struct platform_device *clk_dev;
>>  
>>  	unsigned int num_pipes;
>>  
> 
> 
