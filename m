Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuo0ZkQspeLUs3X8C0Gk71XkMob4E99CUOw/HEDSVatDPe8f1zNRCGCgOTRNFNVs43lKRcA
ARC-Seal: i=1; a=rsa-sha256; t=1520824069; cv=none;
        d=google.com; s=arc-20160816;
        b=SyViTgYxGvp+jJ48cT50m5cDH/agGzv6rpTeSHpSo9cjkhGXbYnorS18r/u3gPlo9l
         gCtF8Xt3eONNmsL+SaRVQ2iPnXWVdzHxhMNm9Q37eGYeiT4ujaViA4hK1pCbYw9Mma6L
         TMMOPZu91mSEaA6aCzxgaC5Nun4RPkoU9JHBUkH+Hux9lFksaZjqc7wf9I91vRci4MBr
         zx2rlD1Ywkhr8JaryWOpU2r0SdN+m7l925ed+7sxRLlR2DSSz+vfnBHXLDF+7ERrRTGz
         oBcV/pv+bztbU5ejERSuFon26NhdEHEAPj8nwWVMEfa3qU+x+t+ty4pqpmm3Z05ztC+a
         HUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=n3uwwIRP6l9ns9jy+KjBvRd5O0wff7c6whVHfv6bIK0=;
        b=CesKLSWr5js1LJs0oPtxuvezmmps/QSEtfpfgkDGBzQ+xy9Jl/bXVUCwzzjO7Eb31P
         90PmZQfrHZ1AGYdIPmtjbFU/Xb5qRGUwagYGuja0BI6OnGFdx6sJ5E71gqgmG1duJ2GB
         ILxZJ8HgnadQ1inOOxc/pI+2bFlYx7dN7LW2R+G4rliCm1inNNk2tV65VvyoYb0ZuKut
         MZ2mFbQaOQLGqb88ZZfOab3SBtaJjRgBe736LYXuRexWCif1g/IhDJTWAkJNtLecF5Ee
         dnalflRzDpRKAatN4bkRHoT+xkZA9MkprsZqWG7Pt9yRf3/y9NX8SStO9L8Dqx4FU3Ch
         FwIw==
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
 "Dave Hansen" <dave.hansen@intel.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Kees Cook" <keescook@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Waiman Long" <longman@redhat.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Jeff Law" <law@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.565608036@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 076/104] x86/retpoline: Remove the esp/rsp thunk
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699653695967264?=
X-GMAIL-MSGID: =?utf-8?q?1594699619689099115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 1df37383a8aeabb9b418698f0bcdffea01f4b1b2 upstream.

It doesn't make sense to have an indirect call thunk with esp/rsp as
retpoline code won't work correctly with the stack pointer register.
Removing it will help compiler writers to catch error in case such
a thunk call is emitted incorrectly.

Fixes: 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
Suggested-by: Jeff Law <law@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1516658974-27852-1-git-send-email-longman@redhat.com
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/retpoline-export.c | 1 -
 arch/x86/lib/retpoline.S        | 1 -
 2 files changed, 2 deletions(-)

--- a/arch/x86/lib/retpoline-export.c
+++ b/arch/x86/lib/retpoline-export.c
@@ -22,5 +22,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-INDIRECT_THUNK(sp)
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -35,7 +35,6 @@ GENERATE_THUNK(_ASM_DX)
 GENERATE_THUNK(_ASM_SI)
 GENERATE_THUNK(_ASM_DI)
 GENERATE_THUNK(_ASM_BP)
-GENERATE_THUNK(_ASM_SP)
 #ifdef CONFIG_64BIT
 GENERATE_THUNK(r8)
 GENERATE_THUNK(r9)
