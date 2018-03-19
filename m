Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtKit6pXZS8AUw+/05fgMnRQAdLBI2RQZDu+aXdid5ok2CdSh5DrhfQk0oKSrN80LG8gGHG
ARC-Seal: i=1; a=rsa-sha256; t=1521484326; cv=none;
        d=google.com; s=arc-20160816;
        b=PJRKqJmPCU29wvALibwhmkPxWhtF2puEEFhlUBqKZpV3ItVuPm32oXh1+KubV60wrt
         5Jy6v7E+mFD5ITVi4C4O2fMA3+QqbqWKzKLCRiG2wKBXuVECNCnYgL5fjoKonEGqA5tT
         R9JCdLWO5wTYUEbSaTIiSuP2O0zErJjsVdzFTAcwnxTn3CgjfzBS3r3OBbpIqjHllROs
         1ZJFDv7D2hVBorMKHNYW2UA4D3KR6DR2uiwAEv9zgcwGzYYzZEjQJwOv6jYHIEpE4abt
         8n8kiMCRqGk7iLUXXxB885jn/V5HRU/Sk/UlFFGhQcKIed8+21bl3MktEPIEKAQlMBTN
         Zs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dME6I52f+l4YRmDSecp3yXa+H5ut31mvN9e4YTj6oHA=;
        b=GitghcfCT7xloUpUL6R8evQmw7eSn24IUJMqogkkP0oicVLo5uZ27W/Qyv3R57r/Yh
         9gmCt5TNnTIZilQ773ezzVV+nuZip710CmPtEZxPWK2SL2uL4SX91T/9ezX0MYay8RFb
         g5X3l/zSMnco+W9pzL7ztXbIb4s1lI5aqZrfofymp67TjwrOTAu9qy2of2rlef5RUdC+
         8jjwkZk7We7EwlqizffjRMyUsJDh1gHsaxIlfvGBaW7sUbCnb9JS07+NTqFQ0AUEbQqK
         bgd4I+uLYqo3kUNbIPlSEyR1/qK1khN0laXGJ9BeAYE5J2U+Pgkosns1nv//yfRjFBOd
         xx6Q==
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
Subject: [PATCH 4.15 07/52] x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist
Date: Mon, 19 Mar 2018 19:08:05 +0100
Message-Id: <20180319180735.457297554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391747267778863?=
X-GMAIL-MSGID: =?utf-8?q?1595391948550750110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
