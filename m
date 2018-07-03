Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D8CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A0424DE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI8AM80z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A0424DE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeGCHyQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:54:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37708 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932566AbeGCHyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:54:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so1972871oib.4;
        Tue, 03 Jul 2018 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8esrqijFPcP4/aomus5IEEwH+C7lj8s7ltrYE/2E3PM=;
        b=sI8AM80zpii5Sx+F1ULumCXmCpOcUYpikrAhf2XGYbUeB3Roc2cR/TtpNI6IZzMfn8
         FpiGgL+wj9ObU0LNhPiQEj2gOJuwnYKwPrfmuMos5+g0vLW5Es9sArdxtqVb9ZHayiF9
         DIEq8GAtIRVjsmJvOZn7YKLjDP5c7bgrvHv4hdD3DZWQ8DOl/OB3qLnVf02UACiVzVl+
         SBPXu4+PGAPGXffi9mzjt8NMc4haS0ViUmhf3Rjff6bQoUQOu0ioNXyBw9RJHhQjZH1l
         8BU/djU0IRx+Qyiw26AA1IZMl/90Dag6iEUxQ3ltzH1zkHc/sSYbEHTGMBRfBhbJsLin
         0D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8esrqijFPcP4/aomus5IEEwH+C7lj8s7ltrYE/2E3PM=;
        b=Oudd20SGGYv0/35zrEajzSpK8nYVeKQNvNlLrN407eWmsKrNwvUv/b6TzEbA0+Ft51
         DbdEXaZhO3WJhI6zotgNA6O0bUT1H//v5cLyTZLs7Al4DC2pc9S5U8bbUZSeL6CXgtHJ
         8/1qqR4ce/6uCWBP0leID4A9akZSptU5dTWidENijmdlKxos9R35m4eERaHfMx3qHGJ/
         phM6FcDCcEAECwTeYZ3ECf+B6J5qxumMhuyWJ8+59fldvaFOfr8BgPkH10d4mv8QGYAl
         qOtc29XYYgf6ysI5S14CnsyWZmuUPCzagebP1apk5PzwLeALsY5aXRr85WUIlnGycjyE
         Cabg==
X-Gm-Message-State: APt69E3b4J7yOed0Ex790ac9iL33YQRb6H5T93EgUrgzJoyW6ndBUPfP
        L1iXJNxxBgUTBscK2UxHa5EBcM/2xKVH75R0Zdg=
X-Google-Smtp-Source: AAOMgpc6/s5uyImOUDT2G4QkAnrOhjwUYhv69a3ikTuLRMeNW6GCdgXSznYYeaQrDA+YvrtkGgFnPDA2BcMZ3FI8w34=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr20250077oie.174.1530604452475;
 Tue, 03 Jul 2018 00:54:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:54:12 -0700 (PDT)
In-Reply-To: <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Jul 2018 09:54:12 +0200
X-Google-Sender-Auth: 9BxTgHd0XOsLqScjpghyOQ5BbJk
Message-ID: <CAJZ5v0hcBiYPMh8V50yq0jQud32Ey8V-ukiavJkP4PU4zAiFyg@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Tue, Jul 3, 2018 at 7:44 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rafael,
>
> On 20 June 2018 at 19:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Changes in v8:
>>  - Added some tags for reviews and acks.
>>  - Cleanup timer patch (patch6) according to comments from Rafael.
>>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>>    improve the new function description a bit.
>>  - Corrected malformed SPDX-License-Identifier in patch20.
>
> There have only been a minor comment from you at patch3 (about
> squashing it with patch21), with that fixed and assuming there are no
> further comments - would you like me to collect the changes and send
> it to you as a pull request?

I have not looked at them in detail yet, sorry.

I any case, I'll apply the patches by hand.

Thanks,
Rafael
