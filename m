Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84E6C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C01208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdo3YVTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C01208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeG3GXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeG3GXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:23:06 -0400
Received: from localhost (unknown [171.76.121.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EFB20873;
        Mon, 30 Jul 2018 04:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532926198;
        bh=SuEYelfMsnfawzrMsPmoyCHEjumA6oHb2hj0+MoPIi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sdo3YVTtkG52ywkdlapls5W+1s6H1jN9WqU65HtmHLTsei2+qdpS1q+09226+//IZ
         Ox1RSIOAAd2fB58fi9pIe4tykfTbmexdZQYUabkyZTsUgoSYYWy5VtQ39eSxhr8kBx
         Xxcab0SSuFK1cuiW6QvRMQAH4+ILp0WCLanXtHh8=
Date:   Mon, 30 Jul 2018 10:19:50 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/10] ASoC: Add support to WCD9335 Audio Codec
Message-ID: <20180730044950.GE3661@vkoul-mobl>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-18, 13:17, Srinivas Kandagatla wrote:
> Thankyou for reviewing v1 patchset, here is v2 addressing comments from v1.
> 
> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
> It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
> and MSM8956 chipsets.
> 
> WCD9335 had multiple functional blocks, like: Soundwire controller,
> interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),
> Ultrasonic proximity and pen detection, Battery-voltage monitoring and
> Codec processing engine.
> 
> Currently this patchset has been only tested with SLIMbus interface due
> to hardware avaiablity, but it can be easily made to work with both SLIMbus
> and I2C/I2S.    
> 
> This patchset adds very basic playback and capture support witout much
> fancy features. New features will be added once the basic support is in.
> This patchset is tested on top of linux-next on DB820c for both playback
> and capture paths.
> 
> This patchset also depends on the SLIMbus Stream apis which is already merged
> via char-misc tree for 4.19.
> 
> Some parts of the code has been inherited from Qualcomm andriod kernel,
> so credits to various authors.
> 
> WCD9335 can be interfaced via I2S/I2C or SLIMbus. 
> 
> Here is my test branch incase someone want to try this out:
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Apart from the few nitpicks I noticed, this looks good to me, so:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
