Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F383C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CD12184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546603778;
	bh=QdQYT1bI9rbfJcfb7a7EIGE0S10nvyrM9kPmsPviO1E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uIiO4AQpC20tvXoyVyuxOos0Wfnn3E98HfuaCic4GcQwCbL2oT/uLRmOJmrzQjiR8
	 V59hNIhGzQPvIMi3LZmEQmUmfvFTI/74Ry0/YmKUGXq77diYCIVagD5l4Zs1fMIPcu
	 iNL9rg/bF056QAmZBv+gX3tTaO/QeLGf3HLtk3yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfADMJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:09:36 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35665 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfADMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:09:35 -0500
Received: by mail-wm1-f45.google.com with SMTP id t200so1021258wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=em4perDKVUX2iE2mhz339V6yz6mRFritEXO4MRQUXVs=;
        b=lAHnat8jbxQa6QqSC6roLMofktWWav+khMlD5X1/PUiK8ZgylYS3F4zqCDmNp1lnHd
         8iQhb1CPVfN+omct92LPzhVpXILmh+tlp6v4UbwWVPoKdfnFbBB+TIRxshSzJuF/Qj3Q
         17fdDlQtkcdBYm5gX6yfC44YLeHwxj5tiYiuE85ANaOePNFxvGkQ4B2pA/Njtt/V1ug3
         utk+D9O/1WQHPU8yd2Qyx7Ft3H4jlKFBEery7x6cRdHVLW7W5THEQpPyd4XKRTbpavpw
         XrF2ygE8aWlHEx5yYMvvXU9cMdkfPLdvBXavz7DFcnmk4ZcWpeOS+iagoHWQUYFoZgoP
         84Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=em4perDKVUX2iE2mhz339V6yz6mRFritEXO4MRQUXVs=;
        b=JqkHoxsUIRlzgDc/pjBqp46FjnW+8QZ9H+piBEY8vRboOthwls64pegYl9VBuBWSAj
         vzwzG0Dc2h/0XpXclC+ffNaxrZ6ZM9Ucdjme+iUP2ViCfYkNSvWdxERmpToZqyil1sEx
         G7PomeGvs+ZJJf/vcOzDsqjd6KfMAXIMxe4aX9mXGU53461IlNAan8xAJjp2og3wnSKx
         h1IFZQFyPfErLIJ5HjXEakaP4/cUh97pYl0C8A47Rj9kOrj3EIcArW0GQ0RHJRxac1iq
         C/ug+cA3tm0+7oTLb3m7jPFdrOIjp4Q1PCVFG+Y8KvOzRidCDdbOV8a60HVk43DrU/GK
         L87g==
X-Gm-Message-State: AJcUukc4vd79vUgsUsJGCX8765fHT5mTDv4yW84Ng7T2DPVkjMeHLj52
        Ve0C390RDXszeWvn5DVslvs=
X-Google-Smtp-Source: ALg8bN584UEzjazyVFILLhMyXwhhpBYWgl9qM5az7IILketKL1VOIw5xKzGNxKzqmXinlolBabVCjA==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr1104864wmh.119.1546603769278;
        Fri, 04 Jan 2019 04:09:29 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a1sm44992760wrw.76.2019.01.04.04.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 04:09:28 -0800 (PST)
Date:   Fri, 4 Jan 2019 13:09:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf tooling updates
Message-ID: <20190104120926.GA87843@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 2573be22e5b6f24a0cabc97715c808c47e29eaaf Merge tag 'perf-core-for-mingo-4.21-20190103' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

A final batch of perf tooling changes: mostly fixes and small 
improvements.

 Thanks,

	Ingo

------------------>
Adrian Hunter (8):
      perf thread-stack: Simplify some code in thread_stack__process()
      perf thread-stack: Tidy thread_stack__bottom() usage
      perf thread-stack: Avoid direct reference to the thread's stack
      perf thread-stack: Allow for a thread stack array
      perf thread-stack: Factor out thread_stack__init()
      perf thread-stack: Allocate an array of thread stacks
      perf thread-stack: Fix thread stack processing for the idle task
      perf session: Add comment for perf_session__register_idle_thread()

Andi Kleen (1):
      perf script: Fix LBR skid dump problems in brstackinsn

Arnaldo Carvalho de Melo (11):
      perf trace: Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter
      perf beauty mmap: PROT_WRITE should come before PROT_EXEC
      perf trace: Do not hardcode the size of the tracepoint common_ fields
      perf trace: Rename thread_thread->paths to thread_trace->files
      perf trace: Move the files table resizing to outside set_pathname()
      perf trace: Store the major number for a file when storing its pathname
      tools headers uapi: Grab a copy of usbdevice_fs.h
      perf beauty ioctl: Add generator for USBDEVFS_ ioctl commands
      perf trace: Wire up ioctl's USBDEBFS_ cmd table generator
      perf trace beauty: Export function to get the files for a thread
      perf trace beauty ioctl: Beautify USBDEVFS_ commands

Colin Ian King (1):
      perf trace: Use correct SECCOMP prefix spelling, "SECOMP_*" -> "SECCOMP_*"

Jiri Olsa (7):
      perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
      perf c2c: Change the default coalesce setup
      perf c2c: Increase the HITM ratio limit for displayed cachelines
      tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
      tools thermal tmon: Allow overriding CFLAGS assignments
      tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
      tools gpio: Allow overriding CFLAGS

Stanislav Fomichev (1):
      perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz


 tools/build/Makefile.feature                       |   4 +-
 tools/build/feature/Makefile                       |  10 +-
 tools/gpio/Makefile                                |   2 +-
 tools/include/uapi/linux/usbdevice_fs.h            | 201 ++++++++++++++++++
 tools/perf/Makefile.config                         |  44 ++--
 tools/perf/Makefile.perf                           |   8 +
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-script.c                        |  21 +-
 tools/perf/builtin-trace.c                         | 142 +++++++++----
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/trace/beauty/beauty.h                   |   7 +
 tools/perf/trace/beauty/ioctl.c                    |  22 ++
 tools/perf/trace/beauty/mmap.c                     |   2 +-
 tools/perf/trace/beauty/seccomp.c                  |   4 +-
 tools/perf/trace/beauty/usbdevfs_ioctl.sh          |  19 ++
 tools/perf/util/dump-insn.c                        |   8 +
 tools/perf/util/dump-insn.h                        |   2 +
 tools/perf/util/intel-bts.c                        |   4 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   8 +
 tools/perf/util/intel-pt.c                         |   6 +-
 tools/perf/util/python.c                           |   3 +-
 tools/perf/util/session.c                          |   7 +
 tools/perf/util/thread-stack.c                     | 227 +++++++++++++++------
 tools/perf/util/thread-stack.h                     |   8 +-
 tools/power/x86/turbostat/Makefile                 |   8 +-
 tools/power/x86/x86_energy_perf_policy/Makefile    |   6 +-
 tools/thermal/tmon/Makefile                        |   8 +-
 27 files changed, 620 insertions(+), 166 deletions(-)
 create mode 100644 tools/include/uapi/linux/usbdevice_fs.h
 create mode 100755 tools/perf/trace/beauty/usbdevfs_ioctl.sh

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index d47b8f73e2e7..5467c6bf9ceb 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -82,8 +82,8 @@ FEATURE_TESTS_EXTRA :=                  \
          cplus-demangle                 \
          hello                          \
          libbabeltrace                  \
-         liberty                        \
-         liberty-z                      \
+         libbfd-liberty                 \
+         libbfd-liberty-z               \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 2dbcc0d00f52..7ceb4441b627 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -17,8 +17,8 @@ FILES=                                          \
          test-libbfd.bin                        \
          test-disassembler-four-args.bin        \
          test-reallocarray.bin			\
-         test-liberty.bin                       \
-         test-liberty-z.bin                     \
+         test-libbfd-liberty.bin                \
+         test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
@@ -210,7 +210,7 @@ $(OUTPUT)test-libpython-version.bin:
 	$(BUILD)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -lz -liberty -ldl
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
@@ -218,10 +218,10 @@ $(OUTPUT)test-disassembler-four-args.bin:
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
-$(OUTPUT)test-liberty.bin:
+$(OUTPUT)test-libbfd-liberty.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
-$(OUTPUT)test-liberty-z.bin:
+$(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
 $(OUTPUT)test-cplus-demangle.bin:
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 240eda014b37..6ecdd1067826 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
new file mode 100644
index 000000000000..964e87217be4
--- /dev/null
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*****************************************************************************/
+
+/*
+ *	usbdevice_fs.h  --  USB device file system.
+ *
+ *	Copyright (C) 2000
+ *          Thomas Sailer (sailer@ife.ee.ethz.ch)
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ *	You should have received a copy of the GNU General Public License
+ *	along with this program; if not, write to the Free Software
+ *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  History:
+ *   0.1  04.01.2000  Created
+ */
+
+/*****************************************************************************/
+
+#ifndef _UAPI_LINUX_USBDEVICE_FS_H
+#define _UAPI_LINUX_USBDEVICE_FS_H
+
+#include <linux/types.h>
+#include <linux/magic.h>
+
+/* --------------------------------------------------------------------- */
+
+/* usbdevfs ioctl codes */
+
+struct usbdevfs_ctrltransfer {
+	__u8 bRequestType;
+	__u8 bRequest;
+	__u16 wValue;
+	__u16 wIndex;
+	__u16 wLength;
+	__u32 timeout;  /* in milliseconds */
+ 	void __user *data;
+};
+
+struct usbdevfs_bulktransfer {
+	unsigned int ep;
+	unsigned int len;
+	unsigned int timeout; /* in milliseconds */
+	void __user *data;
+};
+
+struct usbdevfs_setinterface {
+	unsigned int interface;
+	unsigned int altsetting;
+};
+
+struct usbdevfs_disconnectsignal {
+	unsigned int signr;
+	void __user *context;
+};
+
+#define USBDEVFS_MAXDRIVERNAME 255
+
+struct usbdevfs_getdriver {
+	unsigned int interface;
+	char driver[USBDEVFS_MAXDRIVERNAME + 1];
+};
+
+struct usbdevfs_connectinfo {
+	unsigned int devnum;
+	unsigned char slow;
+};
+
+#define USBDEVFS_URB_SHORT_NOT_OK	0x01
+#define USBDEVFS_URB_ISO_ASAP		0x02
+#define USBDEVFS_URB_BULK_CONTINUATION	0x04
+#define USBDEVFS_URB_NO_FSBR		0x20	/* Not used */
+#define USBDEVFS_URB_ZERO_PACKET	0x40
+#define USBDEVFS_URB_NO_INTERRUPT	0x80
+
+#define USBDEVFS_URB_TYPE_ISO		   0
+#define USBDEVFS_URB_TYPE_INTERRUPT	   1
+#define USBDEVFS_URB_TYPE_CONTROL	   2
+#define USBDEVFS_URB_TYPE_BULK		   3
+
+struct usbdevfs_iso_packet_desc {
+	unsigned int length;
+	unsigned int actual_length;
+	unsigned int status;
+};
+
+struct usbdevfs_urb {
+	unsigned char type;
+	unsigned char endpoint;
+	int status;
+	unsigned int flags;
+	void __user *buffer;
+	int buffer_length;
+	int actual_length;
+	int start_frame;
+	union {
+		int number_of_packets;	/* Only used for isoc urbs */
+		unsigned int stream_id;	/* Only used with bulk streams */
+	};
+	int error_count;
+	unsigned int signr;	/* signal to be sent on completion,
+				  or 0 if none should be sent. */
+	void __user *usercontext;
+	struct usbdevfs_iso_packet_desc iso_frame_desc[0];
+};
+
+/* ioctls for talking directly to drivers */
+struct usbdevfs_ioctl {
+	int	ifno;		/* interface 0..N ; negative numbers reserved */
+	int	ioctl_code;	/* MUST encode size + direction of data so the
+				 * macros in <asm/ioctl.h> give correct values */
+	void __user *data;	/* param buffer (in, or out) */
+};
+
+/* You can do most things with hubs just through control messages,
+ * except find out what device connects to what port. */
+struct usbdevfs_hub_portinfo {
+	char nports;		/* number of downstream ports in this hub */
+	char port [127];	/* e.g. port 3 connects to device 27 */
+};
+
+/* System and bus capability flags */
+#define USBDEVFS_CAP_ZERO_PACKET		0x01
+#define USBDEVFS_CAP_BULK_CONTINUATION		0x02
+#define USBDEVFS_CAP_NO_PACKET_SIZE_LIM		0x04
+#define USBDEVFS_CAP_BULK_SCATTER_GATHER	0x08
+#define USBDEVFS_CAP_REAP_AFTER_DISCONNECT	0x10
+#define USBDEVFS_CAP_MMAP			0x20
+#define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
+
+/* USBDEVFS_DISCONNECT_CLAIM flags & struct */
+
+/* disconnect-and-claim if the driver matches the driver field */
+#define USBDEVFS_DISCONNECT_CLAIM_IF_DRIVER	0x01
+/* disconnect-and-claim except when the driver matches the driver field */
+#define USBDEVFS_DISCONNECT_CLAIM_EXCEPT_DRIVER	0x02
+
+struct usbdevfs_disconnect_claim {
+	unsigned int interface;
+	unsigned int flags;
+	char driver[USBDEVFS_MAXDRIVERNAME + 1];
+};
+
+struct usbdevfs_streams {
+	unsigned int num_streams; /* Not used by USBDEVFS_FREE_STREAMS */
+	unsigned int num_eps;
+	unsigned char eps[0];
+};
+
+/*
+ * USB_SPEED_* values returned by USBDEVFS_GET_SPEED are defined in
+ * linux/usb/ch9.h
+ */
+
+#define USBDEVFS_CONTROL           _IOWR('U', 0, struct usbdevfs_ctrltransfer)
+#define USBDEVFS_CONTROL32           _IOWR('U', 0, struct usbdevfs_ctrltransfer32)
+#define USBDEVFS_BULK              _IOWR('U', 2, struct usbdevfs_bulktransfer)
+#define USBDEVFS_BULK32              _IOWR('U', 2, struct usbdevfs_bulktransfer32)
+#define USBDEVFS_RESETEP           _IOR('U', 3, unsigned int)
+#define USBDEVFS_SETINTERFACE      _IOR('U', 4, struct usbdevfs_setinterface)
+#define USBDEVFS_SETCONFIGURATION  _IOR('U', 5, unsigned int)
+#define USBDEVFS_GETDRIVER         _IOW('U', 8, struct usbdevfs_getdriver)
+#define USBDEVFS_SUBMITURB         _IOR('U', 10, struct usbdevfs_urb)
+#define USBDEVFS_SUBMITURB32       _IOR('U', 10, struct usbdevfs_urb32)
+#define USBDEVFS_DISCARDURB        _IO('U', 11)
+#define USBDEVFS_REAPURB           _IOW('U', 12, void *)
+#define USBDEVFS_REAPURB32         _IOW('U', 12, __u32)
+#define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, void *)
+#define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, __u32)
+#define USBDEVFS_DISCSIGNAL        _IOR('U', 14, struct usbdevfs_disconnectsignal)
+#define USBDEVFS_DISCSIGNAL32      _IOR('U', 14, struct usbdevfs_disconnectsignal32)
+#define USBDEVFS_CLAIMINTERFACE    _IOR('U', 15, unsigned int)
+#define USBDEVFS_RELEASEINTERFACE  _IOR('U', 16, unsigned int)
+#define USBDEVFS_CONNECTINFO       _IOW('U', 17, struct usbdevfs_connectinfo)
+#define USBDEVFS_IOCTL             _IOWR('U', 18, struct usbdevfs_ioctl)
+#define USBDEVFS_IOCTL32           _IOWR('U', 18, struct usbdevfs_ioctl32)
+#define USBDEVFS_HUB_PORTINFO      _IOR('U', 19, struct usbdevfs_hub_portinfo)
+#define USBDEVFS_RESET             _IO('U', 20)
+#define USBDEVFS_CLEAR_HALT        _IOR('U', 21, unsigned int)
+#define USBDEVFS_DISCONNECT        _IO('U', 22)
+#define USBDEVFS_CONNECT           _IO('U', 23)
+#define USBDEVFS_CLAIM_PORT        _IOR('U', 24, unsigned int)
+#define USBDEVFS_RELEASE_PORT      _IOR('U', 25, unsigned int)
+#define USBDEVFS_GET_CAPABILITIES  _IOR('U', 26, __u32)
+#define USBDEVFS_DISCONNECT_CLAIM  _IOR('U', 27, struct usbdevfs_disconnect_claim)
+#define USBDEVFS_ALLOC_STREAMS     _IOR('U', 28, struct usbdevfs_streams)
+#define USBDEVFS_FREE_STREAMS      _IOR('U', 29, struct usbdevfs_streams)
+#define USBDEVFS_DROP_PRIVILEGES   _IOW('U', 30, __u32)
+#define USBDEVFS_GET_SPEED         _IO('U', 31)
+
+#endif /* _UAPI_LINUX_USBDEVICE_FS_H */
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 07c1857c3d7a..b441c88cafa1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -702,18 +702,20 @@ endif
 
 ifeq ($(feature-libbfd), 1)
   EXTLIBS += -lbfd
+else
+  # we are on a system that requires -liberty and (maybe) -lz
+  # to link against -lbfd; test each case individually here
 
   # call all detections now so we get correct
   # status in VF output
-  $(call feature_check,liberty)
-  $(call feature_check,liberty-z)
-  $(call feature_check,cplus-demangle)
+  $(call feature_check,libbfd-liberty)
+  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-liberty), 1)
-    EXTLIBS += -liberty
+  ifeq ($(feature-libbfd-liberty), 1)
+    EXTLIBS += -lbfd -liberty
   else
-    ifeq ($(feature-liberty-z), 1)
-      EXTLIBS += -liberty -lz
+    ifeq ($(feature-libbfd-liberty-z), 1)
+      EXTLIBS += -lbfd -liberty -lz
     endif
   endif
 endif
@@ -723,24 +725,24 @@ ifdef NO_DEMANGLE
 else
   ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
     EXTLIBS += -liberty
-    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
   else
-    ifneq ($(feature-libbfd), 1)
-      ifneq ($(feature-liberty), 1)
-        ifneq ($(feature-liberty-z), 1)
-          # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
-          # or any of 'bfd iberty z' trinity
-          ifeq ($(feature-cplus-demangle), 1)
-            EXTLIBS += -liberty
-            CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-          else
-            msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
-            CFLAGS += -DNO_DEMANGLE
-          endif
-        endif
+    ifeq ($(filter -liberty,$(EXTLIBS)),)
+      $(call feature_check,cplus-demangle)
+
+      # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
+      # or any of 'bfd iberty z' trinity
+      ifeq ($(feature-cplus-demangle), 1)
+        EXTLIBS += -liberty
+      else
+        msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
+        CFLAGS += -DNO_DEMANGLE
       endif
     endif
   endif
+
+  ifneq ($(filter -liberty,$(EXTLIBS)),)
+    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+  endif
 endif
 
 ifneq ($(filter -lbfd,$(EXTLIBS)),)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bd23e3f30895..ff29c3372ec3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -497,6 +497,12 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
+usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+
+$(usbdevfs_ioctl_array): $(linux_uapi_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
+	$(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(linux_uapi_dir) > $@
+
 x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
 x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 
@@ -624,6 +630,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
+	$(usbdevfs_ioctl_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array)
@@ -923,6 +930,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(usbdevfs_ioctl_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array)
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f3aa9d02a5ab..d340d2e42776 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -68,7 +68,7 @@ struct c2c_hist_entry {
 	struct hist_entry	he;
 };
 
-static char const *coalesce_default = "pid,iaddr";
+static char const *coalesce_default = "iaddr";
 
 struct perf_c2c {
 	struct perf_tool	tool;
@@ -1878,7 +1878,7 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 	return hpp_list__parse(&c2c_hists->list, output, sort);
 }
 
-#define DISPLAY_LINE_LIMIT  0.0005
+#define DISPLAY_LINE_LIMIT  0.001
 
 static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3728b50e52e2..d079f36d342d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1073,9 +1073,18 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 	/*
 	 * Print final block upto sample
+	 *
+	 * Due to pipeline delays the LBRs might be missing a branch
+	 * or two, which can result in very large or negative blocks
+	 * between final branch and sample. When this happens just
+	 * continue walking after the last TO until we hit a branch.
 	 */
 	start = br->entries[0].to;
 	end = sample->ip;
+	if (end < start) {
+		/* Missing jump. Scan 128 bytes for the next branch */
+		end = start + 128;
+	}
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
 	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 	if (len <= 0) {
@@ -1084,7 +1093,6 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			      machine, thread, &x.is64bit, &x.cpumode, false);
 		if (len <= 0)
 			goto out;
-
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
 		if (PRINT_FIELD(SRCCODE))
@@ -1096,6 +1104,13 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
+		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
+			/*
+			 * Hit a missing branch. Just stop.
+			 */
+			printed += fprintf(fp, "\t... not reaching sample ...\n");
+			break;
+		}
 		if (PRINT_FIELD(SRCCODE))
 			print_srccode(thread, x.cpumode, start + off);
 	}
@@ -1167,7 +1182,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 					   struct addr_location *al, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
-	size_t depth = thread_stack__depth(thread);
+	size_t depth = thread_stack__depth(thread, sample->cpu);
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
@@ -1701,7 +1716,7 @@ static bool show_event(struct perf_sample *sample,
 		       struct thread *thread,
 		       struct addr_location *al)
 {
-	int depth = thread_stack__depth(thread);
+	int depth = thread_stack__depth(thread, sample->cpu);
 
 	if (!symbol_conf.graph_function)
 		return true;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ebde59e61133..adbf28183560 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -60,6 +60,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <fcntl.h>
+#include <sys/sysmacros.h>
 
 #include "sane_ctype.h"
 
@@ -112,8 +113,9 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
-	bool			sort_events;
+	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
+	bool			sort_events;
 	bool			not_ev_qualifier;
 	bool			live;
 	bool			full_time;
@@ -283,12 +285,17 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	return -ENOENT;
 }
 
-static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel)
+static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel, struct perf_evsel *tp)
 {
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
-	if (evsel->priv != NULL) {       /* field, sizeof_field, offsetof_field */
-		if (__tp_field__init_uint(&sc->id, sizeof(long), sizeof(long long), evsel->needs_swap))
+	if (evsel->priv != NULL) {
+		struct tep_format_field *syscall_id = perf_evsel__field(tp, "id");
+		if (syscall_id == NULL)
+			syscall_id = perf_evsel__field(tp, "__syscall_nr");
+		if (syscall_id == NULL)
+			goto out_delete;
+		if (__tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
 			goto out_delete;
 
 		return 0;
@@ -974,9 +981,9 @@ struct thread_trace {
 		char	      *name;
 	} filename;
 	struct {
-		int	  max;
-		char	  **table;
-	} paths;
+		int	      max;
+		struct file   *table;
+	} files;
 
 	struct intlist *syscall_stats;
 };
@@ -986,7 +993,7 @@ static struct thread_trace *thread_trace__new(void)
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
 	if (ttrace)
-		ttrace->paths.max = -1;
+		ttrace->files.max = -1;
 
 	ttrace->syscall_stats = intlist__new(NULL);
 
@@ -1030,30 +1037,48 @@ void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 
 static const size_t trace__entry_str_size = 2048;
 
-static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int fd)
 {
-	struct thread_trace *ttrace = thread__priv(thread);
-
-	if (fd > ttrace->paths.max) {
-		char **npath = realloc(ttrace->paths.table, (fd + 1) * sizeof(char *));
+	if (fd > ttrace->files.max) {
+		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
-		if (npath == NULL)
-			return -1;
+		if (nfiles == NULL)
+			return NULL;
 
-		if (ttrace->paths.max != -1) {
-			memset(npath + ttrace->paths.max + 1, 0,
-			       (fd - ttrace->paths.max) * sizeof(char *));
+		if (ttrace->files.max != -1) {
+			memset(nfiles + ttrace->files.max + 1, 0,
+			       (fd - ttrace->files.max) * sizeof(struct file));
 		} else {
-			memset(npath, 0, (fd + 1) * sizeof(char *));
+			memset(nfiles, 0, (fd + 1) * sizeof(struct file));
 		}
 
-		ttrace->paths.table = npath;
-		ttrace->paths.max   = fd;
+		ttrace->files.table = nfiles;
+		ttrace->files.max   = fd;
 	}
 
-	ttrace->paths.table[fd] = strdup(pathname);
+	return ttrace->files.table + fd;
+}
 
-	return ttrace->paths.table[fd] != NULL ? 0 : -1;
+struct file *thread__files_entry(struct thread *thread, int fd)
+{
+	return thread_trace__files_entry(thread__priv(thread), fd);
+}
+
+static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+{
+	struct thread_trace *ttrace = thread__priv(thread);
+	struct file *file = thread_trace__files_entry(ttrace, fd);
+
+	if (file != NULL) {
+		struct stat st;
+		if (stat(pathname, &st) == 0)
+			file->dev_maj = major(st.st_rdev);
+		file->pathname = strdup(pathname);
+		if (file->pathname)
+			return 0;
+	}
+
+	return -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
@@ -1093,7 +1118,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 	if (fd < 0)
 		return NULL;
 
-	if ((fd > ttrace->paths.max || ttrace->paths.table[fd] == NULL)) {
+	if ((fd > ttrace->files.max || ttrace->files.table[fd].pathname == NULL)) {
 		if (!trace->live)
 			return NULL;
 		++trace->stats.proc_getname;
@@ -1101,7 +1126,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 			return NULL;
 	}
 
-	return ttrace->paths.table[fd];
+	return ttrace->files.table[fd].pathname;
 }
 
 size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
@@ -1140,8 +1165,8 @@ static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 	size_t printed = syscall_arg__scnprintf_fd(bf, size, arg);
 	struct thread_trace *ttrace = thread__priv(arg->thread);
 
-	if (ttrace && fd >= 0 && fd <= ttrace->paths.max)
-		zfree(&ttrace->paths.table[fd]);
+	if (ttrace && fd >= 0 && fd <= ttrace->files.max)
+		zfree(&ttrace->files.table[fd].pathname);
 
 	return printed;
 }
@@ -1768,16 +1793,16 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
 	return printed;
 }
 
-static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, bool raw_augmented)
+static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
 {
 	void *augmented_args = NULL;
 	/*
 	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
-	 * and there we get all 6 syscall args plus the tracepoint common
-	 * fields (sizeof(long)) and the syscall_nr (another long). So we check
-	 * if that is the case and if so don't look after the sc->args_size,
-	 * but always after the full raw_syscalls:sys_enter payload, which is
-	 * fixed.
+	 * and there we get all 6 syscall args plus the tracepoint common fields
+	 * that gets calculated at the start and the syscall_nr (another long).
+	 * So we check if that is the case and if so don't look after the
+	 * sc->args_size but always after the full raw_syscalls:sys_enter payload,
+	 * which is fixed.
 	 *
 	 * We'll revisit this later to pass s->args_size to the BPF augmenter
 	 * (now tools/perf/examples/bpf/augmented_raw_syscalls.c, so that it
@@ -1785,7 +1810,7 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	 * use syscalls:sys_enter_NAME, so that we reduce the kernel/userspace
 	 * traffic to just what is needed for each syscall.
 	 */
-	int args_size = raw_augmented ? (8 * (int)sizeof(long)) : sc->args_size;
+	int args_size = raw_augmented_args_size ?: sc->args_size;
 
 	*augmented_args_size = sample->raw_size - args_size;
 	if (*augmented_args_size > 0)
@@ -1839,7 +1864,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
 	 */
 	if (evsel != trace->syscalls.events.sys_enter)
-		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls);
+		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
@@ -1897,7 +1922,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls);
+	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
@@ -2686,7 +2711,9 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
 	if (trace->syscalls.map)
 		return trace__set_ev_qualifier_bpf_filter(trace);
-	return trace__set_ev_qualifier_tp_filter(trace);
+	if (trace->syscalls.events.sys_enter)
+		return trace__set_ev_qualifier_tp_filter(trace);
+	return 0;
 }
 
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
@@ -3812,13 +3839,6 @@ int cmd_trace(int argc, const char **argv)
 	 * syscall.
 	 */
 	if (trace.syscalls.events.augmented) {
-		evsel = trace.syscalls.events.augmented;
-
-		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
-		    perf_evsel__init_augmented_syscall_tp_args(evsel))
-			goto out;
-		evsel->handler = trace__sys_enter;
-
 		evlist__for_each_entry(trace.evlist, evsel) {
 			bool raw_syscalls_sys_exit = strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
 
@@ -3827,9 +3847,41 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
+			if (strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_enter") == 0) {
+				struct perf_evsel *augmented = trace.syscalls.events.augmented;
+				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
+				    perf_evsel__init_augmented_syscall_tp_args(augmented))
+					goto out;
+				augmented->handler = trace__sys_enter;
+			}
+
 			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
+				struct syscall_tp *sc;
 init_augmented_syscall_tp:
-				perf_evsel__init_augmented_syscall_tp(evsel);
+				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel))
+					goto out;
+				sc = evsel->priv;
+				/*
+				 * For now with BPF raw_augmented we hook into
+				 * raw_syscalls:sys_enter and there we get all
+				 * 6 syscall args plus the tracepoint common
+				 * fields and the syscall_nr (another long).
+				 * So we check if that is the case and if so
+				 * don't look after the sc->args_size but
+				 * always after the full raw_syscalls:sys_enter
+				 * payload, which is fixed.
+				 *
+				 * We'll revisit this later to pass
+				 * s->args_size to the BPF augmenter (now
+				 * tools/perf/examples/bpf/augmented_raw_syscalls.c,
+				 * so that it copies only what we need for each
+				 * syscall, like what happens when we use
+				 * syscalls:sys_enter_NAME, so that we reduce
+				 * the kernel/userspace traffic to just what is
+				 * needed for each syscall.
+				 */
+				if (trace.raw_augmented_syscalls)
+					trace.raw_augmented_syscalls_args_size = (6 + 1) * sizeof(long) + sc->id.offset;
 				perf_evsel__init_augmented_syscall_tp_ret(evsel);
 				evsel->handler = trace__sys_exit;
 			}
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 8e811ea0cf85..6cb98f8570a2 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -14,6 +14,7 @@ include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
 include/uapi/linux/stat.h
+include/uapi/linux/usbdevice_fs.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 83c5b202e00e..139d485a6f16 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,13 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, boo
 struct trace;
 struct thread;
 
+struct file {
+	char *pathname;
+	int  dev_maj;
+};
+
+struct file *thread__files_entry(struct thread *thread, int fd);
+
 struct strarrays {
 	int		nr_entries;
 	struct strarray **entries;
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 9efeb6a936c2..620350d41209 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -112,6 +112,17 @@ static size_t ioctl__scnprintf_perf_cmd(int nr, int dir, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAE, nr, dir);
 }
 
+static size_t ioctl__scnprintf_usbdevfs_cmd(int nr, int dir, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/usbdevfs_ioctl_array.c"
+	static DEFINE_STRARRAY(usbdevfs_ioctl_cmds, "");
+
+	if (nr < strarray__usbdevfs_ioctl_cmds.nr_entries && strarray__usbdevfs_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "USBDEVFS_%s", strarray__usbdevfs_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%c, %#x, %#x)", 'U', nr, dir);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, bool show_prefix)
 {
 	const char *prefix = "_IOC_";
@@ -157,9 +168,20 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, boo
 	return printed + scnprintf(bf + printed, size - printed, ", %#x, %#x, %#x)", type, nr, sz);
 }
 
+#ifndef USB_DEVICE_MAJOR
+#define USB_DEVICE_MAJOR 189
+#endif // USB_DEVICE_MAJOR
+
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
+	unsigned int fd = syscall_arg__val(arg, 0);
+	struct file *file = thread__files_entry(arg->thread, fd);
+
+	if (file != NULL) {
+		if (file->dev_maj == USB_DEVICE_MAJOR)
+			return ioctl__scnprintf_usbdevfs_cmd(_IOC_NR(cmd), _IOC_DIR(cmd), bf, size);
+	}
 
 	return ioctl__scnprintf_cmd(cmd, bf, size, arg->show_string_prefix);
 }
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index eb31089790e3..859a8a9db2c6 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -18,8 +18,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 	}
 
 	P_MMAP_PROT(READ);
-	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(WRITE);
+	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(SEM);
 	P_MMAP_PROT(GROWSDOWN);
 	P_MMAP_PROT(GROWSUP);
diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index 4600c28a3cfe..637722e2796b 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -9,7 +9,7 @@
 static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_SET_MODE_";
+	const char *prefix = "SECCOMP_SET_MODE_";
 	int op = arg->val;
 	size_t printed = 0;
 
@@ -34,7 +34,7 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
 						   struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	const char *prefix = "SECOMP_FILTER_FLAG_";
+	const char *prefix = "SECCOMP_FILTER_FLAG_";
 	int printed = 0, flags = arg->val;
 
 #define	P_FLAG(n) \
diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
new file mode 100755
index 000000000000..930b80f422e8
--- /dev/null
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+printf "#if 0\n"
+printf "static const char *usbdevfs_ioctl_32_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
+printf "#endif\n"
diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
index 10988d3de7ce..2bd8585db93c 100644
--- a/tools/perf/util/dump-insn.c
+++ b/tools/perf/util/dump-insn.c
@@ -13,3 +13,11 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
 		*lenp = 0;
 	return "?";
 }
+
+__weak
+int arch_is_branch(const unsigned char *buf __maybe_unused,
+		   size_t len __maybe_unused,
+		   int x86_64 __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
index 0e06280a8860..650125061530 100644
--- a/tools/perf/util/dump-insn.h
+++ b/tools/perf/util/dump-insn.h
@@ -20,4 +20,6 @@ struct perf_insn {
 
 const char *dump_insn(struct perf_insn *x, u64 ip,
 		      u8 *inbuf, int inlen, int *lenp);
+int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
+
 #endif
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7b27d77306c2..ee6ca65f81f4 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -451,7 +451,7 @@ static int intel_bts_process_buffer(struct intel_bts_queue *btsq,
 			continue;
 		intel_bts_get_branch_type(btsq, branch);
 		if (btsq->bts->synth_opts.thread_stack)
-			thread_stack__event(thread, btsq->sample_flags,
+			thread_stack__event(thread, btsq->cpu, btsq->sample_flags,
 					    le64_to_cpu(branch->from),
 					    le64_to_cpu(branch->to),
 					    btsq->intel_pt_insn.length,
@@ -523,7 +523,7 @@ static int intel_bts_process_queue(struct intel_bts_queue *btsq, u64 *timestamp)
 	    !btsq->bts->synth_opts.thread_stack && thread &&
 	    (!old_buffer || btsq->bts->sampling_mode ||
 	     (btsq->bts->snapshot_mode && !buffer->consecutive)))
-		thread_stack__set_trace_nr(thread, buffer->buffer_nr + 1);
+		thread_stack__set_trace_nr(thread, btsq->cpu, buffer->buffer_nr + 1);
 
 	err = intel_bts_process_buffer(btsq, buffer, thread);
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 54818828023b..1c0e289f01e6 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -180,6 +180,14 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 	return 0;
 }
 
+int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
+{
+	struct intel_pt_insn in;
+	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
+		return -1;
+	return in.branch != INTEL_PT_BR_NO_BRANCH;
+}
+
 const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 		      u8 *inbuf, int inlen, int *lenp)
 {
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 149ff361ca78..2e72373ec6df 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1174,7 +1174,7 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 	intel_pt_prep_b_sample(pt, ptq, event, sample);
 
 	if (pt->synth_opts.callchain) {
-		thread_stack__sample(ptq->thread, ptq->chain,
+		thread_stack__sample(ptq->thread, ptq->cpu, ptq->chain,
 				     pt->synth_opts.callchain_sz + 1,
 				     sample->ip, pt->kernel_start);
 		sample->callchain = ptq->chain;
@@ -1526,11 +1526,11 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		return 0;
 
 	if (pt->synth_opts.callchain || pt->synth_opts.thread_stack)
-		thread_stack__event(ptq->thread, ptq->flags, state->from_ip,
+		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
 				    state->trace_nr);
 	else
-		thread_stack__set_trace_nr(ptq->thread, state->trace_nr);
+		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
 
 	if (pt->sample_branches) {
 		err = intel_pt_synth_branch_sample(ptq);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 47628e85c5eb..dda0ac978b1e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -939,7 +939,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 		file = PyFile_FromFile(fp, "perf", "r", NULL);
 #else
-		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1, NULL, NULL, NULL, 1);
+		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1,
+				     NULL, NULL, NULL, 0);
 #endif
 		if (file == NULL)
 			goto free_list;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 78a067777144..5456c84c7dd1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1527,6 +1527,13 @@ struct thread *perf_session__findnew(struct perf_session *session, pid_t pid)
 	return machine__findnew_thread(&session->machines.host, -1, pid);
 }
 
+/*
+ * Threads are identified by pid and tid, and the idle task has pid == tid == 0.
+ * So here a single thread is created for that, but actually there is a separate
+ * idle task per cpu, so there should be one 'struct thread' per cpu, but there
+ * is only 1. That causes problems for some tools, requiring workarounds. For
+ * example get_idle_thread() in builtin-sched.c, or thread_stack__per_cpu().
+ */
 int perf_session__register_idle_thread(struct perf_session *session)
 {
 	struct thread *thread;
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 61a4286a74dc..d52f27f373ce 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -15,6 +15,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 #include <errno.h>
 #include "thread.h"
 #include "event.h"
@@ -60,6 +61,7 @@ struct thread_stack_entry {
  * @last_time: last timestamp
  * @crp: call/return processor
  * @comm: current comm
+ * @arr_sz: size of array if this is the first element of an array
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -71,8 +73,19 @@ struct thread_stack {
 	u64 last_time;
 	struct call_return_processor *crp;
 	struct comm *comm;
+	unsigned int arr_sz;
 };
 
+/*
+ * Assume pid == tid == 0 identifies the idle task as defined by
+ * perf_session__register_idle_thread(). The idle task is really 1 task per cpu,
+ * and therefore requires a stack for each cpu.
+ */
+static inline bool thread_stack__per_cpu(struct thread *thread)
+{
+	return !(thread->tid || thread->pid_);
+}
+
 static int thread_stack__grow(struct thread_stack *ts)
 {
 	struct thread_stack_entry *new_stack;
@@ -91,19 +104,14 @@ static int thread_stack__grow(struct thread_stack *ts)
 	return 0;
 }
 
-static struct thread_stack *thread_stack__new(struct thread *thread,
-					      struct call_return_processor *crp)
+static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
+			      struct call_return_processor *crp)
 {
-	struct thread_stack *ts;
-
-	ts = zalloc(sizeof(struct thread_stack));
-	if (!ts)
-		return NULL;
+	int err;
 
-	if (thread_stack__grow(ts)) {
-		free(ts);
-		return NULL;
-	}
+	err = thread_stack__grow(ts);
+	if (err)
+		return err;
 
 	if (thread->mg && thread->mg->machine)
 		ts->kernel_start = machine__kernel_start(thread->mg->machine);
@@ -111,9 +119,72 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 		ts->kernel_start = 1ULL << 63;
 	ts->crp = crp;
 
+	return 0;
+}
+
+static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
+					      struct call_return_processor *crp)
+{
+	struct thread_stack *ts = thread->ts, *new_ts;
+	unsigned int old_sz = ts ? ts->arr_sz : 0;
+	unsigned int new_sz = 1;
+
+	if (thread_stack__per_cpu(thread) && cpu > 0)
+		new_sz = roundup_pow_of_two(cpu + 1);
+
+	if (!ts || new_sz > old_sz) {
+		new_ts = calloc(new_sz, sizeof(*ts));
+		if (!new_ts)
+			return NULL;
+		if (ts)
+			memcpy(new_ts, ts, old_sz * sizeof(*ts));
+		new_ts->arr_sz = new_sz;
+		zfree(&thread->ts);
+		thread->ts = new_ts;
+		ts = new_ts;
+	}
+
+	if (thread_stack__per_cpu(thread) && cpu > 0 &&
+	    (unsigned int)cpu < ts->arr_sz)
+		ts += cpu;
+
+	if (!ts->stack &&
+	    thread_stack__init(ts, thread, crp))
+		return NULL;
+
 	return ts;
 }
 
+static struct thread_stack *thread__cpu_stack(struct thread *thread, int cpu)
+{
+	struct thread_stack *ts = thread->ts;
+
+	if (cpu < 0)
+		cpu = 0;
+
+	if (!ts || (unsigned int)cpu >= ts->arr_sz)
+		return NULL;
+
+	ts += cpu;
+
+	if (!ts->stack)
+		return NULL;
+
+	return ts;
+}
+
+static inline struct thread_stack *thread__stack(struct thread *thread,
+						    int cpu)
+{
+	if (!thread)
+		return NULL;
+
+	if (thread_stack__per_cpu(thread))
+		return thread__cpu_stack(thread, cpu);
+
+	return thread->ts;
+}
+
 static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
 			      bool trace_end)
 {
@@ -226,25 +297,37 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 
 int thread_stack__flush(struct thread *thread)
 {
-	if (thread->ts)
-		return __thread_stack__flush(thread, thread->ts);
+	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
+	int err = 0;
 
-	return 0;
+	if (ts) {
+		for (pos = 0; pos < ts->arr_sz; pos++) {
+			int ret = __thread_stack__flush(thread, ts + pos);
+
+			if (ret)
+				err = ret;
+		}
+	}
+
+	return err;
 }
 
-int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
+int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr)
 {
+	struct thread_stack *ts = thread__stack(thread, cpu);
+
 	if (!thread)
 		return -EINVAL;
 
-	if (!thread->ts) {
-		thread->ts = thread_stack__new(thread, NULL);
-		if (!thread->ts) {
+	if (!ts) {
+		ts = thread_stack__new(thread, cpu, NULL);
+		if (!ts) {
 			pr_warning("Out of memory: no thread stack\n");
 			return -ENOMEM;
 		}
-		thread->ts->trace_nr = trace_nr;
+		ts->trace_nr = trace_nr;
 	}
 
 	/*
@@ -252,14 +335,14 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 	 * the stack might be completely invalid.  Better to report nothing than
 	 * to report something misleading, so flush the stack.
 	 */
-	if (trace_nr != thread->ts->trace_nr) {
-		if (thread->ts->trace_nr)
-			__thread_stack__flush(thread, thread->ts);
-		thread->ts->trace_nr = trace_nr;
+	if (trace_nr != ts->trace_nr) {
+		if (ts->trace_nr)
+			__thread_stack__flush(thread, ts);
+		ts->trace_nr = trace_nr;
 	}
 
 	/* Stop here if thread_stack__process() is in use */
-	if (thread->ts->crp)
+	if (ts->crp)
 		return 0;
 
 	if (flags & PERF_IP_FLAG_CALL) {
@@ -270,7 +353,7 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		ret_addr = from_ip + insn_len;
 		if (ret_addr == to_ip)
 			return 0; /* Zero-length calls are excluded */
-		return thread_stack__push(thread->ts, ret_addr,
+		return thread_stack__push(ts, ret_addr,
 					  flags & PERF_IP_FLAG_TRACE_END);
 	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
 		/*
@@ -280,32 +363,52 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		 * address, so try to pop that. Also, do not expect a call made
 		 * when the trace ended, to return, so pop that.
 		 */
-		thread_stack__pop(thread->ts, to_ip);
-		thread_stack__pop_trace_end(thread->ts);
+		thread_stack__pop(ts, to_ip);
+		thread_stack__pop_trace_end(ts);
 	} else if ((flags & PERF_IP_FLAG_RETURN) && from_ip) {
-		thread_stack__pop(thread->ts, to_ip);
+		thread_stack__pop(ts, to_ip);
 	}
 
 	return 0;
 }
 
-void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
+void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr)
 {
-	if (!thread || !thread->ts)
+	struct thread_stack *ts = thread__stack(thread, cpu);
+
+	if (!ts)
 		return;
 
-	if (trace_nr != thread->ts->trace_nr) {
-		if (thread->ts->trace_nr)
-			__thread_stack__flush(thread, thread->ts);
-		thread->ts->trace_nr = trace_nr;
+	if (trace_nr != ts->trace_nr) {
+		if (ts->trace_nr)
+			__thread_stack__flush(thread, ts);
+		ts->trace_nr = trace_nr;
 	}
 }
 
+static void __thread_stack__free(struct thread *thread, struct thread_stack *ts)
+{
+	__thread_stack__flush(thread, ts);
+	zfree(&ts->stack);
+}
+
+static void thread_stack__reset(struct thread *thread, struct thread_stack *ts)
+{
+	unsigned int arr_sz = ts->arr_sz;
+
+	__thread_stack__free(thread, ts);
+	memset(ts, 0, sizeof(*ts));
+	ts->arr_sz = arr_sz;
+}
+
 void thread_stack__free(struct thread *thread)
 {
-	if (thread->ts) {
-		__thread_stack__flush(thread, thread->ts);
-		zfree(&thread->ts->stack);
+	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
+
+	if (ts) {
+		for (pos = 0; pos < ts->arr_sz; pos++)
+			__thread_stack__free(thread, ts + pos);
 		zfree(&thread->ts);
 	}
 }
@@ -315,9 +418,11 @@ static inline u64 callchain_context(u64 ip, u64 kernel_start)
 	return ip < kernel_start ? PERF_CONTEXT_USER : PERF_CONTEXT_KERNEL;
 }
 
-void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
+void thread_stack__sample(struct thread *thread, int cpu,
+			  struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start)
 {
+	struct thread_stack *ts = thread__stack(thread, cpu);
 	u64 context = callchain_context(ip, kernel_start);
 	u64 last_context;
 	size_t i, j;
@@ -330,15 +435,15 @@ void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
 	chain->ips[0] = context;
 	chain->ips[1] = ip;
 
-	if (!thread || !thread->ts) {
+	if (!ts) {
 		chain->nr = 2;
 		return;
 	}
 
 	last_context = context;
 
-	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
-		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
+	for (i = 2, j = 1; i < sz && j <= ts->cnt; i++, j++) {
+		ip = ts->stack[ts->cnt - j].ret_addr;
 		context = callchain_context(ip, kernel_start);
 		if (context != last_context) {
 			if (i >= sz - 1)
@@ -449,7 +554,7 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 	return 1;
 }
 
-static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
+static int thread_stack__bottom(struct thread_stack *ts,
 				struct perf_sample *sample,
 				struct addr_location *from_al,
 				struct addr_location *to_al, u64 ref)
@@ -474,7 +579,7 @@ static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
 	if (!cp)
 		return -ENOMEM;
 
-	return thread_stack__push_cp(thread->ts, ip, sample->time, ref, cp,
+	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
 				     true, false);
 }
 
@@ -590,24 +695,19 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			  struct addr_location *to_al, u64 ref,
 			  struct call_return_processor *crp)
 {
-	struct thread_stack *ts = thread->ts;
+	struct thread_stack *ts = thread__stack(thread, sample->cpu);
 	int err = 0;
 
-	if (ts) {
-		if (!ts->crp) {
-			/* Supersede thread_stack__event() */
-			thread_stack__free(thread);
-			thread->ts = thread_stack__new(thread, crp);
-			if (!thread->ts)
-				return -ENOMEM;
-			ts = thread->ts;
-			ts->comm = comm;
-		}
-	} else {
-		thread->ts = thread_stack__new(thread, crp);
-		if (!thread->ts)
+	if (ts && !ts->crp) {
+		/* Supersede thread_stack__event() */
+		thread_stack__reset(thread, ts);
+		ts = NULL;
+	}
+
+	if (!ts) {
+		ts = thread_stack__new(thread, sample->cpu, crp);
+		if (!ts)
 			return -ENOMEM;
-		ts = thread->ts;
 		ts->comm = comm;
 	}
 
@@ -621,8 +721,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	/* If the stack is empty, put the current symbol on the stack */
 	if (!ts->cnt) {
-		err = thread_stack__bottom(thread, ts, sample, from_al, to_al,
-					   ref);
+		err = thread_stack__bottom(ts, sample, from_al, to_al, ref);
 		if (err)
 			return err;
 	}
@@ -671,9 +770,11 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	return err;
 }
 
-size_t thread_stack__depth(struct thread *thread)
+size_t thread_stack__depth(struct thread *thread, int cpu)
 {
-	if (!thread->ts)
+	struct thread_stack *ts = thread__stack(thread, cpu);
+
+	if (!ts)
 		return 0;
-	return thread->ts->cnt;
+	return ts->cnt;
 }
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index f97c00a8c251..1f626f4a1c40 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -80,14 +80,14 @@ struct call_return_processor {
 	void *data;
 };
 
-int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
+int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr);
-void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr);
-void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
+void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr);
+void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
-size_t thread_stack__depth(struct thread *thread);
+size_t thread_stack__depth(struct thread *thread, int cpu);
 
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, void *data),
diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 2ab25aa38263..1598b4fa0b11 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -9,13 +9,13 @@ ifeq ("$(origin O)", "command line")
 endif
 
 turbostat : turbostat.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
-CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index f4534fb8b951..ae7a0e09b722 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -9,12 +9,12 @@ ifeq ("$(origin O)", "command line")
 endif
 
 x86_energy_perf_policy : x86_energy_perf_policy.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 735a510230c3..89a2444c1df2 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,13 +6,13 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= -O1 ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
-CFLAGS+= $(call cc-option,-fstack-protector)
+override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
 PKG_CONFIG?= pkg-config
 
-CFLAGS+=-D VERSION=\"$(VERSION)\"
+override CFLAGS+=-D VERSION=\"$(VERSION)\"
 LDFLAGS+=
 TARGET=tmon
 
@@ -29,7 +29,7 @@ TMON_LIBS += $(shell $(PKG_CONFIG) --libs $(STATIC) panelw ncursesw 2> /dev/null
 		     $(PKG_CONFIG) --libs $(STATIC) panel ncurses 2> /dev/null || \
 		     echo -lpanel -lncurses)
 
-CFLAGS    += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
+override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
 		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
