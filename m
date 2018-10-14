Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8CC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EAE20652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlKxVk66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EAE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeJOEUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 00:20:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39715 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeJOEUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 00:20:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so18908978wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Muedtq7GBjkdYyk5pDNZjLjjjYAUTyQ0GAagivEO2lo=;
        b=AlKxVk66Ia5iTAuay+Lhlf0zJvcVogfoDWl/WMvfwSvPZppBeJyeHAsqFRBEbBpvBp
         AAOuNQ8jfN0nnweDKmqtr/XtecCWrjzTuOu9VBhkxCVWmy2oevPz2RFFihwCgMphtKxS
         OH8OspzaCfU7Q13tF46Nz9oiz5ja5RxQ5uHVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Muedtq7GBjkdYyk5pDNZjLjjjYAUTyQ0GAagivEO2lo=;
        b=E6OsadxfsrpFad8KSZZUfteVKjHhSDCsj7MRa00lYqseYsa/njGOwxUxw36QfTOGpg
         7bvPNd00Lv1/+GGDNWfJyZyB3A3hA3VetG28HFI9fNxyr3T3+tWPkhYBBT57LGLB+A5G
         9/l513dB69lhEXlSz2l4Lzg+5EwLky7LwJXCh344Qi6BaxCpd9sO/nr9MiEebb7JWUcM
         7oyx9vcDQ/Fk+V73tRkOvXnizBBw+ff+slWdBRXXsHRWyBElJt7Hq40QonTVHZFeTksH
         Y12XC2u6o7OigqJKErI9fEwZaaN8YIk+/uBiLkKobtiszrSn2rIf3VJ/8/a8I8d/DAjX
         gFBg==
X-Gm-Message-State: ABuFfojeiwcYTB1x/osqfSdhshV607eD4hTHa/OJ74+L3uB2BIi3W2nx
        V1xxbuSplftpZg+b1S7yszIAOg==
X-Google-Smtp-Source: ACcGV60zUBFHw24GGL0fCiKGr8nMAFmtYTfJH796jar1QhYfsg/i0oFxYnhzyqBn2VdhfnkddveHQQ==
X-Received: by 2002:adf:e808:: with SMTP id o8-v6mr11521208wrm.269.1539549518793;
        Sun, 14 Oct 2018 13:38:38 -0700 (PDT)
Received: from [192.168.0.40] ([80.125.189.32])
        by smtp.googlemail.com with ESMTPSA id c64-v6sm5993607wma.44.2018.10.14.13.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 13:38:37 -0700 (PDT)
Subject: Re: [PATCH V12 0/8] C-SKY(csky) Linux Kernel Driver
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        jhogan@kernel.org, paul.burton@mips.com, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1539315341.git.ren_guo@c-sky.com>
 <dfe56d38-cfa5-2be1-114e-c6721d6c92a3@linaro.org>
 <20181014162631.GA13374@guoren-Inspiron-7460>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <36e2cb6d-6d9e-4764-a6dd-a5f74cab5a09@linaro.org>
Date:   Sun, 14 Oct 2018 22:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014162631.GA13374@guoren-Inspiron-7460>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2018 18:26, Guo Ren wrote:
> Hi Daniel,
> 
> Thx for reply and review.
> 
> On Sat, Oct 13, 2018 at 10:50:34PM +0200, Daniel Lezcano wrote:
>> On 12/10/2018 14:02, Guo Ren wrote:
>>> This is about 12th patchset for C-SKY linux drivers and it should pair
>>> with 8th kernel patchset.
>>
>> Guo,
>>
>> I'm willing to take your timer related patches but you have to put a
>> proper description.
> 
> Ok, I've improved all my comment for the drivers. Here is my modification:

Thanks Guo,

the descriptions look ok for the timer part. Can you resend the DT
bindings + timers patches separately with the commit log updated ?

When you add the Changelog you have to insert it *after* the first
'---', so when the patch is git applied, the change log will be
discarded and won't appear in git.

eg.

commit 6b465856936cb8f7eda31b20eb59fb5c8a19d468
Author: Guo Ren <ren_guo@c-sky.com>
Date:   Tue Oct 2 16:43:18 2018 +0800

clocksource: add gx6605s SOC system timer

The driver is for gx6605s SOC system timer and there are two
same timers in gx6605s. We use one for clkevt and another one for
clksrc.

The timer is mmio map to access, so we need give mmio address in dts.
The counter at 0x0  offset is clock event. The counter at 0x40 offset is
clock source.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
     - pass checkpatch.pl
     - Add COMIPLE_TEST in Kconfig
     - no cast is needed for "struct clock_event_device *ce = dev"
     - remove: extra space after (u64)
     - Add License and Copyright
     - Use timer-of framework
     - Change name with upstream feedback
     - Use clksource_mmio framework
---


Thanks

  -- Daniel




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

