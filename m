Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+3W7Mw0HCKiZ9201il0DFFwXizHhn21yXzQgftH4toHq+YTFcV4N8bATRyauYY7Cynh2ub
ARC-Seal: i=1; a=rsa-sha256; t=1522182232; cv=none;
        d=google.com; s=arc-20160816;
        b=oJAmAUqpWvHwL2jU5IvboFmWZWuNK+gabC6Bd0ueoNarU1ivmEwUzEk7jRAx5Yo6lM
         BQK1578Tn6A/y1UIAysqXd1iAOvJqHXlnEk39NsarzZDQ6h8MQQ0kkfXI02j+NrYD7Qg
         kRxpN0U4PHrgHwnPD5CVPBDcpovQvMsfQCGc9eCVZG7S3XeQYbhhNegKF+RvqaXvENvg
         VW3XALtY65MQG79Fb3uy6vOG6zAYJEXYJipyefkiMYv1pKpmoEe3NLFjBIqHS/hd8oeV
         ye9f3UeaHbplwJLOE0axDm3lAsWJ/ekkerq1p56khZ7rM2J7k2b9K9CZYAxGpvPVhG0J
         QwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=xkwPahwxMojRpiFEYWw4/tASSbdt3mrjUcsjzNGSOsI=;
        b=WnvozTYRBkh5IwdFRCxadYxhzNfplr1TaHh53K2inUvCXTw/9FMMcNrMi8k/OKZouX
         a/iyd5T5W8lhZZFWcfjqVdhdx2NRkQAumplrix5J6dRDdlixHLrC8Qo/u8Rf2nUaITr2
         Q8Fef2s2Iep5cKVdocpjBM+BUUCaM852NWq2fu7+Lt0HnXhWNsaV7+m58Mtuw0/mlDgj
         57eND+1g71Zbnh2KqO9pjQmFhlpDRT9e0YLCWZN9k4Wy0CJRofu2FHBnd0I3ICNJhAd2
         mzwiPPUOJKOU3LGOKAJIUtLNprtUEZnb87mXuRezMjbRm/6hkoYlRtcS0Rx56D+MTA1w
         3udw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215401656"
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
	richard.gong@intel.com
Subject: [PATCHv3 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Date: Tue, 27 Mar 2018 15:20:11 -0500
Message-Id: <1522182014-7338-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123756230915390?=
X-GMAIL-MSGID: =?utf-8?q?1596123756230915390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
v3: change to put fpga_mgr node under firmware/svc node
---
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
new file mode 100644
index 0000000..be7cd96
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -0,0 +1,17 @@
+Intel Stratix10 SoC FPGA Manager
+
+Required properties:
+The fpga_mgr node has the following mandatory property, must be located under
+firmware/svc node.
+
+- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+
+Example:
+
+	firmware {
+		svc {
+			fpga_mgr: fpga-mgr@0 {
+				compatible = "intel,stratix10-soc-fpga-mgr";
+			};
+		};
+	};
-- 
2.7.4
