Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9C7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B3D208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gUcOAmON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/9yt1yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B3D208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeGKFex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:34:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36209 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbeGKFew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:34:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 013E621BBE;
        Wed, 11 Jul 2018 01:32:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 11 Jul 2018 01:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OMzzKkzvJhU26U+FL
        wTI6IoolzQTUk0Pg5+SGKYtbdc=; b=gUcOAmON0FQS70uL3J+CzNCeu+9Jd8u+y
        q/jjf19ZQn3xvUb8M61l7wam5suPOYENWhK8XiVf4tSVfKfvm7d4kVsCAl1YFfOO
        Rx6t9uvxss2VeqxX4+QUwrTFR1weJ/qD4bqEWHOGLQsE7Jv7RJvto6hG5VgnT4Sd
        24KFtIJeSMDXkmTmrAqhCYPf5bMY+GHT/sWoYpIZruBvFpA9xEvvr2hHVvOAK7Hl
        iInKOrRqe4+SLLw2lPUAZ23nSu4KKRZXmVnGWjQyzHm15UJKgOwM61ywxZbVyE+L
        WH6t+ycTJWWs3MH2QQ7g9SR4iLWzyfjbLwKBOLu39rBX8P58RUBuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=OMzzKkzvJhU26U+FLwTI6IoolzQTUk0Pg5+SGKYtbdc=; b=b/9yt1yh
        +IH+pV/x/MNuiYfIwf6maGjUhmm8lds6OQstb1KCgCMh5xVpeN5tKHGtCpeRD6xv
        wI1XV6hHF4Q/umKO2E2p64q2pX8/lpI6O8nUlnmo1uCdizTt8T4FiSQDga/JFxQ3
        R4yXCLdiGG4Azi5GRgaHiCYM/JBxHB5KVdPTwYondTFkk6bpO3qeJygINCsn34ga
        nrMq5DzOZH8XEEKZJ4qgfZfWUgEIf3WdlD0iaEV2CnGdroQZBHgDvMpWQt5r4/Sd
        xkzhG3rjHv/umFev4LF4TXIHyUQqj5eFBSHuSE5SryTsMUYV5amb2IiFW1OGBD1H
        qc/5QBAEjCyGyg==
X-ME-Proxy: <xmx:ZJZFWyEroEJy9TJKA16w7Ca67InjFxuKfF0RnwIpQthHxxpaKwzjMQ>
    <xmx:ZJZFW6sfmw5Z1QDT0DCS6WgCnhz3SsBJwEZsjuamcwhkVa6eiRq5ew>
    <xmx:ZJZFW1HsQl8KbBFHB4u9VNlDLVXar9O4Ir9u5L87Ot0Bfqh-Nf4SxA>
    <xmx:ZJZFW6vQKslmnQyky4uaZ1OqbvOs9cdal-bdfleDyI5gQ6LRcnG8kA>
    <xmx:ZJZFW1nWb5EzD_Zps_5CV1oWXyipgMHf4HYWsTuc9mhe9cFOLNWG7w>
    <xmx:ZJZFW_CYiIycs5rdvTKYaDh8Dg93pjMqdA7UUPaYPOdbASfiieWy-A>
X-ME-Sender: <xms:ZJZFW-sg5jkhEoC1lmLzWNcIg-5SN_F02SU1FkT2jWj3WGEvxKk1nA>
Received: from localhost.localdomain (ppp118-210-173-37.bras2.adl6.internode.on.net [118.210.173.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 604BDE45C9;
        Wed, 11 Jul 2018 01:32:16 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 2/4] Documentation: ABI: Add sysfs-devices-platform-field to testing
Date:   Wed, 11 Jul 2018 15:01:20 +0930
Message-Id: <20180711053122.30773-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711053122.30773-1-andrew@aj.id.au>
References: <20180711053122.30773-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Fields" expose control of hardware directly to userspace where
appropriate. Examples of expected use are single bit switches or other
small masks of registers where the range of values is entirely policy
driven and the field is not part of a larger, coherent design.

These fields can be from read-only, read-write or
write-1-set/write-1-clear register sets.

Using fields to control the behaviour of hardware local to the kernel
exposing them is likely incorrect. The use-case motivating the fields
feature is for Baseboard Management Controllers (BMCs) to expose policy
controls for booting and running their host systems.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since RFC v1:

* Describe a 'type' attribute that determines the behaviour of the remaining
  attributes
* Rework paths to point through /sys/devices/platform
* Add a description to the commit message

 .../ABI/testing/sysfs-devices-platform-field  | 95 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-field

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-field b/Documentation/ABI/testing/sysfs-devices-platform-field
new file mode 100644
index 000000000000..216481d8bc99
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-field
@@ -0,0 +1,95 @@
+This document defines the sysfs attributes provided by the bmc-misc-ctrl
+driver. See Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt for
+exhaustive list of field definitions.
+
+What:		/sys/devices/platform/.../<field>/<label>/label
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		An RO attribute providing the name of the field of interest.
+		Corresponds to the value of <label> in the path
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/type
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		An RO attribute describing the type of the field. The type
+		takes one of three values:
+
+		'ro':	The field is read-only. The 'value' attribute will be
+			read-only and neither 'set' nor 'clear' attributes will
+			be present.
+		'rw':	The field is read-write. The 'value' attribute will be
+			both readable and writable and neither 'set' nor
+			'clear' attributes will be present. Values written to
+			the 'value' attribute will be atomically updated.
+		'w1sc':	The field uses write-1-{set,clear} semantics. The
+			'value' attribute will be read-only, and both 'set' and
+			'clear' attributes will be present to manipulate
+			'value'. 'set' and 'clear' will both be write-only.
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/mask
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		An RO attribute providing the mask applied to the value
+		read/written from the 'value' attribute.
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/value
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		The value of the field of interest.
+
+		If the field is exposed from a read-modify-write register this
+		attribute will be RW, where writes will set the field to the
+		value written. Writing values that exceed the width of the
+		field will return an error.
+
+		If the field is exposed from a write-1-set/write-1-clear
+		register this attribute will be RO, and the attributes 'set'
+		and 'clear' will be present as write-only.
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/set
+Users:		openbmc@lists.ozlabs.org
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		A WO attribute that when written will set bits in the backing
+		register corresponding to set bits in the value written.
+		Register bits corresponding to cleared bits in the written
+		value will remain unchanged.
+
+		This attribute is exposed when the field is identified as being
+		composed of write-1-set and write-1-clear registers.
+
+		Writing values that exceed the width of the mask value will
+		return an error.
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/clear
+Users:		openbmc@lists.ozlabs.org
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		A WO attribute that when written will clear bits in the backing
+		register corresponding to set bits in the value written.
+		Register bits corresponding to cleared bits in the written
+		value will remain unchanged.
+
+		This attribute is exposed when the field is identified as being
+		composed of write-1-set and write-1-clear registers.
+
+		Writing values that exceed the width of the mask value will
+		return an error.
+Users:		openbmc@lists.ozlabs.org
diff --git a/MAINTAINERS b/MAINTAINERS
index fa2033a522f2..d167f0340c11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2741,6 +2741,7 @@ R:	Andrew Jeffery <andrew@aj.id.au>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
+F:	Documentation/ABI/testing/sysfs-devices-platform-field
 
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
-- 
2.17.1

