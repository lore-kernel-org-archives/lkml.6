Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FA2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0962084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odzzFmRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0962084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeJ3L6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:58:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45096 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJ3L6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:58:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so11853821qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 20:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEQiumCXGYw1j5BHNY/5b8CsffDg7qXIEi/GMSWLhnQ=;
        b=odzzFmRrr/oBDH5Jzm39yDmysXiLbx7cWvd/IiZa/yBW6IrWEEZaZDUws11lCeG/8M
         PQmPTixEK+tmWZ3dIzjhfTtzY/S4k3mXUEgNGTxy6V5DcBLKaZ5eTjzg/zofshyPgt/B
         I1PDgpovvI7PlxNBtIAB0rhY6jISx/NJGrqWK1eXo2c6jpwLeYTsRoL8MH9zoT9z7ifF
         1puxPIrlk0RZLTScYVrZneKPRaC2d1yk4FWdg4AJHPsPZuxmqqmLseiMtdQ1AlP4uTko
         H7gqKaqgggp3OgBYjRIkeD86+8skRIQejkii35Uy8o70FWYSu43qKTm657Luc6Y/nBs9
         liCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEQiumCXGYw1j5BHNY/5b8CsffDg7qXIEi/GMSWLhnQ=;
        b=L7gApZYosn7wkH6s/fniLhThuLIMAokqyhKD8nzoRA6eTL0ndkMkQav+A5fp0+7g9K
         WdVAUdIeV4xRqOrr99zCtMLg0Y2XYEuMoLhJeG6vUoHcTuOpx79HvEYxBpP7FguIGiQE
         EWnuLg7wSwyU7ed6CB+Uc8zLeN2F/oXUAwebQNyHE9ycNVDYX4K4WcGUJYdudL4kynOP
         VvdS/wIDb+nc4k8BXOjPNoBBlHwKDkfkJKi7yqAvh/0qgZN3eFPF8dkSaR8cxx02xR4Z
         1tbz+hr7p8xBU2OmIi7Uu6YDpJo1ZYGeukVao6hdeT+DpYfQRR1go1Om/0p5+d1rGWW/
         BO5A==
X-Gm-Message-State: AGRZ1gK0KI5x85S4TUrMVMtPIAzNZkYDswQz+vY6+67+vvdyxwPoDeTX
        mkgUhUB+KhRiSHvBl06EhkuKfggNAyZj716Jit03/Q==
X-Google-Smtp-Source: AJdET5entudZdQ5N871bMwswgxxrfTLlMHjeWrQ2cbMje/RK7spWX/6b9AUK4dMrAtfaaopuODHaKcxAjtjXTv0KRyQ=
X-Received: by 2002:ad4:408f:: with SMTP id l15mr13097849qvp.165.1540868800177;
 Mon, 29 Oct 2018 20:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181029175322.189042-1-dancol@google.com> <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
 <CAKOZuetEeP2QgowUL60LYoOgavN7e-WX52adzTdMQhZX0bZn-Q@mail.gmail.com>
In-Reply-To: <CAKOZuetEeP2QgowUL60LYoOgavN7e-WX52adzTdMQhZX0bZn-Q@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 29 Oct 2018 20:06:28 -0700
Message-ID: <CAJWu+orRE9HL2KWRzEhr2B2Owi=66x-mgjYiJV=cje-rgOeSxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     Daniel Colascione <dancol@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 1:01 PM Daniel Colascione <dancol@google.com> wrote:
>
> Thanks for taking a look.
>
> On Mon, Oct 29, 2018 at 7:45 PM, Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Mon, Oct 29, 2018 at 10:53 AM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > This patch adds a new file under /proc/pid, /proc/pid/exithand.
> > > Attempting to read from an exithand file will block until the
> > > corresponding process exits, at which point the read will successfully
> > > complete with EOF.  The file descriptor supports both blocking
> > > operations and poll(2). It's intended to be a minimal interface for
> > > allowing a program to wait for the exit of a process that is not one
> > > of its children.
> > >
> > > Why might we want this interface? Android's lmkd kills processes in
> > > order to free memory in response to various memory pressure
> > > signals. It's desirable to wait until a killed process actually exits
> > > before moving on (if needed) to killing the next process. Since the
> > > processes that lmkd kills are not lmkd's children, lmkd currently
> > > lacks a way to wait for a proces to actually die after being sent
> > > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
> >
> > Any idea why it needs to wait and then send SIGKILL? Why not do
> > SIGKILL and look for errno == ESRCH in a loop with a delay.
>
> I want to get polling loops out of the system. Polling loops are bad
> for wakeup attribution, bad for power, bad for priority inheritance,
> and bad for latency. There's no right answer to the question "How long
> should I wait before checking $CONDITION again?". If we can have an
> explicit waitqueue interface to something, we should. Besides, PID
> polling is vulnerable to PID reuse, whereas this mechanism (just like
> anything based on struct pid) is immune to it.

The argument sounds Ok to me. I would also more details in the commit
message about the alternate methods to do this (such as kill polling
or ptrace) and why they don't work well etc so no one asks any
questions. Like maybe under a "other ways to do this" section. A bit
of googling also showed a netlink way of doing it without polling
(though I don't look into that much and wouldn't be surprised if its
more complicated)

Also I guess when you send a patch, it'd be good to pass
"--cc-cmd='./scripts/get_maintainer.pl" to git-send-email so it
automatically CCs the maintainers who maintain this.

thanks,

- Joel
