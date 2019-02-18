Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F722176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dgk6Skko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfBRKuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:50:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42015 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:50:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so4428819wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aS3pn+FwO9e/L96l1q5GR2QSJA56tlCPGB22Banj6Dw=;
        b=Dgk6Skko9GsFD0mcudXrG04MKcVYNkihFXasB2fqsiLvRxuck2gewPVRDdiUHIpdLA
         mnXLXsSYIHPVrIrrDz7DRwZ+lAf9H9iB5zxHfxN11xxbmz9GKOIrwpqa61ajzGmLA0qh
         68DhjobONdawx1wEOZCycF2BbTRwTejckluNO8LPXiJatoIIFhYB1bReoL5/h2nuE/f7
         INmxzTaSnScZKBquhV+G59Lsit9TvqgwzIlPshpksZzMnQ00MCfrHJ5UK2FT6uy12JL4
         poRMKi529e951w/tvsoI06AVrhWvMQawO6pEazE1fAwQQAaKuP+VG60040ZPDNHLs2R9
         Vbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aS3pn+FwO9e/L96l1q5GR2QSJA56tlCPGB22Banj6Dw=;
        b=EhbLvw0mM5p/g2SRvquNwiM04v7vLh6PmB3xJLRfwIlJF6OEwlQ7g3txpbOCI+RuxL
         fNbUo02YsycgBIzZ59HKs4YuLVmnUZnra/fmhHg0XNp2C1Nzy/YdNh3ZMzpaU3fbVA0r
         dtLdgY90cKcZPnqaG4lybWZGu63NEGXdl0h76oPRGK0JExNIRbn1r2AfudIaoBETh2oN
         K2X2To5y4K1zq4Xq9b4+UqpDXS+dA1WcrZEnibTVx77hjG7Rq81PDFtk8Q+yVbltf1VI
         K0sasbHN+SK9n+LJPOkQVs2n9E1/3wHi2j6t9wdNlXe10w6R6xzzDVz6fwfKKkN78LoZ
         XunQ==
X-Gm-Message-State: AHQUAuaRwIHBGX+wOXw9Z3BspA4hWgrQ6jFNd5kPdmF8dWnyuZUnS4Iw
        3Z4YqxCCx/cLMLOf74u5tcqUKA==
X-Google-Smtp-Source: AHgI3IYNs/h8krv9CzyRnk7cIkNdzuI64vf9d1Ac/qGJhfux3UPLXK2iHgWB4zvH421oHoPAElIzZw==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr10493701wrv.73.1550487048409;
        Mon, 18 Feb 2019 02:50:48 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id b8sm2310542wmj.35.2019.02.18.02.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 02:50:47 -0800 (PST)
Subject: Re: [PATCH] clocksource: exynos_mct: Remove unused header includes
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <1550484598-1952-1-git-send-email-krzk@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d6a2fd0-60e1-cf36-e9fe-23de07e76019@linaro.org>
Date:   Mon, 18 Feb 2019 11:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550484598-1952-1-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 11:09, Krzysztof Kozlowski wrote:
> The driver does not use sched.h and platform_device.h.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied for 5.1

Thanks


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

