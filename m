Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F6BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C02F204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="NUvggGrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C02F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbeIFUFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:05:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42710 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeIFUFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:05:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so12708514qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+K6Qz8aW96F6EY8yEoynuNIfebVsJabLKEt2J4ZZskM=;
        b=NUvggGrcxvh9COX3MkXHhrS+AEZw9BYX91Qws6+60lT/jBil1itK2OQzDhps+5jUBv
         36sodK/ehD/kAwyCcWCBvpCpTNoNmAj74eeP/EjT7LDWrKhsVJQVvIUNbQfSIrQtk/dS
         zz/YRPKL81dJAJVEuWp1Ss+VquekrdIRtEKIAgnPTFuz/vAlzUdk8vcm1+Tb40+5yG8O
         0AS9ldFB//yol4wAI4aizTXSr6mUM/ApObcU8pNY+mFYMxnAJqnwORJfRDEu5PQ7+jPB
         shsXQiDajBoCbQ17KSLFIDR/VCAvOwJx7TbaU16KMwLOcYIRs0oBRqbR9GqApOiOe5tq
         pVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+K6Qz8aW96F6EY8yEoynuNIfebVsJabLKEt2J4ZZskM=;
        b=XLeI2DNyXxXdV7din6hhqlS+hB2tYVpt1CjAbM7zPcaxAm9HRziNSpXM9/WNAePWDM
         Kddq27N+GxqoUF5fNIps3pSepvFn3dK/n0rSzBHCtFfzgrfoP9wOgSyBc8WmuJR0Kciv
         Lea3t2hQH2T4FMHk21OucptGP3TH0+jK9ZM+kWZgr+4+wcuz9ydOLzyASFBC/0UZds+z
         DlWQG84tlV/l/xAyhmsqlVKUfmkH5VEoYH1kK8NeicUXVcOEEpu/VedQBI6hPvsai/mc
         NiC493/tSmiGCQ25kfDieeBAolKbHw0wz08h+6w7wWugVYXafbTJ8qPksvsrSJs2zdxH
         BDdw==
X-Gm-Message-State: APzg51Ck9KihNdvBlJNeNgXDuV6gw+cjM22B4MuWsaDa/3/y+/SvwRR7
        5/kqid6yxO4JpYmDZwAjtdxfHw==
X-Google-Smtp-Source: ANB0VdbOKGrF+JtVZIZSMgszqCR0FWH3ccsNVac3pPkIm4S9b6HoMlivIV46F4V7sgjT1+5I25MlBg==
X-Received: by 2002:ac8:22ac:: with SMTP id f41-v6mr2539451qta.197.1536247773782;
        Thu, 06 Sep 2018 08:29:33 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3254507qtk.38.2018.09.06.08.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:29:32 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v6 0/5] seccomp trap to userspace
Date:   Thu,  6 Sep 2018 09:28:54 -0600
Message-Id: <20180906152859.7810-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a v6 of the seccomp trap to userspace series. v5 [1] was fairly
quiet, with Christian reminding me that I had forgotten to update the
docs for the ioctl change. Other than that, there are no changes.

[1]: https://lkml.org/lkml/2018/8/28/590

Thoughts welcome,

Tycho

Tycho Andersen (5):
  seccomp: add a return code to trap to userspace
  seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
  seccomp: add a way to get a listener fd from ptrace
  seccomp: add support for passing fds via USER_NOTIF
  samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt          |   1 +
 .../userspace-api/seccomp_filter.rst          |  84 +++
 arch/Kconfig                                  |   9 +
 include/linux/seccomp.h                       |  18 +-
 include/uapi/linux/ptrace.h                   |   2 +
 include/uapi/linux/seccomp.h                  |  36 +-
 kernel/ptrace.c                               |   4 +
 kernel/seccomp.c                              | 538 +++++++++++++++-
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   7 +-
 samples/seccomp/user-trap.c                   | 312 ++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 587 +++++++++++++++++-
 12 files changed, 1586 insertions(+), 13 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c

-- 
2.17.1

