Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230112-2-892996540649115483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230111; b=Cln/yhV4otCXpdZhr8JpDeE3HR6MEaweO/0lq39Kcdhzq1tne6
    ioipmYdygPsHwEt85HRO5FfZjUkVXNzqoNtikC/C5A1Y3geeYe03a+ZCSKyoXesY
    SMsnqQJ5xnRS7QyviepJj9RX69EUTTfVr05rCavhiMKmuJoqV4L4X7DFfVgQ8MJq
    UtzyO0beV+HLRXqemntg86BW5gMdMyxAuyH9bGrwh8NJ7I0GKoan17GBXqaGlf2g
    WJj1EQVG57cASL5WUSgCvmlVvWFmFN8FIdfwnxUJFUy9tOQuD98Zh7CHFjhFt0R4
    jdlGDwTYFHeoCK+bgx16hWfZqm8cShyKd8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230111; bh=
    POHcL4nDvi9YZQAUhB0+nnqQ/Rct9sE3W5s+43kosw8=; b=FpaN67CE/HUW0N82
    zgDiI9yVSLyJO2WYi37L9B9nFBWNEFluB02t8Gy3l0aJNxX4YosSfIB5Twp34Mik
    IIMBvJntqnIQBW2+FrgNlWiZ908k5V88KsMUKgg/4kliVEABoamf2FLPyTzxt/8x
    1/HwManwDXEJFbE34/Opa3I9VmecxEwBrnwe4kPpKcKyZC0qg0tPY/7RrXhnBzkS
    lurATfu1sNTwY5++sxP6GIAhQX6aksqYAHVkqAX9xbOul9UDoTbyrZsgIXAKAvtq
    Y35X2FcX1JB7NoYqwHeh7TZLBkNC/ZHDU1yAUUX+UotX7ToT6UFpUt02cCCCps6i
    yc1jeg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXYfJJpPFzgzuPfOIHFB5SuMyt9g6aEHe5VwOS5i6q8i73leMnCMF6N+qSZjo4JErwG/AI5Tbmc/tLHJkhUHHiPXv5zs7BUOoLiiXq+tGv/dHpvWqS5
    wVu881hZFBa/FO/j673s7ed6t7fftG9arHnl2RuZzC/u5aqaFE4al8SA8XpR6UTrzaMKoaiFvzTq4+Qc/zInHlKJsQwxO1BW8FadMMFqH8FbvFrB8KR3z3Kv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=ekKyoHb0s9nNJl1EhaAA:9 a=k32JTX0eLr5UggHk:21
    a=H9WIq_xNUmxHf6N7:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeEBDBq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:01:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:63823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbeEBDBn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058185"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Enno Luebbers <enno.luebbers@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v5 01/28] docs: fpga: add a document for FPGA Device Feature List (DFL) Framework Overview
Date: Wed,  2 May 2018 10:50:04 +0800
Message-Id: <1525229431-3087-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a document for FPGA Device Feature List (DFL) Framework Overview.

Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: added FME fpga-mgr/bridge/region platform driver to driver organization.
    updated open discussion per current implementation.
    fixed some typos.
v3: use FPGA base region as container device instead of fpga-dev class.
    split common enumeration code from pcie driver to functions exposed by
    device feature list framework.
    update FME performance reporting which supports both integrated (iperf/)
    and discrete (dperf/) FPGA solutions.
v4: rename this doc to Device Feature List (DFL) Framework Overview (dfl.txt)
    add Device Feature List introduction and re-organize the content.
    add description for port reset, bitstream_id/metadata and etc.
v5: remove introduction of the APIs/features which aren't covered in this patchset.
    replace "blue/green bitstream" terminology with "static region" and "PR bitstream".
    add a "DFL_" prefix to IOCTL APIs introduced by DFL framework.
    s/FPGA Bus Device Module/FPGA DFL Device Module/
    fix typos, improve descriptions per comments from Alan Tull against v4.
---
 Documentation/fpga/dfl.txt | 285 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 Documentation/fpga/dfl.txt

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
new file mode 100644
index 0000000..ba2a1ee
--- /dev/null
+++ b/Documentation/fpga/dfl.txt
@@ -0,0 +1,285 @@
+===============================================================================
+              FPGA Device Feature List (DFL) Framework Overview
+-------------------------------------------------------------------------------
+                Enno Luebbers <enno.luebbers@intel.com>
+                Xiao Guangrong <guangrong.xiao@linux.intel.com>
+                Wu Hao <hao.wu@intel.com>
+
+The Device Feature List (DFL) FPGA framework (and drivers according to this
+this framework) hides the very details of low layer hardwares and provides
+unified interfaces to userspace. Applications could use these interfaces to
+configure, enumerate, open and access FPGA accelerators on platforms which
+implemented the DFL in the device memory. Besides this, the DFL framework
+enables system level management functions such as FPGA reconfiguration.
+
+
+Device Feature List (DFL) Overview
+==================================
+Device Feature List (DFL) defines a linked list of feature headers within the
+device MMIO space to provide an extensible way of adding features. Software can
+walk through these predefined data structures to enumerate FPGA features:
+FPGA Interface Unit (FIU), Accelerated Function Unit (AFU) and Private Features,
+as illustrated below:
+
+    Header            Header            Header            Header
+ +----------+  +-->+----------+  +-->+----------+  +-->+----------+
+ |   Type   |  |   |  Type    |  |   |  Type    |  |   |  Type    |
+ |   FIU    |  |   | Private  |  |   | Private  |  |   | Private  |
+ +----------+  |   | Feature  |  |   | Feature  |  |   | Feature  |
+ | Next_DFH |--+   +----------+  |   +----------+  |   +----------+
+ +----------+      | Next_DFH |--+   | Next_DFH |--+   | Next_DFH |--> NULL
+ |    ID    |      +----------+      +----------+      +----------+
+ +----------+      |    ID    |      |    ID    |      |    ID    |
+ | Next_AFU |--+   +----------+      +----------+      +----------+
+ +----------+  |   | Feature  |      | Feature  |      | Feature  |
+ |  Header  |  |   | Register |      | Register |      | Register |
+ | Register |  |   |   Set    |      |   Set    |      |   Set    |
+ |   Set    |  |   +----------+      +----------+      +----------+
+ +----------+  |      Header
+               +-->+----------+
+                   |   Type   |
+                   |   AFU    |
+                   +----------+
+                   | Next_DFH |--> NULL
+                   +----------+
+                   |   GUID   |
+                   +----------+
+                   |  Header  |
+                   | Register |
+                   |   Set    |
+                   +----------+
+
+FPGA Interface Unit (FIU) represents a standalone functional unit for the
+interface to FPGA, e.g the FPGA Management Engine (FME) and Port (more
+descriptions on FME and Port in later sections).
+
+Accelerated Function Unit (AFU) represents a FPGA programmable region, and
+always connects to a FIU (e.g a Port) as its child as illustrated above.
+
+Private Features represent sub features of the FIU and AFU. They could be
+various function blocks with different IDs, but all private features which
+belong to the same FIU or AFU, must be linked to one list via the Next Device
+Feature Header (Next_DFH) pointer.
+
+Each FIU, AFU and Private Feature could implement its own functional registers.
+The functional register set for FIU and AFU, is named as Header Register Set,
+e.g FME Header Register Set, and the one for Private Feature, is named as
+Feature Register Set, e.g FME Partial Reconfiguration Feature Register Set.
+
+This Device Feature List provides a way of linking features together, it's
+convenient for software to locate each feature by walking through this list,
+and can be implemented in register regions of any FPGA device.
+
+
+FIU - FME (FPGA Management Engine)
+==================================
+The FPGA Management Engine performs reconfiguration, and other infrastructure
+functions. Each FPGA device only has one FME.
+
+User-space applications can acquire exclusive access to the FME using open(),
+and release it using close().
+
+The following functions are exposed through ioctls:
+
+ Get driver API version (DFL_FPGA_GET_API_VERSION)
+ Check for extensions (DFL_FPGA_CHECK_EXTENSION)
+ Program bitstream (DFL_FPGA_FME_PORT_PR)
+
+More functions are exposed through sysfs
+(/sys/class/fpga_region/regionX/dfl-fme.n/):
+
+ Read bitstream ID (bitstream_id)
+     bitstream_id indicates version of the static FPGA region.
+
+ Read bitstream metadata (bitstream_metadata)
+     bitstream_metadata includes detailed information of static FPGA region,
+     e.g synthesis date and seed.
+
+ Read number of ports (ports_num)
+     one FPGA device may have more than 1 port, this sysfs interface indicates
+     how many ports the FPGA device has.
+
+
+FIU - PORT
+==========
+A port represents the interface between the static FPGA fabric and a partially
+reconfigurable region containing an AFU. It controls the communication from SW
+to the accelerator and exposes features such as reset and debug. Each FPGA
+device may have more than 1 port, but always 1 AFU per port.
+
+
+AFU
+===
+An AFU is attached to a port FIU and exposes a fixed length MMIO region to be
+used for accelerator-specific control registers.
+
+User-space applications can acquire exclusive access to an AFU attached to a
+port by using open() on the port device node, and release it using close().
+
+The following functions are exposed through ioctls:
+
+ Get driver API version (DFL_FPGA_GET_API_VERSION)
+ Check for extensions (DFL_FPGA_CHECK_EXTENSION)
+ Get port info (DFL_FPGA_PORT_GET_INFO)
+ Get MMIO region info (DFL_FPGA_PORT_GET_REGION_INFO)
+ Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
+ Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
+ Reset AFU (*DFL_FPGA_PORT_RESET)
+
+*DFL_FPGA_PORT_RESET: reset the FPGA Port and its AFU. Userspace can do Port
+reset at any time, e.g during DMA or Partial Reconfiguration. But it should
+never cause any system level issue, only functional failure (e.g DMA or PR
+operation failure) and be recoverable from the failure.
+
+User-space applications can also mmap() accelerator MMIO regions.
+
+More functions are exposed through sysfs:
+(/sys/class/fpga_region/<regionX>/<dfl-port.m>/):
+
+ Read Accelerator GUID (afu_id)
+     afu_id indicates which PR bitstream is programmed to this AFU.
+
+
+DFL Framework Overview
+======================
+
+         +----------+    +--------+ +--------+ +--------+
+         |   FME    |    |  AFU   | |  AFU   | |  AFU   |
+         |  Module  |    | Module | | Module | | Module |
+         +----------+    +--------+ +--------+ +--------+
+                 +-----------------------+
+                 | FPGA Container Device |    Device Feature List
+                 |  (FPGA Base Region)   |         Framework
+                 +-----------------------+
+--------------------------------------------------------------------
+               +----------------------------+
+               |   FPGA DFL Device Module   |
+               | (e.g PCIE/Platform Device) |
+               +----------------------------+
+                 +------------------------+
+                 |  FPGA Hardware Device  |
+                 +------------------------+
+
+DFL framework in kernel provides common interfaces to create container device
+(FPGA base region), discover feature devices and their private features from the
+given Device Feature Lists, and create platform devices for feature devices
+(e.g FME, Port and AFU) with related resources under the container device. It
+also abstracts operations for the private features and exposes common ops to
+feature device drivers.
+
+The FPGA DFL Device could be different hardwares, e.g PCIe device, platform
+device and etc. Its driver module is always loaded first once the device is
+created by the system. This driver plays an infrastructural role in the
+driver architecture. It locates the DFLs in the device memory, handles them
+and related resources to common interfaces from DFL framework for enumeration.
+(Please refer to drivers/fpga/dfl.c for detailed enumeration APIs).
+
+The FPGA Management Engine (FME) driver is a platform driver which is loaded
+automatically after FME platform device creation from the DFL device module. It
+provides the key features for FPGA management, including:
+
+	a) Expose static FPGA region information, e.g version and metadata.
+	   Users can read related information via sysfs interfaces exposed
+	   by FME driver.
+
+	b) Partial Reconfiguration. The FME driver creates FPGA manager, FPGA
+	   bridges and FPGA regions during PR sub feature initialization. Once
+	   it receives a DFL_FPGA_FME_PORT_PR ioctl from user, it invokes the
+	   common interface function from FPGA Region to complete the partial
+	   reconfiguration of the PR bitstream to the given port.
+
+Similar to the FME driver, the FPGA Accelerated Function Unit (AFU) driver is
+probed once the AFU platform device is created. The main function of this module
+is to provide an interface for userspace applications to access the individual
+accelerators, including basic reset control on port, AFU MMIO region export, dma
+buffer mapping service functions.
+
+After feature platform devices creation, matched platform drivers will be loaded
+automatically to handle different functionalities. Please refer to next sections
+for detailed information on functional units which have been already implemented
+under this DFL framework.
+
+
+Partial Reconfiguration
+=======================
+As mentioned above, accelerators can be reconfigured through partial
+reconfiguration of a PR bitstream file. The PR bitstream file must have been
+generated for the exact static FPGA region and targeted reconfigurable region
+(port) of the FPGA, otherwise, the reconfiguration operation will fail and
+possibly cause system instability. This compatibility can be checked by
+comparing the compatibility ID noted in the header of PR bitstream file against
+the compat_id exposed by the target FPGA region. This check is usually done by
+userspace before calling the reconfiguration IOCTL.
+
+
+Device enumeration
+==================
+This section introduces how applications enumerate the fpga device from
+the sysfs hierarchy under /sys/class/fpga_region.
+
+In the example below, two DFL based FPGA devices are installed in the host. Each
+fpga device has one FME and two ports (AFUs).
+
+FPGA regions are created under /sys/class/fpga_region/
+
+	/sys/class/fpga_region/region0
+	/sys/class/fpga_region/region1
+	/sys/class/fpga_region/region2
+	...
+
+Application needs to search each regionX folder, if feature device is found,
+(e.g "dfl-port.n" or "dfl-fme.m" is found), then it's the base
+fpga region which represents the FPGA device.
+
+Each base region has one FME and two ports (AFUs) as child devices:
+
+	/sys/class/fpga_region/region0/dfl-fme.0
+	/sys/class/fpga_region/region0/dfl-port.0
+	/sys/class/fpga_region/region0/dfl-port.1
+	...
+
+	/sys/class/fpga_region/region3/dfl-fme.1
+	/sys/class/fpga_region/region3/dfl-port.2
+	/sys/class/fpga_region/region3/dfl-port.3
+	...
+
+In general, the FME/AFU sysfs interfaces are named as follows:
+
+	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/
+	/sys/class/fpga_region/<regionX>/<dfl-port.m>/
+
+with 'n' consecutively numbering all FMEs and 'm' consecutively numbering all
+ports.
+
+The device nodes used for ioctl() or mmap() can be referenced through:
+
+	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
+	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
+
+
+Add new FIUs support
+====================
+It's possible that developers made some new function blocks (FIUs) under this
+DFL framework, then new platform device driver needs to be developed for the
+new feature dev (FIU) following the same way as existing feature dev drivers
+(e.g FME and Port/AFU platform device driver). Besides that, it requires
+modification on DFL framework enumeration code too, for new FIU type detection
+and related platform devices creation.
+
+
+Add new private features support
+================================
+In some cases, we may need to add some new private features to existing FIUs
+(e.g FME or Port). Developers don't need to touch enumeration code in DFL
+framework, as each private feature will be parsed automatically, and related
+mmio resources can be found under FIU platform device created by DFL framework.
+Developer only needs to provide a sub feature driver with matched feature id.
+FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
+could be a reference.
+
+
+Open discussion
+===============
+FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
+to user now. In the future, if unified user interfaces for reconfiguration are
+added, FME driver should switch to them from ioctl interface.
-- 
1.8.3.1

