Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B04C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3CB20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547674375;
	bh=ZOxAz1zDSHBY3O+tVpWus/MBGhzCUdqOn+mpcQvHvnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sb7nIsjl1lEFY++6hee+KUtpGzXYJi181Oh3je0th5xkPappjMYpSBKWS14hvgvjN
	 1sm37WvYQNfRV5JKBVvshgq1/r85EdLB2k9J7vwuy1o2wZlMEM62YmYRnXHaCXH3h5
	 2rAqOhavouo5gYCSzxOrc9bgQ2/2P3H7azgSsAOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfAPVcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:32:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34934 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfAPVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:32:52 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so4484170oif.2;
        Wed, 16 Jan 2019 13:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6j3gJcqjshy+GkTGMDYzhvxPH9lHIMCSe1531fgy/pk=;
        b=MIdtEsnsrJa0gqRh2cnAtk8yKb07Azche7jKH/trI6qHfPjMdCFMK6gAS3Jc0ERW6M
         opqiy2Riydiifnywer82r1mmxcxH4oko0+nKjQEneaNY3ftzPv9jHAPWlWWIIcBhXPZK
         laWNm0gDu3lPzwJ5LwHpgKYa/e5DJtMQdvL+yS1o3/KM6A16rJUgnQMZEH9DuwmtbNGZ
         PTRRkZxBrM0Vqo6IjW/qT+Kg/+vEcpxdCPFf0Alf8l2Cj6HxckdkelfI9XS4SnrZz+yS
         HKk7jKFajqOJh+YovwAThe7hsYDRAqKZa15vy4njacMzPxNc7jgtqiGudUJPN5BnLC9l
         0B8w==
X-Gm-Message-State: AJcUukdB6SCJLng7katLZwFptzwk8MSyIsWmlCoXR8VZAbOBPa7nhSKH
        LOTWumQiBdTqg02gsrrv7A==
X-Google-Smtp-Source: ALg8bN7KHbBQjXW/WBoRRcPT9JcO6OYK63BTFMuRUt8V2q5t6bdVevP0gpe+1DbVs3PiR4zgGcxfzg==
X-Received: by 2002:aca:3c06:: with SMTP id j6mr5895782oia.126.1547674371501;
        Wed, 16 Jan 2019 13:32:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u136sm3525213oie.38.2019.01.16.13.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:32:50 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:32:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: usb: Add support for msm8998
Message-ID: <20190116213250.GA24600@bogus>
References: <1547483787-5371-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547483787-5371-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 09:36:27 -0700, Jeffrey Hugo wrote:
> msm8998 USB has a dwc3 controller just like the existing sdm845 support
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
