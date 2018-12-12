Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56FEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uxyanzt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3F82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeLLXQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:16:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46360 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:16:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so50138ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DXa5uRlh0huHpXYItEvyQ55WkZSxKksF2U/9xlrXEhE=;
        b=Uxyanzt/1LLMVqY1nRIbCKsfg/E8J2Lq1SwLx+a6hgZ8kpgX6+APE9dBMe+D30dWoH
         sEwDoP9N/j0Q+aSJeiKGfZzUJZeiXy+t9b6CwBugvLek3I39/YQ4Gsbol4M82guCPNTF
         Zin/KP98mrDIIjxd6CMmqGQdw8d/Hldg5hqdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DXa5uRlh0huHpXYItEvyQ55WkZSxKksF2U/9xlrXEhE=;
        b=EA7EMSOAoG7Nc/iwwWbcZJWI/g5bYfI8vVjV52UuQl1jcP3jQLy0BiLuJvB0Cl8QgN
         fMZETZ8H49TSnwfRQvNxK8TUFAhQyxmXQX6gd2p8S8F+DHZ13/5XLyPLmG/305YD1759
         J6xbIH1kpiWg2IXKLLnm4HfESljC2kwqoFFgL1Oto/3qPzjRF01gTpBmeGFrb4u19iu3
         yU+OrDm5yzejoeftu1jaP5okCY0DVp3pi4QC5NwZt1Ark1I9aoHNiuFaoRHHREnikvK/
         m4XsZCExiC4IFdB7rGza5Zjp+Suzqoif/vdR9b5+TJFsdY43KubQiYd9CkouX1ST5SxG
         xEBA==
X-Gm-Message-State: AA+aEWamZs5voige7l86c+fxJU1dvyqhce0lmb6leEJO1rhdAyhfTtlw
        Q2PIV0c7a+1Jmn4P9WYSsWuJkw==
X-Google-Smtp-Source: AFSGD/UQjyxd9eVZxlfv5H+TgEztq4OtYbWjinuF/GKMBI6s/p4MltZ02IMqV7gsKk32T3Q4wdP3sg==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr21848274plb.312.1544656591982;
        Wed, 12 Dec 2018 15:16:31 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t24sm117262pfh.21.2018.12.12.15.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:16:31 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:16:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Serge Hallyn <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] seccomp updates for next
Message-ID: <20181212231630.GA31584@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Please pull these seccomp changes for next.

Thanks!

-Kees

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next

for you to fetch changes up to fec7b6690541b8128663a13c9586b1daf42b0a6c:

  samples: add an example of seccomp user trap (2018-12-11 16:32:11 -0800)

----------------------------------------------------------------
Add SECCOMP_RET_USER_NOTIF

----------------------------------------------------------------
Tycho Andersen (4):
      seccomp: hoist struct seccomp_data recalculation higher
      seccomp: switch system call argument type to void *
      seccomp: add a return code to trap to userspace
      samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt           |   1 +
 Documentation/userspace-api/seccomp_filter.rst |  84 +++++
 include/linux/seccomp.h                        |   9 +-
 include/linux/syscalls.h                       |   2 +-
 include/uapi/linux/seccomp.h                   |  40 ++-
 kernel/seccomp.c                               | 468 ++++++++++++++++++++++++-
 samples/seccomp/.gitignore                     |   1 +
 samples/seccomp/Makefile                       |   7 +-
 samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
 10 files changed, 1411 insertions(+), 23 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c

-- 
Kees Cook
