Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELs2ZkE3VoxeLjf398XUvvARmkop5LUB+uKrb8OkYDHQg7uMCp5sH2wFEqywfkzK3YTuaylB
ARC-Seal: i=1; a=rsa-sha256; t=1520966036; cv=none;
        d=google.com; s=arc-20160816;
        b=y/YHtzmSm2s5kQQOn/aSJH0PFE0yUCNso3qZpUDiD/UXTHGXEYKGdScF0DA516iU6B
         17iHXOHAM24YZMwStvLCRW2RxBp6X3c4vg2vcbavotPATTO30nrBoJYtEC7otnnjQH38
         9h0XmggjcO2ai4xqr4GMgl8J0Z3KEJlDCJJxEIj/HyDhjAauuSYH+95qhOOtbe4VsZMX
         QfPaci0wpe/qPM0MEZ+BDW37/RP42A7EK9nvoTPjMFbSmjHXEJVdYja7ZVamB8HCoarT
         I4tL0LDoJauKKpqOgm9jum6TRodq4hj8iZ6X1QZDhrtnbLwBRuaEoJJ19mMiA6RkyIHk
         b0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P3r7K1oneOgRUQO5dPxWxOWV/S+Mk6wT9HTRx0CiJdo=;
        b=MXDJkilJ4JdyZkmhsRmf8h+9acPpr/r5KJ2vNBn2Md6Cd15oIg7D15+IwnoJs+ziFR
         aaPB+VdH/tX571yQYk5r2I/zRRWsph1ggV75iE1wZFDecUzeKbL6SADiLbETDwLkp2af
         FNM2sgM9rAKptJwlSjOG5XNJZDTQTkI0MjrWEhbLZM0lVdNJ1K8knRcM+4pwxPg1GEc7
         uQAxA1QVEwICC1HaRWxy8sPr69HNsHvdHM4k8kPbIySzwH3gWt3Nac/evWTw0Yc/UOuH
         3B5/3c0dFQCmEQbIdCjhqAMGm1aY5KpGuBoB3gHm/LzSc+pw08ObU5HK93WFpmmuy2Ts
         heVA==
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
Subject: [PATCH RFC 8/8] powerpc/64: barrier_nospec: Add commandline trigger
Date: Tue, 13 Mar 2018 19:33:06 +0100
Message-Id: <8639fc8cb02548d478b041c3a00ad9053fdd8bc4.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848482819509094?=
X-GMAIL-MSGID: =?utf-8?q?1594848482819509094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/setup_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4b67b7b877d9..257f0e6be107 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -840,6 +840,14 @@ static int __init handle_no_pti(char *p)
 }
 early_param("nopti", handle_no_pti);
 
+static int __init handle_no_nospec(char *p)
+{
+	pr_info("barrier_nospec: disabled on command line.");
+	no_nospec = true;
+	return 0;
+}
+early_param("no_nospec", handle_no_nospec);
+
 static void do_nothing(void *unused)
 {
 	/*
-- 
2.13.6
