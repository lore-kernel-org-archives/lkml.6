Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECE3205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="RrZSMhJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECE3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeJ3Hb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:31:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33788 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeJ3Hb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:31:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so4519914pln.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6+FSbd+rLOYyrKEivrSmwWx/vfj/Gd/EMTvBjUnbWVc=;
        b=RrZSMhJB4j0MEaWDbXMgvkAbw5mpEXM7qHvSx45H5vWjkog6ZQT9sG0k+Y7fjbbV84
         cEg6yt37xGizRH9iL45/s25c9s1AWsnK3JwMJzL7evm4eCQJTPsH3cw/uqthdhUGTaZN
         NI+xZL0CNQ6slDYSgu7PImysg2xQPyJQd7rbeTTtAdCbSfTnHPjosU4XpU3pOsjEAUiH
         Xirn6WAo9B95pT0QywJdTEzZcTTava2kvSxq+Ds+NbfsiOC86WaQ2aOzBb9YWfkkeee9
         wrHlzDwAPhTjWtFAZvdhUYHAG7S/jnbbOYKxtLtvG20Zgo1hBIG3nPsTvJQwX7bl6m8A
         BuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+FSbd+rLOYyrKEivrSmwWx/vfj/Gd/EMTvBjUnbWVc=;
        b=l8Go21demaBBnv6ybIyYqHByTbeeBBVn8htRJQcKRvl8s9Kr7AgeYSKX79RK4z5fYc
         6TZX70SMW0uzrWtAsNM0wOJfg/MxCs1LOzm3wO/qg9ub+td+lgv1i9WwQ5kIv/qoRQSq
         S/A1zR/GGPawYp5p4uY0lDh4GaycqNFDF+HYehv1StMPC+Pi2sai+Xw36WPrXUjxZiQP
         DAk/cCzNR7gtXVwMj0RKJEBDwsl21oGV+RxdIh7KkYl/lVrQPyPeZ9YEg1H/qYPjNZyc
         ijdBLhGumhcbgFZVTBK7WxEFeLAvXOYpeSc6hSijF7FMBWzHKKC6i0wvZ7wBYxgdYao5
         NKNA==
X-Gm-Message-State: AGRZ1gK+BXshQ17OeEl9+N9QG4m6QaSfGPnFOnMjZlac5rNlL/eoTpMX
        x8FvLYlaKoHdalPmnby5RR/2tQ==
X-Google-Smtp-Source: AJdET5e2F5i3AbqKnDt80VWl0y+uY3DMrjfMKIX/CSk2ToBzFGWUqAdqdvFaKdEte0qXdpYT0fBw2Q==
X-Received: by 2002:a17:902:8202:: with SMTP id x2-v6mr16122192pln.192.1540852841566;
        Mon, 29 Oct 2018 15:40:41 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id t27-v6sm23274712pfj.96.2018.10.29.15.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 15:40:40 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v8 0/2] seccomp trap to userspace
Date:   Mon, 29 Oct 2018 16:40:29 -0600
Message-Id: <20181029224031.29809-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Here's v8 of the seccomp trap to userspace series. Major changes are:

* dropped the ptrace API all together. I believe based on the last
  thread that it could be made safe by adding a check on the refcount of
  the filter when grabbing it, but that sort of feels like a hack and
  it's not strictly necessary, so I dropped it.
* dropped the fd passing bits (for now). I like Andy's API proposal, and
  there are a few ways to implement it, but how exactly is
  controversial, and the stuff I'm really interested in using this for
  doesn't need the fd passing bits.
* applied all the feedback from v7 (I think, there was a lot of it :)

Link to v7: https://lkml.org/lkml/2018/9/27/968

Cheers,

Tycho

Tycho Andersen (2):
  seccomp: add a return code to trap to userspace
  samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt          |   1 +
 .../userspace-api/seccomp_filter.rst          |  66 +++
 include/linux/seccomp.h                       |   7 +-
 include/uapi/linux/seccomp.h                  |  35 +-
 kernel/seccomp.c                              | 475 +++++++++++++++++-
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   7 +-
 samples/seccomp/user-trap.c                   | 345 +++++++++++++
 tools/testing/selftests/seccomp/foo           | 106 ++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 355 ++++++++++++-
 10 files changed, 1387 insertions(+), 11 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c
 create mode 100644 tools/testing/selftests/seccomp/foo

-- 
2.17.1

