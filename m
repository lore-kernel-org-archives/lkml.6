Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671B42177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MQyAViwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfAKAg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:36:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39928 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbfAKAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:36:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so5543652pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Tg7Of7yfTzZ306F/K4qCSlYHP5A6DxEIoqC8M4YN+vY=;
        b=MQyAViwSN01pOAfrrM921Gs4lkY0lyizOADbno1ks5RZ+GlZihXvS9GJHc1b339YxN
         /cVWpPBuoAoQ4EtdGPktE1ljnwJsSRk0kmuOWC1vzcg1pgDU6tLEerT7wIPLDEJe8yNR
         57+eAmCXE5eukDsM+LgGwevXqNKGYFvFfAvvjFpy+W8TF8SBj+tK/YkdHh65rouxO22q
         2eewIBkwXZeRmiVXNwHYG0VtdL6AF9tzAxG2LZ+RgWKyzkUiFQm6OoVPxb+lQihjfa8W
         3yCbm20kK7P5J/0eX8YSCF4bhu7W6LAAH2/MxFJw8DqRB+zkSWUXGIDGA5rRSsgNmAi4
         TP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Tg7Of7yfTzZ306F/K4qCSlYHP5A6DxEIoqC8M4YN+vY=;
        b=kccR9aJIGhCkvB6KTKMV0Ubjw1Bn/lsEKZ9doCbkR8oabQtNvIOuOBwVaneiBqOB6K
         PDmMolMI9Sfc9it6b1/sDPrh2UkUpdI9BMpJVs+KBQEpQYhLYMZ+2DpGDYwCx1cYAEUC
         8vmcc2zKvRsRwYQb2X/jfYFIk+AVQbTzOJvJg8aCaTphx5Pidp9Sj/o0r8a9NbYFRuRQ
         eKF3B3sw6Ub7Vx+6hQKPEGrhEsw7IHpW0XLV+2YjSQmGwPdYFQuuOxzDLb0qtMAjQlWi
         0mKo+ORY/RbOgJLRWR0Yqi2xHr+Ru2WEi4t7ZBD7u8YNEAsUN7yNfZYLRFDx2fGczoeM
         d12A==
X-Gm-Message-State: AJcUukdWraXYuBRydye90SZLZSUBhXPevGB47HMuT4zZndlVvHhcMZpl
        WPkJywxW8rwLwthlifb99koCEg==
X-Google-Smtp-Source: ALg8bN66d6XtM6IH1M/QANv1bw6+4LfmMjOinIvMqGnH63lRt0UZyynMHQzdIY1RzhQg6Aj6pOyFgw==
X-Received: by 2002:a62:5793:: with SMTP id i19mr12431040pfj.49.1547166988352;
        Thu, 10 Jan 2019 16:36:28 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id g11sm107288074pfo.139.2019.01.10.16.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:36:27 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
In-Reply-To: <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com> <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
Date:   Thu, 10 Jan 2019 16:36:27 -0800
Message-ID: <7himywqbck.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 08/12/2018 17:50, Martin Blumenstingl wrote:
>> This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
>> Meson6. This is preparation work for adding the Mali GPU which is
>> located on theses busses.
>> 
>> Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
>> region at 0xd0000000 is called APB2 or A9_APB and it has a different
>> size (256k) compared to Meson8 and Meson8b (2M).
>> 
>> Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
>> - Meson6: [0]
>> - Meson8: [1]
>> - Meson8b: [2]
>> 
>> 
>> Changes since v1 at [3]:
>> - re-send the patches but this time don't include the old patches
>>   which still had a typo in the patch description (ABP vs APB)
>> 
>> 
>> [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
>> [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
>> [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
>> [3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html
>> 
>> 
>> Martin Blumenstingl (3):
>>   ARM: dts: meson6: add the APB2 bus
>>   ARM: dts: meson8: add the APB bus
>>   ARM: dts: meson8b: add the APB bus
>> 
>>  arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
>>  arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
>>  arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
>>  3 files changed, 24 insertions(+)
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> But frankly I'll squash the meson8/meson8b patches with the mali node patches !

In general, I agree with Neil.  Adding the new busses along with the
series that uses them would be fine, but I don't have a strong
preference.

So queueing this series as is for v5.1 (branch: v5.1/dt)

Kevin
