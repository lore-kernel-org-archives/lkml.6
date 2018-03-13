Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELvFzRjJSOgq7GmiJcWBcWHV7l4Pmxk2xP8oWbpzPGdXVk9QLDmMRgy+nouiiu8Lmg1Oc8+6
ARC-Seal: i=1; a=rsa-sha256; t=1520966031; cv=none;
        d=google.com; s=arc-20160816;
        b=TBzkzM0UJ1RRZTNY7UQxSCohYj0+02QbTdXfMbKbNRfhVKOLWbsODYGJSDqT/KR4vQ
         il61g5P6T1im0o0aar14Ww/PoJiVjhlYz4ipOZ/6dTsWK15AFsF1ShZj41YvS1yBW0Cm
         eLHkSLoDSsNlBOF2VTSunElYq3grk/7L92WQzGZsJuPFmp/4S5iKJtkOy7qtSktouSul
         TNTWcfF18XqF5z6f9VDKGawhOO2X+pLnDoIs9KEwrSqefcD8WyRdVMqtcdQzrIhCzkUk
         2CZeSXxtmdLBiCLCItEMb+GfkclqHIYbvfMw06Er2dzjYut0g/hLV6ujukl1cc7XNHej
         /0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CN2Hm4f5djlUFuxMhAT1GFUgEANS34LJuCBgen3LaDw=;
        b=DdaKetw7Gt9ETWJSKb5sQs9KgtaFlaidOe1KpuIwF6r57nIjSb33lBtVH3a82Ls79G
         MkOY/TDVUVNPWA5IvnUc3wnix1g+vd0emOactO0WwSBeCbBdI4oWaLDa5rz3Radz1Jp9
         ltMu/y0RprBmzGMw01hAFBB8BrmoflfGpJnyo5aLbx6oaL7Tog66iqrZDUYVtcMutDXQ
         auOaoYyBUsaVxMXEv0YEUDlpJq3YcWriuvUCQ/kqDXwRlbYlvSL0bU5MunfzAJ3QUysT
         hblL89uXoil9jQj+KM9bMTYcYjlnT9jlsNgR5Bi7zcKIECOlvEgqY6UvRZv0/vo5rDRh
         ZFJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Neuling <mikey@neuling.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Russell Currey <ruscur@russell.cc>,
	Joe Perches <joe@perches.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/8] powerpc: Add barrier_nospec
Date: Tue, 13 Mar 2018 19:32:59 +0100
Message-Id: <e1c146e5d43e8b2605af6e1330167d8e18d36f44.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848477585828051?=
X-GMAIL-MSGID: =?utf-8?q?1594848477585828051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copypasta from original gmb() and rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/barrier.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 10daa1d56e0a..8e47b3abe405 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -75,6 +75,15 @@ do {									\
 	___p1;								\
 })
 
+/* TODO: add patching so this can be disabled */
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec_asm ori 31,31,0
+#ifdef __ASSEMBLY__
+#define barrier_nospec barrier_nospec_asm
+#else
+#define barrier_nospec() __asm__ __volatile__ (stringify_in_c(barrier_nospec_asm) : : :)
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
2.13.6
