Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELt39UlclMMm4tgBdAr/Nxaofy2uBH7oq+M00GACxteKzGEjiR+xuFusx6qGP60BZjCkZuRD
ARC-Seal: i=1; a=rsa-sha256; t=1521141386; cv=none;
        d=google.com; s=arc-20160816;
        b=DKLlBKC2AWqb04hnQbh5sGD9kuphLJm3DstCS3CyPhRFKDw4Hq6WuLOm9lx+TqfZAn
         gB+hlrh1/h4qMkvGNClTiDaWohGC/t2jmCTJjBbShWv45Emyd0zGhuo1Yd/TGD1SvwSx
         nIc6YGvmL2ua/pAIq28Ox1aKZd5dreZwi6tES5uQkj8uPEUU6Vs03DS7//4CvGwDe/PG
         2W02gQsoJAWcDnZmlhdp9hMKr74FfILpSz64lGHjgipIqRtVWuhPQtbiK+huhAUPHDFe
         fqEOacSNryU4jrigoPTs83AzB2Q2KzHyMca6IRcdFcNXeNIyjI67on5ZMVgRBBfcs08L
         szpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XUfm8YYgtxGynaHkC+bobRw6IFwZa1ner4MwuzA4+Ss=;
        b=LbCILqEWUdeKpHS6puPuip5IdzPC/pA63O9fS+JC73BZi5J5KRPEGL/n2y76U5bxuT
         OZsScLtFTdrVxdOUTbqpNP0Ccx4iV5tbbYRCgZGcrJ2TpOfY5+CpyfjT4jDpWTCmxIA9
         A1HwOydPh0ccrEkcouL54mxhWZlouoycuoaDxx4L3i+8v04+ltTfVBweY6IVFr7/cJn0
         qMKHkI/seKdhwjobHtyr4E3fg9DCnMXyVBomqP12oQZq4AYSm72P1mNlrG2GSZT2UkiJ
         ibUS3BUKp+Bt6wIaIpki+a1GP0W1/ahLxCybMDQM3rKLt69Pb2Zt/c2m4qEtfbOf8pZN
         huBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 7/9] powerpc/64: barrier_nospec: Add debugfs trigger
Date: Thu, 15 Mar 2018 20:15:56 +0100
Message-Id: <3fe550ea345920af7edea4f4d24ba075430ca9d0.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032350839375792?=
X-GMAIL-MSGID: =?utf-8?q?1595032350839375792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/setup_64.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f60e0e3b5ad2..f6678a7b6114 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -963,6 +963,41 @@ static __init int rfi_flush_debugfs_init(void)
 	return 0;
 }
 device_initcall(rfi_flush_debugfs_init);
+
+static int barrier_nospec_set(void *data, u64 val)
+{
+	switch (val) {
+	case 0:
+	case 1:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!!val == !!barrier_nospec_enabled)
+		return 0;
+
+	barrier_nospec_enable(!!val);
+
+	return 0;
+}
+
+static int barrier_nospec_get(void *data, u64 *val)
+{
+	*val = barrier_nospec_enabled ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_barrier_nospec,
+			barrier_nospec_get, barrier_nospec_set, "%llu\n");
+
+static __init int barrier_nospec_debugfs_init(void)
+{
+	debugfs_create_file("barrier_nospec", 0600, powerpc_debugfs_root, NULL,
+			    &fops_barrier_nospec);
+	return 0;
+}
+device_initcall(barrier_nospec_debugfs_init);
 #endif
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.13.6
