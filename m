Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6241C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7C62064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdCuGsq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7C62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJPBsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:48:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJPBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:48:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so21989340wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxEOfsrNcWxo7LgGfFUAW0V6/xKGIBWw7bmVLMlVFg4=;
        b=QdCuGsq/Vxej6GnUEUIlbLjINkLwA1eCHGAEjJXp8tekBkx2dDIZ9qmTINuS0iZ7it
         9vARvUEMYtdRM1llz3+PsPuj6SHbfuHX/xrAvLd3pyFpvHBV5eMIL7nLYXfEKJsAX1ZV
         T620/pZK0B2cDvCcNbCuqF6Tey5Ge7c2q4uOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxEOfsrNcWxo7LgGfFUAW0V6/xKGIBWw7bmVLMlVFg4=;
        b=NkEiYNSloC889i8rpwX2f+rSQo8TAqo1ZP+Z+7ynk+Znw0tyupNlcxQAK3sNLAAr2s
         +cmADzUhhGUrVuXHCbajvFwKUUVw9D60vBDR06KP7GxH0YfDrK/1nYjDGo4tx/gD9IZB
         adZF/rVzY6UMl65TNErJKfmTqxhpQizFHrDVZXdjZcyOTvYRXDxoBqO3dv95aYSNFOao
         H1/NK10K904IBo1VFA56kdWOYvykpBBGlLTjAX7erypk8pJ9yGIPpC3Dmw01ikLl7quT
         +45keaK6aGx47TSy4/h1Nel0JcPGfgpF9xyhi4K2tz5UKLmGgnuoejrHRzfyNPT6KVpu
         bGqg==
X-Gm-Message-State: ABuFfoh4FEHaddjjh6THLPp6UkRnXGd9Yp9UASDikbHX0Fk+dicTwtPP
        +9/leK0J2Tuu5apxNKVdQPFh1Q==
X-Google-Smtp-Source: ACcGV63UFha9cwlnzaZlmbTpWxzUUSxDs3dLAByljhcTHDiLDYJQAmiOFxWO+Pp6h7ym1mIJUY47pA==
X-Received: by 2002:adf:e403:: with SMTP id g3-v6mr14658619wrm.96.1539626518906;
        Mon, 15 Oct 2018 11:01:58 -0700 (PDT)
Received: from [192.168.0.40] (85.238.136.77.rev.sfr.net. [77.136.238.85])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm18626711wmd.10.2018.10.15.11.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 11:01:58 -0700 (PDT)
Subject: Re: [PATCH 10/14] ARM64: dts: hisilicon: Add interrupt names for the
 tsensors
To:     Rob Herring <robh@kernel.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/HISILICON SOC SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
 <20181015163115.GA25282@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9f9650d9-cae9-9dfb-ded3-4ba5834a6ffe@linaro.org>
Date:   Mon, 15 Oct 2018 20:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015163115.GA25282@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2018 18:31, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 11:03:08AM +0200, Daniel Lezcano wrote:
>> Add the missing interrupts for the temperature sensors as well as
>> their names.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 8 ++++++--
> 
> Combine this and the previous binding change to 1 patch.

Ok.

>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       | 8 ++++++--
>>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> And more checkpatch whitespace errors in this.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

