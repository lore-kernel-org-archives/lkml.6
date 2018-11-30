Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C9C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBCC20989
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WJS3e6AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBCC20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeK3L6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:58:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40471 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeK3L6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:58:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so1894519plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3qvdcJZ8PmRKbLEtfm59ggyyqKNvacVBja+BjrAt068=;
        b=WJS3e6AVEzrj2cNpHm8MlAx/K1Lv5wEha+ApFYew9Bvs+1Akii+dzTgWZ9BbQUCkWV
         y5y4PA8NJvMfqaqLZuhV8zutLSyWv78JxpzQSsaoIM9FmLWAP/VhSg9xTg9TbZ7yATHA
         opOnw31UXZPj25JGgXm174OWTW2U8Q6+UmQ22kN/OYkYuTaeq8PlVeEegBDOo8mFR0AD
         w14EujUcNJrxjQxWx1tYmBU7M7Y+zvvRTeWV/V+/vqlcDUBJEjjm1VuTIgTlh3eoMj/P
         y1VoW/IDW8mUb7+OWIT3iG7MNnAic6yrLXLKQPoPZOlJGpG5F3BzTqW6tn5JL4enJeM6
         8TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3qvdcJZ8PmRKbLEtfm59ggyyqKNvacVBja+BjrAt068=;
        b=IwepStt2KVf0dtpFwxigxRczEnxjJ7vSZVe5uGZt2tR4ilUlZ/7jM2SipoJx4tRHZn
         BWQcpclmhGHGmVD4Kru5cTleZqXotyN8DRHAEmrPZVo64rRw7yz7CeH8awb72yx2g36X
         lLaCLn1bSTeDlPmwIQvlyfAXungyWh7CiCuOHpGabsaZwZKwDX0Xzlhlwa8lnjh2TH5W
         UQI4x70Fuf9dUXbIdvQdusKkQu4RvMwrlRg+NBMELj/74AVz8aB6leTvaug3ZZGG0QNw
         6Ace7seLyqKbmtHBBq/G7HB99TwbeKJNPPZvE+5eEqzKD7cFi0EkRFmHD0Hlrl3FyQyJ
         Fv8g==
X-Gm-Message-State: AA+aEWYSlEX8kXBFtUL5RqBfLXiDHbJ8PyPSUC+VkHTw8TUMd7NliTS1
        vaKnh1ETVbhuDJydSbE7KcYS6Q==
X-Google-Smtp-Source: AFSGD/X9wmudIEKf+M0xp2qRrZW5YYkX6+DVaoYHlNiJQZtYuP0oHnlFoXVsE/JPb47cb1qJi8b8Lw==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr3709000plb.182.1543539072726;
        Thu, 29 Nov 2018 16:51:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id q75sm5257657pfa.38.2018.11.29.16.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 16:51:11 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
In-Reply-To: <CAFBinCB8r+5tGKxfsPMapayxmDuWOi=WihvvdxS=UxcnpeYqdQ@mail.gmail.com>
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com> <7hh8g0d8tg.fsf@baylibre.com> <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com> <7hk1kv79at.fsf@baylibre.com> <CAFBinCB8r+5tGKxfsPMapayxmDuWOi=WihvvdxS=UxcnpeYqdQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 16:51:10 -0800
Message-ID: <7hefb375hd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Kevin,
>
> On Fri, Nov 30, 2018 at 12:28 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> > Hi Kevin,
>> >
>> > On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
>> >>
>> >> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>> >>
>> >> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
>> >> > voltage supply of the CPU cores (this regulator is typically called
>> >> > "VCCK").
>> >> > Now that we are preparing support for CPU frequency scaling on Meson8,
>> >> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
>> >> > kernel so we can configure the CPU voltage early in the boot process.
>> >>
>> >> Can you explain a little more why the configuration of CPU voltage
>> >> cannot wait a bit so this could be properly probed?
>> >
>> > I was under the impression that cpufreq-dt would still initialize even
>> > if the regulator is not ready yet. however (after reading the code
>> > again) this is clearly NOT the case.
>>
>> Hmm, a quick look at cpufreq-dt suggests that it should -EPROBE_DEFER if
>> the regulator isn't ready yet.  Why doesn't that work?
> sorry for not being clear:
> I was under the impression that cpufreq-dt wouldn't handle -EPROBE_DEFER.
> I'm not sure why I assumed that. As you already said: deferred probing
> of the regulator works fine.
>
>> > there's still a benefit with this change: your Odroid-C1 in your
>> > KernelCI lab would also be able to change the CPU frequency (so in
>> > case something breaks we could spot it there).
>> > will you accept this patch after I updated the description to mention
>> > that it's for KernelCI test coverage?
>>
>> Possibly, but I'd still rather see the dependencies worked out correctly
>> so that this can be module, and cpufreq-dt would defer until it's ready.
> KernelCI shows multiple "pwm-regulator regulator-vcck: Failed to get
> PWM: -517" messages on Odroid-C1.
> however, what I failed to notice so far is that there's a
> "pwm-regulator: supplied by regulator-dummy" at the end of the boot
> process. does this mean that the Odroid-C1 in your KernelCI lab can
> load kernel modules? in that case this patch can be ignored.

All boards in my lab can load modules.  The boot with a minimal
buildroot-based ramdisk that uses eudev, so any drivers that are present
in DT will be loaded (if they're modules) or probed.

> (I will still send a PWM regulator related patch: that "Failed to get
> PWM: -517" message is very noisy and we typically suppress that in
> other drivers)

Sure, no objections to that one.

Kevin
