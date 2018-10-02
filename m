Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80092C65BA7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEACE2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEACE2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJCBqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:46:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJCBqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:46:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92J0rld2067144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 12:00:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92J0q8p2067141;
        Tue, 2 Oct 2018 12:00:52 -0700
Date:   Tue, 2 Oct 2018 12:00:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Feng Tang <tipbot@zytor.com>
Message-ID: <tip-fa7948a6413c63128335aa871fade8df55ac61e2@git.kernel.org>
Cc:     jkosina@suse.cz, feng.tang@intel.com, thymovanbeers@gmail.com,
        bp@alien8.de, stuart.r.anderson@intel.com, hpa@linux.intel.com,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        kai.heng.feng@canonical.com, pombredanne@nexb.com,
        konrad.wilk@oracle.com, frederic@kernel.org, peterz@infradead.org,
        bhelgaas@google.com, rientjes@google.com, mingo@kernel.org,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Reply-To: rientjes@google.com, mingo@kernel.org,
          kstewart@linuxfoundation.org, tglx@linutronix.de,
          gregkh@linuxfoundation.org, bhelgaas@google.com,
          peterz@infradead.org, konrad.wilk@oracle.com,
          frederic@kernel.org, pombredanne@nexb.com,
          kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
          thymovanbeers@gmail.com, bp@alien8.de, feng.tang@intel.com,
          jkosina@suse.cz, corbet@lwn.net, stuart.r.anderson@intel.com,
          hpa@zytor.com, hpa@linux.intel.com
In-Reply-To: <20181002164921.25833-1-feng.tang@intel.com>
References: <20181002164921.25833-1-feng.tang@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/early-printk] x86/earlyprintk: Add a force option for
 pciserial device
Git-Commit-ID: fa7948a6413c63128335aa871fade8df55ac61e2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fa7948a6413c63128335aa871fade8df55ac61e2
Gitweb:     https://git.kernel.org/tip/fa7948a6413c63128335aa871fade8df55ac61e2
Author:     Feng Tang <feng.tang@intel.com>
AuthorDate: Wed, 3 Oct 2018 00:49:21 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 2 Oct 2018 20:40:27 +0200

x86/earlyprintk: Add a force option for pciserial device

The "pciserial" earlyprintk variant helps much on many modern x86
platforms, but unfortunately there are still some platforms with PCI
UART devices which have the wrong PCI class code. In that case, the
current class code check does not allow for them to be used for logging.

Add a sub-option "force" which overrides the class code check and thus
the use of such device can be enforced.

 [ bp: massage formulations. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Stuart R . Anderson" <stuart.r.anderson@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H Peter Anvin <hpa@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thymo van Beers <thymovanbeers@gmail.com>
Cc: alan@linux.intel.com
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20181002164921.25833-1-feng.tang@intel.com
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++-
 arch/x86/kernel/early_printk.c                  | 29 ++++++++++++++++---------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f42240d..34e6800dea0e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1063,7 +1063,7 @@
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
-			earlyprintk=pciserial,bus:device.function[,baudrate]
+			earlyprintk=pciserial[,force],bus:device.function[,baudrate]
 			earlyprintk=xdbc[xhciController#]
 
 			earlyprintk is useful when the kernel crashes before
@@ -1095,6 +1095,10 @@
 
 			The sclp output can only be used on s390.
 
+			The optional "force" to "pciserial" enables use of a
+			PCI device even when its classcode is not of the
+			UART class.
+
 	edac_report=	[HW,EDAC] Control how to report EDAC event
 			Format: {"on" | "off" | "force"}
 			on: enable EDAC to report H/W event. May be overridden
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 5e801c8c8ce7..374a52fa5296 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -213,8 +213,9 @@ static unsigned int mem32_serial_in(unsigned long addr, int offset)
  * early_pci_serial_init()
  *
  * This function is invoked when the early_printk param starts with "pciserial"
- * The rest of the param should be ",B:D.F,baud" where B, D & F describe the
- * location of a PCI device that must be a UART device.
+ * The rest of the param should be "[force],B:D.F,baud", where B, D & F describe
+ * the location of a PCI device that must be a UART device. "force" is optional
+ * and overrides the use of an UART device with a wrong PCI class code.
  */
 static __init void early_pci_serial_init(char *s)
 {
@@ -224,17 +225,23 @@ static __init void early_pci_serial_init(char *s)
 	u32 classcode, bar0;
 	u16 cmdreg;
 	char *e;
+	int force = 0;
 
-
-	/*
-	 * First, part the param to get the BDF values
-	 */
 	if (*s == ',')
 		++s;
 
 	if (*s == 0)
 		return;
 
+	/* Force the use of an UART device with wrong class code */
+	if (!strncmp(s, "force,", 6)) {
+		force = 1;
+		s += 6;
+	}
+
+	/*
+	 * Part the param to get the BDF values
+	 */
 	bus = (u8)simple_strtoul(s, &e, 16);
 	s = e;
 	if (*s != ':')
@@ -253,7 +260,7 @@ static __init void early_pci_serial_init(char *s)
 		s++;
 
 	/*
-	 * Second, find the device from the BDF
+	 * Find the device from the BDF
 	 */
 	cmdreg = read_pci_config(bus, slot, func, PCI_COMMAND);
 	classcode = read_pci_config(bus, slot, func, PCI_CLASS_REVISION);
@@ -264,8 +271,10 @@ static __init void early_pci_serial_init(char *s)
 	 */
 	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
 	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
-	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
-		return;
+	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
+		if (!force)
+			return;
+	}
 
 	/*
 	 * Determine if it is IO or memory mapped
@@ -289,7 +298,7 @@ static __init void early_pci_serial_init(char *s)
 	}
 
 	/*
-	 * Lastly, initialize the hardware
+	 * Initialize the hardware
 	 */
 	if (*s) {
 		if (strcmp(s, "nocfg") == 0)
