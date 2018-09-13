Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCAAC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7856820881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJ/YWFtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7856820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeIMPaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:30:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIMPaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:30:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so4154161ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+hrBtGdAXBLZd2TXIddL4V+8X3o8MCs1FECk1jP34YY=;
        b=DJ/YWFtn40j1r3ycfkVRrbj8ItKp+eHiMiF6Hnrp8rkt+GyHaPm/d6H1N8CwQh+1Cp
         goE8pbbZmquyadlLR74QrVaDbvwUnU60IPjw9ya6JJVLA3i18RB1sjmBGTZ9qkZ9CDTz
         ye6Q+cxO/pMmneMXNkKiugFhb2tizlejgchT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+hrBtGdAXBLZd2TXIddL4V+8X3o8MCs1FECk1jP34YY=;
        b=MVBkwzanhjxoZsw3PwptHwAkzzSaYePtmi4+KoFqBNtfnv2/l0VMmqL4vNlhSJYa9w
         WHRh1mFwdLjC+o2KJFQzFDn8BVxOVoVQrHejojGQv7x2ofRwU4N6KjFZat66uxRvo9x/
         DpqA32fJRF+AhFf/p6DZwX94toFsXcjN5cFEZBLVc+wcjjyivcxPJWO5DcEcYhmvneod
         fpXd7MNIxEmYSB4w/AlGBX7SAEmtrCVnsrt4uCA+AeybtfRiuys19BPGBAdoNMAEt790
         aYtzhdFH/FnCAF4R8sfc0zgxwHq82mWkWNwyqHTzwXWjiCD3znIJ42NSHNWHpm/dNPI6
         hipQ==
X-Gm-Message-State: APzg51A8Z/XeyZmZSwunoCxOoyMMV70Sh8ptjt9rBDVrZcDX/J/lX5lO
        DEJao4u+BLXmQJFh78swE4NRRA==
X-Google-Smtp-Source: ANB0VdYnvAJViGOQK5e3UD/OGkV+qEZmtSsBJbGu5SyNOsyFPnRmqIjwjdNkJVB4u55xPxPHKTnttw==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr3976734ljk.42.1536834076295;
        Thu, 13 Sep 2018 03:21:16 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id n3-v6sm613062lji.96.2018.09.13.03.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 03:21:15 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:21:13 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4.18" <stable@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
Message-ID: <20180913102113.GA25222@centauri.lan>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <20180912135537.GA9985@centauri.ideon.se>
 <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 01:18:34PM +0530, Viresh Kumar wrote:
> On 12 September 2018 at 19:25, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> > On Wed, Sep 12, 2018 at 01:58:39PM +0530, Viresh Kumar wrote:
> >> Hello,
> >>
> >> Niklas Cassle recently reported some regressions with his Qcom cpufreq
> >> driver where he was getting some errors while creating the OPPs tables.
> >>
> >> After looking into it I realized that the OPP core incorrectly creates
> >> multiple OPP tables for the devices even if they are sharing the OPP
> >> table in DT. This happens when the request comes using different CPU
> >> devices. For example, dev_pm_opp_set_supported_hw() getting called using
> >> CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.
> >>
> >> This series redesigns the internals of the OPP core to fix that. The
> >> redesign has simplified the core itself though.
> >>
> >> @Niklas: Can you please confirm that this series fixes the issues you
> >> have reported ? I have already tested it on Hikey960.
> >
> > Hello Viresh,
> >
> > This fixes the OPP error messages that I previously reported.
> >
> > However, I also tested to add a duplicate OPP to the opp-table.
> >
> > Before this series, I got the first two error prints.
> > After this series, I get the first two error prints + the use after free splat.
> 
> This looks to be an old bug. Can you please try this branch:

Hello Viresh,

You confused me here, since you did hide the fix for this old bug in the
middle of your new patch series :)

I think that it would have been more obvious to simply paste the fix/diff
in your reply directly, since that is the most common way to post a
potential fix. Or, if you are really confident in your fix, post a V2
directly.

However, your branch works like a charm, so feel free to add:
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
when sending out your branch as a V2.

Kind regards,
Niklas

> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/qcom-fix
> 
> ?
