Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E133C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3989220817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vAgxw1nA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3989220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeKREhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:52 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40867 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeKREhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:52 -0500
Received: by mail-wr1-f46.google.com with SMTP id p4so18834086wrt.7;
        Sat, 17 Nov 2018 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDG6cqRycRzCFwic/B2Il8324dwPbu/CMN+slyIzPK4=;
        b=vAgxw1nA3Iu5hoM6aMtOykELP2lWTjBzzkaZGjdg+QESjuzfjMnJtGjGC0yJgdbRdE
         4vDyDHtrLbKU+LltSnA5MMwbxV7KzwHhMVRhxYgg1Ax7gbXIMEHsPPFXFixk+RTQtQYy
         bPIG7HEDa20jLW2oM24kiZnWlqctZie4ilmSk39xf/wF2suY8XfxT7S0EqugKKdsPU1l
         +m/gZZykrVXFRty+jGPwl576XvyfGpM79SmaghHxD+P9burZllJjuwLFOwE1sYZiEIki
         0rT2z4QXRXmtn0GUSUVJ/TTRo+E3n4c/jfMCXFqKbBRua1GsuREIBICwKoh6udoyJLHH
         LIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDG6cqRycRzCFwic/B2Il8324dwPbu/CMN+slyIzPK4=;
        b=gfUrBHAaWL6I0gXelriEXw2pMYlu2lZ8BEthde/0m8QasOoo1d7EOoL96PV1bmIahL
         oIf8BoZeUEq0SP057VRm7TVpzAvUjy/vf3rxsgNQAOC4ytiv8AVV+4HOFoEIcWVm7GIH
         DmPToqaD3JUWN69pPYCuf+ebr13L5OzM8qT84TyS6gSrZXRGzDEhLuuEaMUPjBHytk+3
         iVzEfKqqS3swLtkgnPnNMOJGXiS3YyElvMhAMPghUakExIc0QW7dI61RM5XqCVVsS9B2
         HcfzMV6KatvlPlt1bEuLa+/p6OSBX2JgaoxlpPsO1qc2fS/fdBP9injp73ebEp8w2OiD
         IX4A==
X-Gm-Message-State: AA+aEWaZT7UciyjkYNtBukXO5UCgmQFf5eYSJyO4Ve1ZJIMq+0I2ZwXe
        z5rTR4XiflesvfXcFp0v7sQxwqpy9fM=
X-Google-Smtp-Source: AFSGD/V2QEtzLCi01JBjp8aUMQmroEc+9ACkEB7m7HmD4dS54dbU/ygrUUnLV7LGsicIHT3JPYEDzQ==
X-Received: by 2002:a5d:478c:: with SMTP id w12mr5992584wrq.319.1542478821101;
        Sat, 17 Nov 2018 10:20:21 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:20 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/7] dt-bindings: vendor-prefix: add prefix for IC Plus Corp.
Date:   Sat, 17 Nov 2018 19:20:01 +0100
Message-Id: <20181117182007.14791-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IC Plus Corp. has various Ethernet related products such as Ethernet
transceivers, Ethernet controllers, Ethernet switches, etc.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..cc6b2c0d3b49 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -170,6 +170,7 @@ holtek	Holtek Semiconductor, Inc.
 hwacom	HwaCom Systems Inc.
 i2se	I2SE GmbH
 ibm	International Business Machines (IBM)
+icplus	IC Plus Corp.
 idt	Integrated Device Technologies, Inc.
 ifi	Ingenieurburo Fur Ic-Technologie (I/F/I)
 ilitek	ILI Technology Corporation (ILITEK)
-- 
2.19.1

