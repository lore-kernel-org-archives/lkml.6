Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C850C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B9F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TazUe7ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfBLOHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:07:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38706 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfBLOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:07:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so3157537wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OfBbmJfbzBOuWOgCO8r4N6YmWf5R/YrSg9fCQxZNEhk=;
        b=TazUe7ngiSYDgV3wp244TaN8H5ZRBbi0GqzOzU8o+Bk8NBwbktSAaB59u7pKufgfi8
         pzPNFeWwZlGjNvuTerOIxDMwyjqfyFF56PSO2zhi0BwYMPqC5hNVIg+ysZHqeYsxjece
         TvkZ97YHvVdORwU9utIoWpT0tOCt+DxPULLca7NAT8G9iHsM/gwkFKikPlfwdfP9+Sck
         ocPxlwn+8CkabbhNzjy8Z6SeRUUUelLqQOK2BKpBBd4Ocrywu303/zYE51J3oMHSUObt
         QChGDznfKKbEKdoiKydL3kQXccgBj2XhhDUpiVJGK2LtDq8pl/PGPxdNlmNubYupIjz1
         RU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OfBbmJfbzBOuWOgCO8r4N6YmWf5R/YrSg9fCQxZNEhk=;
        b=ooeACdbP69UM90VyRm3B1YQwlam5vVzywn2Km8Teh8qMZuHmzFLZb/yvFkqI8dHDiD
         DzUuJX3AiT54Yu6Hg+lq0C4JZXTLhL9r9/cz9HZGunBEkwLanwiUVoCNS+u7uq+X5UtI
         IrqVSipba1I+BCy1LFxBhlsE5IVfi2edORfEaLFP5xjAgjoZU5DqTdaj+bLf3TmW5LIQ
         SgXGEJClpEQJWrnOSZn7/LmYwWIcvlX9ko/aLvCuTrXJWkomc6CHJTpmgSjehZw3MytI
         VfB/i36IdLrxboxzbXb1On3d6m21WZ01rfQa9/ElgKV1u6YLm9B+rgjuYTPWCRE3XZZV
         UxDg==
X-Gm-Message-State: AHQUAuYyrrAy/eRV4NxbqcSwd5tB8JChvGGCQDspk+1IGnn5ll7+UwgW
        FOqDvMov6KTTToHGz8Z2OLL9rYgUG+o=
X-Google-Smtp-Source: AHgI3IaUT2jwqoMkAkAEcMpXryDaBgZI2Nc3LgTeHtRIsW4+djUnN87LfL3inXjS9Zx20hYAEkvObQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr141624wme.115.1549980459309;
        Tue, 12 Feb 2019 06:07:39 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y22sm38964434wrd.45.2019.02.12.06.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 06:07:38 -0800 (PST)
Subject: Re: [PATCH] drm/msm/a6xx: Add support for an interconnect path
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jcrouse@codeaurora.org, robdclark@gmail.com, evgreen@chromium.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190212095238.12306-1-georgi.djakov@linaro.org>
 <20190212101624.GA20915@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <99ab72bf-9e06-bcaf-85ec-33d4037a54cd@linaro.org>
Date:   Tue, 12 Feb 2019 16:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190212101624.GA20915@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2/12/19 12:16, Greg KH wrote:
> On Tue, Feb 12, 2019 at 11:52:38AM +0200, Georgi Djakov wrote:
>> From: Jordan Crouse <jcrouse@codeaurora.org>
>>
>> Try to get the interconnect path for the GPU and vote for the maximum
>> bandwidth to support all frequencies. This is needed for performance.
>> Later we will want to scale the bandwidth based on the frequency to
>> also optimize for power but that will require some device tree
>> infrastructure that does not yet exist.
>>
>> v6: use icc_set_bw() instead of icc_set()
>> v5: Remove hardcoded interconnect name and just use the default
>> v4: Don't use a port string at all to skip the need for names in the DT
>> v3: Use macros and change port string per Georgi Djakov
>>
>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>> Acked-by: Rob Clark <robdclark@gmail.com>
>> Reviewed-by: Evan Green <evgreen@chromium.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>
>> Hi Greg,
>>
>> If not too late, could you please take this patch into char-misc-next.
>> It is adding the first consumer of the interconnect API. We are just
>> getting the code in place, without making it functional yet, as some
>> DT bits are still needed to actually enable it. We have Rob's Ack to
>> merge this together with the interconnect code. This patch has already
>> spent some time in linux-next without any issues.
> 
> I have a question about the interconnect code.  Last week I saw a
> presentation about the resctrl/RDT code from ARM that is coming (MPAM),
> and it really looks like the same functionality as this interconnect
> code.  In fact, this code looks like the existing resctrl stuff, right?

Thanks for the question! It's nice that MPAM is moving forward. When i
looked into the MPAM draft spec an year ago, it was an optional
extension mentioning mostly use-cases with VMs on server systems.

But anyway, MPAM is only available for ARMv8.2+ cores as an optional
extension and aarch32 is not supported. In contrast to that, the
interconnect code is generic and does not put any limitations on the
platform/architecture that can use it - just the platform specific
implementation would be different. We have discussed in that past that
it can be used even on x86 platforms to provide hints to firmware.

> So why shouldn't we just drop the interconnect code and use resctrl
> instead as it's already merged?

I haven't seen any MPAM code so far, but i assume that we can have an
interconnect provider that implements this MPAM extension for systems
that support it (and want to use it). Currently there are people working
on various interconnect platform drivers from 5 different SoC vendors
and we have agreed to use a common DT bindings (and API). I doubt that
even a single one of these platforms is based on v8.2+. Probably such
SoCs would be coming in the future and then i expect people making use
of MPAM in some interconnect provider driver.

Thanks,
Georgi
