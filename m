Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9269BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E5820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSURbtaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E5820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbeGXG6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGXG6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:58:52 -0400
Received: from localhost (unknown [106.201.120.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27A020856;
        Tue, 24 Jul 2018 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532411647;
        bh=vNcCDl4QxA+/t5vTYqGYBf8FzCgyu52CkqbJUxwIxgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSURbtaWqEDeGE0C7T/VYK5qx7L/WX1H0IEC9m1EnJG+ZtHamRaoYVQzy2TRswcR4
         +8fyqERCQaEt7VTIdTQajdXLlM7kfbnio7/6s/DVo/lAgsotVKOtpS09VwI6q3kPft
         fWbHo0fwrb7h1wNxDkJT4+EyxwxMAeavsnSxM3Rg=
Date:   Tue, 24 Jul 2018 11:23:58 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/12] mfd: Add support to WCD9335 Audio Codec
Message-ID: <20180724055358.GI3219@vkoul-mobl>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18, 16:53, Srinivas Kandagatla wrote:
> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
> It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
> and MSM8956 chipsets.
> 
> WCD9335 had multiple functional blocks, like: Soundwire controller,
> interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),

MBHC ??

> Ultrasonic proximity and pen detection, Battery-voltage monitoring and
> Codec processing engine.
> 
> Currently this patchset has been only tested with SLIMbus interface due
> to hardware avaiablity, but it can be easily made to work with both SLIMbus

typo avaiablity

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

typo andriod

-- 
~Vinod
