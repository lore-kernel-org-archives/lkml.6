Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF452668D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxONe6fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF452668D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeFZIO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:14:56 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36485 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeFZIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:14:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so16671129lfh.3;
        Tue, 26 Jun 2018 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sXg7Ly2hHNzrjG5wNU8iGTxdYK3Jbxx11AygjgUXt8Q=;
        b=WxONe6fSNL2QHiTFVxgce2YWb1QWVYEZZUH/YAoC0pjPJMicdjdm0w1cGSsbxxG7Xg
         KCE38hrwUSWFMs6mTf0yegrNzrdLvy2MbLDBxVNjmKbwHefIzBSkxTC56I3ycrvy6Mw9
         uf7GVw7wZNuJPlnM2XjaAJtipFLRsPQg9naSy210cUt7CxRzmU8ZPLhkikHrBcKyHunb
         jo8ALOE5WXObqs4T7OZb20PTh0bztgdHN5+IHRSKSVm8wrWil2SHVlaC2SljObms1PdV
         Ffy8qDqFdct72IsLpvVLIH705dl6AGYDJBSzjgUaBxwOaqlugcC6wg+decrLh/4Zg9qn
         TJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXg7Ly2hHNzrjG5wNU8iGTxdYK3Jbxx11AygjgUXt8Q=;
        b=UWZxZFy8nJZy9t9vaBrPniECe4jz/eKo8+19DLNOXNCTFYai604U4ScLH0yC0g3lKW
         m/K3MhKsxLClVKs2IZQFzuJ1viLV37X9LEe3vrYyH0sXFk8/JlOqoDLs9GmDa+xGyaqI
         dDqfAXk6d0Bj5hX3/deml5tPXkmtq/0qHXRpfFT7HeLX0bGbux2I6qKPMTpiyGN52q2g
         dKAjCGyS713mg65M7hDkjCuwHO/y0hVUr2ZXHnfmT/2GE08LW8/KbivRC8TPw8A7FpeH
         R6uSjPinnDLmWOOyR1SQ2qf6tkrQ/Np+zNoTHXMlHyfdhRwrOaMATP+7IXJn9ah8F8YZ
         tRSw==
X-Gm-Message-State: APt69E2a2vExzErV2S/QgwF8qkpxFpkk12zg1gNVe8QH2+ro2YBTiEJ6
        7aat02JvWREgmD98MpYrReZS4raD
X-Google-Smtp-Source: AAOMgpecrbBmmf3HU09l+jPeodNEKHWpiK4lt0na4At8d6Fltjz/vyqWDDtin6/5nErhMVa3n06l/g==
X-Received: by 2002:a19:cb12:: with SMTP id b18-v6mr455907lfg.64.1530000880743;
        Tue, 26 Jun 2018 01:14:40 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26030-74736162.cust.telenor.se. [46.194.96.48])
        by smtp.gmail.com with ESMTPSA id p28-v6sm149783lja.13.2018.06.26.01.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:14:39 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v4 2/3] Documentation: usb: add documentation for USB CCID Gadget Device
Date:   Tue, 26 Jun 2018 10:14:21 +0200
Message-Id: <20180626081422.19237-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626081422.19237-1-marcus.folkesson@gmail.com>
References: <20180626081422.19237-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to give a brief description on how to use the
CCID Gadget Device.
This includes a description for all attributes followed by an example on
how to setup the device with ConfigFS.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
    	- clarify how to use /dev/ccidg and BULK endpoind (thanks Randy)
    v3:
    	- correct the grammer (thanks Randy)
    v2:
    	- add the missing changelog text

 Documentation/usb/gadget_ccid.rst | 269 ++++++++++++++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 Documentation/usb/gadget_ccid.rst

diff --git a/Documentation/usb/gadget_ccid.rst b/Documentation/usb/gadget_ccid.rst
new file mode 100644
index 000000000000..c8f25080c9e7
--- /dev/null
+++ b/Documentation/usb/gadget_ccid.rst
@@ -0,0 +1,269 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+CCID Gadget
+============
+
+:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
+
+Introduction
+============
+
+The CCID Gadget will present itself as a CCID device to the host system.
+The device supports two endpoints for now; BULK IN and BULK OUT.
+These endpoints are exposed to userspace via /dev/ccidgX where `X` is
+the device enumeration number.
+Use read(2) and write(3) to operate on BULK_IN and BULK_OUT respectively.
+
+All CCID commands are sent on the BULK-OUT endpoint. Each command sent to the CCID
+has an associated ending response. Some commands can also have intermediate
+responses. The response is sent on the BULK-IN endpoint.
+See Figure 3-3 in the CCID Specification [1]_ for more details.
+
+The CCID commands must be handled in userspace since the driver is only working
+as a transport layer for the TPDUs.
+
+
+CCID Commands
+--------------
+
+All CCID commands begins with a 10-byte header followed by an optional
+data field depending on message type.
+
++--------+--------------+-------+----------------------------------+
+| Offset | Field        | Size  | Description                      |
++========+==============+=======+==================================+
+| 0      | bMessageType | 1     | Type of message                  |
++--------+--------------+-------+----------------------------------+
+| 1      | dwLength     | 4     | Message specific data length     |
+|        |              |       |                                  |
++--------+--------------+-------+----------------------------------+
+| 5      | bSlot        | 1     | Identifies the slot number       |
+|        |              |       | for this command                 |
++--------+--------------+-------+----------------------------------+
+| 6      | bSeq         | 1     | Sequence number for command      |
++--------+--------------+-------+----------------------------------+
+| 7      | ...          | 3     | Fields depends on message type   |
++--------+--------------+-------+----------------------------------+
+| 10     | abData       | array | Message specific data (OPTIONAL) |
++--------+--------------+-------+----------------------------------+
+
+
+Multiple CCID gadgets
+----------------------
+
+It is possible to create multiple instances of the CCID gadget, however,
+a much more flexible way is to create one gadget and set the `nslots` attribute
+to the number of desired CCID devices.
+
+All CCID commands specify which slot is the receiver in the `bSlot` field
+of the CCID header.
+
+Usage
+=====
+
+Access from userspace
+----------------------
+All communication is by read(2) and write(2) to the corresponding /dev/ccidg* device.
+Only one file descriptor is allowed to be open to the device at a time.
+
+The buffer size provided to read(2) **must be at least** 522 (10 bytes header + 512 bytes payload)
+bytes as we are working with whole commands.
+
+The buffer size provided to write(2) **may not exceed** 522 (10 bytes header + 512 bytes payload)
+bytes as we are working with whole commands.
+
+
+Configuration with configfs
+----------------------------
+
+ConfigFS is used to create and configure the CCID gadget.
+In order to get a device to work as intended, a few attributes must
+be considered.
+
+The attributes are described below followed by an example.
+
+features
+~~~~~~~~~
+
+The `feature` attribute writes to the dwFeatures field in the class descriptor.
+See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
+
+The value indicates what intelligent features the CCID has.
+These values are available to user application as defined in ccid.h [2]_.
+The default value is 0x00000000.
+
+The value is a bitwise OR operation performed on the following values:
+
++------------+----------------------------------------------------------------+
+| Value      | Description                                                    |
++============+================================================================+
+| 0x00000000 | No special characteristics                                     |
++------------+----------------------------------------------------------------+
+| 0x00000002 | Automatic parameter configuration based on ATR data            |
++------------+----------------------------------------------------------------+
+| 0x00000004 | Automatic activation of ICC on inserting                       |
++------------+----------------------------------------------------------------+
+| 0x00000008 | Automatic ICC voltage selection                                |
++------------+----------------------------------------------------------------+
+| 0x00000010 | Automatic ICC clock frequency change according to active       |
+|            | parameters provided by the Host or self determined             |
++------------+----------------------------------------------------------------+
+| 0x00000020 | Automatic baud rate change according to active                 |
+|            | parameters provided by the Host or self determined             |
++------------+----------------------------------------------------------------+
+| 0x00000040 | Automatic parameters negotiation made by the CCID              |
++------------+----------------------------------------------------------------+
+| 0x00000080 | Automatic PPS made by the CCID according to the                |
+|            | active parameters                                              |
++------------+----------------------------------------------------------------+
+| 0x00000100 | CCID can set ICC in clock stop mode                            |
++------------+----------------------------------------------------------------+
+| 0x00000200 | NAD value other than 00 accepted (T=1 protocol in use)         |
++------------+----------------------------------------------------------------+
+| 0x00000400 | Automatic IFSD exchange as first exchange                      |
++------------+----------------------------------------------------------------+
+
+
+Only one of the following values may be present to select a level of exchange:
+
++------------+--------------------------------------------------+
+| Value      | Description                                      |
++============+==================================================+
+| 0x00010000 | TPDU level exchanges with CCID                   |
++------------+--------------------------------------------------+
+| 0x00020000 | Short APDU level exchange with CCID              |
++------------+--------------------------------------------------+
+| 0x00040000 | Short and Extended APDU level exchange with CCID |
++------------+--------------------------------------------------+
+
+If none of those values is indicated the level of exchange is
+character.
+
+
+protocols
+~~~~~~~~~~
+The `protocols` attribute writes to the dwProtocols field in the class descriptor.
+See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
+
+The value is a bitwise OR operation performed on the following values:
+
++--------+--------------+
+| Value  | Description  |
++========+==============+
+| 0x0001 | Protocol T=0 |
++--------+--------------+
+| 0x0002 | Protocol T=1 |
++--------+--------------+
+
+If no protocol is selected both T=0 and T=1 will be supported (`protocols` = 0x0003).
+
+nslots
+~~~~~~
+
+The `nslots` attribute writes to the bMaxSlotIndex field in the class descriptor.
+See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
+
+This is the index of the highest available slot on this device. All slots are consecutive starting at 00h.
+i.e. 0Fh = 16 slots on this device numbered 00h to 0Fh.
+
+The default value is 0, which means one slot.
+
+
+pinsupport
+~~~~~~~~~~~~
+
+This value indicates what PIN support features the CCID has.
+
+The `pinsupport` attribute writes to the dwPINSupport field in the class descriptor.
+See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
+
+
+The value is a bitwise OR operation performed on the following values:
+
++--------+----------------------------+
+| Value  | Description                |
++========+============================+
+| 0x00   | No PIN support             |
++--------+----------------------------+
+| 0x01   | PIN Verification supported |
++--------+----------------------------+
+| 0x02   | PIN Modification supported |
++--------+----------------------------+
+
+The default value is set to 0x00.
+
+
+lcdlayout
+~~~~~~~~~~
+
+Number of lines and characters for the LCD display used to send messages for PIN entry.
+
+The `lcdLayout` attribute writes to the wLcdLayout field in the class descriptor.
+See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
+
+
+The value is set as follows:
+
++--------+------------------------------------+
+| Value  | Description                        |
++========+====================================+
+| 0x0000 | No LCD                             |
++--------+------------------------------------+
+| 0xXXYY | XX: number of lines                |
+|        | YY: number of characters per line. |
++--------+------------------------------------+
+
+The default value is set to 0x0000.
+
+
+Example
+-------
+
+Here is an example on how to setup a CCID gadget with configfs ::
+
+    #!/bin/sh
+
+    CONFIGDIR=/sys/kernel/config
+    GADGET=$CONFIGDIR/usb_gadget/g0
+    FUNCTION=$GADGET/functions/ccid.sc0
+
+    VID=YOUR_VENDOR_ID_HERE
+    PID=YOUR_PRODUCT_ID_HERE
+    UDC=YOUR_UDC_HERE
+
+    #Mount filesystem
+    mount none -t configfs $CONFIGDIR
+
+    #Populate ID:s
+    echo $VID > $GADGET/idVendor
+    echo $PID > $GADGET/idProduct
+
+    #Create and configure the gadget
+    mkdir $FUNCTION
+    echo 0x000407B8 > $FUNCTION/features
+    echo 0x02 > $FUNCTION/protocols
+
+    #Create our English strings
+    mkdir  $GADGET/strings/0x409
+    echo 556677 > $GADGET/strings/0x409/serialnumber
+    echo "Hungry Penguins" > $GADGET/strings/0x409/manufacturer
+    echo "Harpoon With Smart Card"  > $GADGET/strings/0x409/product
+
+    #Create configuration
+    mkdir  $GADGET/configs/c.1
+    mkdir  $GADGET/configs/c.1/strings/0x409
+    echo Config1 > $GADGET/configs/c.1/strings/0x409/configuration
+
+    #Use `Config1` for our CCID gadget
+    ln -s $FUNCTION $GADGET/configs/c.1
+
+    #Execute
+    echo $UDC > $GADGET/UDC
+
+
+References
+==========
+
+.. [1] http://www.usb.org/developers/docs/devclass_docs/DWG_Smart-Card_CCID_Rev110.pdf
+.. [2] include/uapi/linux/usb/ccid.h
-- 
2.18.0

