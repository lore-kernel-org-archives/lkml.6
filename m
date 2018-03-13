Return-Path: <vitalya@ti.com>
X-Google-Smtp-Source: AG47ELuOUe0VHEqW2cpsBL5eo/6KORMJstCkTN6xrIIXviZ3fh5ms1DHTCeMg0ML/XQP7i82ZtVZ
ARC-Seal: i=1; a=rsa-sha256; t=1520962496; cv=none;
        d=google.com; s=arc-20160816;
        b=rw4L9Aq+Jf/3FaGy7IPAro8UaSghA2Ssr3xZO9Ws3M4adpq1VDVYAB5s5xPR5nUSxZ
         3kXOWB0zS/HTa25Cr1Bl16Hmw2sS0xOyYpYQwrgNA8w0S4V9L545jTRHll946YT87DNK
         wUnlGpzJBLhfpRw/6ST9m5s4xwIGEwzxYHL3J9rso9f7idG1to2wiwfKTY8Hl7Bm9EKo
         C2RWqVLSI0yvwZfcAnn+3JPiSWTGzv6l+xTS6tJiUeeefjxT4R6FYqXL5GySiB9pkPIC
         MgQZsC6FMcD4qh5T8sJ355o8ZwYv0NAj8XxK4XIVQJqILE8lx4+lFq+aIZfw2dfwh8/a
         rCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=bq9SIULzpCrCpG7BikuJdTavGMjUBLi5vWeWDkcWoiE=;
        b=tgj6n6ZR1Vgc7z6kd2VXe06FLIUSokBlwCI0VhNJVqAeHapgUkNidZtWHSDaHXA9hA
         yX9ogxFUxsZMDVDJuI3aVdVxhRg4GAYKgz+NgNOxbH61/XEscEHmYWtNfD0FWQ5yyrW3
         xSjtWaGwfnuh0NeRbB+qB9aUcIqljxf/xQoabONnT0admFzYdufLVHW+HPFOIJ8iEHIK
         Fnan+CjcwYLTqHmip61xmSOf2F5T4cqSmkbXh24QbvJD0+59NxMp41x0/k25GCksNoWW
         GMXQyP9v/lZ+UiZ8ZXf83dAt3WqYpJqzu1bnbySSS3Z2Iph21gUtHi78e2Y7SX2blwZh
         sacw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=uxUcSPhS;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=uxUcSPhS;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Vitaly Andrianov <vitalya@ti.com>
To: <mpm@selenic.com>, <herbert@gondor.apana.org.au>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <t-kristo@ti.com>, <vitalya@ti.com>, <m-karicheri2@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: rng: add bindings doc for Keystone SA HWRNG driver
Date: Tue, 13 Mar 2018 13:33:30 -0400
Message-ID: <1520962411-18208-2-git-send-email-vitalya@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520962411-18208-1-git-send-email-vitalya@ti.com>
References: <1520962411-18208-1-git-send-email-vitalya@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594844770633727819?=
X-GMAIL-MSGID: =?utf-8?q?1594844770633727819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Keystone SA module has a hardware random generator module.
This commit adds binding doc for the KS2 SA HWRNG driver.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/rng/ks-sa-rng.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ks-sa-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/ks-sa-rng.txt b/Documentation/devicetree/bindings/rng/ks-sa-rng.txt
new file mode 100644
index 0000000..b7a65b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/ks-sa-rng.txt
@@ -0,0 +1,21 @@
+Keystone SoC Hardware Random Number Generator(HWRNG) Module
+
+On Keystone SoCs HWRNG module is a submodule of the Security Accelerator.
+
+- compatible: should be "ti,keystone-rng"
+- ti,syscon-sa-cfg: phandle to syscon node of the SA configuration registers.
+		    This registers are shared between hwrng and crypto drivers.
+- clocks: phandle to the reference clocks for the subsystem
+- clock-names: functional clock name. Should be set to "fck"
+- reg: HWRNG module register space
+
+Example:
+/* K2HK */
+
+rng@24000 {
+	compatible = "ti,keystone-rng";
+	ti,syscon-sa-cfg = <&sa_config>;
+	clocks = <&clksa>;
+	clock-names = "fck";
+	reg = <0x24000 0x1000>;
+};
-- 
2.7.4
