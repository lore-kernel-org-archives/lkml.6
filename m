Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB6EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A99121477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXM1mDnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A99121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIOXCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 19:02:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37985 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIOXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 19:02:16 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so6344359ite.3;
        Sat, 15 Sep 2018 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=RXM1mDnxaiIy+aT7bbXrL9pt6LYvkvXpBQuFDVq7w13H6+UB0ZjwMGN3IJU/xLf3+x
         Qlhh1SV4/GiPd9i5KAb1FYdQm4v24pESqg2U3pjDTEJfy5bR7VgVYNZhCIwNYL59olo0
         Y05DP5zZzw4/nnnnwET8Y9I93YgO+PpbRRSSyLqQ2EhFdn1CFYE+wlkDrZwe7vy1RjpU
         MmysZyW/5KksuNVxnzs+enwW8fPDp0ouu/x4X2tNsd0A7uYTffAsYrrQUDojfdAAHv1O
         jlbfgBMpbf4wK6Yle4Hx6zAJV9VomDzpoGzkOBs4uUvF2inXvV3rx/kNVTEekuc5C75n
         yUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=PGFln0joYGHP4pgTzB28714QMfarEMI9+sZ0BYtbilheoa1OhRvtj92QGm4RdVuySb
         d+KBLF2BsBiYi+0pIhs/dHPSz8iTk2Q3KlpJa6nBUxjzYwlracQuG+PB3a/9GjPp6GmW
         DflQ7Ofh5VXhgIDg205BQSWN/GJNBHlzKrfr2N1LW+/0Kg7JSB17VP0jYZY5iuKhEVjE
         qxuOUPgL004R3bkd02G0WPf7+vQ/Z5bToKjWjrM4KbXFCnZ1mLisARTYaT0O+4vvZLiZ
         zuh/tt6MEpO1VlsDLdTq1pKHuD1RZM3zyMrLBcqRgOAs9ExYqs3FKFECfv5K9JcF38hB
         DOiA==
X-Gm-Message-State: APzg51BDzMSNixsXYraRlqnkkK6U26quoWkoTWi+rLdqJxTQpfU884u3
        fcT9d5w02GB6nJnYciyMNA==
X-Google-Smtp-Source: ANB0VdbBxoaLx5rM8bcsV2Iy8Mu12EygbW8N0jYq4Mfsnf4eP652rYd6yeD8PEie2iXC+f+xWfwcvQ==
X-Received: by 2002:a24:fd04:: with SMTP id m4-v6mr7392851ith.28.1537033351004;
        Sat, 15 Sep 2018 10:42:31 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id t187-v6sm1150250ita.28.2018.09.15.10.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 10:42:30 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: light: bh1750: Add device tree binding documentation
Date:   Sat, 15 Sep 2018 13:42:13 -0400
Message-Id: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for ROHM BH1750 ambient light sensor driver.

Signed-off-by: ryang <decatf@gmail.com>
---
 .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
new file mode 100644
index 000000000000..468350cc7af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
@@ -0,0 +1,18 @@
+ROHM BH1750 - ALS, Ambient light sensor
+
+Required properties:
+
+- compatible: Must be one of:
+    "rohm,bh1710"
+    "rohm,bh1715"
+    "rohm,bh1721"
+    "rohm,bh1750"
+    "rohm,bh1751"
+- reg: the I2C address of the sensor
+
+Example:
+
+bh1750@23 {
+	compatible = "rohm,bh1750";
+	reg = <0x23>;
+};
-- 
2.17.1

