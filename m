Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeDKMzi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:55:38 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:56450 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeDKMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:55:34 -0400
X-Google-Smtp-Source: AIpwx4+sk2gNuLJ6dR08othzq3qLAAdmOzkRRsbo8pwLYXe72I0Hbx5ujjgJOgHj8xkQOqPMFwaEF8874g==
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 14:54:58 +0200
Message-Id: <20180411125501.188477-1-tweek@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 0/3] Refactor TPM event log code
From: Thiebaud Weksteen <tweek@google.com>
To: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tweek@google.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the proposal from Jarkko Sakkinen [1]. I have
included the feedback from Nayna Jain about the function naming.

[1] https://lkml.kernel.org/r/20171024222148.gwnkj5vqsyj43qer@linux.intel.com

Thiebaud Weksteen (3):
  tpm: Move eventlog files to a subdirectory
  tpm: Move shared eventlog functions to common.c
  tpm: Move eventlog declarations to its own header

 drivers/char/tpm/Makefile                     |  10 +-
 .../{tpm_eventlog_acpi.c => eventlog/acpi.c}  |   2 +-
 drivers/char/tpm/eventlog/common.c            | 196 +++++++++++++++++
 drivers/char/tpm/eventlog/common.h            |  35 +++
 .../{tpm_eventlog_efi.c => eventlog/efi.c}    |   2 +-
 .../tpm/{tpm_eventlog_of.c => eventlog/of.c}  |   2 +-
 .../tpm/{tpm1_eventlog.c => eventlog/tpm1.c}  | 200 ++----------------
 .../tpm/{tpm2_eventlog.c => eventlog/tpm2.c}  |   3 +-
 drivers/char/tpm/tpm.h                        |  27 ---
 9 files changed, 258 insertions(+), 219 deletions(-)
 rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (99%)
 create mode 100644 drivers/char/tpm/eventlog/common.c
 create mode 100644 drivers/char/tpm/eventlog/common.h
 rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (98%)
 rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (99%)
 rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (58%)
 rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)

-- 
2.17.0.484.g0c8726318c-goog
