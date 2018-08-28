Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51114C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F325620898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F325620898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeH1QoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:44:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43684 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1QoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:44:25 -0400
Received: by mail-qt0-f194.google.com with SMTP id g53-v6so1457676qtg.10;
        Tue, 28 Aug 2018 05:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daeeH0czeyZPJwNOZjDyqBx45o6MGqwmHVNKhVJn3Yo=;
        b=BLLOyj29ElS7VFOGyniS7g4MpwkPr0X4xSECDQgS2xnHSw1l/4pBizsOKnpzOGh9yq
         cM/tQ/Y0A/EhkTmwu4l9aE+h280Fqjw1nxb89JajnQV79j9+ZsdrPNZIZpxdbmw2qiKP
         N0hCLM3E/IgMTyErZI6AEuapk6gp2clR1NpdZbb4G7oehsOpHWF3qLYt1re8HSJIUovL
         CYhcNhfq1odNsUSwvMHJ19/gycgm7Bc93o6NjGK0hcurcaNG052qIU5qXO3T0t/p2w27
         Usfv5pMKyQPk/UfI2mzvl+FYQLBjXPjBJB+aKxw3fn5X9OtgIBx6fOZDKq2o0L7T1a5w
         t5+g==
X-Gm-Message-State: APzg51BwLILVN3rWHAG4JWNybFT5l3WKZuzzwHWdkdJwU2rzivkM8bBP
        OgSSJ8JypSLMPgW/nNUXy55EfjMQB8znpeF5uP4=
X-Google-Smtp-Source: ANB0Vdb1PKJxxdTgv/oUWy3xgpg0qGYCvtnxjWQeUZVn53ytfo5acXoM+tL13qt+swNvTbJ37AOgcs6FVLouvTsrZ6I=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr1482418qtr.9.1535460773306;
 Tue, 28 Aug 2018 05:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com> <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
In-Reply-To: <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:52:36 +0200
Message-ID: <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, amakarov@marvell.com,
        sgoutham@marvell.com, lbartosik@marvell.com,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> > >
> > > From: Aleksey Makarov <amakarov@marvell.com>
> > >
> > > This patch adds mailbox support infrastructure APIs.
> > > Each RVU device has a dedicated 64KB mailbox region
> > > shared with it's peer for communication. RVU AF has
> > > a separate mailbox region shared with each of RVU PFs
> > > and a RVU PF has a separate region shared with each of
> > > it's VF.
> > >
> > > These set of APIs are used by this driver (RVU AF) and
> > > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> > >
> > > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
> >
> > Why does this driver not use the drivers/mailbox/ infrastructure?
> >
> This is a common administrative software driver which will be handling requests
> from kernel drivers and as well as drivers in userspace applications.
> We had to keep mailbox communication infrastructure same across all usages.

Can you explain more about the usage of userspace applications
and what interface you plan to use into the kernel?

Do you things like AF_XDP and virtual machines, or something else?

        Arnd
