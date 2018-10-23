Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548BFC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58713205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IzKns45C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58713205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJWJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:15:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40125 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:15:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so1251492lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9NN3fLcUlHVOjzUj6hDJ85TEsXQY8rTP555AlaSzOCU=;
        b=IzKns45Cg33sKrW+tkZ14wcvZitmdZT987Oe1txd4vPZLguYvdTdbzzuV7gO4J5CTl
         u7Ek8aE3lRsX2efu7zgQJRFWtGEmtfjmpgbbOd4D4aHA9LtkG9v230RqgOcSSxqCpn9o
         iqMkhQLfL/QHOkVY1Ch89jgOniGYX94pY0dfD4a30Nt7nYnFkNi3dqSPcktaE2hh7ntB
         b7B5yuiHVA3RcszEhfTMPZU8rdiPV0JfehJn4JK+eIs7iM97/FYPQ4/sxiR2rIy4kCNT
         oKH8pgdtL+2JRTFI06lIDNksRoXydNcnyZDqM7autX+qCGIAk3ThEuRl7ZiU1RMB/opu
         mVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9NN3fLcUlHVOjzUj6hDJ85TEsXQY8rTP555AlaSzOCU=;
        b=AWow4UJyI2yRUEKrLrf5g0iwTUvFy4CY17LL+1OTi0k/qXtnfKHi/KZZsMjkUc+VYl
         0XcE5pXPFZTEe/AM9G7z+9WuthxQTIiKc2yw68+qCIQ7HLioipCXccX/LyyRsWGhAV5n
         Fv96r2D15fIi2Kwx4GW9CqSjJoQ6grOSLaukaJO+rPiC5dhjGvkkIBzya2k/SvOmpfDm
         +QvFKDmtVjK5ox8LZkoVdDEMR56VEk6/U30M/zfMmB8OcaEy2MUKfFUkU5O4KlkwchhF
         vwYwvtgm2ikxVYtHKqd4rHGgAwFHcuTpM1tOtXaX6ZVm0CG4YyBwN+o6I9lW5qE9YmQe
         a8cQ==
X-Gm-Message-State: AGRZ1gKBtFXGGKi7jc44yihPbWbWr8eFucp+/QzLtpvs7I5jKdpSH9Dv
        zF9+lC1k2PSzJg9HD3wyJmpN1pb8/bYnY5FqJ1f1cU/NEw==
X-Google-Smtp-Source: ACcGV61i4DpQPdSkI+/OCrhgGAbBDLKD+B1TRsABb5fQ9jDuGQmIe1yrGoj4BRwonFkeHHVPqnPCpcgts7sShDkDtsA=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr10902275lja.77.1540256101579;
 Mon, 22 Oct 2018 17:55:01 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Oct 2018 20:54:50 -0400
Message-ID: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Welcome back.

Three SELinux patches for v4.20, all fall under the bug-fix or
behave-better category, which is good.  All three have pretty good
descriptions too, which is even better.  Please merge this for v4.20.

Thanks,
-Paul

--
The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

 Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20181022

for you to fetch changes up to 4458bba09788e70e8fb39ad003f087cd9dfbd6ac:

 selinux: Add __GFP_NOWARN to allocation at str_read()
   (2018-09-13 15:36:25 -0400)

----------------------------------------------------------------
selinux/stable-4.20 PR 20181022

----------------------------------------------------------------
Jann Horn (1):
     selinux: refactor mls_context_to_sid() and make it stricter

Stephen Smalley (1):
     selinux: fix mounting of cgroup2 under older policies

Tetsuo Handa (1):
     selinux: Add __GFP_NOWARN to allocation at str_read()

security/selinux/hooks.c       |   5 ++
security/selinux/ss/mls.c      | 178 ++++++++++++++++++-----------------------
security/selinux/ss/mls.h      |   2 +-
security/selinux/ss/policydb.c |   2 +-
security/selinux/ss/services.c |  12 +--
5 files changed, 88 insertions(+), 111 deletions(-)

-- 
paul moore
www.paul-moore.com
