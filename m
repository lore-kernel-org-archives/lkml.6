Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeCTLFa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7319 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752753AbeCTLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:20 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38002751"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 0/5] x86/cpu_hotplug: one bug fix and four cleanup
Date: Tue, 20 Mar 2018 19:04:27 +0800
Message-ID: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: B79CD48AE76A.A3292
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, we hoped to make the possible CPU count more accurate for
Kernel. I stuck on the issue how do I run acpi_early_init() _before_ 
setup_percpu() is invoked. So send these insignificant patches first.

This patchset does this things:

  - two document-related work(the 1th and 2th patch),
  - two cleapup work (the 3th and 5th patch)
  - a bug fix for CPU hotplug(4th patch)

Dou Liyang (5):
  x86/smpboot: Add the missing description of possible_cpus
  x86/cpu_hotplug: Update the link of cpu_hotplug.rst
  x86/smpboot: Make the check code more clear in prefill_possible_map()
  acpi/processor: Fix the return value of acpi_processor_ids_walk()
  acpi/processor: Make the acpi_duplicate_processor_id() static

 Documentation/00-INDEX                          |  2 -
 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 Documentation/cputopology.txt                   | 10 ++--
 Documentation/x86/x86_64/cpu-hotplug-spec       |  2 +-
 arch/x86/kernel/smpboot.c                       | 31 +++++++-----
 drivers/acpi/acpi_processor.c                   | 66 ++++++++++++-------------
 include/linux/acpi.h                            |  3 --
 7 files changed, 62 insertions(+), 57 deletions(-)

-- 
2.14.3
