Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C2DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D7125606
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VngkXnFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D7125606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeFYIem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:34:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41215 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeFYIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:34:39 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so8974641ioa.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gN1Mp69z/SBIh4XzKqmns9xAz4UtNJHYMyHKTNGG4UI=;
        b=VngkXnFoxdUgXP91IDYY69Ciccu4sNOmHL1TJ2YjBwImbQLC/+7ryeIN55wfov9BDp
         L6R2+Jd/huepYJ9Cw5I8h453RtRlLk7a+KEotu+a4qdRZryRxQBYZOcNEmoiVmX8hf/z
         w4kZn2fLg2W4iidkbf1K1SMgqc273b3AUKdR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gN1Mp69z/SBIh4XzKqmns9xAz4UtNJHYMyHKTNGG4UI=;
        b=B4ZZXd8LBswXWNHnVwBeZd2yJeOrMtGtJ66rqQ6xt7OpRnLRR/DkcwISNrsGJ3bfkl
         bFbM4fj6Q3CpaD3TFt6x5o7PkMEtYx9cRJnuW9oKAMh1c2myHEsgoO3jr1ygT1gAF1+f
         4GAsl41pU29vQUR3PYHb525YXf3I10s2+E7acCWZRR7J9cSQkdveJvH8xQA6NBHrqdo6
         Vn7skT72QEDgp9yfFQeRAXZ8gtZCeiDQ6KjHFeMTNliPf3aJPs2Om72g8I9OPEZ4I2qZ
         vTgmsAGHeaCG+zAA70USR0pTNmT+XMUhf/O7mFVysF+pqHXLAuSA28O1X1BDO25FvLzO
         Qc5A==
X-Gm-Message-State: APt69E3GfwhGzhU6O/3lRPob8slxEz0P+0gEv68sM7cYp5sxiNacwtH2
        Jg3dNXVFTPbN8+bCcTwJUOLFdx1BBnDpdwAwKyoexw==
X-Google-Smtp-Source: AAOMgpclnq8tz0rNO2jA3JfHUIeipqs/dIhxzVKZInODX2sSVsatSrljx+UjsQ9s80FiK6hkt9HhQf5DfsHTzPT7YLY=
X-Received: by 2002:a6b:c992:: with SMTP id z140-v6mr9709798iof.266.1529915679077;
 Mon, 25 Jun 2018 01:34:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:34:38
 -0700 (PDT)
In-Reply-To: <CAJZ5v0i52JTFbvBBaDyNHCnTz3UMW00NiodFpzS5m614D++9uA@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-4-ulf.hansson@linaro.org> <CAJZ5v0i52JTFbvBBaDyNHCnTz3UMW00NiodFpzS5m614D++9uA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Jun 2018 10:34:38 +0200
Message-ID: <CAPDyKFrB71OyLTFX9huc30R+SXtMWw5Kn4qM4bXi-DHFM+UYfQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/26] PM / Domains: Add generic data pointer to
 genpd_power_state struct
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 June 2018 at 23:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 7:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> From: Lina Iyer <lina.iyer@linaro.org>
>>
>> Let's add a data pointer to the genpd_power_state struct, to allow
>> platforms to store per state specific data.
>
> Can you please fold it into a patch actually using this pointer?

Yep, no problem.

Anyway, the change that uses the pointer is "[PATCH v8 21/26] drivers:
firmware: psci: Add support for PM domains using genpd".

Let's see if there is further comments, if not - perhaps you can
squash $subject patch into that change?

>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  include/linux/pm_domain.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 9206a4fef9ac..27fca748344a 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -44,6 +44,7 @@ struct genpd_power_state {
>>         s64 residency_ns;
>>         struct fwnode_handle *fwnode;
>>         ktime_t idle_time;
>> +       void *data;
>>  };
>>
>>  struct genpd_lock_ops;
>> --
>> 2.17.1
>>

Kind regards
Uffe
