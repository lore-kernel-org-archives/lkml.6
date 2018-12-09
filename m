Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB60C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C11620837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="iHYJ8oaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C11620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLISY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:24:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53963 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLISYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:24:25 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so14220214ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqao7JYLtTgdPFbX+Ng5WO8iCE+HSOq9strrayMPOb8=;
        b=iHYJ8oaXgankf8n8lxzjkImMMH98c2K/vpiw7vGzr47k8R+EpGhiY8UexjQR5v8cMN
         52iXYIVm1f2cxioA00+mYlk/ZuL4rq7ayyqfQ1nIP3Hp7gjW74GCzzz7zK3q1Ts4bMV9
         nRVhqsoI0oB+3zuwUb5Tz8iEpA3ich5Qn7ePC64g81RHxqC5iVcBUQjwlyPuuXHCQu6H
         vOT6ge4rHhrqH6phvad5f0VlMBe6KT0pQPGR/p9W0lG9DWdSMWxC0xJs0BkJgYR+EfVe
         yOuypsQ/Q/84QNQbb/bzLOYbSVjlqG70ZKPZ22NkOz2lWn+LhFJ87YUlN32AahTh8SuX
         qzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqao7JYLtTgdPFbX+Ng5WO8iCE+HSOq9strrayMPOb8=;
        b=Bv3bQ03vI9I2w70fDFD7vlBCJZyaBmFYqgxuUa7O/Ys9/P5K76xjwMTD55vhxCv33N
         UdpAmRZQ8SAQxCpIC9holpWIZ+/JxmtOMc7nKUoX2v72KelC/9uHdZ2ufTEC3pAs+qSz
         m5KnBdgN200Z4/tHQHP3D/rQxsDTPxwNWO7dVTsoe+IW3dIH3Al+XAfyFsweWOXQfobo
         xW3L1Iu3C6T/p5lBU1/EOzPvmzG/A2EM5LGnRAq+NFqpJ5RPntR9RUUUKTsq8ryAZpfH
         fdkFxnBxt5IgxSfAgQ59045wI4npw3+MzEMd83kcctE/6cUv4FGR/v0l7yeqH0lvUhHO
         i57Q==
X-Gm-Message-State: AA+aEWbKJBxv9tZSoGJZ8wJaK4h2Qg7WGlyQIm+6J3CBun0PQih1e4cn
        PCHfB26mSzilvtQR1tnmadAUZg==
X-Google-Smtp-Source: AFSGD/XPVQWEbOLKjSpymGEsUmqLRYfDIHzz623WNwdeWjW+LN4+S3cx/SJY3F10L2Jh1kebSbMaXQ==
X-Received: by 2002:a02:946e:: with SMTP id a101mr9054492jai.90.1544379864019;
        Sun, 09 Dec 2018 10:24:24 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id l25sm3270631ioj.68.2018.12.09.10.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:24:23 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v10 0/4] seccomp trap to userspace
Date:   Sun,  9 Dec 2018 11:24:10 -0700
Message-Id: <20181209182414.30862-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v10 of the seccomp trap to userspace series. The only changes
since v9 was to fix up a compilation error in the
!CONFIG_ARCH_HAS_SYSCALL_WRAPPER case, and to add Serge's acks.

Link to v9: https://lore.kernel.org/lkml/20181203032827.27978-1-tycho@tycho.ws/T/#u

Cheers,

Tycho

Tycho Andersen (4):
  seccomp: hoist struct seccomp_data recalculation higher
  seccomp: switch system call argument type to void *
  seccomp: add a return code to trap to userspace
  samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt          |   1 +
 .../userspace-api/seccomp_filter.rst          |  84 ++++
 include/linux/seccomp.h                       |   9 +-
 include/linux/syscalls.h                      |   2 +-
 include/uapi/linux/seccomp.h                  |  40 +-
 kernel/seccomp.c                              | 468 +++++++++++++++++-
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   7 +-
 samples/seccomp/user-trap.c                   | 375 ++++++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 447 ++++++++++++++++-
 10 files changed, 1411 insertions(+), 23 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c

-- 
2.19.1

