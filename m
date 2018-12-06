Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D0BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA68220700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/EHpjkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA68220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLFPCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:02:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54172 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLFPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:02:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so1283002wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk8Tnme4bbqG3+h4d86EKaBi7wPmuDTPdXEEnReXJ4A=;
        b=N/EHpjkqTWKjgqSkOlTjkDXo/pwUWieIGKYO4EpsKf4t59q24pnoEftZU0NmDrvNBC
         HQjJuJOypbvOX9wZSTvZOLQJffPAWvZR0yY1J+Fuhm09ZhvEf3WX69iGs9W0gowXbqIN
         mC9njeuRVySLafFGDwYpyhWQ0C8MHONm9mR5P9sD6n5u6YjFY7Bl8Mj5wofjeRWDrltD
         IEltuc38IR6MV7cadiKoQ2PY0K8yr393HEHRkHsyXNaDYVOxGV+BjpET7jGZGeK003xy
         U3PvMI3MJHZJ4VDqokwub3zJTtaT5NkhczmnPzFKDBynapoFXlyFDTTTXr19FEK998+b
         9zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk8Tnme4bbqG3+h4d86EKaBi7wPmuDTPdXEEnReXJ4A=;
        b=pJI+sqxOAPUeSFu/QVAe3quFvfEsiTEKW+y95MO7hxeu+DMzVHVXc4Pyd3uYtqKdOw
         qRWqtltIuRv6qeeSa81z3QidIAaKgq8mZiyD9F6zZoAlX04dIK0RvmUvSkKtQj66QnQU
         E+asUCXRJt162hcSzedZBnKol7M99787ETk7WDdIEEEXM5fM9Tz/gKrOSyLQEuLCRSzZ
         xL75WrIKMCG1JMj9hz/8P4udLPxychGakp6M8I1k/ykqeN/0lqYq6uxS3wDmRZi/VIOJ
         tk4DhoEX5Tw0rhyddNTzRvXv4kd11bQEvqp8c5ssJRYjT7ISgPoaSoqZYpit+5GOeqLP
         SNVQ==
X-Gm-Message-State: AA+aEWYIVUEdCjU+EhQzJKDnlK+UakgNWNpcZjFV4sL4pS+vR35uqr9U
        BAGrb7VMqss5r4W4Yej5xKyiErCFGMg=
X-Google-Smtp-Source: AFSGD/UVOJM66XYYaUjPwVXWLk9eVU1L6NjBdcIUR9aVX4TEFGE9dvix3M+yZx1VCJNY+uM0ALZtbQ==
X-Received: by 2002:a1c:d7d3:: with SMTP id o202mr13863733wmg.135.1544108524137;
        Thu, 06 Dec 2018 07:02:04 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id 14sm1629981wmv.36.2018.12.06.07.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:02:02 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 0/2] riscv: add support for SECCOMP and SECCOMP_FILTER
Date:   Thu,  6 Dec 2018 16:01:54 +0100
Message-Id: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was originally tested on 4.19 kernel with Fedora 29/RISCV. 
Depends on audit patches (already in linux-next).

The patches are on top of linux-next next-20181206 tag.

Validation was done using libseccomp (at 
1e64feb5f1a9ea02687228e3073e8b784a04ce46, which is master at this 
date). See PR: https://github.com/seccomp/libseccomp/pull/134

Test results:

# ./regression -T live

Regression Test Summary
tests run: 8
tests skipped: 0
tests passed: 8
tests failed: 0
tests errored: 0

# ./regression

Regression Test Summary
tests run: 5129
tests skipped: 104
tests passed: 5129
tests failed: 0
tests errored: 0

David Abdurachmanov (2):
  riscv: add support for SECCOMP incl. filters
  riscv: fix syscall_{get,set}_arguments

 arch/riscv/Kconfig                   | 14 ++++++++++
 arch/riscv/include/asm/syscall.h     | 42 +++++++++++++++++++++-------
 arch/riscv/include/asm/thread_info.h |  5 +++-
 arch/riscv/kernel/entry.S            | 27 ++++++++++++++++--
 arch/riscv/kernel/ptrace.c           |  8 ++++++
 5 files changed, 83 insertions(+), 13 deletions(-)

-- 
2.19.2

