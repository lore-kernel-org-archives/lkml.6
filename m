Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtm8YXrfUEVd/R0MUKU7XulQLHdeLzJmP1OPeYF/7Fw09PsLN1N2b5jS9615qK6GVdG0Wz8
ARC-Seal: i=1; a=rsa-sha256; t=1520824074; cv=none;
        d=google.com; s=arc-20160816;
        b=Rns3HlFuskwVrKH/oK8Rx9U+y9LmsJXEb663XlQhzT0HD2L38C7s3898K4pKltyR+9
         2d66glKyq4HRtOs7NdERi0CtwjuNw9RORr6wFyR9En7cCiZ2jTJXykGDtXAbmYerrhAV
         OjsJJzyLfgdC38plnuYQCDK88LcWmHeJf5H7i+5qHpW/luLKUXcfkacDWP2jqvCoMhXM
         HY0QGTRZQi1ndyAz1ZXBhLhUuuVM4RxVd+tumDXyCGQ3xlcC1re3Rb94/ADwswkzg9RG
         mO0BjoH8+1lJOL+535n5/zkZzBT4wuP2ysZrvxPudyRYECidV2+t0i/hNaSCdB14lfr/
         2HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=F716oF+lqmpBbq7JVav8Qdws4BmWqZhz9/jOaz587oc=;
        b=NKEKndaXOBR1wdy3KEx0cDuO9ex95HDezaaQ8lFW3bupzkqYj1yjLhuJwBDez6aL+x
         j3Fyezuz33lTwrcMLmRI5DUl1dTzQQLXhCdCtKQ8xuI/36eDUp2WFiF972FuknKyH6f3
         n4OvRwe7HDisLpJQwdk2UEhWvolJ1tUvri9xvGSHmrqR9cPHPpWY+BA1JvLpFYAQhlR7
         stYU7FAVzQwOWxYPvAYGq14vNL8fqANTCZ+3ec0tAExSihdpzxef6RgjiuwgtYBMVdKi
         6yh7vS5TFI9jTSQbZ6c98pXsouXBrdRnVqCbzrAru6NwpSSLL9nNvj699v40dI4YiFrv
         xTVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg KH" <gregkh@linux-foundation.org>,
 "Jiri Koshina" <jikos@kernel.org>,
 "Andi Lutomirski" <luto@amacapital.net>,
 "Kees Cook" <keescook@google.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Alan Cox" <gnomes@lxorguk.ukuu.org.uk>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.205773972@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 043/104] x86/pti: Rename BUG_CPU_INSECURE to
 BUG_CPU_MELTDOWN
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699653185874182?=
X-GMAIL-MSGID: =?utf-8?q?1594699624648615226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit de791821c295cc61419a06fe5562288417d1bc58 upstream.

Use the name associated with the particular attack which needs page table
isolation for mitigation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Koshina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Lutomirski  <luto@amacapital.net>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Greg KH <gregkh@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801051525300.1724@nanos
[bwh: Backported to 3.2: bug number is different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -214,7 +214,7 @@
  */
 #define X86_BUG(x)		(NCAPINTS*32 + (x))
 
-#define X86_BUG_CPU_INSECURE	X86_BUG(0) /* CPU is insecure and needs kernel page table isolation */
+#define X86_BUG_CPU_MELTDOWN	X86_BUG(0) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -769,7 +769,7 @@ static void __init early_identify_cpu(st
 		this_cpu->c_bsp_init(c);
 
 	if (c->x86_vendor != X86_VENDOR_AMD)
-		setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
+		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
 void __init early_cpu_init(void)
