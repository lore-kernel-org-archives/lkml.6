Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELssksE2AuE0DWHTUB4Ff+ZLpU8JiB5U5d1ZukD/o7g5hs+5R5qRJSiYu5wLlOUr1rQ8szkW
ARC-Seal: i=1; a=rsa-sha256; t=1519950204; cv=none;
        d=google.com; s=arc-20160816;
        b=On/QEu1ZvX6o4Rk1KOirBEoeu9K9QdzloHlaKd4ttA3bVDxWeVm+XypBda8IeJoJPN
         fJsOv5gokzAIOaXJbuDzOdOY7JQ7wlnHKxiGvoaD3l2cM7tf2VXo+bY+D0w7uq9QdZ8H
         h7qgc9tL3OfRiKnzMJ1MNel1lFv93gK38YMcnAn2H3UOoq5FIGqQ5IBpSrYE8tI52jjt
         nSphHtSG7If5/zuXPEB982QlBTaqWWOyBljRgMmXLeyxSSnZ6OY61JB2cJtbvOOR1o6U
         nJ1eNFnXjl0nh8/c3x3UFSMD2n4svwIlypKfEOt+8qwIDe/Zn0nxZwxVoisGlQavSdAn
         h1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kyvQmzlDWEEAZE1c4J+CD3qOj0ZZvP2iXNc8AXOY2U0=;
        b=Oib5OczF0vCvjL7oW++D0EOnzgnmfYbbJGRliN7ut2ev8+ZG7u680HDG1few2sMP7Q
         Yo6qhoMjjVztIvuK2dl4z9qApZOfEqJtk6g0JkdRHeKAsGgLsoRstNQMOOHQEolO2Qwa
         eVMIP8LKWgKyOJ813pycF4eJJJ4SLqD2F/0+PVKlPwgQS/6AAhzLTbhKWngZMTZA6kMb
         J0lkBdPDHxKBX4Ut9dAAuiEfx5PyTYk5a2aEZwCcqnoHRZ177XCpqQMsfghJGjsB85UI
         tyPEe328kPxIz8N/Eudya9f4vVBHzH42BVAivXx8XR55YcnRxnFXndG7s8z/ImwMVsFf
         XdLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="35279639"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	dinguyen@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	atull@kernel.org,
	mdf@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	richard.gong@linux.intel.com,
	Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 1/7] dt-bindings, firmware: add Intel Stratix10 service layer binding
Date: Thu,  1 Mar 2018 18:19:29 -0600
Message-Id: <1519949975-13548-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783306027832989?=
X-GMAIL-MSGID: =?utf-8?q?1593783306027832989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add a device tree binding for the Intel Stratix10 service layer driver

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: Change to put service layer driver node under the firmware node
    Change compatible to "intel, stratix10-svc"
---
 .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
new file mode 100644
index 0000000..1fa6606
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
@@ -0,0 +1,57 @@
+Intel Service Layer Driver for Stratix10 SoC
+============================================
+Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
+processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
+configured from HPS, there needs to be a way for HPS to notify SDM the
+location and size of the configuration data. Then SDM will get the
+configuration data from that location and perform the FPGA configuration.
+
+To meet the whole system security needs and support virtual machine requesting
+communication with SDM, only the secure world of software (EL3, Exception
+Layer 3) can interface with SDM. All software entities running on other
+exception layers must channel through the EL3 software whenever it needs
+service from SDM.
+
+Intel Stratix10 service layer driver, running at privileged exception level
+(EL1, Exception Layer 1), interfaces with the service providers and provides
+the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
+driver also manages secure monitor call (SMC) to communicate with secure monitor
+code running in EL3.
+
+Required properties:
+-------------------
+The svc node has the following mandatory properties, must be located under
+the firmware node.
+
+- compatible: "intel,stratix10-svc"
+- method: smc or hvc
+        smc - Secure Monitor Call
+        hvc - Hypervisor Call
+- memory-region:
+	phandle to the reserved memory node. See
+	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+	for details
+
+Example:
+-------
+
+	reserved-memory {
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+
+                service_reserved: svcbuffer@0 {
+                        compatible = "shared-dma-pool";
+                        reg = <0x0 0x0 0x0 0x1000000>;
+                        alignment = <0x1000>;
+                        no-map;
+                };
+        };
+
+	firmware {
+		svc {
+			compatible = "intel,stratix10-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+		};
+	};
-- 
2.7.4
