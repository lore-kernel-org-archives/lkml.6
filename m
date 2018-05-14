Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314852-2-7873535097767863809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314851; b=QBInk0AcGnxaRRu6zISly4qWWPdw/hFIAORsBLVZFsrKajlHla
    xtO6Q1noW0RAq9am8xU9qb1OwnR6ektCiKcbij/yrpmAr22FVa8i8yMdpDofv9hD
    Izhyewm4l9D9oHvSITXHNfwwrjzAqrsNowtY1sa8gQ9H1IIL8Sk9xfilAfs85Q+U
    dc/uaZvgHVJE3XhKmpFI8SYHg+K51fz0dkRP2aTvi4TOb95dEfZyYo/1yBwg3KRd
    gS+SUHJInJmXYCxDeGCKvtH7f3moVcIe0s+NP2sGxPL4WTRh1yOVkpnhAbg0S67v
    CfwEU2pXRAdUCZfbB2cbahncMCb0/jnOsQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526314851; bh=
    74N4bAPS8Dbz892Bk0iuympdeQ9jAeB9TjBgjKfueLM=; b=O4z1CnPWgxVqhV31
    FuEnB59rwUUKhSibKeneMZxAAg+8573MV9JUHQ/ot1fFdabWpK3DIuM25lATdEJH
    eFvzxA4ZlWqPiWIYS1VO92PSn6uCIIV7JH14oy3OlgXmQFflkcj5eB00pfu5XkRG
    y84Q1VbqFK4Btg9OeTCg4XU+bI3aF7iD+esI5kCRuYoJSw4UGtE2YfaIdWBa1g7H
    WDkeAGl4pYneXtR0hltxl/BP2YUuyaJUKSRw3OOpM4xEYNHfsslgIVv9AptOa0YS
    GXxFnBj1wbbQuSjjJr6Xp7l0WHmH2eSPw+NMiCuA6UQkvammBucIhROunZtIBOq7
    /MeSPw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mellanox.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mellanox.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMalq905gi7cLR2VZ3VtHB6PnxPMPx13rBNbRG9fujtCqpDbFzeidGqSIQ5ly93A6PP11Cx0lCQMPYr9RTcZ6hX9NKys76yr5I5UEeH/jXvfKPJ+w31g
    ZjfDMPWg7QrUNp5IYgBFTziB65EWZG7A6QCp4Z1mAqymldd+MaW4B9QtMrNNWfZ3/QYD9xrjqGRPtjppLnKgR7UMN/X33bvfjJgt6zlLMf6MUTw4G+325xIr
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=CbDCq_QkAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=9G363b7KqlRuhU7PzZcA:9
    a=hrTgYwi5xKA-A2YF:21 a=MftaiI-O0s-Klqi-:21 a=NHPAMD8d11cA:10
    a=x8gzFH9gYPwA:10 a=1qrBK16LubpBFNPVNq2M:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbeENQUO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:20:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39833 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754880AbeENQUL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 12:20:11 -0400
From: Oleksandr Shamray <oleksandrs@mellanox.com>
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org,
        Oleksandr Shamray <oleksandrs@mellanox.com>
Subject: [patch v20 4/4] Documentation: jtag: Add ABI documentation
Date: Mon, 14 May 2018 19:20:03 +0300
Message-Id: <1526314803-3532-5-git-send-email-oleksandrs@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
References: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added document that describe the ABI for JTAG class drivrer

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v19->v20
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Fix JTAG doccumentation

v18->v19
Pavel Machek <pavel@ucw.cz>
- Added JTAG doccumentation to Documentation/jtag

v17->v18
v16->v17
v15->v16
v14->v15
v13->v14
v12->v13
v11->v12
Tobias Klauser <tklauser@distanz.ch>
- rename /Documentation/ABI/testing/jatg-dev -> jtag-dev
- Typo: s/interfase/interface
v10->v11
v9->v10
Fixes added by Oleksandr:
- change jtag-cdev to jtag-dev in documentation
- update Kernel Version and Date in jtag-dev documentation;
v8->v9
v7->v8
v6->v7
Comments pointed by Pavel Machek <pavel@ucw.cz>
- Added jtag-cdev documentation to Documentation/ABI/testing folder
---
 Documentation/ABI/testing/jtag-dev |   27 +++++++++
 Documentation/jtag/overview        |   28 +++++++++
 Documentation/jtag/transactions    |  109 ++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/jtag-dev
 create mode 100644 Documentation/jtag/overview
 create mode 100644 Documentation/jtag/transactions

diff --git a/Documentation/ABI/testing/jtag-dev b/Documentation/ABI/testing/jtag-dev
new file mode 100644
index 0000000..4325316
--- /dev/null
+++ b/Documentation/ABI/testing/jtag-dev
@@ -0,0 +1,27 @@
+What:		/dev/jtag[0-9]+
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	oleksandrs@mellanox.com
+Description:
+		The misc device files /dev/jtag* are the interface
+		between JTAG master interface and userspace.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include/uapi]<linux/jtag.h>.
+
+		The following file operations are supported:
+
+		open(2)
+		The argument flag currently support only one access
+		mode O_RDWR.
+
+		ioctl(2)
+		Initiate various actions.
+		See the inline documentation in [include/uapi]<linux/jtag.h>
+		for descriptions of all ioctls.
+
+		close(2)
+		Stops and free up the I/O contexts that was associated
+		with the file descriptor.
+
+Users:		TBD
diff --git a/Documentation/jtag/overview b/Documentation/jtag/overview
new file mode 100644
index 0000000..a86f188
--- /dev/null
+++ b/Documentation/jtag/overview
@@ -0,0 +1,28 @@
+Linux kernel JTAG support
+=========================
+
+The JTAG is an industry standard for verifying hardware
+JTAG provides access to many logic signals of a complex integrated circuit,
+including the device pins.
+
+A JTAG interface is a special interface added to a chip.
+Depending on the version of JTAG, two, four, or five pins are added.
+
+The connector pins are:
+	TDI (Test Data In)
+	TDO (Test Data Out)
+	TCK (Test Clock)
+	TMS (Test Mode Select)
+	TRST (Test Reset) optional.
+
+JTAG interface is designed to have two parts - basic core driver and
+hardware specific driver. The basic driver introduces a general interface
+which is not dependent of specific hardware. It provides communication
+between user space and hardware specific driver.
+Each JTAG device is represented as a char device from (jtag0, jtag1, ...).
+Access to a JTAG device is performed through IOCTL calls.
+
+Call flow example:
+User: open  -> /dev/jatgX
+User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hw specific driver
+User: close -> /dev/jatgX
diff --git a/Documentation/jtag/transactions b/Documentation/jtag/transactions
new file mode 100644
index 0000000..6a857c8
--- /dev/null
+++ b/Documentation/jtag/transactions
@@ -0,0 +1,109 @@
+The JTAG API
+=============
+
+JTAG master devices can be accessed through a character misc-device.
+Each JTAG master interface can be accessed by using /dev/jtagN
+
+JTAG system calls set:
+- SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
+- SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
+- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
+number of clocks.
+
+open(), close()
+-------
+open() opens JTAG device. Only one open operation per JTAG device
+can be performed. Two or more open for one device will return error
+
+Open/Close  device:
+- open("/dev/jtag0", O_RDWR);
+- close(jtag_fd');
+
+ioctl()
+-------
+All access operations to JTAG devices performed through ioctl interface.
+The IOCTL interface supports this requests:
+	JTAG_IOCRUNTEST - Force JTAG state machine to RUN_TEST/IDLE state
+	JTAG_SIOCFREQ - Set JTAG TCK frequency
+	JTAG_GIOCFREQ - Get JTAG TCK frequency
+	JTAG_IOCXFER - send JTAG data Xfer
+	JTAG_GIOCSTATUS - get current JTAG TAP status
+	JTAG_SIOCMODE - set JTAG mode flags.
+
+JTAG_SIOCFREQ, JTAG_GIOCFREQ
+------
+Set/Get JTAG clock speed:
+
+	unsigned int jtag_fd;
+	ioctl(jtag_fd, JTAG_SIOCFREQ, &frq);
+	ioctl(jtag_fd, JTAG_GIOCFREQ, &frq);
+
+JTAG_IOCRUNTEST
+------
+Force JTAG state machine to RUN_TEST/IDLE state
+
+struct jtag_run_test_idle {
+	__u8	reset;
+	__u8	endstate;
+	__u8	tck;
+};
+
+reset: 0 - run IDLE/PAUSE from current state
+	   1 - go through TEST_LOGIC/RESET state before  IDLE/PAUSE
+endstate: completion flag
+tck: clock counter
+
+Example:
+	struct jtag_run_test_idle runtest;
+
+	runtest.endstate = JTAG_STATE_IDLE;
+	runtest.reset = 0;
+	runtest.tck = data_p->tck;
+	usleep(25 * 1000);
+	ioctl(jtag_fd, JTAG_IOCRUNTEST, &runtest);
+
+JTAG_IOCXFER
+------
+Send SDR/SIR transaction
+
+struct jtag_xfer {
+	__u8	type;
+	__u8	direction;
+	__u8	endstate;
+	__u8	padding;
+	__u32	length;
+	__u64	tdio;
+};
+
+type: transfer type - JTAG_SIR_XFER/JTAG_SDR_XFER
+direction: xfer direction - JTAG_SIR_XFER/JTAG_SDR_XFER,
+length: xfer data len in bits
+tdio : xfer data array
+endstate: xfer end state after transaction finish
+	   can be: JTAG_STATE_IDLE/JTAG_STATE_PAUSEIR/JTAG_STATE_PAUSEDR
+
+Example:
+	struct jtag_xfer xfer;
+	static char buf[64];
+	static unsigned int buf_len = 0;
+	[...]
+	xfer.type = JTAG_SDR_XFER;
+	xfer.tdio = (__u64)buf;
+	xfer.length = buf_len;
+	xfer.endstate = JTAG_STATE_IDLE;
+
+	if (is_read)
+		xfer.direction = JTAG_READ_XFER;
+	else
+		xfer.direction = JTAG_WRITE_XFER;
+
+	ioctl(jtag_fd, JTAG_IOCXFER, &xfer);
+
+JTAG_SIOCMODE
+------
+If hw driver can support different running modes you can change it.
+
+Example:
+	unsigned int mode;
+	mode = JTAG_XFER_HW_MODE;
+	ioctl(jtag_fd, JTAG_SIOCMODE, &mode);
-- 
1.7.1

