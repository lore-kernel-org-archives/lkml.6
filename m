Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5194C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FD92084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+BwXYsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FD92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJDVv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:51:58 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:39783 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:51:58 -0400
Received: by mail-it1-f169.google.com with SMTP id w200-v6so14419129itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DM+zNmB7OI8OGxVUhYuwDbO1R9ste+zcr3X/ukoAHRA=;
        b=g+BwXYsGGkEc3vov39xtcyWifhvEmUahE2a/qVwkaT3Le3BD13UvkwpOjoKrHFBvOg
         e6MnZmT2hWluVtW/DgMob7vTnU6Crsqog0CqZ/awth3Lm6OHTqFa5BdObcU2/pKOfMeY
         u4AXDbuge5DVv40cob009hq+0UH+KJqPBpYdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DM+zNmB7OI8OGxVUhYuwDbO1R9ste+zcr3X/ukoAHRA=;
        b=jcxY4P4h8/AID3UT5oNMibGWPgRGp5Y+O6+Y3tvs9l1j2xuEBard/kJib8x8RGRooX
         Bof3Qll8W0GllDlHFbMkzrR2WTk94wGFDZH9H1LoCXVYTALbnQTW/9tqcozepL2KHbjO
         hQDbIgtcN0rn64XYNeKIP/1P/E5n/8CNy4Mqv/Zs0J6HD2UvLJxKUfI/rWkkA2zjgm32
         niLv73ghkEOU1DsB42Esv0ZHdSnoYyHw6q2mkjuWtFGg3ysiSiJ2u5+GwRWCY1fFZrWI
         ONknRcYZUMD885dl34d5utg/EtP202Yy4D9IDV3OwN1TCA6SJuyKpU6jI8E6fD/kEY9c
         7pAQ==
X-Gm-Message-State: ABuFfoi9vR1WWOPQMM4OggYHMR1w96Tmw+KqX4jL99PmALaTm3Rt0cpp
        BkwpGMDfQ8+mbCOZCIfXUOHxsDhpytK+tRIeEdp6DQ==
X-Google-Smtp-Source: ACcGV60g4btd/UErdt+YQ5vWMiSegTjnYzoc10jNF9m7I04yDrowZdevmoHcKeJJ9bJ4EA/FAetz54hDSFkTZecxS10=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr5459999itd.45.1538665098184;
 Thu, 04 Oct 2018 07:58:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 07:57:37 -0700 (PDT)
In-Reply-To: <20181004134839.GZ5662@atomide.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-4-ulf.hansson@linaro.org> <20181004134839.GZ5662@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 16:57:37 +0200
Message-ID: <CAPDyKFr1H_ah3OYqghQgADs8fwNd+HpjWw9VfGR1T1-K5KbnhQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] PM / Domains: Document flags for genpd
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 15:48, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [181003 14:43]:
>> + * GENPD_FLAG_IRQ_SAFE:              This informs genpd that its backend callbacks,
>> + *                           ->power_on|off(), doesn't sleep. Hence, these
>> + *                           can be invoked from within atomic context, which
>> + *                           enables genpd to power on/off the PM domain,
>> + *                           even when pm_runtime_is_irq_safe() returns true,
>> + *                           for any of its attached devices. Note that, a
>> + *                           genpd having this flag set, requires its
>> + *                           masterdomains to also have it set.
>> + *
>
> Let's try to avoid adding more irq_safe stuff because of having that
> propagate to the masterdomains..

I am not sure I get your point. This is just documenting existing
functionality in genpd, there is nothing new here.

>
> I think you can just flag the power_on/off in genpd, then have cpu_pm
> callbacks do it.

Not really sure what you propose, but feel free to send a patch.

Do note, genpd has since the beginning of its time tried to cope with
pm_runtime_irq_safe() devices. I admit it's quite complicated, however
GENPD_FLAG_IRQ_SAFE greatly improved the support for such devices and
their PM domains. Moreover, we need this functionality, in one way or
the other, as long as there users of pm_runtime_irq_safe().

Kind regards
Uffe
