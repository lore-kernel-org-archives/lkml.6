Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2ECC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065CE2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xs+VyK6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065CE2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeHNX4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:56:18 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33209 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNX4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:56:17 -0400
Received: by mail-lf1-f47.google.com with SMTP id u14-v6so14837223lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UY5ssDU7kVTHFhIwvhQ6hKKMcao3Ty+RYxCvRgkoaNE=;
        b=xs+VyK6I7Anqs6bmdVScPgt0wowDZ3Eo5sgfntH1WupxIBY+8PMmWlDpm4aSEQCFcp
         JcUbsw5RaIkCwFUpZpkVz8iRi0EjTk0dpTupX2K8D8wYkp51QoCC5QCwUG+6in4lKlKa
         T8NPWVxMMIdMdY03DGekEMbdaa1hkm7yfZm/tP9mnlz4huWwKVDTWe2EJ5GMKnzmx29Y
         9qVePHW4+DomyogeQVbo/mW8q4lrllVMsoP921LyBzVnR1wwaSXNSG484gjpoHZCLzKH
         m3Sp48zQseInaM2fKiAJU8Aio3uf+Na6+PVNZjCvjdkVSXucUkje5/XtdXF+f4AtKFUT
         UuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UY5ssDU7kVTHFhIwvhQ6hKKMcao3Ty+RYxCvRgkoaNE=;
        b=rI8XZoerFeIRVvDvYX4i+DqV+qoiDzOol1O+VdyaVZNrgc4BQWKURKeLO9WYnivyXt
         /2sdnqROCCFwohu1jK23sFtr4tk5Cxn9qVSX8xPOzHF6MmYFOghm7JpZf3d+kOh/0QAF
         zCBuGJ2s7MB2BTxd9TXwnXEvcU29bLRdibU/Qsb6m8T+Zl1LihYVGkPIeCZvo5+AImeE
         Desnk7Cr+x5SpYt4n42AQqBzyDtCLJy1XYT6BnisIPZIAdHyjd5embrcjIknTyeQrBT2
         /qCZ0HulSxGgPS1nzS7qDrCHewEl4BnWjtsIzDDSVRxhB5UIRo4L6CTq3r47r3bJqkl0
         Sp1w==
X-Gm-Message-State: AOUpUlGlzb4ZV4GX/+Z7TKmNkwbS74dJb3l5q5JIkLY0s4L3frjm5ing
        SyNvkGYHAKpIDMsZUNoYvWfuFHhilL/8GHrjlKviQuJlgQ==
X-Google-Smtp-Source: AA+uWPwPOvT9Xqj/zGzXrxHahjz3xlUUja5UIfpbo5GHd1t28TjrI0wqm4uaxNPf5t8Fauyk5jBDHYw2OoP7u1y/VzE=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr14365677lfh.19.1534280835672;
 Tue, 14 Aug 2018 14:07:15 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Aug 2018 17:07:04 -0400
Message-ID: <CAHC9VhTC_xMSNq0ZOMN9eJjyfuYSk7_Q0Me2h2=DFJAxQEJpEA@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Twelve audit patches for v4.19 and they run the full gamut from fixes
to features.  Notable changes include the ability to use the "exe"
audit filter field in a wider variety of filter types, a fix for our
comparison of GID/EGID in audit filter rules, better association of
related audit records (connecting related audit records together into
one audit event), and a fix for a potential use-after-free in
audit_add_watch().

All the patches pass the audit-testsuite and merge cleanly on your
current master branch.

Please pull, thanks.
-Paul
--
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40=
:

 Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20180814

for you to fetch changes up to baa2a4fdd525c8c4b0f704d20457195b29437839:

 audit: fix use-after-free in audit_add_watch (2018-07-18 11:43:36 -0400)

----------------------------------------------------------------
audit/stable-4.18 PR 20180814

----------------------------------------------------------------
Arnd Bergmann (1):
     audit: use ktime_get_coarse_ts64() for time access

Ondrej Mosn=C3=A1=C4=8Dek (3):
     audit: allow other filter list types for AUDIT_EXE
     audit: Fix extended comparison of GID/EGID
     cred: conditionally declare groups-related functions

Paul Moore (1):
     audit: use ktime_get_coarse_real_ts64() for timestamps

Richard Guy Briggs (6):
     audit: tie SECCOMP records to syscall
     audit: tie ANOM_ABEND records to syscall
     audit: rename FILTER_TYPE to FILTER_EXCLUDE
     audit: eliminate audit_enabled magic number comparison
     audit: check audit_enabled in audit_tree_log_remove_rule()
     audit: simplify audit_enabled check in audit_watch_log_rule_change()

Ronny Chevalier (1):
     audit: fix use-after-free in audit_add_watch

drivers/tty/tty_audit.c      |  2 +-
include/linux/audit.h        |  5 ++++-
include/linux/cred.h         | 15 ++++++++++-----
include/net/xfrm.h           |  2 +-
include/uapi/linux/audit.h   |  3 ++-
kernel/audit.c               |  7 ++-----
kernel/audit_tree.c          |  2 ++
kernel/audit_watch.c         | 41 ++++++++++++++++++++++++--------------
kernel/auditfilter.c         | 17 ++++++++++-------
kernel/auditsc.c             | 14 +++++++-------
net/netfilter/xt_AUDIT.c     |  2 +-
net/netlabel/netlabel_user.c |  2 +-
12 files changed, 67 insertions(+), 45 deletions(-)

--
paul moore
www.paul-moore.com
