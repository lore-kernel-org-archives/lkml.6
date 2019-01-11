Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11089C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48AC2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h/frq+od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAKX7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:59:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfAKX7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:59:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6952096pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YXS609+Rr6Firj7E3CvyBmMR2oehV0/tgvrPgdkRRUM=;
        b=h/frq+odSvkPp71ZOX+utraN21aXiQKtMAVRIkkriqkC6MI/yvvAP+WNxhCgg2Fqhs
         I3TMY7PGPh9+btnsz+G3jJ09+gWrvanFn53IoveMNYyh6Ao/zqSu527gKQRDiOzf8FZP
         r5+KZk0eAbA5Iu2hCAsn1avLCpm+rPQ2TR/C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YXS609+Rr6Firj7E3CvyBmMR2oehV0/tgvrPgdkRRUM=;
        b=AEXxTT+uQ3A3zErnmnh2n7d8/SpNnTDb/VT5QBW5FxGYmGMCURlBYy1QMJZyeqqumT
         5eBPGn7DezuzRv+PJPvN3fo4FeDMT337Vq/SrDWWJncG/ewkHAJSiom1kckhdA8cz0LH
         MHuDPzkRZwsyBiuG8HlswFqC+/zGOyTgeR6nEz6oc5tG4rSqhbZn9osG0mo80Qco+SlD
         jflCQTksZBhfF0cHNuQVQpumMeSgonlaD15zCPnN6c+mCmg01erXJSJg8NGUXMZjpCPp
         blP1C/tvJKql0KiCGwao0Uz8Z+sS59EkcojznIlWsd+zOpPdysFkHo8inwTVyOEJPGi8
         97Xw==
X-Gm-Message-State: AJcUukf0E5R+koiFiz/68xy0wWsOszcm20pu6eH+sQNE2VGOwOOu6Vtd
        hABHQzv7+MYRLEEVmhDAW4bQaQ==
X-Google-Smtp-Source: ALg8bN7xRpKks2BDpy3PoPgjGMzpdg3A/VIgRcgiaNK5w0N2PooKIbWCfCDwIS+o6+bsN9curvA9LQ==
X-Received: by 2002:a63:295:: with SMTP id 143mr14746138pgc.362.1547251143332;
        Fri, 11 Jan 2019 15:59:03 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y29sm102477011pga.59.2019.01.11.15.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 15:59:02 -0800 (PST)
Subject: Re: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and
 stablize for PWM kona
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
Date:   Fri, 11 Jan 2019 15:58:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please remove 'INTERNAL' in all of your patches and cover letter.

On 1/10/2019 9:08 PM, Sheetal Tigadoli wrote:
> Hi,
> 	This patchset contain support to make PWM changes configure
> 	and stablize
> 	Following are brief changes done
> 	a. Add support for version2 compatible string
> 	b. Change PWM config and stablize delay in PWM Kona
> 
> Praveen Kumar B (3):
>   dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
>   drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
>   ARM: dts: cygnus: Change pwm compatible to new version
> 
>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
>  drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
>  3 files changed, 100 insertions(+), 32 deletions(-)
> 
