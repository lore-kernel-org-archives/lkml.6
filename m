Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB9EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026F3218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551219095;
	bh=JgxewvZL9yicc5I+x0166hHvE+MngKlUGNApsDP0lqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IWSDamLUoi4OkZJN0J5DHOavuKcNhT9ONDlMFJwcatq9qxz6/2RoFojUbklxqaNSG
	 Fp3JLZrzRdgddc56vtnXwUoEhojZAYX/9ZL7eEFLhgElEFZ/0ssD4pQDLiPTWAnCWj
	 6jIc4ccD3DKuZGMfcuISiev/csOKA/DT5Aai1j+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfBZWLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:11:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35949 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:11:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id t206so11744774oib.3;
        Tue, 26 Feb 2019 14:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IINA/hllyo9vqhgF5Pi1jx3T2WsGGNckh4bq0dzFHBk=;
        b=fSK0/7dmGgqGOicIFNQNFiXKjnukzNF3hY9Yk9JqGT9qzLv3nIOTqqEnnOYI/Zweed
         FVwafpkwW7aaAT2dWEpMF3JNFIDWixQWW6hGr3yAXAmPHFalP6N9EY5thXM//p/bd0UR
         ctcDwD4Yq6b6P9f3riK0NUfbxNs8Mps1Rl5oPeT3nN2KKkLWu8Hip8BtQC8oipUmgWkb
         5uFRnQbLo0V6mC6xP8YS/7wTx5Mz+oUsWRFoOybryxNcRDd+Mllh9GCq0md4S9OANNcI
         IKYvk7MFjR65NmW3YUbDaukkEKQ5tOZJM/oGHVHtd5w7SOOVkZVGY03q6K3ryRnCx8RU
         8xVA==
X-Gm-Message-State: AHQUAuY4Z5LcTUhkE4JdvYKhK8H9NlI3lsY6mXhqHiE65A3wKytii66F
        EI0E+jk9mLK2WWzpG4mxHbjovx7wN7+1m2Sekl4=
X-Google-Smtp-Source: AHgI3IbRu8kzwyq5aDQt9KLm/BVxZmnu2I7fpqBnPUufdesoi+hhHEsOC7GjJiz9bo01KD3iAi/EyJay9K1ghwnDUlE=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3868685oii.95.1551219091906;
 Tue, 26 Feb 2019 14:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
 <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
 <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com> <CAPDyKFoxEA09ZKAb=zu_xO13Li-6=ipnxcJDe1B9PWyxKsUxcQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoxEA09ZKAb=zu_xO13Li-6=ipnxcJDe1B9PWyxKsUxcQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Feb 2019 23:11:20 +0100
Message-ID: <CAJZ5v0g8Do3v_+0EE1W=8LCi6RsXc5s1HaRUXSbr6mXFPsFKVg@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Feb 26, 2019 at 11:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 22:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > Changes in v11:
> > > > >  - This version contains only the infrastructure changes that is needed for
> > > > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > > > post them separately. Still, to provide completeness, I have published a branch
> > > > > containing everything to a git tree [1], feel free to have a look and test.
> > > > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > > > which has been replaced by a couple of new patches, whom reworks the existing
> > > > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > > > instead of the duration.
> > > > >  - More changelogs are available per patch.
> > > >
> > > > NAK for patches [4-6/8].
> > > >
> > > > The code as is specifically avoids calling ktime_get() from the
> > > > governors as that can be quite expensive, so these patches potentially
> > > > make things worse.
> > >
> > > Yeah, good point! What do you think about folding in a patch into the
> > > series, like below, and then let the cpuidle governors use it?
> >
> > It is not objectionable as it stands, but that also depends on what
> > the new function is used for.
> >
> > In particular, I don't really think that the menu and teo governors
> > need to call it at all.
>
> Well, if we are going to re-work the code as suggested in the series,
> then how would you suggest to get rid of the calls to ktime_get() that
> is introduced in patch 4 and patch5?
>
> BTW, at a closer look I am even tempted to squash patch3 to patch6
> (including the part I attached earlier) as this part of the series is
> really a re-work of tick_nohz_get_sleep_length() and its users.

Which is unnecessary IMO - see my reply to patch [7/8].
