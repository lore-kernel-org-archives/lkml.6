Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELvr1/Ym4xkk33BqzfxbcyzR9TP3/Zkbh/+R7bYXnwgg9AXDpmMHAAU/njtKYT40eURUp7jd
ARC-Seal: i=1; a=rsa-sha256; t=1520966036; cv=none;
        d=google.com; s=arc-20160816;
        b=eQ93Kqzg4UB4c6XXPSDkp1nP80d1nXBUDtjdr5oFRjOiduR2Du+b0Cu+POcXFAptH+
         CNq9lin7EJIvf31ZaYrEvMm/dkpRYaYkT/EvPSmQOG0SJGysJyQulH79WUb6JQAqF7g4
         UduM7GIpnS/8qEDFMYbEWtszL6qaoLjq4tLxStTHfRSieeisIp30DAKcuFGu5RONfNs3
         mZe/fo0tRay4eMhDzHOCY49O7s+aNn3Ss0x8JgCg8e9Xq9WRN6u+25oMSzVoOWjjLb7e
         YDqYWR6piLSFVPqhFMsGWyyvROKDMmpydthArptOq8BqlKwAY+VDRZsfdPejeYVsa9ww
         EtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5MbJoKo+c1+tYVpuHyQ2aYrQ4Y0B9cuaEC+XCSoTvXs=;
        b=dDdmAiZrE+6nsV9Z6L33ZlGUOh6lrIhJwTHwLzAhrCH0mMhLGfmUC9SqXHmffQahzL
         hJGvLvydmzpBBj3l7MUlgjdPJVXydvlMxcjtBjDSTrwwy4i80r0HebiBI2d5p78ol/ZL
         3dmQamm6xRVLiZqC+BCBfz7MPZ398alGcqE1umpjwacQ5hgg6qulVKtl3GOsjTGpCJne
         UB/aGqAKBv7smp44vBNsULFD3rVZWaqvtaJK6mGoajlLnDknQmtGtE9Ces2vvEQ6rnUj
         ypj0ZEfNtzD/7hJn3ez/9eVZiup9VoFGI27P5fMy8H+i36qvBP6ONSGy1+IXq7dWBBQL
         fw+A==
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
Subject: [PATCH RFC 7/8] powerpc/64s: barrier_nospec: Add hcall triggerr
Date: Tue, 13 Mar 2018 19:33:05 +0100
Message-Id: <1c687d0e029de81ae27465dd4c32036e956f4970.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848482589457573?=
X-GMAIL-MSGID: =?utf-8?q?1594848482589457573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/platforms/pseries/setup.c | 38 ++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1a527625acf7..b779ddb8e250 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,38 +459,50 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
-static void pseries_setup_rfi_flush(void)
+static void pseries_setup_rfi_nospec(void)
 {
 	struct h_cpu_char_result result;
-	enum l1d_flush_type types;
-	bool enable;
+	enum l1d_flush_type flush_types;
+	enum spec_barrier_type barrier_type;
+	bool flush_enable;
+	bool barrier_enable;
 	long rc;
 
 	/* Enable by default */
-	enable = true;
+	flush_enable = true;
+	barrier_enable = true;
+	/* no fallback if the firmware does not tell us */
+	barrier_type = SPEC_BARRIER_NONE;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
-		types = L1D_FLUSH_NONE;
+		flush_types = L1D_FLUSH_NONE;
 
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
+			flush_types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
+			flush_types |= L1D_FLUSH_ORI;
+		if (result.character & H_CPU_CHAR_SPEC_BAR_ORI31)
+			barrier_type |= SPEC_BARRIER_ORI;
 
 		/* Use fallback if nothing set in hcall */
-		if (types == L1D_FLUSH_NONE)
-			types = L1D_FLUSH_FALLBACK;
+		if (flush_types == L1D_FLUSH_NONE)
+			flush_types = L1D_FLUSH_FALLBACK;
 
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
+			flush_enable = false;
+
+		if ((!(result.behaviour & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR)) ||
+		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
+			barrier_enable = false;
 	} else {
 		/* Default to fallback if case hcall is not available */
-		types = L1D_FLUSH_FALLBACK;
+		flush_types = L1D_FLUSH_FALLBACK;
 	}
 
-	setup_rfi_flush(types, enable);
+	setup_barrier_nospec(barrier_type, barrier_enable);
+	setup_rfi_flush(flush_types, flush_enable);
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -666,7 +678,7 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	pseries_setup_rfi_flush();
+	pseries_setup_rfi_nospec();
 
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
-- 
2.13.6
