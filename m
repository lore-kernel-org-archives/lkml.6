Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7046C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED002246A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="uy2oX6tE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED002246A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeFUWEr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:04:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33224 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933807AbeFUWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:04:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id l10-v6so4349718qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Vec3g15rqX5tPpr4wXsVAyRefMb116qUxoatzMLj2BU=;
        b=uy2oX6tEmYlWWni1O95dHTOAz3Mmfxl2JNGvGSZewuyqBETlp5AMZQktPZrqwWkxPH
         rdWz7JhuFfXKkwU8lDOf24J8BVWi0mjhwHCOWXpYxuINv4qTOEK58tJIKnBiJm2IRo+i
         OHLE4Rz/XRnKqn16VAdj7U6XjPaWYKSF8814pq3tVlfRhgfWbhy+vO1X7B4cF+g3x9Nb
         11ssRjlaAHgdK/o6WPjKI2wSEVHfiY3a5VNYJR0mfKI9d2mBZlHLPI+hhUlD2X1+n+aK
         DgaI7Dm6c2YFqmhgCrLJ+bA3umtzAz2pS8dAlklksfF/gebVsW5NpqAjFghiys5LWBsc
         Or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vec3g15rqX5tPpr4wXsVAyRefMb116qUxoatzMLj2BU=;
        b=OBLnACo/8nQOigXkFE5EReZ03BT74FV+6aZq/fD1AGkj++ROLbJuazoswBPC3lOBj4
         2tQstUvsbvHmyCZL2SbBnBuR8xNTAELVGK+CLWDC4XvtPYtQA3LZoHlAtplhCwjaou5o
         jG31A6tAd4TpqwXT5GymDdQv850lEroUrj7EBqNl3r+VWZlgghPWAjGVgYJLFILHmtZh
         ndtnBvMHrBRSrwXTXuHgTP+NnfKSLYkKBJ+AuZOrlIvg5oXy0XmDm/3f0LCa1eSE4MKD
         z43pDsxuxKulB3SybqmZffcdiRnQNYH3H/Lejn1ImLT4+s/oBnuKr5n9afLCI1QeOj6v
         alTQ==
X-Gm-Message-State: APt69E1YDDmowazRs/v5paID6SqdT3ffqeGOHOvH1H/+0zRJOjB6EX2p
        JkZGt/qMfVrlEOc5Y4bIfoaGcg==
X-Google-Smtp-Source: ADUXVKKKp4W+K8VkpE+P6hMwcE0xVw8+cGadUb3JwN9+IflyfTrZkY6y9tWA4WNDOEDMgKzhBJU0jQ==
X-Received: by 2002:a0c:b916:: with SMTP id u22-v6mr23714477qvf.224.1529618681229;
        Thu, 21 Jun 2018 15:04:41 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id l73-v6sm6668473qkl.78.2018.06.21.15.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:04:40 -0700 (PDT)
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
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v4 0/4] seccomp trap to userspace
Date:   Thu, 21 Jun 2018 16:04:12 -0600
Message-Id: <20180621220416.5412-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v4 of the seccomp trap to userspace series. v3 is here:
https://lkml.org/lkml/2018/5/31/527

I believe we've addressed the two burning questions I had about v3: 1.
it seems ok not to use netlink, since there's not a great way to re-use
the API without a lot of unnecessary code and 2. only having return
capability for fds seems fine with people. Or at least I haven't heard
any strong objections.

I've re-worked a bunch of things in this version based on feedback from
the last series. See patch notes for details. At this point I'm not
aware of anything that needs to be addressed, but of course that is
subject to change :)

Tycho

Tycho Andersen (4):
  seccomp: add a return code to trap to userspace
  seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
  seccomp: add a way to get a listener fd from ptrace
  seccomp: add support for passing fds via USER_NOTIF

 .../userspace-api/seccomp_filter.rst          |  79 +++
 arch/Kconfig                                  |   7 +
 include/linux/seccomp.h                       |  18 +-
 include/uapi/linux/ptrace.h                   |   2 +
 include/uapi/linux/seccomp.h                  |  23 +-
 kernel/ptrace.c                               |   4 +
 kernel/seccomp.c                              | 491 ++++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 560 +++++++++++++++++-
 8 files changed, 1172 insertions(+), 12 deletions(-)

-- 
2.17.1

