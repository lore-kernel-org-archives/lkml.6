Return-Path: <sergeev917@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520969689; cv=none;
        d=google.com; s=arc-20160816;
        b=PyALZh/IC7VKpVnjGad78sngl9Ceok8UdZfcy18o73j/IT2tt8e7Cqb8gLhWYMNseB
         rxX6Vr62DXiBs3jQOPyN3iz5NPDkHpYrHCCcvQk0IaIID2fNAUBUTZcwrs+u1sPnPqnx
         2MIyMHmMwsIJPoOkWvXgY/Yz+FKL3WO3vmRDEJ/dsDsZTujiLHiUib8Llr13jTxRJz5t
         hsyyP1D7nuyC5iO07Isz3np3rokKxAIopQZYnlxQUggj1tQw2TfrEDivbJJD3nEXzfs4
         JT5owmx4rzl6H2CXRUZZSpmehYxqXE1KgMdTmYXJuFHaepwaP/z3vQZLeftrxr+DRYN+
         pUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=k8lX/8xPrE56sqAhoxyyalOONJvnQBsAKxw3lkAtbpA=;
        b=uclkeUVT0SUhncHdTvAUGSKaEZ8q1AKPb2Qe4KI+N+WQxjjNYhyeVP69fbZZo4jMoz
         p6qj/ENzYdPS2nKJKSQQyeYxpEuPODGX7OI7DhQhKbcxb2/6BwXrcbe73BDpcl4nJr0H
         vmYNb0nzk5H3TU9JiaRBQmXmPx4jC42VZYfRnmWWGt5+zFwMassWldp7ZI+jRhyO+mqC
         sUWmDgtIduaqDkYw4YTRkhzA0MqY1dCeUSR+Fagc0zJetdBAwiu4xPUcTLIrmD8APYEg
         b8Jr6N+NkroMc1jc/i34XP4PQM0Zk0QGRCoYVXVofYvYKGoEgVxrpHJKLGn4WUMZA0CY
         JcAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oDfmfHBB;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oDfmfHBB;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuFElN7cnT0dVPouvR7tzJhVOqu93Ewxf8NwRcvf983QRLUVJGlmwvWnJJYoFt+qBXNrqs0vg==
Date: Tue, 13 Mar 2018 22:38:56 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kyle Huey <me@kylehuey.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/speculation: Remove Skylake C2 from Speculation Control
 microcode blacklist
Message-ID: <20180313193856.GA8580@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: mtt
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594852313515913739?=
X-GMAIL-MSGID: =?utf-8?q?1594852313515913739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In accordance with Intel's microcode revision guidance from March 6 MCU
rev 0xc2 is cleared on both Skylake H/S and Skylake Xeon E3 processors
that share CPUID 506E3.

Signed-off-by: Alexander Sergeyev <sergeev917@gmail.com>
---
 arch/x86/kernel/cpu/intel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b862067bb33c..3f8d7a3b6447 100644
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
-- 
2.16.1
