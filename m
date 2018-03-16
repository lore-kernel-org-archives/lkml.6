Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELtMMqCivs+wmx21t+mfzy6kdWYNqjqRmQgg0XbKKVW1qDtA4kAj0nHuos3mbAmTHBpCeEdi
ARC-Seal: i=1; a=rsa-sha256; t=1521201327; cv=none;
        d=google.com; s=arc-20160816;
        b=tay6ZRSN4HcRN2lkEGuR7ZOEiSKKQ7wqtbb1nnq7IhpXW3HDssb+T8dD3eYjDjZYtY
         NDaBLw9Tmp2ATNwUyG41wjFsSjz29NgOXkSlPleEA6Iapb92EOgbuZiYStYpzHxWhCzY
         lS01l0Iy6AxoWjWQNdOcuzfPFo9SRMVaMugsXkXsT9M/ntVrdoYTLsLf0xAb2djB7y+c
         3mbffWKeC0EvxRZ+RGTw9ROQF4hL+xhLe7FHbXi+/oMkTbs7rv+D+Ssje74tu23C1SXX
         KMzLEYoT1rHxZNeS2uKLLdbuuzHegSZrM+mudNqrMdONUqpGpDgW9097iJOlVKngR6CR
         p03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=0f2viviv9JTMPiztw2039ztWElBqqZ2cnjz4E6LgM+g=;
        b=WaPq3bLPumgHAzd2/cZ8PM0QzU9Bii+yuOzHB0oXfZwAd8ae/VTqgjT1EZ/h2cPimc
         DKon3ulfIyOH8/aVYOHInmkkDi8/4pon875jaaBkTzeldac8YlEWUoMaTP/Byz9yrs4U
         u16fDkTIvhYbe+eflkPNY9WJLAdoWmsSWkZsRWDyIqK2EgeffqSot+gtvy8fwEbiRpTO
         x4hGWm8w4UKwLj2SmqyjOavuY37ja/mjsohZXvKCKUnT9bei1Ty1hOVKc2Br1H/OLu7g
         Ko6byW3qhX7A9T8N42PZSIZTTBmGBwRXbsOujLz62xMrmyli797P7MWHmXexfBj/peCa
         AXXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Fri, 16 Mar 2018 04:55:12 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Alexander Sergeyev <tipbot@zytor.com>
Message-ID: <tip-e3b3121fa8da94cb20f9e0c64ab7981ae47fd085@git.kernel.org>
Cc: qianyue.zj@alibaba-inc.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, sergeev917@gmail.com, hpa@zytor.com,
        dwmw@amazon.co.uk, gregkh@linuxfoundation.org, me@kylehuey.com
Reply-To: mingo@kernel.org, sergeev917@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, qianyue.zj@alibaba-inc.com, me@kylehuey.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, dwmw@amazon.co.uk
In-Reply-To: <20180313193856.GA8580@localhost.localdomain>
References: <20180313193856.GA8580@localhost.localdomain>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Remove Skylake C2 from Speculation
 Control microcode blacklist
Git-Commit-ID: e3b3121fa8da94cb20f9e0c64ab7981ae47fd085
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594852313515913739?=
X-GMAIL-MSGID: =?utf-8?q?1595095203456121051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  e3b3121fa8da94cb20f9e0c64ab7981ae47fd085
Gitweb:     https://git.kernel.org/tip/e3b3121fa8da94cb20f9e0c64ab7981ae47fd085
Author:     Alexander Sergeyev <sergeev917@gmail.com>
AuthorDate: Tue, 13 Mar 2018 22:38:56 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Mar 2018 12:33:11 +0100

x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist

In accordance with Intel's microcode revision guidance from March 6 MCU
rev 0xc2 is cleared on both Skylake H/S and Skylake Xeon E3 processors
that share CPUID 506E3.

Signed-off-by: Alexander Sergeyev <sergeev917@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kyle Huey <me@kylehuey.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180313193856.GA8580@localhost.localdomain
---
 arch/x86/kernel/cpu/intel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4aa9fd379390..c3af167d0a70 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -105,7 +105,7 @@ static void probe_xeon_phi_r3mwait(struct cpuinfo_x86 *c)
 /*
  * Early microcode releases for the Spectre v2 mitigation were broken.
  * Information taken from;
- * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/03/microcode-update-guidance.pdf
  * - https://kb.vmware.com/s/article/52345
  * - Microcode revisions observed in the wild
  * - Release note from 20180108 microcode release
@@ -123,7 +123,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
