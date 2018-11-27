Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788F0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468312086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMuogJ79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468312086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbeK1FEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:04:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40142 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeK1FEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:04:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so23127262wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eQ8kTXqiEAagVlAp1jMqhXS2NrO5ERaK3acUtEGGsWM=;
        b=OMuogJ79mbCg599v7De1cTgpP0ktkweA0bbAGgPpGs8/GruHiJu+lO6nbxR908iHfn
         zFYe8U3spLtn/scWmsh3bKSgqsf+bkKq50nAIgi9b24F7hXKXxGhMf/LF9JExUKKdGOx
         7ij5VVZpSTHM/YxgpQ2XxOXrzK7IvB1mFp+ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eQ8kTXqiEAagVlAp1jMqhXS2NrO5ERaK3acUtEGGsWM=;
        b=Bi5jnlEUBw/IC3RO93DERQYIkweFhLObZEywWIT3XTZ439dT+xkCzFOC0zjJXq2CVN
         SyMBkk9R+IxKxi62l2ME6Y4Yk74VFJXD+axOe6z24TuC1xHA+5r2BMIZnXKiAI6xEYEo
         wUuhZacL7r7uggDkWZ6ftTwHBR08PZGQ3O3lPjypvI9nL58Q1LZD1q9NXVTi04CpuseT
         c/jDqaqtNG6EFez5DlEtT1+fZG+c4LUFV38Wn3czorcAw0N2OizoknV5/ZhgulPGdchi
         VSTpaDk1H5UQpM2BKDloy9RKDZc+QEM1OZyihKUlHaNRUcTp8hsNlwOV/+GYFglIMf+w
         GXMg==
X-Gm-Message-State: AA+aEWb/BNq/d/0/vh5srfZG4VedLsDllQOe9zvYVembvR4pbmwijKBs
        cJwlGdFy7irLPMyia5L+Vo90TQ==
X-Google-Smtp-Source: AFSGD/Wfns9xl52m4apvfGorWaHkXBkFJCo7oX70SMuN/8wOlmGgre7AZSoAN6Zs8x4gVda+1tkO4Q==
X-Received: by 2002:a1c:174f:: with SMTP id 76mr1406294wmx.116.1543341941110;
        Tue, 27 Nov 2018 10:05:41 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 14sm8291119wmv.36.2018.11.27.10.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 10:05:40 -0800 (PST)
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Sitaraman <ksitaraman@nvidia.com>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
Message-ID: <bfed1f52-1544-8491-9f0f-b46c2787b45e@linaro.org>
Date:   Tue, 27 Nov 2018 20:05:39 +0200
MIME-Version: 1.0
In-Reply-To: <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 9/26/18 17:42, Georgi Djakov wrote:
> Hi Rob,
> 
> Thanks for the comments!
> 
> On 09/25/2018 09:02 PM, Rob Herring wrote:
>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>> This binding is intended to represent the relations between the interconnect
>>> controllers (providers) and consumer device nodes. It will allow creating links
>>> between consumers and interconnect paths (exposed by interconnect providers).
>>
>> As I mentioned in person, I want to see other SoC families using this
>> before accepting. They don't have to be ready for upstream, but WIP
>> patches or even just a "yes, this works for us and we're going to use
>> this binding on X".

Patches for the iMX7ULP platform are already available [1]. Thanks 
Alexandre Bailon!

The interconnect API seems to be also a good fit for Nvidia SoCs. There 
is an ongoing discussion about implementing an interconnect provider 
driver for Tegra [2]. Thanks Thierry and Krishna!

In addition of the above, i also checked privately with a few other SoC 
maintainers and made them aware of these patches. Some are not ready for 
upstream yet, but the feedback was positive and i expect more SoCs to 
make use of this in the future.

BR,
Georgi

[1] https://lkml.org/lkml/2018/11/17/368
[2] https://marc.info/?t=154056181900001&r=1&w=2


> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
> currently using this binding, there is ongoing work from at least two
> other vendors that would be using this same binding. I will check on
> what is their progress so far.
> 
>> Also, I think the QCom GPU use of this should be fully sorted out. Or
>> more generically how this fits into OPP binding which seems to be never
>> ending extended...
> 
> I see this as a further step. It could be OPP binding which include
> bandwidth values or some separate DT property. Jordan has already
> proposed something, do you have any initial comments on that?
> 
> BR,
> Georgi
> 
