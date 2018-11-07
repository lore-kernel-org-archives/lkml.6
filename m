Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2520882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLB+LatE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E2520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKHHrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:47:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33855 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeKHHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:47:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id y18-v6so5917836pfn.1;
        Wed, 07 Nov 2018 14:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfDO39p8xSTyBe2RIBKrkDdDPe9VRX7ePPYvAvL1qz8=;
        b=VLB+LatE1wTbMFBAX2/Q7ypExPyGk7WkEeIfnqTzFTaoLHfiWdgtHLWcBlUmN9luGI
         oo53GH+0y8bhmSJrkhcGUq3xaDeoHC980Oly8DPfpMQDaeydxbnxYttu5f2EIV1drgqJ
         G7iTg0XAZhmI41QhP+4eKmf8SYiW+HPRMH/BZrlVNupL57ry3JI/AbRG+dl3UhGWadF0
         eAO/FZJu2DYnihtMPmoxaYwa2+iTTTgNn960NVlaD+ecxIcijosR8yVsc+vQQUqVh/Wp
         r4KhPLdrfNfsjysYYEItN1oFH01haIc70BZp8iYbYCUnP7zA+/QehMLmTaqm2jhIXW2M
         J5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mfDO39p8xSTyBe2RIBKrkDdDPe9VRX7ePPYvAvL1qz8=;
        b=kVaxAz7EzvfbY36yWavfzXk6rn4g18AU1HKzo2wsUOSduygU0Gt/H/iwJvPhgewlPq
         BF9onTTCoRv5WGxM8qOiR76kMcCtEGVUm8sENOsX03YBHPylZ9m0hK1JISUk2GvvGjfk
         RvASpSg83oikYrsEdJLOiUqOeRB7NYnIawix5qKuSJIvXKfo51IondDtOptpKu5JaPx6
         Xizjw4MzH/4845fHcNH+Y9U63ydRJX/qTKbm+y3QgdpuYwuXbLr9zXk15NA0BESs1xl/
         SnXUBeAqfCMoDIUhgn9KpHpQX1pqNKuPs9ETfZ+/osPGswkSUVGbQJX80vHt/EDcnHkM
         Dcwg==
X-Gm-Message-State: AGRZ1gJvTzg5cVi3OCzkT9w/l7AV3jFLg//5+ZGJdYNm6Tv0zmKP78g5
        GVQnslhJz3JJaRHINueVVKvz8VeU
X-Google-Smtp-Source: AJdET5cufD13sQsxuHNABMHfCAXJc4h0mE8f2s/FO9iDcfwuSA4Q1HDh0V1a2hCGXKY3ysNsBK2Ucg==
X-Received: by 2002:a63:6cc7:: with SMTP id h190-v6mr1731425pgc.216.1541628927374;
        Wed, 07 Nov 2018 14:15:27 -0800 (PST)
Received: from [10.69.78.41] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1868925pfr.55.2018.11.07.14.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:15:26 -0800 (PST)
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com>
Date:   Wed, 7 Nov 2018 14:15:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2018 8:11 AM, Srinath Mannam wrote:
> These patches adds the stingray thermal driver and its
> corresponding DT nodes with documentation.

Can we get feedback from the thermal maintains whether this is
acceptable or not?

> 
> Changes from v4
>   - Addressed Rob Herring comments on DT parameters and
>     thermal driver architecture.
>   - Removed brcm,max-crit-temp DT parameter
>   - Changed driver to thermal sensor registration model.
>   - Added trip DT properties.
> 
> Changes from v3
>   - Addressed Daniel lezcano comments.
>   - Elaborated commit description of thermal driver patch.
>   - Added brcm,max-crit-temp DT parameter.
> 
> Changes from v2:
>   - All stingray TMON DT nodes are combine together into single.
>     Temperature registers are combined into one mem resource.
>     brcm,tmon-mask parameter has available TMONs mask value.
>   - All available TMONs are initialized together in single
>     instance of driver probe call.
> 
> Changes from v1:
>   - Fixed auto build sparce warning.
> 
> Pramod Kumar (3):
>   dt-bindings: thermal: Add binding document for SR thermal
>   thermal: broadcom: Add Stingray thermal driver
>   arm64: dts: stingray: Add Stingray Thermal DT support.
> 
>  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++
>  drivers/thermal/Kconfig                            |   3 +-
>  drivers/thermal/broadcom/Kconfig                   |   9 ++
>  drivers/thermal/broadcom/Makefile                  |   1 +
>  drivers/thermal/broadcom/sr-thermal.c              | 138 +++++++++++++++++++++
>  6 files changed, 344 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> 

-- 
Florian
