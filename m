Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45464C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F164C20891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="oS/J1fTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F164C20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeH1S3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:29:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33742 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeH1S3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:29:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14-v6so856605pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AcrZoWuPg9/ZorKZOrctybLAjTuChmzL5RQBybjz/UY=;
        b=oS/J1fThU9PwfQsLCzmo5f7fnzrpHCy9pd2B/GZyc8Fvc3zUJlwmS3IKHSU87aU9Uf
         9dvZrYbzRmBkZAuLCbspOw7FL2rLeTmr67TclrTGkl691B1knH9IN6l7y0kSakbfUImI
         U9d2/6o/CnGmuWWa7mte7txSWvpQEsT8/nZFxf5OdZGwxu8OWwVP9/w9C6QiwT5RNoW3
         0RklqiU7inU/tCYjVOQrQfaSCuELWLTgko0SdxPQF/NGEkkB4HCuwKVjf+TtAczPT2z4
         thhqS0bSLDu2gmRA+/TapEnRjy+WtSzbB14yNgvhem56NEazLX6jnBH5ZhqPvpR1I/kL
         wSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AcrZoWuPg9/ZorKZOrctybLAjTuChmzL5RQBybjz/UY=;
        b=DIhZ6eAPtUzTfGk6bmqTdDoaRIo4yUXi4ZOQoNYLgSVSaXA7kOmGFmsWPZMLPTGMcN
         wl6lvXFYA+NQ37f0BTOEuKj4vwIBRZYENA24V5+D8wjtkVdG4V1YmnOfeBGe/jdO7q4s
         A4vqTZI7k8U5Xws3lGpb8YCn3GFIo6/h7ImYxojNM6P0RRuCvaQqBe8MafWzKBU8pLba
         xmF1Qj3SSTqUwkskMPSKZT2ZRen3ZvYyD6B1TBRbat/wIg9Dl/gJUQOeqcHY384YYRlt
         ZcHXaBEdKTixuQ+yEmjx02V6JDxHHj6obuHibGAsfXXj6EbgTXkoIfHP8thLPQXcC403
         cNdw==
X-Gm-Message-State: APzg51BH2ftfnfZt5eme/GBNt67cp+0FKNKco4dNnqvws7xBJg1CxYc7
        0CTVwt2PraNod0fIlx9KhIgkoQ==
X-Google-Smtp-Source: ANB0VdagYIkrENywxWzLdqmg/2KoYlrIBtnUGTVup8eksYS6XMZwSxRoTifUmU6aUatYXRPjjR3WcA==
X-Received: by 2002:a63:91:: with SMTP id 139-v6mr1842653pga.389.1535467025086;
        Tue, 28 Aug 2018 07:37:05 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.165])
        by smtp.gmail.com with ESMTPSA id s16-v6sm1973550pfm.114.2018.08.28.07.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:37:03 -0700 (PDT)
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
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v5 0/5] seccomp trap to userspace
Date:   Tue, 28 Aug 2018 08:35:58 -0600
Message-Id: <20180828143603.8127-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v5 of the seccomp user set. Major changes from v4 include:

* switching to ioctl vs read/write
* adding a way to query whether a notification id is valid
* added a sample program that shows a complete usage of the API w/ notes
  about various TOCTOUs

as well as a bunch of smaller fixes. See individual patch notes for
details.

Thanks,

Tycho

Tycho Andersen (5):
  seccomp: add a return code to trap to userspace
  seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
  seccomp: add a way to get a listener fd from ptrace
  seccomp: add support for passing fds via USER_NOTIF
  samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt          |   1 +
 .../userspace-api/seccomp_filter.rst          |  80 +++
 arch/Kconfig                                  |   9 +
 include/linux/seccomp.h                       |  18 +-
 include/uapi/linux/ptrace.h                   |   2 +
 include/uapi/linux/seccomp.h                  |  36 +-
 kernel/ptrace.c                               |   4 +
 kernel/seccomp.c                              | 538 +++++++++++++++-
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   9 +-
 samples/seccomp/user-trap.c                   | 312 ++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 587 +++++++++++++++++-
 12 files changed, 1584 insertions(+), 13 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c

-- 
2.17.1

