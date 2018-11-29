Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819FC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8FB2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y8BqipgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8FB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeK3Kf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:35:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32849 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Kf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:35:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so1822580plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=sWbxhkFth6vBUM1Snfeosc2LQRu3OThmz1EQOLm+GtE=;
        b=Y8BqipgP0P8KiOPbWRR0HSv3yNvQns2cREminu0kcCwGBNo31c59pVet7RZ95dB5wa
         jupLyKSqWXUE73WuMhQmMGZR0Htfz8nzmeEwx/1RswqBfVmHRyjyX7Fv/aJ4bsI4iW0p
         Qp4PayFkbz9HGnpyJqjMW5R8k4pDpoJF+NOMiykS1yXTSnm3grBJEjRPYS5ZRDxJkpX7
         8abht64xdiGB7ZrezQ6igmHtw/dsfh6bYRUdZTaaTMrUE0qHh17MOupmmsR4AeBC/C1p
         NfuSDxaVd+1w7/ja2ZauZvTYyg5ACme+60F8bwalj+lPE3TEfF1bz3G60ty9ckD/gb8r
         7rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sWbxhkFth6vBUM1Snfeosc2LQRu3OThmz1EQOLm+GtE=;
        b=hWOikzkaFwQ9NKhZPtaoW6mgkjxXLnCtlBrqtPHtGILN3NNdwyueAE9g34nmr9LiMq
         DtV85BP0UKNk4ijO9BPjtD37R+yg5tpD8vKEXKmLUBZkpc6nVtcCGHVGGd83W4pp0EfB
         jdCZMhjt0or+2dAb5W/yh2sDkZVsshtmq3bQaixUrv18sqa9LoEOvnQjwThuCmPFh9A/
         zvGgcIVI6nXdcdllsXkYesinrYBljlrPQxs8DeHSDrGS3feQn11v9vYx3QkIwhVOz3Kf
         nsL6e8+5p5nITIj3bz44AL2oRn3fq8dDY576CCQazAgvKfX+sk/9NS8TV9HzNH194Ky3
         JH+w==
X-Gm-Message-State: AA+aEWZpsXjmscX62v8S87gcVn2Qox5zr/8HQHkTnkUYlFPmE7fQ7Bei
        X9BF1xZOu9kwuMqiOx9h7ba58A==
X-Google-Smtp-Source: AFSGD/X3OKi16ppD27/OdLHWtokaOXJm/Xe01KObh0iafGtVGjCVGpxow+wUi5kFnJ5Ua41K+RIFgw==
X-Received: by 2002:a17:902:7d82:: with SMTP id a2mr3419606plm.163.1543534124838;
        Thu, 29 Nov 2018 15:28:44 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id z62sm4484115pfl.33.2018.11.29.15.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:28:44 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
In-Reply-To: <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com> <7hh8g0d8tg.fsf@baylibre.com> <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
Date:   Thu, 29 Nov 2018 15:28:42 -0800
Message-ID: <7hk1kv79at.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Kevin,
>
> On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
>> > voltage supply of the CPU cores (this regulator is typically called
>> > "VCCK").
>> > Now that we are preparing support for CPU frequency scaling on Meson8,
>> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
>> > kernel so we can configure the CPU voltage early in the boot process.
>>
>> Can you explain a little more why the configuration of CPU voltage
>> cannot wait a bit so this could be properly probed?
>
> I was under the impression that cpufreq-dt would still initialize even
> if the regulator is not ready yet. however (after reading the code
> again) this is clearly NOT the case.

Hmm, a quick look at cpufreq-dt suggests that it should -EPROBE_DEFER if
the regulator isn't ready yet.  Why doesn't that work?

> there's still a benefit with this change: your Odroid-C1 in your
> KernelCI lab would also be able to change the CPU frequency (so in
> case something breaks we could spot it there).
> will you accept this patch after I updated the description to mention
> that it's for KernelCI test coverage?

Possibly, but I'd still rather see the dependencies worked out correctly
so that this can be module, and cpufreq-dt would defer until it's ready.

Kevin
