Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477EC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P87byO+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C9520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeKHFQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:16:55 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:41249 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeKHFQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:16:54 -0500
Received: by mail-qk1-f172.google.com with SMTP id 189so22515185qkj.8;
        Wed, 07 Nov 2018 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SGVh1pRpqxTDJUil1PaJY2qjRkU65DCtN64z6kLuIws=;
        b=P87byO+m9jareZqeHanIfDsaL4RTnXQPC+pKn68FyBiLJuUOq3Bvznoj2vw+dh8KUL
         xEhEb2GP3pg+cT3mYzDLdlvXKYDhdxO+L6Pz3Ii46AVkNtU4cGhEYsNeP/dukk6o9W8E
         rj03aGogeh6E0cQvG7474iza601VozTlqscPJk8f0x4Y/OgkqJA5XuKIsrQmwypafB4D
         j7vtEwHNyGDfNJJXJjXAq59LZi7SSkLGiQMnxqkWBOM4GxGiblpUBDHUc+Q3/MeYr//R
         gx9tGra+F6mRLuWNTazJJ+Nb1fuyPzFwxRvzmoogaT1Qn3G9+Ib5WRtSspRssUhvohKA
         sYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SGVh1pRpqxTDJUil1PaJY2qjRkU65DCtN64z6kLuIws=;
        b=j3xppaI6FB2JDfNRywmaj/axDGWpE7B0VrBkQhYuFqHZJ3Y0GAnKbaIDUpX3iQFud4
         qGO7654x6nJi+ZOBWLZfHXOTzAaLAuD/UEADZU+kUbJrmFpv5jEaF+Z+9h2/ZVrVaM9f
         NZKQ2WVCqC68gaqF9cRhRz4Q0w2cVlfF5gy85StJGfntysbpBZ0RWV+TCWy6fgvVNra4
         jYoai14vulB4lUHZpSU3ALenIBAHMgdolMiKs//ZaDPU6sgXKHrAca8UjY9NtgKrJC7B
         M4dHLYXTqRH75IKUwdDu05Zctf9lZu/mOo9Epua+M4DMe/qxX6/8guaUwZO0LAlMK9up
         7saA==
X-Gm-Message-State: AGRZ1gKB/SWVz3Wy8sHYVbaSXPJT3WziI5fhcTiZ5VEcpS+67mYMvig7
        qtwABHa5MVxH4kdgxy4FAUx10La3Vjvu65dUwQ==
X-Google-Smtp-Source: AJdET5e+boVKTDngrVwcjXovI+II2oq+n4LGZbqpXn80PMjxFA3CdYwLqP0wCvJ5HS2QV9gHRhVXTv+dJHk3+GdpWFI=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr1483539qkg.184.1541619904850;
 Wed, 07 Nov 2018 11:45:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
In-Reply-To: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 7 Nov 2018 13:44:53 -0600
Message-ID: <CAL_Jsq+4d-0_T68r=PWm5ey=NqsCn5j_j1sQ4Kjp1zBz6zgt6A@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] SoC maintainer group
To:     Olof Johansson <olof@lixom.net>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Russell King <rmk@armlinux.org.uk>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 4:17 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi KS organizers (and others),
>
> This is a late topic proposal, hopefully there is still time on the agend=
a.
>
> We=E2=80=99ve recently been discussing some maintainer model changes as
> described below, and would like a slot to discuss the idea and solicit
> feedback/comments from the others there.
>
>
> This started with Arnd and I finally being in one place at the same
> time, and talking about how we want to evolve arm-soc maintainership
> moving forward. We've been independently thinking of ways to expand
> the group and making it more self-service for everybody, but there's a
> bunch of tooling needed to make it run smoothly beyond the smaller
> group we have now.
>
> In the end, we ended up looking at it from a slightly different angle:
> Right now, when contributors show up with new platform support, the
> first hill they need to climb is figuring out how they need to carve
> up their platform among all the various maintainers, how to make sure
> they're all handshaking on keeping things stable, and get code
> submitted. It's awkward, not well documented and one of the biggest
> overheads we have on our side as well.
>
> When we started talking to other maintainers, we're also realizing
> that we are currently duplicating a lot of work. In particular, we
> often all get cc:d on patch series, so we all need to read and filter,
> and assume that other maintainers spot the right patches, etc.
>
> We have discussed a few different options, and it seems like pooling
> more of the contribution flow to a group of co-maintainers is a useful
> approach. Initially, we're considering the arm-soc platforms, clock
> drivers and pinctrl drivers, which all tend to be affected by new
> platform contributions in this way, and often end up cross-cc:d on
> everything. Additionally, the flow for successfully merging a new
> platform or SoC needs to be documented and advertised. This is true
> whether or not we change the way that maintainers coordinate amongst
> themselves, or whether or not we change the current workflow used by
> platform contributors today.
>
> So, we're planning to change things up a bit. We're starting a new
> group that pools current arm-soc, clk and pinctrl drivers and
> maintainers into one funnel. We'll set up a new mail alias for the
> maintainer group, and one shared patchwork to collect contributions.
> We still expect developers to use existing mailing lists, and we still
> expect for example ARM platform maintainers to keep their workflow of
> collecting patches for their platform like they do today. Down the
> road it might make sense to incorporate other driver subsystems as
> well.

Given that dts files are a large part of what goes into arm-soc, any
thoughts on changes to the process around them? I think it would be
good if dts files were a bit more decoupled from kernel code changes.
Yes, there's the issue with header dependencies to deal with. Ignoring
that for a moment, keeping the dts files somewhat separate even if
ultimately in the same tree and the same maintainers would be
beneficial both for perception and to be able to do validation
separately. And if we do ever move things out of the kernel tree, then
it's less of a work-flow change. And I'm happy to help out here in
whatever way I can.

> Beyond this, we're going to keep a close eye on the drm-misc tree,
> which is exploring a move to gitlab (and working with gitlab on adding
> the features they need to move over). If they get a broad maintainer
> model working well in that environment it could be something we reuse
> for ourselves too.

AIUI for drm-misc, a major goal there is to have more automated checks
fed back to submitters which doesn't necessarily have anything to do
with maintainers. That's something I want to get in front of for DT
schema so we're not fixing things after we've accepted them. So I've
been experimenting with gitlab CI and integration with patchwork a bit
recently. I have gitlab CI running some tests on binding patches
(checkpatch and schema validation), attaching the results to the DT
patchwork instance, and updating the patch state. Here is an example
patch[1], my patchwork related scripts are here[2], and the CI job is
here[3].

Rob

[1] https://patchwork.ozlabs.org/patch/979613/
[2] https://gitlab.com/robherring/pw-utils
[3] https://gitlab.com/robherring/linux/-/jobs
