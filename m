Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+UYbizrPwSzvPwey0bgwPzlEs5geZYdo5YCReDk8V/q0v+1Z0ZBjroXmUs0FEgeW661E1o
ARC-Seal: i=1; a=rsa-sha256; t=1522182234; cv=none;
        d=google.com; s=arc-20160816;
        b=cEPvNT1lkKIlezWLJbTum04WGrt3ZKUg2p+m7Lqo+c6BaLVCCcnEHHBBaNQpFrErZU
         fNkNT34NBoOwEmXXzELJiWWy/EJNQ3+AbWy+KRAb6Mi89fyMhF9UxtbT3Csx77Wsxinf
         e65/8pLQoSvOhen9rSkov9ktdvkgCHxhLz1qvbCdS7LgbHLxXBPcLpJZTtZ7Jvev4qPu
         Q5dF+VcOsVuAO0dj4q16bfmk0IkGfuu5xqCUIg8CKcMDDzmH4IfZ+/c+8DXZLhkXI+F4
         +IZpgK95wn1H8e3uTH1r2bqW0IxHOjkGA2KqP+g10A5z5jsRDTkBgsemXjTyZQJSz9uh
         mdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=U/B96ToH2Y1Fb8Az7tir08kaiqTDobsfWzMaWzBL/og=;
        b=qF+df5+GnUjd+IPWM71V56IZ1cP9shObrnUS16AXXCfmRoyz2KD37Gq/nKacXbMaeG
         21rnCkCtrPWeowIMkx/vK5maHC4vJWiSEC+mG844W5NNQk5IFQzxIPORI/MFXFOq4NBW
         ioZ64HCd6qFm8I7fW2nS9DyHJdwoK4rWzbKU7plbUBM7TULMGwZGGJrVEaF+BTIZvH8l
         RV+fV+keWCjT7yMEafpEL8NJ3QQoJCO6ScMJkEXN2wyuHQPFEpFFQQEto9r7QZdGQf9a
         mAMTEGPki5u1uow939ZpBqcRzytj71wVIaTIjPaiWXc9kGqNN3OPFcBY5kqxKdhuEb18
         /MPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215401687"
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
Subject: [PATCHv3 5/7] arm64: dts: stratix10: add fpga manager and region
Date: Tue, 27 Mar 2018 15:20:12 -0500
Message-Id: <1522182014-7338-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123759313856770?=
X-GMAIL-MSGID: =?utf-8?q?1596123759313856770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add the Stratix10 FPGA manager and a FPGA region to the
device tree.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
v3: change to put fpga_mgr node under firmware/svc node
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 4395e76..8c8f66c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -107,6 +107,14 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
+		base_fpga_region {
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+
+			compatible = "fpga-region";
+			fpga-mgr = <&fpga_mgr>;
+		};
+
 		clkmgr: clock-controller@ffd10000 {
 			compatible = "intel,stratix10-clkmgr";
 			reg = <0xffd10000 0x1000>;
@@ -453,6 +461,10 @@
 				compatible = "intel,stratix10-svc";
 				method = "smc";
 				memory-region = <&service_reserved>;
+
+				fpga_mgr: fpga-mgr@0 {
+					compatible = "intel,stratix10-soc-fpga-mgr";
+				};
 			};
 		};
 	};
-- 
2.7.4
