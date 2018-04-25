Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-778319-1524664855-2-8001102455539298769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524664854; b=htm7Z9hRF+7F/g+q7IoohJA9HyZo3BTOiFC+uvBmJSJUuroWCK
    DTtZqWxtG3kmyqe6vsfhXltJzIxUjDjgGihU6jWs79k7LBB7RES09f5zR0gZ69Q6
    UVdKXzN3euU+AVrh8EAxqwqXyWeSq7V6hjczqfDKTkywD43Aa22dP/sJHq0u7XsY
    DLysxPs+aUAssre58YMZ/CwhK5UNj2s4H36uzJMkaUALmvY7WUTE7FfLDe3yFiex
    gJ0y4/by69CYk0pVZHoRx7Hg8o9hZO9QSqxXOX2xSu21qPXzhJxL5wSvnW4EYsnY
    CgRB4dutotwfNuhkeCjkGljCkGmq9fwAFTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1524664854; bh=P8yx
    Tf0tDalyaM0gZWxSZmqsVAqBkVq4ZD62mgG0lWs=; b=pMCkscSagS5qXaOnWjzy
    GiSPDLkjtWbYWnLf27hxa21R1uFFd/g7p2etNV4OWmPIJ39WMq1ulgdCRdd0lhF4
    wkXP50To9SH/Fmf81mZozyepGsITBf03HgKnkL9orfBi7z9K0JB7yNpEVzrfdfae
    Dta7SlPvzshK29SprsFAS391c9lezl8RaxjD2kqTKnsHzhfWJ0+lnsvS1V6YDB3a
    6FuSNBrpfJQv8YSVQ5VNjFfWuQtlEqBQhMjN746HiaS/55HVIEHyXuFqTtmRhaXz
    CG+fv3Be7FbT1hO99Jk5frJjGJnh5/nMWEW/1xerSTJI80AhCLhKmz/mb65zB2T1
    BA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lrJHAdZb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VQC2daXI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lrJHAdZb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VQC2daXI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA+07WRH9+2uqV7tVBm8EQubrQ023K+FIyFYdzn7Wd07xpeFkhYiPelA2dOX7hqSJv6zNAvv6e7+7s3O466dQMEQ9ww3i0DGW67vI6oJS1v5SytbPXKG
    wfqEpcgMlInoLoryYV2ZwThuV9TbEsH3gka3553aMR9XvDNxQuhsKdnSVOa7qHgo+xs2qy8kESWkRXQByFMjQnnW3FV/ppUGSa0sl8VnR8zoPZEZOOCH8oox
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=B6KMzFptAAAA:20 a=bVfw19_g2iHN1v91vbUA:9
    a=gBK3r5GUaqX-lCqB:21 a=Ovn3aacyWmVi7UaH:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeDYOAj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 10:00:39 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46129 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754566AbeDYOAe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 10:00:34 -0400
X-Google-Smtp-Source: AB8JxZqmdxZrNIQJ2GekMgG/ABA0lZiPscluzU7KdFu+beIVDvDB2sECo+3q4a1JgGhYVfOkrBgokGBBGZF5HeIxWoA=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Apr 2018 16:00:33 +0200
X-Google-Sender-Auth: 8RgVwowOQHblJ0WU1lNRShoFK6w
Message-ID: <CAK8P3a2fJODEHVJ1jfTsX9DGQAPh=FipUDHTqJhRRARXv5JDvQ@mail.gmail.com>
Subject: y2038 kernel status update
To: y2038 Mailman List <y2038@lists.linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        Firoz Khan <firoz.khan@linaro.org>,
        RISC-V SW Dev <sw-dev@groups.riscv.org>,
        Linux API <linux-api@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi everyone,

A lot of things have happened in the move to make the kernel y2038
ready in recent times. I've sent out new patches recently but will be
on vacation for the next few weeks, so here's a quick update on where
we are today with recent changes and work in progress:

- A large number of small driver fixes got merged into linux-4.16.
  Many of these were old patches I had done a while ago but that had
  not made it in yet. There are a few dozen more of these coming, but
  those have some dependency.

- Deepa Dinamani has done a lot of the groundwork for the system
  call conversion. Her latest patch series that got merged now finally
  adds new system call entry points for timekeeping related syscalls. They
  are not wired up yet, but now we have a template for the remaining ones,
  and we have sorted out the header file dependencies.

- I just sent a pull request for a second chunk of system calls:
  The sysvipc semtimedop, semctl/shmctl/msgctl and
  mq_timedsend/mq_timedreceive calls. I have more patches for most of
  the remaining calls, and they should be simpler (this one was rather
  tricky). A full list can be found in a spreadsheet I made[2].

- Baolin Wang has worked on RTC related issues and most recently
  posted a series to convert the user space ABI for ALSA. This is
  currently under discussion.

- The most complicated remaining part is the conversion of
  the VFS layer. Deepa is getting a new series for this ready after
  having done some groundwork over the past years.  The current idea is
  to have a flag-day patch using coccinelle to change the inode, iattr
  and kstat structures over at the same time. Many file systems will
  require further changes after that, but those can be done individually
  through their respective maintainers.

- Firoz Khan has started looking at the system call entry
  points in the architectures. We want to add the new system calls to
  all 32-bit architectures at once, in order to have a baseline release
  that C libraries can rely on for implementing 64-bit time_t on all
  architectures.  Even after the architecture removal series, we still
  have over a dozen different syscall tables and each one is laid out
  slightly differently, which makes it hard to change.  To improve this,
  Firoz is preparing a series that changes
  all architectures to use a common table format as used by x86, arm
  and s390 today.

- I have collected all those patches in a git tree [1] for testing.
  This currently has updated system call entry points for 32-bit ARM
  and x86, but no others so far.  The system call numbers *will* change
  before it gets merged, so be careful when building user space based
  on this, but it should be a starting point for testing. I definitely
  expect this to contain bugs still, especially to the end of the series,
  but the start of it should be fairly solid. Some patches are marked
  as work-in-progress or don't contain a proper changelog text. Those
  will still get reworked before a first version is posted to the
  mainling lists.

- There are two notable areas not included in that tree today:
  v4l and socket timestamps. I've had patches for both in the past but
  they need to be reworked.

        Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-next
[2] https://docs.google.com/spreadsheets/d/1HCYwHXxs48TsTb6IGUduNjQnmfRvMPzCN6T_0YiQwis/
