Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27FAC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A2624899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LzjnyPMN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPaobINV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A2624899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeGCHEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41515 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754599AbeGCHEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 900D421E76;
        Tue,  3 Jul 2018 03:04:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Jul 2018 03:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2Bi1DQGM6wLVyQtLI
        Ww/2fzCoBI8DeuVFPU6XvggWws=; b=LzjnyPMNHORPghz+WUjtREHW6qvnAD58T
        GrvW/aBR68Oml2SIqMxgaOP3ke9UoVz9L9ws8E8R6B7sudvLjsKMPcWG+B4fAKeG
        Vaf5saCrc6M/vL56z1NLbeMlqEOsXi5vxJgmrbGSI6YHopLUmmMHOL1weYkyOd22
        WvBATEzJ229qND1qrzEkoJ04xnuZQItF6Jl/UqXoMFzr0fHyXiT+OeU3mWwNmDfv
        eu8SBV/rnmwn+KXXabdXO23VyckwMEaCr99fc+gO1SFz9Z14+tDIVpS5AE+cJcDe
        TB31sUoOawa1FRtpoZF/EaN3RQJdi0CnaEw/fDeKXcyQ0sStQ6J6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2Bi1DQGM6wLVyQtLIWw/2fzCoBI8DeuVFPU6XvggWws=; b=XPaobINV
        WLNzQn1AnAQOX92oG0720hc/yJvTlbf3XUk0YMvDjo8v3pNByuNGFGY1K6N7mbmr
        qqN5+O/VS3AaSg6YhUaxVf7wxN8PXg1AcZerTtUtiVyaLKP5t+xVKfkXcfRYISgD
        +00KXAY6PwGjihMq6/F84c2o7ZN7iBpKpmUN0Bfk9gghUq35KF6YE2XzZlqpvd9l
        71nUvsVURINEapSdRMyZBpjhRJiGmTp5Xau9aEByQsnm6nkqd7+N1/lYYosGJiuc
        93/aSiihuYxaSeEy1KyXpdstCeQf9k8VooAmKeNfokBgaGHauBP5bEUuf8LaV1dC
        phBQSS3rdEKczg==
X-ME-Proxy: <xmx:DCA7WzpYht-ir_lPzG5wqxFnhIcLNDPBrJHPQpPJDWssBL2_psDO4A>
    <xmx:DCA7W7n1yai8-o-oW5jESWHkdzZ5xDUUQnUWnE0SLXs0ohl872iGEQ>
    <xmx:DCA7W3xTFC_ryZzsdCkeyzINk_2Zg3e15z53_7KlVCLv72yCGDrcsw>
    <xmx:DCA7WznfkGpx-Y7obkP9NZHoTILNrgRTkiiVqGLrTYpfOd_oPBEYSg>
    <xmx:DCA7Wwf0XJqpAOGntSAkX_quI6KWYaeK3FayaUEVVMApMQ2fzIYaUg>
    <xmx:DCA7WwElI6JYADpMFWoIY0YlVDdbOaL2ze7ESzjfm-gZvYoSTlaByA>
X-ME-Sender: <xms:DCA7WxpKR1XuXAUAFKNM1--LSNB562ptulp3yDFFx8j4FmKmxQT-Xg>
Received: from dave.bha-au.ibmmobiledemo.com (unknown [202.81.18.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id B80E01026E;
        Tue,  3 Jul 2018 03:04:39 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/4] Documentation: ABI: Add sysfs-class-bmc documentation to testing
Date:   Tue,  3 Jul 2018 17:04:11 +1000
Message-Id: <20180703070413.28756-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703070413.28756-1-andrew@aj.id.au>
References: <20180703070413.28756-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/ABI/testing/sysfs-class-bmc | 62 +++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-bmc

diff --git a/Documentation/ABI/testing/sysfs-class-bmc b/Documentation/ABI/testing/sysfs-class-bmc
new file mode 100644
index 000000000000..9d42106b89f9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-bmc
@@ -0,0 +1,62 @@
+This document defines the sysfs attributes common to the bmc device class. See
+Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt for exhaustive list of
+field definitions.
+
+What:		/sys/class/bmc/<field>/label
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		The name of the field of interest. Corresponds to the value of
+		<field> in the path
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/class/bmc/<field>/value
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
+What:		/sys/class/bmc/<field>/mask
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		The mask applied to the value read/written from the 'value'
+		attribute.
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/class/bmc/<field>/set
+Users:		openbmc@lists.ozlabs.org
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		For fields backed by write-1-set/write-1-clear registers,
+		set bits in the value written will be set in hardware. Zero
+		values are ignored. Writing values that exceed the width of the
+		mask value will return an error.
+Users:		openbmc@lists.ozlabs.org
+
+What:		/sys/class/bmc/<field>/clear
+Users:		openbmc@lists.ozlabs.org
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc@lists.ozlabs.org
+Description:
+		For fields backed by write-1-set/write-1-clear registers,
+		set bits in the value written will be cleared in hardware. Zero
+		values are ignored. Writing values that exceed the width of the
+		mask value will return an error.
+Users:		openbmc@lists.ozlabs.org
-- 
2.17.1

