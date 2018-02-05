Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22599e52XvxYbd7No7FC2p3cfUIMmKKMc6g7Wj7ltjOYm0ZkcjRaefRBaCQUn4i3AyxEMIya
ARC-Seal: i=1; a=rsa-sha256; t=1517855163; cv=none;
        d=google.com; s=arc-20160816;
        b=ivE6mnKOzQ98UGE06UNypYuQBUru2i1Nciiz0MEOHbINsiwPbpdGo57GbV/VXM3jmN
         8uip9gYLKL4EBJxP5/O9mytaUj4xxc7eTCRcbS39AwYrpVeI90m1E2Ah5Yqo1xHlFiwn
         LodRXnprDXPC2r/VGyPCWt1rF6yr3aFBIm98P9DJuOtzgv2FUY4AuwjHYtTbtjaDynhL
         yhgn6/6p1fDHPE1ornWzZlxkNKwhdZNOktGy5N/gsz9qGwiDpv4UU2HfdAgw1vQWij3T
         gsr9Oi6a1DV5JMVmG3U0CZf4+K0oUilTinssQht5Kt09c/0VlwpUzqw5rdegZ8l/YAcN
         wovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fE8MEG9prrX9oGz2J3iue0ZwGYviTbEbw3Bx47lvOvE=;
        b=nzhrRiulIuO4lDSgiU8yPwLpvBmfarsuQGJ8vv1bsRpoUQgFhLVeh6YIv4R3IQxWbx
         WNq5Jk+DnTStIWH1IKGsPFQ2qduYqccAGc0Jzii/inBm07e2AxkbXoz/ktscWSYo8QI7
         JU8wHMYLoR8v97rhXoqEV6DZUmsLgUqfXQvaUoG3+PadlPSW3JLEUmVvW7czl1Lr8e4h
         DW807tpCmQsghN5DfSZq/rNT/OXoPvknMdPpqE0cZftvwss4qM/0YsCqS/LTHJDMKkL1
         cMdRWh80Uhz1AeD1RawfdbBx9keygWODSs85zbAXG62c9oi06UrzsvGL3Uzt9yFPiAd2
         br9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Thomas Garnier <thgarnie@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.15 52/60] x86/pti: Mark constant arrays as __initconst
Date: Mon,  5 Feb 2018 10:23:25 -0800
Message-Id: <20180205182216.503443700@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586399778869328?=
X-GMAIL-MSGID: =?utf-8?q?1591586495869056228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann arnd@arndb.de

commit 4bf5d56d429cbc96c23d809a08f63cd29e1a702e

I'm seeing build failures from the two newly introduced arrays that
are marked 'const' and '__initdata', which are mutually exclusive:

arch/x86/kernel/cpu/common.c:882:43: error: 'cpu_no_speculation' causes a section type conflict with 'e820_table_firmware_init'
arch/x86/kernel/cpu/common.c:895:43: error: 'cpu_no_meltdown' causes a section type conflict with 'e820_table_firmware_init'

The correct annotation is __initconst.

Fixes: fec9434a12f3 ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202213959.611210-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -900,7 +900,7 @@ static void identify_cpu_without_cpuid(s
 #endif
 }
 
-static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
@@ -913,7 +913,7 @@ static const __initdata struct x86_cpu_i
 	{}
 };
 
-static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
 	{}
 };
