Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34227C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDA62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDA62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbeITEHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:07:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbeITEHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:07:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JMKC6O074753
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:27:39 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mkx1ptg67-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:27:38 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 18:27:38 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 18:27:35 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JMRY5736044940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 22:27:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C0DDB205F;
        Wed, 19 Sep 2018 18:26:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEAA4B2065;
        Wed, 19 Sep 2018 18:26:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 Sep 2018 18:26:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E509016C1019; Wed, 19 Sep 2018 15:27:33 -0700 (PDT)
Date:   Wed, 19 Sep 2018 15:27:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, dougmill@linux.ibm.com, eajames@linux.ibm.com,
        haver@linux.ibm.com, fbarrat@linux.ibm.com, jejb@linux.ibm.com,
        jallen@linux.ibm.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        mikecyr@linux.ibm.com, zohar@linux.ibm.com,
        naveen.n.rao@linux.ibm.com, pfsmorigo@linux.ibm.com,
        pjk1939@linux.ibm.com, seroyer@linux.ibm.com,
        tlfalcon@linux.ibm.com, tyreld@linux.ibm.com, ukrishn@linux.ibm.com
Subject: [PATCH RFC] MAINTAINERS: Update from @linux.vnet.ibm.com to
 @linux.ibm.com
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091922-0040-0000-0000-0000047285EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009736; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090772; UDB=6.00563534; IPR=6.00870793;
 MB=3.00023396; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-19 22:27:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091922-0041-0000-0000-00000879C0DF
Message-Id: <20180919222733.GA13679@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBM's patch-friendly email infrastructure is changing domains from
@linux.vnet.ibm.com to @linux.ibm.com, which if nothing else might
save a bit of typing.  This commit therefore updates us stragglers'
email addresses in the MAINTAINERS file.  The old addresses are
expected to continue to work for a few more months.

While in the neighborhood, remove some obsolete entries, which results
in an orphaned subsystem: "JSM Neo PCI based serial card".

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Douglas Miller <dougmill@linux.ibm.com>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: John Allen <jallen@linux.ibm.com>
Cc: Manoj N. Kumar <manoj@linux.ibm.com>
Cc: Matthew R. Ochs <mrochs@linux.ibm.com>
Cc: Michael Cyr <mikecyr@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@linux.ibm.com>
Cc: Philip Kelleher <pjk1939@linux.ibm.com>
Cc: Steven Royer <seroyer@linux.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.ibm.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..ce6ad11b1c17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4013,7 +4013,7 @@ S:	Supported
 F:	drivers/net/ethernet/chelsio/cxgb4vf/
 
 CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
-M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
+M:	Frederic Barrat <fbarrat@linux.ibm.com>
 M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
@@ -4025,9 +4025,9 @@ F:	Documentation/powerpc/cxl.txt
 F:	Documentation/ABI/testing/sysfs-class-cxl
 
 CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
-M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
-M:	Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
-M:	Uma Krishnan <ukrishn@linux.vnet.ibm.com>
+M:	Manoj N. Kumar <manoj@linux.ibm.com>
+M:	Matthew R. Ochs <mrochs@linux.ibm.com>
+M:	Uma Krishnan <ukrishn@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/cxlflash/
@@ -5381,7 +5381,7 @@ S:	Orphan
 F:	fs/efs/
 
 EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
-M:	Douglas Miller <dougmill@linux.vnet.ibm.com>
+M:	Douglas Miller <dougmill@linux.ibm.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ibm/ehea/
@@ -5517,7 +5517,7 @@ F:	Documentation/filesystems/ext4.txt
 F:	fs/ext4/
 
 Extended Verification Module (EVM)
-M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 F:	security/integrity/evm/
@@ -5726,7 +5726,7 @@ F:	include/linux/firmware.h
 
 FLASH ADAPTER DRIVER (IBM Flash Adapter 900GB Full Height PCI Flash Card)
 M:	Joshua Morris <josh.h.morris@us.ibm.com>
-M:	Philip Kelleher <pjk1939@linux.vnet.ibm.com>
+M:	Philip Kelleher <pjk1939@linux.ibm.com>
 S:	Maintained
 F:	drivers/block/rsxx/
 
@@ -5985,7 +5985,7 @@ F:	include/linux/fscrypt*.h
 F:	Documentation/filesystems/fscrypt.rst
 
 FSI-ATTACHED I2C DRIVER
-M:	Eddie James <eajames@linux.vnet.ibm.com>
+M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-i2c@vger.kernel.org
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
@@ -6161,8 +6161,7 @@ S:	Supported
 F:	drivers/uio/uio_pci_generic.c
 
 GENWQE (IBM Generic Workqueue Card)
-M:	Frank Haverkamp <haver@linux.vnet.ibm.com>
-M:	Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
+M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
 F:	drivers/misc/genwqe/
 
@@ -6937,8 +6936,7 @@ F:	crypto/842.c
 F:	lib/842/
 
 IBM Power in-Nest Crypto Acceleration
-M:	Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
-M:	Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
+M:	Paulo Flabiano Smorigo <pfsmorigo@linux.ibm.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	drivers/crypto/nx/Makefile
@@ -6955,8 +6953,8 @@ S:	Supported
 F:	drivers/scsi/ipr.*
 
 IBM Power SRIOV Virtual NIC Device Driver
-M:	Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
-M:	John Allen <jallen@linux.vnet.ibm.com>
+M:	Thomas Falcon <tlfalcon@linux.ibm.com>
+M:	John Allen <jallen@linux.ibm.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/ibm/ibmvnic.*
@@ -6971,41 +6969,38 @@ F:	arch/powerpc/include/asm/vas.h
 F:	arch/powerpc/include/uapi/asm/vas.h
 
 IBM Power Virtual Ethernet Device Driver
-M:	Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
+M:	Thomas Falcon <tlfalcon@linux.ibm.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/ibm/ibmveth.*
 
 IBM Power Virtual FC Device Drivers
-M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvfc*
 
 IBM Power Virtual Management Channel Driver
-M:	Bryant G. Ly <bryantly@linux.vnet.ibm.com>
-M:	Steven Royer <seroyer@linux.vnet.ibm.com>
+M:	Steven Royer <seroyer@linux.ibm.com>
 S:	Supported
 F:	drivers/misc/ibmvmc.*
 
 IBM Power Virtual SCSI Device Drivers
-M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvscsi*
 F:	include/scsi/viosrp.h
 
 IBM Power Virtual SCSI Device Target Driver
-M:	Bryant G. Ly <bryantly@linux.vnet.ibm.com>
-M:	Michael Cyr <mikecyr@linux.vnet.ibm.com>
+M:	Michael Cyr <mikecyr@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
 L:	target-devel@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/ibmvscsi_tgt/
 
 IBM Power VMX Cryptographic instructions
-M:	Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
-M:	Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
+M:	Paulo Flabiano Smorigo <pfsmorigo@linux.ibm.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	drivers/crypto/vmx/Makefile
@@ -7268,7 +7263,7 @@ S:	Maintained
 L:	linux-crypto@vger.kernel.org
 
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
-M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
 L:	linux-integrity@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
@@ -7847,9 +7842,8 @@ S:	Maintained
 F:	drivers/media/platform/rcar_jpu.c
 
 JSM Neo PCI based serial card
-M:	Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
 L:	linux-serial@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/tty/serial/jsm/
 
 K10TEMP HARDWARE MONITORING DRIVER
@@ -8079,7 +8073,7 @@ F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
 
 KEYS-ENCRYPTED
-M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
@@ -8088,8 +8082,8 @@ F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
-M:	James Bottomley <jejb@linux.vnet.ibm.com>
-M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
+M:	James Bottomley <jejb@linux.ibm.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
@@ -8142,7 +8136,7 @@ F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
 KPROBES
-M:	Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
+M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
@@ -8471,7 +8465,7 @@ M:	Nicholas Piggin <npiggin@gmail.com>
 M:	David Howells <dhowells@redhat.com>
 M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
@@ -9417,7 +9411,7 @@ F:	drivers/platform/x86/mlx-platform.c
 
 MEMBARRIER SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	kernel/sched/membarrier.c
@@ -10431,7 +10425,7 @@ S:	Supported
 F:	tools/objtool/
 
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
-M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
+M:	Frederic Barrat <fbarrat@linux.ibm.com>
 M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
@@ -12204,7 +12198,7 @@ S:	Orphan
 F:	drivers/net/wireless/ray*
 
 RCUTORTURE TEST FRAMEWORK
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -12250,7 +12244,7 @@ F:	arch/x86/include/asm/intel_rdt_sched.h
 F:	Documentation/x86/intel_rdt*
 
 READ-COPY UPDATE (RCU)
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -12384,7 +12378,7 @@ F:	include/linux/reset-controller.h
 RESTARTABLE SEQUENCES SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 M:	Boqun Feng <boqun.feng@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
@@ -12897,7 +12891,7 @@ F:	drivers/scsi/sg.c
 F:	include/scsi/sg.h
 
 SCSI SUBSYSTEM
-M:	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
+M:	"James E.J. Bottomley" <jejb@linux.ibm.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git
 M:	"Martin K. Petersen" <martin.petersen@oracle.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
@@ -13325,7 +13319,7 @@ F:	mm/sl?b*
 
 SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -14721,7 +14715,7 @@ F:	drivers/platform/x86/topstar-laptop.c
 
 TORTURE-TEST MODULES
 M:	Davidlohr Bueso <dave@stgolabs.net>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
 M:	Josh Triplett <josh@joshtriplett.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported

