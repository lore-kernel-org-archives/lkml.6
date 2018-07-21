Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61BAECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1AF20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFK2E75L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1AF20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeGUVQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:16:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeGUVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:16:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id m12-v6so3933594lfc.10;
        Sat, 21 Jul 2018 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jplPFLWn9VLOrkDA3WzAUOfQbTUQ6H1EjyiO3Mo3fBo=;
        b=dFK2E75LRmFkMOh7SmUUNLtvN2Y8w1T9oyUBvstbRiK50/A0BTgvjKYWUkIQf6Ul+T
         lB31nuIh74VfqvgMgcSymbP0C+3NEeR2NuSRmyoacEzYYn/Bs2H5kTpHmLBrim4UBpnd
         Ira2vpHYn7i5kjmw4wHw3oHrGNbI416zpjlzQcYgXOa8Ct5eJmwjRvOqGosSS2G/3aXA
         C5z6nXlVkwZoXZDmX1/m/UZlDgOGNJ0W5u5e1CxlffS5BcqSiKfl9vpJ/ESPeuFgQcmF
         LfEx0hcIbxWsZyZNwFDgzlwAerBw007mkUOHPw0BPv8PziVLi90IXXDxe1kMP9wS/k+h
         WSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jplPFLWn9VLOrkDA3WzAUOfQbTUQ6H1EjyiO3Mo3fBo=;
        b=CFtsibrOcUL9KbH18HB/rIT9euyJBkilTnsJFz14XLTjBOET4DePF0k6FLWydBKZaj
         /BCPt96PP8vg9c/mHWPkK3IqYwlqbv0PY70o9Nv75iloUh7H7k4Ah4CR3BQEw/NcJ4d4
         0Fwsmjcho5wlz+tzm/6TeS5kLVIPRuIlrz4wbWYYEP0ICHHzrzse8Ptl0JXrdFAuzeCE
         J3WvwX79Jkod1HoL6bQUlzn0M7GkipDQFhOy9fJ4Y+qTBFFYNEh9iY4gZ1J1/Cn6l1Ol
         QyhUurVxtGFIwLeZ1JYFc8xWkJHzSj0OK4iCPrnsb/K6j+9MxIn7lEhxOrjam6fqZGos
         pYqA==
X-Gm-Message-State: AOUpUlGG57KBf9glr1WfMrSwJxBdOFPD6JCgPyR0F2ivlexD5Ue2PXYP
        zXVPjHd+xU9S++SDHtiZQeQ=
X-Google-Smtp-Source: AAOMgpevgUcZ2sU+uGU4A8loE9IhHTQfl62Hesdj0VRPd4oOsC3Niskei3J+niIcfrtH4mfTbQvb5g==
X-Received: by 2002:a19:f22:: with SMTP id e34-v6mr3886309lfi.1.1532204545985;
        Sat, 21 Jul 2018 13:22:25 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id z5-v6sm756742lff.96.2018.07.21.13.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 13:22:25 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Add entry for mcp3911 ADC driver
Date:   Sat, 21 Jul 2018 21:59:23 +0200
Message-Id: <20180721195923.7610-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180721195923.7610-1-marcus.folkesson@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for mcp3911 ADC driver and add myself and
Kent Gustavsson as maintainers of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79bb02ff812f..9276da915d9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9271,6 +9271,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP / ATMEL MCP3911 ADC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+M:	Kent Gustavsson <kent@minoris.se>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/mcp3911.c
+F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
-- 
2.11.0.rc2

