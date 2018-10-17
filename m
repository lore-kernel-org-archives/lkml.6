Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7DDECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900F3204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900F3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJQVWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:22:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45759 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:22:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so21020283oig.12;
        Wed, 17 Oct 2018 06:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfQNZq9SjufMQWHvYpzfEbDGAV2uu11s9XBjD518IHA=;
        b=EmihDvJLdsGnAQQqiRbuIBjs1G+NGDLyYzftTfTs65yonI1ulRpLicnPne+3Bdd6br
         1O7i8HV4nI96wXMZuQAfB2ivOaLI4i/lAzfqaSKcNCJKNI9bKhDDTfgCx0o3/JYHfU4l
         I4RbMbNj4TNbCLcpOjsfDxY3PYQo6SuDCfne4H9/4iifrdEGCzuLq0nz0f9K1EwdBoog
         zhPm1s3u0SAnuBJukP8o3tq1aNzpWi9mRrgs8ZgqeDwUq3Qai1G1j9idjOBWLwwo4Cbw
         iN6eoNVjj+KdFPjcYXv2kSYnE8CezB9trQ5eeWV06eUoOdghhxxP9i6N1bYk6YLRZz2v
         o2BA==
X-Gm-Message-State: ABuFfoh1+BdmupMoefcUxzIB0g7OlWMCTjiMvGEIjLdVXegXdT8l75ah
        /Q5MdRUiCBewKDJXPAgvNQ==
X-Google-Smtp-Source: ACcGV63051yf8wokHUSuK80HgG0bbMQLfFbZD2IoOxiYddT8vizpgzqo+PCSoWtcZ6MYk1RO4oxO+w==
X-Received: by 2002:aca:1018:: with SMTP id 24-v6mr13278406oiq.303.1539782825124;
        Wed, 17 Oct 2018 06:27:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t69sm5560745ota.10.2018.10.17.06.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:27:04 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:27:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
Message-ID: <20181017132703.GA26895@bogus>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-6-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 18:36:32 +0300, Dmitry Osipenko wrote:
> Redefine binding for regulator-coupled-max-spread property in a way that
> max-spread values are defined per regulator couple instead of defining
> single max-spread for the whole group of coupled regulators.
> 
> With that change the following regulators coupling configuration will be
> possible:
> 
> regA: regulatorA {
> 	regulator-coupled-with = <&regB &regC>;
> 	regulator-coupled-max-spread = <100000 300000>;
> };
> 
> regB: regulatorB {
> 	regulator-coupled-with = <&regA &regC>;
> 	regulator-coupled-max-spread = <100000 200000>;
> };
> 
> regC: regulatorC {
> 	regulator-coupled-with = <&regA &regB>;
> 	regulator-coupled-max-spread = <300000 200000>;
> };
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
