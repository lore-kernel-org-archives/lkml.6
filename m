Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lZagC7/VG1vzGwAAmS7hNA
	; Sat, 09 Jun 2018 13:27:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A0C8608BA; Sat,  9 Jun 2018 13:27:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 122D06074D;
	Sat,  9 Jun 2018 13:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 122D06074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeFIN1Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:27:25 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:40314 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753171AbeFIN1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:27:23 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAAXTbkR1BtbkShEBA--.934S2;
        Sat, 09 Jun 2018 21:20:33 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, peterz@infradead.org,
        tony.luck@intel.com, bp@alien8.de, pbonzini@redhat.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        zhangpanyong@hygon.cn
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 00/11] Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:20:10 +0800
Message-Id: <1528550410-28080-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAAXTbkR1BtbkShEBA--.934S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryUAr4rCFy3Ar1fuFykZrb_yoW5uw1kpF
        W2yrsYyF4ruasxA3sxCrn7uryfAFy8GrW7Gw12g39rX3WYva4UXrn7Aa1kJ3yqqw1rGw4f
        tryrWF4UGr1kXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fU7b18DUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a new x86 CPU Vendor, Chengdu Haiguang IC Design Co., Ltd (Hygon)
is a Joint Venture between AMD and Haiguang Information Technology Co.,
Ltd., and aims at providing high performance x86 processor for China
server market.

The first generation Hygon's processor(Dhyana) originates from AMD
technology and shares most of the architecture with AMD's family 17h,
but with different CPU Vendor ID("HygonGenuine")/PCIE Device Vendor ID
(0x1D94)/Family series number(Family 18h).

To enable the support of Linux kernel to Hygon's CPU, we added a new
vendor type (X86_VENDOR_HYGON, with value of 9) in arch/x86/include/
asm/processor.h, and shared most of kernel support codes with AMD
family 17h.

These patches have been applied and tested successfully in Hygon's
Dhyana SoC silicon. Also tested on AMD's EPYC (Family 17h) processor
works fine and makes no harm to existing codes.

Thanks.

Pu Wen (11):
  x86/cpu: Add support for Hygon's Dhyana Family 18h processor
  x86/pci: Add support for Hygon's Dhyana Family 18h processor
  x86/cpu/bug: Add support for Hygon's Dhyana Family 18h processor
  x86/perf: Add support for Hygon's Dhyana Family 18h processor
  x86/mce: Add support for Hygon's Dhyana Family 18h processor
  x86/kvm: Add support for Hygon's Dhyana Family 18h processor
  x86/xen: Add support for Hygon's Dhyana Family 18h processor
  driver/acpi: Add support for Hygon's Dhyana Family 18h processor
  driver/cpufreq: Add support for Hygon's Dhyana Family 18h processor
  driver/edac: Add support for Hygon's Dhyana Family 18h processor
  tools/cpupower: Add support for Hygon's Dhyana Family 18h processor

 arch/x86/events/amd/core.c                         | 10 ++++++++
 arch/x86/events/amd/uncore.c                       |  7 ++---
 arch/x86/events/core.c                             |  1 +
 arch/x86/include/asm/kvm_emulate.h                 |  4 +++
 arch/x86/include/asm/nospec-branch.h               |  4 +--
 arch/x86/include/asm/processor.h                   |  3 ++-
 arch/x86/include/asm/virtext.h                     |  5 ++--
 arch/x86/kernel/alternative.c                      |  4 +++
 arch/x86/kernel/amd_nb.c                           | 11 +++++++-
 arch/x86/kernel/apic/apic.c                        | 13 ++++++++--
 arch/x86/kernel/cpu/amd.c                          | 14 +++++++++-
 arch/x86/kernel/cpu/bugs.c                         | 30 ++++++++++++----------
 arch/x86/kernel/cpu/common.c                       |  1 +
 arch/x86/kernel/cpu/intel_cacheinfo.c              |  9 ++++---
 arch/x86/kernel/cpu/mcheck/mce-severity.c          |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c                   | 16 +++++++++---
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |  3 ++-
 arch/x86/kernel/cpu/mtrr/generic.c                 |  3 ++-
 arch/x86/kernel/cpu/mtrr/main.c                    |  2 +-
 arch/x86/kernel/cpu/perfctr-watchdog.c             |  2 ++
 arch/x86/kernel/smpboot.c                          |  4 ++-
 arch/x86/kvm/emulate.c                             |  8 +++++-
 arch/x86/pci/amd_bus.c                             |  6 +++--
 arch/x86/pci/irq.c                                 |  1 +
 arch/x86/xen/pmu.c                                 | 12 ++++++---
 drivers/acpi/acpi_pad.c                            |  1 +
 drivers/acpi/processor_idle.c                      |  1 +
 drivers/cpufreq/acpi-cpufreq.c                     |  5 +++-
 drivers/cpufreq/amd_freq_sensitivity.c             |  9 +++++--
 drivers/edac/amd64_edac.c                          | 20 ++++++++++++++-
 drivers/edac/amd64_edac.h                          |  4 +++
 drivers/edac/mce_amd.c                             |  4 ++-
 include/linux/pci_ids.h                            |  2 ++
 tools/power/cpupower/utils/cpufreq-info.c          |  6 +++--
 tools/power/cpupower/utils/helpers/cpuid.c         |  6 +++--
 tools/power/cpupower/utils/helpers/helpers.h       |  2 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  3 ++-
 37 files changed, 183 insertions(+), 56 deletions(-)

-- 
2.7.4
