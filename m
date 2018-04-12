Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeDLKOC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:14:02 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:51729 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:13:59 -0400
X-Google-Smtp-Source: AIpwx49sSRDR+JHiLHOtOHBEpMks72PnRJ6ZW77XQtRb7GS9j1REw5UArZGgaWLs6vyRZaz59Yx8FkVTDg==
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 12:13:46 +0200
Message-Id: <20180412101350.210547-1-tweek@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH v2 0/4] Refactor TPM event log code
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

Changes since v1:
- Add Suggested-by
- Fix kbuild report

Thiebaud Weksteen (4):
  tpm: Add explicit endianness cast
  tpm: Move eventlog files to a subdirectory
  tpm: Move shared eventlog functions to common.c
  tpm: Move eventlog declarations to its own header

 drivers/char/tpm/Makefile                     |  10 +-
 .../{tpm_eventlog_acpi.c => eventlog/acpi.c}  |   3 +-
 drivers/char/tpm/eventlog/common.c            | 195 +++++++++++++++++
 drivers/char/tpm/eventlog/common.h            |  35 +++
 .../{tpm_eventlog_efi.c => eventlog/efi.c}    |   3 +-
 .../tpm/{tpm_eventlog_of.c => eventlog/of.c}  |   7 +-
 .../tpm/{tpm1_eventlog.c => eventlog/tpm1.c}  | 200 ++----------------
 .../tpm/{tpm2_eventlog.c => eventlog/tpm2.c}  |   3 +-
 drivers/char/tpm/tpm.h                        |  27 ---
 9 files changed, 262 insertions(+), 221 deletions(-)
 rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (98%)
 create mode 100644 drivers/char/tpm/eventlog/common.c
 create mode 100644 drivers/char/tpm/eventlog/common.h
 rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (97%)
 rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (94%)
 rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (58%)
 rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)

-- 
2.17.0.484.g0c8726318c-goog
