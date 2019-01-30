Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B665FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C5A20855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBEuGwn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfA3M2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:28:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33073 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbfA3M2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:28:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so15356640wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 04:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4U/iIJj82u26qLoq46qihY0sTUO30P5OPcQP+2hQt4=;
        b=bBEuGwn1o7o2K8JnDQ6yuznyxfZ8aIkbh6vqE/DBlyhp+6yqEURJYjfHBCAepcN1gY
         KBDN9pSi+/C2hO3RkkPQZoWYUQsT0j/QwFPQiIjWsCYGD3KcATpFnofhfVf0hukoGC5B
         WWeXgPNmRZNzXguHf4Daup0YWcGB6CqwaL3b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4U/iIJj82u26qLoq46qihY0sTUO30P5OPcQP+2hQt4=;
        b=fDMuqXfPqwf93dUSnjNVuun/OsZxqi1Uqb6tbxIxYHdLdipLXdY1XKm5PyQoQ0U9LX
         GcRfaNpfdCsk7+Ku0f0F7mA4p2vLjxX8h1S24qNRVe4BNVHHuYp+HQDl/mWVIdY7EoqC
         ctlfSGmVFl2DirKv/J/8ql0IgMcKQ2Ojp7SFc6g9BTZJuvbs6yD5MJQHKPOQifawLzuJ
         u0KLzkQXK4XzYhRwgOBq3k0FA54ZSDA/1xCImKLJVefslbPW2svNNMoPhG2YjHsHHrc/
         TImTRZf+8wYNxEsV6aWMjLA8uV/vDxSyB5WHWM3HJaUoLRYzZ0XsPqmzjiDzXgVhdOC+
         tBFA==
X-Gm-Message-State: AJcUukf64hnwYrM3qPsVy1yuOR1PeCbC0LELbzevLFpjeSp4uXRtFkZz
        DNEl7XvHTHKKnpgGqM/vUB8fhFcrZKE=
X-Google-Smtp-Source: ALg8bN5HK5CtsRK25o5XOzy94A9USGHN7oWCi0//bbFt7rwvoCn57KBqYeC34t2f0+YEHFUe+uiq8Q==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr24272697wmd.89.1548851281230;
        Wed, 30 Jan 2019 04:28:01 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id f199sm2273299wmd.25.2019.01.30.04.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 04:28:00 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190129202726.GA3036@builder>
 <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Message-ID: <61bdca18-cef9-3f02-45ef-5df4f96b4f2b@linaro.org>
Date:   Wed, 30 Jan 2019 13:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 10:53, Jorge Ramirez wrote:

>> +	priv->vbus = devm_regulator_get_optional(priv->dev, "vbus");
> get_optional means that if vbus-supply is not found, rather than
> returning a dummy regulator object this will fail with -ENODEV.

on this subject, is it intentional that devm_reset_control_get_optional
behaves differently (ie, it returns a NULL if it cant be found)

IMO all *_get_optional should be semantically as well as functionally
equivalent to avoid confusions like the one I had.
