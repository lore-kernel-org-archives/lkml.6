Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A2BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84C724491
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKXq0TSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84C724491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeGDNhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:37:03 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45071 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeGDNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so2504040pgv.12;
        Wed, 04 Jul 2018 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhsA5GmYA+UA544kCdrWrrIXqS2tlobWNCtjnelqA6s=;
        b=WKXq0TSvzMYl4YJ/xxomACl2OpliJQBEvS+Fb3SKjd68Q3H5RvjGZWB0DOKaqcIN/O
         Xd0YUup97ZXHrtWNxNPOjD6Mx/ljUOCjq2OMosAfuGP9YtU+HVGBD6KVk3TScIQ+1Xft
         3EP1LJYHGeKfhDiGUUSVXL9uoOZM+SKmhoVpa6lYnUy17It3M6jDbwg4sMIOyA1BSdwN
         ZWEVRxFHhnWMW393wKewsZSQ3/qQtmA0cndZeiSt6ZSpuvIFyvr6r5+GTGxVgZBw05r3
         M3ahV52j0EFHO8EEfUr4PYX1ak8pLUWzx+yWPA6Be9+nhm2cgAAP/t6ttRiFEQb4zGIu
         HRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhsA5GmYA+UA544kCdrWrrIXqS2tlobWNCtjnelqA6s=;
        b=A0zw2ySXWYTHvDX2X/eDo3lXw+Jpb8FrCvpo1hU5EWbzl2x4UX6NFbHyuItWn/hFYF
         gGxpw+WoNXs5tyka7EBBrXq3D5hupGkwJLtCs+pqmtAcb2AAAAc81t57B+MLpsK4o0QJ
         bJqKQPK1DI3ZIBmUKYEfmpprKdhF3yodXSCUqWjRjof9UMo50AwOwk4HI+j9DToLwozL
         +6jtBhRWHgqr3lkhsYvacwlVdTe2Pd6wlqC4hEVcFj6yE5K7c+69SKvD+9iOe/A/NB/t
         55RbUBXEqZSARy2m4fd/6MmcxyLz3tXKbQ391q4oa4n7MnGNPGoNw138Vul7ONRrQo0W
         iLVQ==
X-Gm-Message-State: APt69E0ToG9OOun/MDs3thpZNYSP46PmBOj6VmCMVyiNZ7NNdi+lmX5j
        LsNUxIZof3eVRiSYlZKW+wsOxw==
X-Google-Smtp-Source: AAOMgpefUJzhnze994c4zn1EhXp6/1gQKZd4U3Vv4f1JhzWq1IAXmD7NC7LGfe9k1MxNMwhJ3yk8DA==
X-Received: by 2002:a63:f919:: with SMTP id h25-v6mr1906986pgi.401.1530711420945;
        Wed, 04 Jul 2018 06:37:00 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3593913pgd.87.2018.07.04.06.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:37:00 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 0/4] samples/bpf: simple fixes
Date:   Wed,  4 Jul 2018 22:36:35 +0900
Message-Id: <20180704133639.11855-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- in error cases, do return; instead of break; in loop

Hello,
This patchset fixes trivial things that I found
when testing 'samples/bpf/' sample code.
I'd appreciate it, if you review this.

Thanks,
Taeung

Taeung Song (4):
  samples/bpf: add missing <linux/if_vlan.h>
  samples/bpf: Check the result of system()
  samples/bpf: Check the error of write() and read()
  samples/bpf: add .gitignore file

 samples/bpf/.gitignore           | 49 ++++++++++++++++++++++++++++++++
 samples/bpf/parse_varlen.c       |  6 +---
 samples/bpf/test_overhead_user.c | 19 ++++++++++---
 samples/bpf/trace_event_user.c   | 27 ++++++++++++++++--
 4 files changed, 89 insertions(+), 12 deletions(-)
 create mode 100644 samples/bpf/.gitignore

-- 
2.17.1

