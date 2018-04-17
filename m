Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Wug0NG7kjZTn7P/LcG3U3pTUN5fddDc81oC3niY/iOItJHCjdnh6taVMKCYotiDjrHXMz
ARC-Seal: i=1; a=rsa-sha256; t=1523980968; cv=none;
        d=google.com; s=arc-20160816;
        b=hx8BNOC4AR21Difyj2yBjDCxyIqKgQ/wmjOCpWOS9e9s8WmtDcxhev2V/je2GdR5AR
         ReH+wFPb3tbjbFLicP1nJibrSxbfi0WM4JSyRwUEDujw1wnGIdsViQYkNobGdOYCiMrp
         iyJfnneLtR6CpU1Jb5aC8BetWyfoplYviM18JXPq8i+0hWLglEI8e9hYrpI9cesr93Nh
         1b5SyoZs0aHXwmfI2Pvd/T14aaN2/BgMEi8iuZHFbEugG64ZuEn/4m3gfZSzUdtq/JM5
         s0sQk9NRqZX7v1qHpA6MG/8fQNGrjrRawyIx7v1sMAxS0f6SZ4cQqKdn9kQzxOc91fZO
         iN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WKU/nhGPpS6VynbrBF8rkruLggsOwNNISEXsmFmACCY=;
        b=qyw4qB/WnrteoZivAJwezLXf4Xm7msS8RdeX8Ea0xTky4FcAC160cAUFYnOlBnI9bK
         KUX2tnateCh2vjSZLnc0cYyV7FTtBpxFI/2zWZTnSr67r/6TaHPXIEjbwUWUKmBuCxLq
         HJU57YJm8BbHkVPW98btj0VcmDBqq5Ik84nhPU5RP5OWNuv8YTa7/Sed0trJjCnMcTED
         07OZuPk5vdteErWgAYTJa63AzwsJdev8NTSZBl0/QvzJNBkb1wvgkSrkZ68AU4njn+OI
         SlLySPV3/BmtK3bz7TicKh8A0ZAUnlxhp4ZwWDw50VR9oLUIxXm0jN8ydvBknNSypYkI
         g1Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Dmitry V. Levin" <ldv@altlinux.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 32/68] x86/uapi: Fix asm/bootparam.h userspace compilation errors
Date: Tue, 17 Apr 2018 17:57:45 +0200
Message-Id: <20180417155750.648492693@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009867721216871?=
X-GMAIL-MSGID: =?utf-8?q?1598009867721216871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry V. Levin <ldv@altlinux.org>

commit 9820e1c3376c641299624dd24646aed3167ad5b1 upstream.

Consistently use types provided by <linux/types.h> to fix the following
asm/bootparam.h userspace compilation errors:

	/usr/include/asm/bootparam.h:140:2: error: unknown type name 'u16'
	  u16 version;
	/usr/include/asm/bootparam.h:141:2: error: unknown type name 'u16'
	  u16 compatible_version;
	/usr/include/asm/bootparam.h:142:2: error: unknown type name 'u16'
	  u16 pm_timer_address;
	/usr/include/asm/bootparam.h:143:2: error: unknown type name 'u16'
	  u16 num_cpus;
	/usr/include/asm/bootparam.h:144:2: error: unknown type name 'u64'
	  u64 pci_mmconfig_base;
	/usr/include/asm/bootparam.h:145:2: error: unknown type name 'u32'
	  u32 tsc_khz;
	/usr/include/asm/bootparam.h:146:2: error: unknown type name 'u32'
	  u32 apic_khz;
	/usr/include/asm/bootparam.h:147:2: error: unknown type name 'u8'
	  u8 standard_ioapic;
	/usr/include/asm/bootparam.h:148:2: error: unknown type name 'u8'
	  u8 cpu_ids[255];

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: <stable@vger.kernel.org> # v4.16
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in non-root cell")
Link: http://lkml.kernel.org/r/20180405043210.GA13254@altlinux.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/uapi/asm/bootparam.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -137,15 +137,15 @@ struct boot_e820_entry {
  * setup data structure.
  */
 struct jailhouse_setup_data {
-	u16	version;
-	u16	compatible_version;
-	u16	pm_timer_address;
-	u16	num_cpus;
-	u64	pci_mmconfig_base;
-	u32	tsc_khz;
-	u32	apic_khz;
-	u8	standard_ioapic;
-	u8	cpu_ids[255];
+	__u16	version;
+	__u16	compatible_version;
+	__u16	pm_timer_address;
+	__u16	num_cpus;
+	__u64	pci_mmconfig_base;
+	__u32	tsc_khz;
+	__u32	apic_khz;
+	__u8	standard_ioapic;
+	__u8	cpu_ids[255];
 } __attribute__((packed));
 
 /* The so-called "zeropage" */
