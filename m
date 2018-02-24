Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519463211; cv=none;
        d=google.com; s=arc-20160816;
        b=JGoZlK4tJaf1B8B91I/CmuvEIvp65F9IXl5fsXa8CL37fNYpyIQ4FxfmnjrEknZxVe
         VsEpn+YmeDOP92H7ANPNbVze+q2Svmxho3N4jfSb/PYS1alfy3u7TeP9G+YKrrhbZfQt
         LiTiNl/R2rr4hWT9LlDt2jenVmyIUpHU/1lexGjOix/rkdi7m8m7LWCmGIyPv+Oc2744
         13DP/2Z2mTRqQ7vwh36+QU8IUIqLNH4MAcFiDim9U66HZ2/Io92zh1s/i1vGIqdXcD6K
         AmhvjHYy83/mRrlbY7620Qs29QUnrPSpiNnkHDlLtLL9uBv639mA1rEdrYGWAIqcgBtM
         sccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=LP5vT9cCpg6YzGH1eTt5FVOkzN8tYUfBCFV3S0vjEsA=;
        b=u/xjwlD8Od+kfyhlSUuaWa0qmB+ZlISxfBesB5ZtXecYTBeK1VVlYTYIhqwakYvQQQ
         hdMJYkwt4E6kky3ZBS37buSjf7IFe9u/bJrtcDfjxYhEY93uUUJ/QZOh5KX/mjTV485R
         YtKUG34plIkzI9CzBvk1RckgPByYxl/79lpbLQD/Kl45Pnf1RUUlgzE/uUrS1fqsR1zT
         8SDR3umJ5DIVQh8142ByAJ2X4M5kN8H1rHBJoSbKBtg4eGfccZo076et3q6ILL970DMt
         fMYSrn6GlSSY96zvxtAsov23nEHB8TroY6Jazj+IOIUT9a7EPgcFYotS2IsGw0h37ccE
         subw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jd11Bfx8;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jd11Bfx8;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227SwDeQp7PQG7GQBQGLP31p/LNEpLDTeO2kSI6sHiG0NnuUcWOha24Q+biAtYp5kMW502souQ==
Date: Sat, 24 Feb 2018 14:36:45 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] char/ipmi: add documentation for sysfs interface
Message-ID: <20180224090645.GA15344@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593272656676320677?=
X-GMAIL-MSGID: =?utf-8?q?1593272656676320677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an attempt to document the sysfs interface for the IPMI drivers.
Descriptions were collected from v2.0 of the IPMI specification and from
code comments.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-devices-platform-ipmi        | 238 +++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-ipmi

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ipmi b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
new file mode 100644
index 000000000000..2a781e7513b7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
@@ -0,0 +1,238 @@
+What:		/sys/devices/platform/ipmi_bmc.*/firmware_revision
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) The major and minor revision of the firmware.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/aux_firmware_revision
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Holds additional information about the firmware revision,
+		such as boot block or internal data structure version numbers.
+		The meanings of the numbers are specific to the vendor
+		identified by Manufacturer ID.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/revision
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Device revision. Useful for identifying if significant
+		hardware changes have been made to the implementation of the
+		management controller.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/provides_device_sdrs
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Indicates whether device provides device sensor data
+		records (1) or not (0).
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/device_id
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Device id is specified by the manufacturer identified by
+		the Manufacturer ID field. This field allows controller specific
+		software to identify the unique application command, OEM
+		fields, and functionality that are provided by the controller
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/additional_device_support
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Lists the IPMI ‘logical device’ commands and functions
+		that the controller supports that are in addition to the
+		mandatory IPM and Application commands.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/ipmi_version
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Displays the IPMI Command Specification Version.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/manufacturer_id
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Identifies the manufacturer responsible for the
+		specification of functionality of the vendor (OEM)-specific
+		commands, codes, and interfaces used in the controller.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/product_id
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Displays a number that identifies a particular system,
+		module, add-in card, or board set. The number is specified
+		according to the manufacturer given by Manufacturer ID.
+
+For detailed definitions of the above attributes, refer to section 20.1 'Get
+Device ID Command' of the IPMI specification v2.0.
+
+
+What:		/sys/devices/platform/ipmi_bmc.*/guid
+Date:		Mar, 2006
+KernelVersion:	v2.6.17
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) A GUID (Globally Unique ID), also referred to as a UUID
+		(Universally Unique Identifier), for the management controller,
+		as described in section 20.8 'Get Device GUID Command' of the
+		IPMI specification v2.0.
+
+
+What:		/sys/devices/platform/ipmi_si.*/type
+Date:		Sep, 2017
+KernelVersion:	v4.15
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) The device interface for IPMI "kcs", "smic", "bt" or
+		"invalid"
+
+What:		/sys/devices/platform/ipmi_si.*/idles
+What:		/sys/devices/platform/ipmi_si.*/watchdog_pretimeouts
+What:		/sys/devices/platform/ipmi_si.*/complete_transactions
+What:		/sys/devices/platform/ipmi_si.*/events
+What:		/sys/devices/platform/ipmi_si.*/interrupts
+What:		/sys/devices/platform/ipmi_si.*/hosed_count
+What:		/sys/devices/platform/ipmi_si.*/long_timeouts
+What:		/sys/devices/platform/ipmi_si.*/flag_fetches
+What:		/sys/devices/platform/ipmi_si.*/attentions
+What:		/sys/devices/platform/ipmi_si.*/incoming_messages
+What:		/sys/devices/platform/ipmi_si.*/short_timeouts
+Date:		Sep, 2017
+KernelVersion:	v4.15
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+
+		idles:			(RO) Number of times the interface was
+					idle while being polled.
+
+		watchdog_pretimeouts:	(RO) Number of watchdog pretimeouts.
+
+		complete_transactions:	(RO) Number of completed messages.
+
+		events:			(RO) Number of IPMI events received from
+					the hardware.
+
+		interrupts:		(RO) Number of interrupts the driver
+					handled.
+
+		hosed_count:		(RO) Number of times the hardware didn't
+					follow the state machine.
+
+		long_timeouts:		(RO) Number of times the driver
+					requested a timer while nothing was in
+					progress.
+
+		flag_fetches:		(RO) Number of times the driver
+					requested flags from the hardware.
+
+		attentions:		(RO) Number of time the driver got an
+					ATTN from the hardware.
+
+		incoming_messages:	(RO) Number of asynchronous messages
+					received.
+
+		short_timeouts:		(RO) Number of times the driver
+					requested a timer while an operation was
+					in progress.
+
+
+What:		/sys/devices/platform/ipmi_si.*/interrupts_enabled
+Date:		Sep, 2017
+KernelVersion:	v4.15
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Indicates whether interrupts are enabled or not. The driver
+		disables interrupts when it gets into a situation where it
+		cannot handle messages due to lack of memory. Once that
+		situation clears up, it will re-enable interrupts.
+
+
+What:		/sys/devices/platform/ipmi_si.*/params
+Date:		Sep, 2017
+KernelVersion:	v4.15
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		[to be documented]
+
+
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/type
+Date:		Sep, 2017
+KernelVersion:	v4.15
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		(RO) Shows the IMPI device interface type - "ssif" here.
+
+
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/hosed
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/alerts
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/sent_messages
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/sent_messages_parts
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/received_messages
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/received_message_parts
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/events
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/watchdog_pretimeouts
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/flag_fetches
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/send_retries
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/receive_retries
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/send_errors
+What:		/sys/devices/platform/dmi-ipmi-ssif.*/receive_errors
+Date:		Sep, 2017
+KernelVersion:	v4.15
+Contact:	openipmi-developer@lists.sourceforge.net
+Description:
+		hosed:			(RO) Number of times the hardware didn't
+					follow the state machine.
+
+		alerts:			(RO) Number of alerts received.
+
+		sent_messages:		(RO) Number of total messages sent.
+
+		sent_message_parts:	(RO) Number of message parts sent.
+					Messages may be broken into parts if
+					they are long.
+
+		receieved_messages:	(RO) Number of message responses
+					received.
+
+		received_message_parts: (RO) Number of message fragments
+					received.
+
+		events:			(RO) Number of received events.
+
+		watchdog_pretimeouts:	(RO) Number of watchdog pretimeouts.
+
+		flag_fetches:		(RO) Number of times a flag fetch was
+					requested.
+
+		send_retries:		(RO) Number of time a message was
+					retried.
+
+		receive_retries:	(RO) Number of times the receive of a
+					message was retried.
+
+		send_errors:		(RO) Number of times the send of a
+					message failed.
+
+		receive_errors:		(RO) Number of errors in receiving
+					messages.
-- 
2.16.2
