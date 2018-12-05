Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFFDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2AD2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2AD2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeLELyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:54:03 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34504 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeLELyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:54:03 -0500
Received: by mail-oi1-f175.google.com with SMTP id h25so17295058oig.1;
        Wed, 05 Dec 2018 03:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vFIepcRb1f6f7BkGiJWaXwVx/coKih3n+V7+OpoRBtE=;
        b=odGdHWFEt1O7O3qJLmdIZExOFKeY4rGLUZGWvtVeOfkuGe09hb7n/2kp7PwRuj89ef
         8hwDmq3gSPIjT5WN9/hzVPpIF8u6e0xaeJDvMs5KS5LE+eJlNbmMICJQ/N6zYxe3A2RR
         D7k4ikYgQl7FAp6oY0CeWfl6zXUpdr17OLkozKNCetDgK7zNRAF0LiWsde8ZFhX0n3pP
         KG4g4nuCKHfCMRQK9iVrn38c8eyaVdlU8wYR1znDrOhfEtYMiQNXnpOSxK8GeI1SQluF
         BXEXvXEdbHrbW+QLsg4b0UTvnMgoFCTd1j4BqIrIrDsFiV7HV76dE8QUDyUU5PfRW5+0
         e+3Q==
X-Gm-Message-State: AA+aEWbhA7khKoHl1t86R8xExT1M+YtpmqPZomWNhcyCo6/GXjDsQPlq
        XK25jO+X1OC8zlVLpUaJTxdBuRoS+9cK6/Si9Iz0nQbz
X-Google-Smtp-Source: AFSGD/UFbGWs3BidhBtaP5anUUxZ9Iw+jAHPqScqQKsLktRN2gq3q4mISsYjgFFuzbBREnHwz1bhtNUpYLLhjFEm0m8=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr10052602oic.33.1544010842073;
 Wed, 05 Dec 2018 03:54:02 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Dec 2018 12:53:50 +0100
Message-ID: <CAJZ5v0jCSFiK1mij3ChgxCs04kpFxPjr+u=WKNCFYeY5mUWv4w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.20-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc6

with top-most commit a72173ecfc6774cf2d55de9fb29421ce69e3428c

 Revert "exec: make de_thread() freezable"

on top of commit 2595646791c319cadfdbf271563aac97d0843dc7

 Linux 4.20-rc5

to receive a power management fix for 4.20-rc6.

This reverts a problematic recent commit that attempted to
fix a system-wide suspend issue related to the freezer.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "exec: make de_thread() freezable"

---------------

 fs/exec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
