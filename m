Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488F820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlFm1D+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488F820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeKIUCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:02:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42722 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:02:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id x63-v6so1031287oix.9;
        Fri, 09 Nov 2018 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWACwKLAWw8MM/g0ZZfBRYEqltpqlUefrzfC7mPiHQc=;
        b=LlFm1D+MLOEFX2auIpJkkVYuzp4sVP4XVNJ9ZxFxbW5lbTH0W6ozR0rRLMl5mU+HCX
         Pt3xylBzMvCj9inPf51kMtz+qpiw0G3q+kiKS7cU9b3uot0mcoSg+DdIztliNTMJL7tP
         DC7GG9YxL149aw7BUipD9Ej1eIYt2oejNiBNF7JGbbM414hAQvjh3mV11Ceq/4ozjbXB
         P3fbM56vjn2LWT4zqiiSpeOQXO60iXAoaOfXX6pqrS00Bv3xfh1glvArhBjjSLhN2GLy
         ribAAl4BbGvT/QYth/Ymj1pLk064/kJlUF069ybmdDAs5YLdBg/pk3Rz0jI5IQxOq10P
         DMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWACwKLAWw8MM/g0ZZfBRYEqltpqlUefrzfC7mPiHQc=;
        b=KqdQ7vtMzRoR5SFohsOM0Vz2tI3aHC0bs+Jxoa1JgaFEVyEjZt2mPu++klvWbb3JRS
         MjrGG8/5SUJa9mWxYzr2i5UhArb2GKTpxsKzFczSEqeWg0tS/0r9P1+z3IER3vCPaaRN
         mDlbTBXC2n/4e8mFT2FVKhiYo8o2lqWltga7NrqTpnsCG4P9WDAmhDaUrzuCWlQF/P+L
         G9d4FeUOrc/byGkzRPUnjh9jlaa1RC3ynkUtYSMk0s0+Ebp2QlAq/U16cGu68J6sf5a2
         liXWVUv8NEa8rJszKhDWAp5EbuLW2ZRhDRzPVRpbZHA7gIerT7AuXE80qsNF2+11FoW1
         S6HQ==
X-Gm-Message-State: AGRZ1gIF5Geb7Z10DFbAKAqqoxUVRfvUY1qeT7oI5XU6Z5NdjY4GnSk5
        WwX+pAyX655zaPlkmISCnWmKddPXN4FJFwuupjE=
X-Google-Smtp-Source: AJdET5e9BBW9saJ8tbNbl//hnCNF4aj4jryaj75adji0CC3UT4+eTESU/lPPKIyWm5KDX/eGth49f8InjmWnMCsfM8E=
X-Received: by 2002:aca:503:: with SMTP id 3-v6mr4451784oif.302.1541758963891;
 Fri, 09 Nov 2018 02:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 9 Nov 2018 15:52:32 +0530
Message-ID: <CAKTKpr5eJJPX4Wpn=OvcZmzZYQpVgKBYYD1UEjEQZ0rH=DPTHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
To:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

can you please review this series?

On Thu, Oct 25, 2018 at 11:29 AM Kulkarni, Ganapatrao
<Ganapatrao.Kulkarni@cavium.com> wrote:
>
> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> The SoC has PMU support in L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
>
> v7:
>         Incorporated review comments [3].
>         Modified driver as loadable module.
>         Updated Documentation with Event description.
>         Removed per-channel(no SMC calls) sampling implementation(
>         Since DMC and L3C channels are interleave, we have decided to
>         sample channel zero and prorate it to account for a Device).
>
> [3] https://patchwork.kernel.org/patch/10479203/
>
> v6:
>         Rebased to 4.18-rc1
>         Updated with comments from John Garry[3]
>
> [3] https://lkml.org/lkml/2018/5/17/408
>
> v5:
>         Incorporated review comments from Mark Rutland[2]
> v4:
>         Incorporated review comments from Mark Rutland[1]
>
> [1] https://www.spinics.net/lists/arm-kernel/msg588563.html
> [2] https://lkml.org/lkml/2018/4/26/376
>
> v3:
>         Fixed warning reported by kbuild robot
>
> v2:
>         Rebased to 4.12-rc1
>         Removed Arch VULCAN dependency.
>         Update SMC call parameters as per latest firmware.
>
> v1:
>         Initial patch
>
> Ganapatrao Kulkarni (2):
>   perf, uncore: Adding documentation for ThunderX2 pmu uncore driver
>   ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE PMU driver
>
>  Documentation/perf/thunderx2-pmu.txt | 106 ++++
>  drivers/perf/Kconfig                 |   9 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/thunderx2_pmu.c         | 867 +++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h           |   1 +
>  5 files changed, 984 insertions(+)
>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>  create mode 100644 drivers/perf/thunderx2_pmu.c
>
> --
> 2.18.0
>

thanks
Ganapat
