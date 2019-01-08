Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F12C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C065420883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWVEkflu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfAHVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:35:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33606 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfAHVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:35:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2316017pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iyJoBe3sQ1g2k/YakZ2KTAU/l/VCXCfZ7ONR0Zw987U=;
        b=NWVEkflu7bnnh9Pde5GbgKCYHz/CMZeOVvS+rlUYthaXoxbx/q03W4qxVL68OXoCq6
         3Do2THtYYl6I7AmWhouall/Z13F3YCW5bh+JHvBXTQILG+A4YbQEljS5LyKNHdGz4T+v
         SRBIf4O0MWaARrYpv8YknJ5wOl4EDOQKSovUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iyJoBe3sQ1g2k/YakZ2KTAU/l/VCXCfZ7ONR0Zw987U=;
        b=EIh+c2k0XB34BCLAalZ9KkeRTW+nsbQiBdRmaZLGgrrYUYYbC/p8NkXFuLaA1zlDAr
         U3EFhslzFDiji6LpdWi0t+s/wTvoKQQLytyJKw0PTkYQW4+mIDVAVoJkYLxu2j4uHyCV
         MDElDPR+hHX/sTfn/M7e1PatUIlhBFp5uHTHtOI5dhI8KTYhXPvdlN11HjyJ1B3sM98m
         GUQCHoXJGLEKy9aTseEYEWtSNZhvul/RJoTgc9RWIVr+YqJxvZogMZcGdjAYKf+Ghq2E
         KNKg+VnpIVxcSjaNvwqBkTMAV+p/IG5UjfD0qxxflmxA6iIsa4vNYpf5PIlAS9GAlTVE
         7Aag==
X-Gm-Message-State: AJcUukclU7TCGA1UDVpxKR5jCFPFoFWLIlc2gCnpStDxX/M83nUDZq3y
        N/7NkOgnng4822WrOdK9WkAwKw==
X-Google-Smtp-Source: ALg8bN5+off+7sUT4lR2EWRRm2sfcL51bRS00BjcBCBwWcUj3L527qnVrb+Fsd7GfSqguz0Dos2NoQ==
X-Received: by 2002:a63:4b25:: with SMTP id y37mr834622pga.181.1546983306707;
        Tue, 08 Jan 2019 13:35:06 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t12sm109578212pfi.45.2019.01.08.13.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:35:05 -0800 (PST)
Date:   Tue, 8 Jan 2019 13:35:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [GIT PULL] blob-stacking updates for security-next
Message-ID: <20190108213504.GA32901@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Please pull these blob-stacking changes for security-next.

Thanks!

-Kees

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/blob-stacking-security-next

for you to fetch changes up to a5e2fe7ede1268d2f80fe49ca1f717d0e3750995:

  TOMOYO: Update LSM flags to no longer be exclusive (2019-01-08 13:18:45 -0800)

----------------------------------------------------------------
LSM: Module stacking for SARA and Landlock

The combined series of LSM refactoring and addition of blob-sharing for
SARA and Landlock.

----------------------------------------------------------------
Casey Schaufler (19):
      LSM: Add all exclusive LSMs to ordered initialization
      procfs: add smack subdir to attrs
      Smack: Abstract use of cred security blob
      SELinux: Abstract use of cred security blob
      SELinux: Remove cred security blob poisoning
      SELinux: Remove unused selinux_is_enabled
      AppArmor: Abstract use of cred security blob
      TOMOYO: Abstract use of cred security blob
      Infrastructure management of the cred security blob
      SELinux: Abstract use of file security blob
      Smack: Abstract use of file security blob
      LSM: Infrastructure management of the file security
      SELinux: Abstract use of inode security blob
      Smack: Abstract use of inode security blob
      LSM: Infrastructure management of the inode security
      LSM: Infrastructure management of the task security
      SELinux: Abstract use of ipc security blobs
      Smack: Abstract use of ipc security blobs
      LSM: Infrastructure management of the ipc security blob

Kees Cook (19):
      LSM: Introduce LSM_FLAG_LEGACY_MAJOR
      LSM: Provide separate ordered initialization
      LSM: Plumb visibility into optional "enabled" state
      LSM: Lift LSM selection out of individual LSMs
      LSM: Build ordered list of LSMs to initialize
      LSM: Introduce CONFIG_LSM
      LSM: Introduce "lsm=" for boottime LSM selection
      LSM: Tie enabling logic to presence in ordered list
      LSM: Prepare for reorganizing "security=" logic
      LSM: Refactor "security=" in terms of enable/disable
      LSM: Separate idea of "major" LSM from "exclusive" LSM
      apparmor: Remove SECURITY_APPARMOR_BOOTPARAM_VALUE
      selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
      LSM: Split LSM preparation from initialization
      LoadPin: Initialize as ordered LSM
      Yama: Initialize as ordered LSM
      LSM: Introduce enum lsm_order
      capability: Initialize as LSM_ORDER_FIRST
      TOMOYO: Update LSM flags to no longer be exclusive

 Documentation/admin-guide/LSM/index.rst         |  13 +-
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 fs/proc/base.c                                  |  64 ++-
 fs/proc/internal.h                              |   1 +
 include/linux/cred.h                            |   1 -
 include/linux/lsm_hooks.h                       |  40 +-
 include/linux/security.h                        |  15 +-
 include/linux/selinux.h                         |  35 --
 kernel/cred.c                                   |  13 -
 security/Kconfig                                |  41 +-
 security/apparmor/Kconfig                       |  16 -
 security/apparmor/domain.c                      |   2 +-
 security/apparmor/include/cred.h                |  16 +-
 security/apparmor/include/file.h                |   5 +-
 security/apparmor/include/lib.h                 |   4 +
 security/apparmor/include/task.h                |  18 +-
 security/apparmor/lsm.c                         |  65 ++-
 security/apparmor/task.c                        |   6 +-
 security/commoncap.c                            |   9 +-
 security/loadpin/loadpin.c                      |   8 +-
 security/security.c                             | 635 +++++++++++++++++++++---
 security/selinux/Kconfig                        |  15 -
 security/selinux/Makefile                       |   2 +-
 security/selinux/exports.c                      |  23 -
 security/selinux/hooks.c                        | 345 ++++---------
 security/selinux/include/audit.h                |   3 -
 security/selinux/include/objsec.h               |  38 +-
 security/selinux/selinuxfs.c                    |   4 +-
 security/selinux/ss/services.c                  |   1 -
 security/selinux/xfrm.c                         |   4 +-
 security/smack/smack.h                          |  44 +-
 security/smack/smack_access.c                   |   4 +-
 security/smack/smack_lsm.c                      | 316 ++++--------
 security/smack/smackfs.c                        |  18 +-
 security/tomoyo/common.h                        |  22 +-
 security/tomoyo/domain.c                        |   4 +-
 security/tomoyo/securityfs_if.c                 |  15 +-
 security/tomoyo/tomoyo.c                        |  49 +-
 security/yama/yama_lsm.c                        |   8 +-
 39 files changed, 1133 insertions(+), 793 deletions(-)
 delete mode 100644 include/linux/selinux.h
 delete mode 100644 security/selinux/exports.c

-- 
Kees Cook
