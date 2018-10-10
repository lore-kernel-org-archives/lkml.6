Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C2C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A173C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CieM3E+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A173C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJJXKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:10:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46116 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:10:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n11-v6so6208984wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdiGz+8xlyIlyX7MjzfrzrCwpgn/gTJhJshsQOzlJUw=;
        b=CieM3E+avxSej3p58bf1DK39GH9DbBkVnseYNXCo0UN+numl1VgTjtSR+h9zds8UPZ
         2hT3CumO9zzD6tL8dEgS9yswHtKk723a4RNn2KIy6nQY2PYf9fCFeTZeSQV/0TOyGWg6
         iibZIiFzeIBwOli6tZQ4+1IPCQKFiq+f5w6kJd83mpQoQ8xHK31YbWNmJMMH/lw7KejT
         ZCriIpd4clzVIgM4wDPmJqW2fRMiCzR+Hl6cTaZC2rLDJdr52H+lQ86O7/IVq2gixZxd
         vQ4l/yb760xIsuCVgLacOoThxGn0w5NiwMyGp/lFFGB9kPK75yvkpJcIJDip+1Ja0ndg
         T/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdiGz+8xlyIlyX7MjzfrzrCwpgn/gTJhJshsQOzlJUw=;
        b=ll5Ms7YuA3LEpLrGRszF4Yj2RMUicAkK+2o5pn/vi92ABB3LDy6Wm00QBG6mJJDC46
         v4FNOPOhREGM+7piKRViRAN2Z/pQMWzN6IWgpOwbQc/BEimh2cjaumFiLbNAEiZjJVcN
         8mnDuK3vebfuWKFiV6tWtCZRzIwwPORSPIBeePqvAaCNq/vBGCPNmviou5OepqeFpTwA
         ott/DfumD9ROAs/K8P4N2gR79ELKQYFc6Yf7RIjbBKp9k5ZGu2ZOFZGupj1cM4qTaRvP
         UJe5ScI+EkFdROCAYMlfYVZBTKJHasI9Frp2VaUGCIuOo5X5czcPW/8AfHdsL9qDmK8v
         8doA==
X-Gm-Message-State: ABuFfoiy3ssjn5FdI9GDCCEJkzVGbPWm0XHQcjLiRW8+Kxg9QabbMXZL
        vguDr3lIxQjWWzMuSdMPlCX1NyZbCC0ziAh1XSzSvA==
X-Google-Smtp-Source: ACcGV61Y08tDzi2C6toqQkVOSeKsdpQp3cJ3NtGYoZcxZn/JfuQ1Cd0mwR8Mk5qd+ttihFZJMed5smqcXvYzXWJGMlM=
X-Received: by 2002:a5d:4c90:: with SMTP id z16-v6mr22511094wrs.239.1539186478154;
 Wed, 10 Oct 2018 08:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
 <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com> <20181008142300.3aacaabe@gandalf.local.home>
In-Reply-To: <20181008142300.3aacaabe@gandalf.local.home>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Wed, 10 Oct 2018 08:47:46 -0700
Message-ID: <CAPhKKr8QvK3bkT6gQB9jc31Cx+gLmZwRnKuRUD_1xaidwL14Dg@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 11:23 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 8 Oct 2018 19:02:51 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Wed, Sep 19, 2018 at 7:13 PM, Dhaval Giani <dhaval.giani@gmail.com> wrote:
> > > Hi folks,
> > >
> > > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > > LPC [ 1 ]. We are planning to continue the discussions from last
> > > year's microconference [2]. Many discussions from the Automated
> > > Testing Summit [3] will also continue, and a final agenda will come up
> > > only soon after that.
> > >
> > > Suggested Topics
> > >
> > > - Syzbot/syzkaller
> > > - ATS
> > > - Distro/stable testing
> > > - kernelci
> > > - kernelci auto bisection
> > > - Unit testing framework
> > >
> > > We look forward to other interesting topics for this microconference
> > > as a reply to this email.
> >
> > Hi Dhaval and Sasha,
> >
> > My syzbot talk wasn't accepted to main track, so I would like to do
> > more or less full-fledged talk on the microconf. Is it possible?
>
> Hi Dmitry,
>
> Note, microconfs are not for full-fledged talks. They are to be
> discussion focused. You can have a 5-10 minute presentation that leads
> up to discussion of future work, but we like to refrain from any talks
> about what was done if there's nothing to go forward with.

Dmitiry,

Can you clarify the scope of what you want to discuss during the
microconference? Further to what Steven said, we don't want
presentations (So 3, maybe 4 slides). We want discussions about future
work.

Thanks!
Dhaval
