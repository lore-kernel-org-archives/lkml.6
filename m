Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELsY8qi+mL/avW/qEngYXNDUdRg0TCI6pKILDkaAnCX09fE5k6rIpEuDFLTbaKpQjjn9TGzl
ARC-Seal: i=1; a=rsa-sha256; t=1520966035; cv=none;
        d=google.com; s=arc-20160816;
        b=ER8kEHlOBn7rAJ1MHxD/sna3iKgIWX1Kdp0qC1hRBfYdxTHE7Evr8XeKhKLCQGiVFx
         Sqj2CdsW7oJZL8URiT8Hg31U3F8UHJWCA/ccJHe3ajrRlyQw7H7AsTU3Djnw440RzkC2
         G7f+p5OtjFPnlKIyna1ofz7ImBS6GM4wTRaZyjoUlETRy3EOMwivpTDrt08vMwtY1B8l
         du5CrNqOQxOsCQfaOtMTjcQBToGjAPkqeCHI9OxkgO5Fl+sRrM/YCukysgKpJEU7bUuw
         +tA12+qokRbpmwvss47ysGigusEPj2AETTq8Er2IyfxY6bNLm4s6/tchYXjAtY4fA4Oz
         u+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9xqgUluudFFO5C1nUSkvzdpWoO4JVF+wgannQeY73nY=;
        b=XqBmKh5FMN93h2wpCywX2HmCxhoQBtaBoydGIHvAY94CUWwzZ2o4M55W3lX8KWCc8R
         L2zQN6VzHXkuXARh4eaWStptvbZ9yV7I6QkwN3Ox6q/rxjRtwI2WfGb/az/QjPckO7YI
         Rb5TfQfnkON9MHVCqC95H/yfOrVNc90X9EH1wP1qqOdQVMtTGq4wl0zfhokb/2w5zfUL
         u7EIXSrjMrJiiElKJhHeYoBUF0R30gMNSTJajColDRBPrOhiNK9uN+TRcljoBEPtFVT6
         RWqyKPhnsvtEAYvBOnOoFQ8+osT/oQKP9tpPzuhG3Ycy+gPzrm0BS2sifZwy4VYJ62SW
         XUFA==
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
Subject: [PATCH RFC 6/8] powerpc/64: barrier_nospec: Add debugfs trigger
Date: Tue, 13 Mar 2018 19:33:04 +0100
Message-Id: <614dfe0abb78fffd35f127d0ba78e644e1a0570a.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848481057518187?=
X-GMAIL-MSGID: =?utf-8?q?1594848481057518187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/setup_64.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d1d9f047161e..4b67b7b877d9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -955,6 +955,41 @@ static __init int rfi_flush_debugfs_init(void)
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
