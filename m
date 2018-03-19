Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvljqQy7c4BUCuObcFzckbRDxxR8XeCdh1Mt9ph8IBqSaHbxg+yRuJ8TCNsO2DPS3zleohS
ARC-Seal: i=1; a=rsa-sha256; t=1521484206; cv=none;
        d=google.com; s=arc-20160816;
        b=ruku8vOFveHruAzMQH56YYsvc5JET2hQKjd4Qus3hXMFjq3f2E0LbdbbXKdgy5ztBZ
         ifuEzw79MoLoZpxvfG6s8xikG4NjuZxU7DAm/QKoH1qu9tBRG8hmAtPn4tIgs9Ohdabv
         Bs30rd51zgVb4uun+QWL3KKHrmu8iGEVx47BQgRO5JjPo02IsY6w2rVEPTV3oCr8flTq
         dX6GV7YHP6Jvd+sCzqZvBR08iObSflH7wca2k2yYkrjqFloZUARl2OTcuCSsnntSL4F3
         5iQTDKwl15xwVU3Nw6ZhldByL5qCncIW0Slh7GPwuHErPPDpBcnIG/7rtfr6pfylheiB
         VX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bm4fJuMHpcWZsifYR1Us6X2RX8j+XVrIoZycHCaZ+NY=;
        b=Lge/WVBripP0JVB8rUiophgbgONpKGCkxtnL3Jd9td9UR6Vzh390pQE5LWruMWeeWA
         x5g5bcxrM/A2USAo8iFQIWLZYm2ElqzfKAVciYofVBOjEuppuX+OIMFKpw2UV480VKMS
         leJLxEcH/tYcKk6mYEVcu9EivK/PmlSVxa6GDup2V4Ftewp+cetoDBsjh4zMBcaOO+lo
         mnl+nUtndL5sE1qNJqO8VcQi5wSJG3M4o3Q9MLqgKpw3XnvI0VkYIp0kfX4u0w3xf004
         DHZf0mJmb4AgOYpeivQe4LXXzq7yjn78IEFZb5tVoKGhRcF9cb4vmg9Ixvi+lqjaM6JF
         9d1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Sergeyev <sergeev917@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>,
	Kyle Huey <me@kylehuey.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.14 09/41] x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist
Date: Mon, 19 Mar 2018 19:08:09 +0100
Message-Id: <20180319180732.817648219@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391747267778863?=
X-GMAIL-MSGID: =?utf-8?q?1595391823292270723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sergeyev <sergeev917@gmail.com>

commit e3b3121fa8da94cb20f9e0c64ab7981ae47fd085 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -105,7 +105,7 @@ static void probe_xeon_phi_r3mwait(struc
 /*
  * Early microcode releases for the Spectre v2 mitigation were broken.
  * Information taken from;
- * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/03/microcode-update-guidance.pdf
  * - https://kb.vmware.com/s/article/52345
  * - Microcode revisions observed in the wild
  * - Release note from 20180108 microcode release
@@ -123,7 +123,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
