Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13874C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B9E2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203426;
	bh=pbvwPAt09twopLvxuXWK0FH1zkDp8jRmVyZuPcqV8hw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MIv9+eZFEOkgp0S+nSOJ7lQckezt8/c9pLlkCHAKpy4oJvWlVDOJhob3VAbrvCIBr
	 viZ/sivnF5lbslZFmgdc5/1MrYsZd1AUb09RGtDHM/hwwpFq9ul2IEBPLRFv0P3/O5
	 S8navbtZGN/DrKMpU0AJC4nl0VPLYQkdoE+BsuEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfBZRuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:50:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44462 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:50:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id g1so11805282otj.11;
        Tue, 26 Feb 2019 09:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXMHoA+e6KvFK4k3IVcJ2Rj0Ytz/58ELiPETz53e63M=;
        b=bTTu9sT+zT6+clbzGVCvIpiuP+e8HTlL9H/DK0OGfmxMm1lqz+Lxj6tzGwpq94i583
         i0QsLsblyyCiKJ45aBrfEDW4caO0oODbTE/6/Yv50pgBvIzRidqesnPkqbv+M4c/V00v
         xm2/XIzTTMzFUCQ4C8jVqmT3C+6ImW+3DDr4uT3cRi8l2hNFEzdaFbXDDQfAwotQYWNB
         bvV8LFBdj1mVI92XOd6sOSMN/9YMpDHl7cfC0Pe7/iYSNP9nQKSYiFD1dBx9Z1tn/Cz9
         +e8qLnIHITlBmYokMty3piLPtYZSlniFvI3sirLQM216/wd3uD2xhxT4Y1uTTKFiFgls
         D4XQ==
X-Gm-Message-State: AHQUAubK1UtCY6Bngn+7DT6OEIY3d06n4fE8Jj/IPKbnwd07vccziWpF
        YA5oZOINbHWUxvDtaUDWGf45FvTLSjeIEDxmhtA=
X-Google-Smtp-Source: AHgI3IYG36r78AFYK5oZRrsLFkV2c/ou8NID5EzMjerFlWJPEctH8vIVuNeNGfx3JUh0wvRfsffu/0p74gVb1DCFBrY=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr10485755otf.124.1551203424194;
 Tue, 26 Feb 2019 09:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Feb 2019 18:50:13 +0100
Message-ID: <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
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

On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v11:
>  - This version contains only the infrastructure changes that is needed for
> deployment. The PSCI/ARM changes have also been updated and tested, but I will
> post them separately. Still, to provide completeness, I have published a branch
> containing everything to a git tree [1], feel free to have a look and test.
>  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> which has been replaced by a couple of new patches, whom reworks the existing
> tick_nohz_get_sleep_length() function, to provide the next timer expiration
> instead of the duration.
>  - More changelogs are available per patch.

NAK for patches [4-6/8].

The code as is specifically avoids calling ktime_get() from the
governors as that can be quite expensive, so these patches potentially
make things worse.
