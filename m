Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeA3Fvm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:51:42 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39152 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeA3Fvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:51:39 -0500
X-Google-Smtp-Source: AH8x2277LB9tAqX8SF5QFvaX5vK0mGtw5y8C9eMqjUouDc4DW6q3qXjHclyZf4jz6mH/ShbQNMmt6A==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Jeremy Kerr <jk@ozlabs.org>, Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: fsi: Add optional property no-scan-on-init
Date: Tue, 30 Jan 2018 16:21:15 +1030
Message-Id: <20180130055116.17411-2-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130055116.17411-1-joel@jms.id.au>
References: <20180130055116.17411-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Bostic <cbostic@linux.vnet.ibm.com>

Add an optional FSI master property 'no-scan-on-init.  This
can be specified to indicate that a master should not be
automatically scanned at init time.  This is required in cases
where a scan could interfere with another FSI master on the same
bus.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/fsi/fsi.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
index 4eaf488d4015..ab516c673a4b 100644
--- a/Documentation/devicetree/bindings/fsi/fsi.txt
+++ b/Documentation/devicetree/bindings/fsi/fsi.txt
@@ -56,6 +56,13 @@ addresses (link index and slave ID), and no size:
     #address-cells = <2>;
     #size-cells = <0>;
 
+An optional boolean property can be added to indicate that a particular master
+should not scan for connected devices at initialization time.  This is
+necessary in cases where a scan could cause arbitration issues with other
+masters that may be present on the bus.
+
+    no-scan-on-init;
+
 FSI slaves
 ----------
 
-- 
2.15.1
