Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeCTLFX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7319 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752839AbeCTLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:18 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38002749"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 1/5] x86/smpboot: Add the missing description of possible_cpus
Date: Tue, 20 Mar 2018 19:04:28 +0800
Message-ID: <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 5261648AE76B.AF586
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel uses the possible_cpus in command line to reset the possible_cpus bits
in cpu_possible_map. It doesn't be recorded in the kernel-parameters.txt

Add its description in this document, also replace the wrong option additional_cpus
with possible_cpus in cpu-gotplug-spec.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 Documentation/x86/x86_64/cpu-hotplug-spec       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..34f8a5f04e63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2832,6 +2832,11 @@
 			variables need be pre-allocated for later physical cpu
 			hot plugging.
 
+	possible_cpus=	[s390,x86_64] Use this to set hotpluggable cpus.
+			This option sets possible_cpus bits in cpu_possible_map.
+			Thus keeping the numbers of bits set constant even if
+			the machine gets rebooted.
+
 	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
 
 	numa_balancing=	[KNL,X86] Enable or disable automatic NUMA balancing.
diff --git a/Documentation/x86/x86_64/cpu-hotplug-spec b/Documentation/x86/x86_64/cpu-hotplug-spec
index 3c23e0587db3..d218bc0bdaaa 100644
--- a/Documentation/x86/x86_64/cpu-hotplug-spec
+++ b/Documentation/x86/x86_64/cpu-hotplug-spec
@@ -16,6 +16,6 @@ it should have its LAPIC Enabled bit set to 0. Linux will use the number
 of disabled LAPICs to compute the maximum number of future CPUs.
 
 In the worst case the user can overwrite this choice using a command line
-option (additional_cpus=...), but it is recommended to supply the correct
+option (possible_cpus=...), but it is recommended to supply the correct
 number (or a reasonable approximation of it, with erring towards more not less)
 in the MADT to avoid manual configuration.
-- 
2.14.3
