Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806DBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B6321726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WFKu1w3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAVXig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:38:36 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51826 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVXig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:38:36 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so640626ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hezd3DAi4m26mdcQXgyX6zwdNZB7MKrbNOkLnCTYrE=;
        b=WFKu1w3gKSkWSQbGKoIZWCpHMjxJ7Jaz7pmiw72v34nwMu8m7bLhrtMAf7EwFmn/J3
         OW6cU1OiMaiJmQGSOEpnQ7w7Olpk9tp3rFw8MzXy1SXEYBqZlsyO1yWk+f0tiiAvFTDE
         7zFsNuFhvydaANxqwm3wxxbZBDPT5UzQfLwAckPVaVREdOYByT6rsLWtIn9qq8N9ENAz
         J2vNeiV3Ppf+ldzdijxLqv0LkegqGKm29J5o65c4tKAvuEdFgTUp3HZWEAA/3UvelPE0
         H/l6Mf/ssCL4CXnW8xU9xu8k71QyxKBMMn0v5OMY1ZY6VdJ3RJsA6ntiCRLMuUCEQr8f
         lj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hezd3DAi4m26mdcQXgyX6zwdNZB7MKrbNOkLnCTYrE=;
        b=kWyEgsG5z5D69QJZd2NVMqXsbc6pq8lQGnYpauWt7OKuB1S4YGKzWOLyjFpq4xnHxt
         C3C44fvAhamXvGL0ey6vr9qM2TqhDjrtnxYh/nr1F+PcmbJvOaJJyEL3RtBGGrWAiV2r
         2GgwZkrE6mCs/qVXEWebUxVkZ/acvh2zIbuBVUkI0jmfCbQvmIMBFdtE6l4WLJUXmMRo
         YHKCG0JgLJfcShxnSeCMxpQPMPnYE/bGX95C6eP1jhmWZFzzgqXNAUttneb0yMedoFV0
         9LQKHRhMesMpMNhuyg1R3uyUXEwxzMjYPkiaxnGsf2TzLRFVn9XI2XZZTPgj1oi+FQdP
         DFKw==
X-Gm-Message-State: AJcUukcN2dQ3zXsaxTh/72C5Xr2qqUX/lchFt3BFuMtDtlqhSwweTc7s
        RkX/YIpzbH7BkpX8rgYcqY7Ofw==
X-Google-Smtp-Source: ALg8bN5F+lxLQYsHtJDLoAae/8Sxk7g9bJ1N9b1jPaUyS6tdXlpY5G01vqTFG5O7GAoDnJu/O9DsRQ==
X-Received: by 2002:a24:a701:: with SMTP id a1mr360156itf.7.1548200314979;
        Tue, 22 Jan 2019 15:38:34 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id g186sm8058823ite.39.2019.01.22.15.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:38:34 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, Tri Vo <trong@android.com>
Subject: [PATCH v3 0/3] gcov: add Clang support
Date:   Tue, 22 Jan 2019 15:37:46 -0800
Message-Id: <20190122233749.42220-1-trong@android.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Clang supoprt for gcov.

Patch 1 refactors existing code in preparation for Clang support.
Patch 2 implements necessary LLVM runtime hooks and gcov kernel interfaces.
Patch 3 updates documentation.

Greg Hackmann (2):
  gcov: Clang: move common GCC code into gcc_base.c
  gcov: Clang support

Tri Vo (1):
  gcov: docs: add a note on GCC vs Clang differences

 Documentation/dev-tools/gcov.rst |  18 +-
 kernel/gcov/Kconfig              |   3 +-
 kernel/gcov/Makefile             |   5 +-
 kernel/gcov/base.c               |  84 +----
 kernel/gcov/clang.c              | 555 +++++++++++++++++++++++++++++++
 kernel/gcov/gcc_base.c           |  86 +++++
 kernel/gcov/gcov.h               |   3 +
 7 files changed, 665 insertions(+), 89 deletions(-)
 create mode 100644 kernel/gcov/clang.c
 create mode 100644 kernel/gcov/gcc_base.c

v2:
- Reorganized config dependencies, as per Masahiro.

v3:
- Squashed patches 2-4 of v2, as per Nick, Masahiro, and Peter.
Addressed comments by Peter:
- Moved __gcov_exit() to gcc_base.c
- Added missing header to gcc_base.c
- Removed unnecessary boundary checks in gcov_info_add().
- Changed counters' allocation to use vmalloc().
- Added check for failed allocation of filename.
- Changed list_for_each_entry_safe to list_for_each_entry when traversing
  without modifying.
- Updated Documentation/dev-tools/gcov.rst

--
2.20.1.321.g9e740568ce-goog

