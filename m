Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDSBeY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:34:24 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33927 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeDSBeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:34:22 -0400
X-Google-Smtp-Source: AIpwx49s5lgDA8VeNzvAIwm9O5QPEBkxv0YnvB/IM2rXrQU1sc3cQ7cYAt+NFr+wZUwSyozeH39ikQ==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next 0/5] samples/bpf: Minor fixes and cleanup
Date: Thu, 19 Apr 2018 09:34:01 +0800
Message-Id: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is minor fixes and cleanup for bpf load and samples
code.  The first one patch is typo fixing; patch 0002 is refactor for
dynamically allocate memory for kernel symbol structures; the last
three patches are mainly related with refactor with function
ksym_search(), the main benefit of this refactor is program sampleip
can be used without architecture dependency.

The patch series has been tested on ARM64 Hikey960 boards.

Leo Yan (5):
  samples/bpf: Fix typo in comment
  samples/bpf: Dynamically allocate structure 'syms'
  samples/bpf: Use NULL for failed to find symbol
  samples/bpf: Refine printing symbol for sampleip
  samples/bpf: Handle NULL pointer returned by ksym_search()

 samples/bpf/bpf_load.c         | 29 +++++++++++++++++++++++------
 samples/bpf/offwaketime_user.c |  5 +++++
 samples/bpf/sampleip_user.c    |  8 +++-----
 samples/bpf/spintest_user.c    |  5 ++++-
 samples/bpf/trace_event_user.c |  5 +++++
 5 files changed, 40 insertions(+), 12 deletions(-)

-- 
1.9.1
