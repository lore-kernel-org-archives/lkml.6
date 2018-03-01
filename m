Return-Path: <vitalya@ti.com>
X-Google-Smtp-Source: AG47ELv16XQIQ3VX50vsYJQo0mVNs3vblPwKXo7W+2wlWnO5OiSem4O2P74kU92luN2vJyPiiRl2
ARC-Seal: i=1; a=rsa-sha256; t=1519909030; cv=none;
        d=google.com; s=arc-20160816;
        b=lVxdAlcKuPUl12CQ/1io0CLvWFA3GsGUnTYgmgp0IoqxT9dLMfw8vowfwNToMcuezv
         F8pDc2iFI4ZDXn5ZCefWWkvXbcHZ5yjwWRfBWGSsp+M6l80KBtSacqAZQL35p4h7RkVF
         uBOq+My++iHAtKJUUCt1q4q+1m6st5tTRde+1/46cLMPg4ay0TmPWssQDUrRi7/aYr94
         8EhM/KogvF8+kC8/tecb/n6lHwF/cjnRh/IRQp8T1MYmDo1nFGfNtA2aU21gOA06icB4
         r/1FsY+0rHydY/i4QpRLCgJsgz5b3PeiFewr7Bu1RKqXweEM7voe2L1TH48Ba64grYmi
         YRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=cGuYXrmqLhpuvzVrxJixLcbDcmTW4hRJWJ/Nwz76LGw=;
        b=qe3AjlFTLD3GL8VmsKSoCuEtztEB0dbG1eLlMpVXF+piJnqTnrkTCN4CnoxzR61Svl
         rCaanTy8A7e8/Xifr8TgSFJrCK0E4pFd2FB9T2wXP5Gl3VITNyPqOt++kDzXcoDDHVQF
         ADSMzU1h5YHHOni1QKAwQQESKwZ5/tUWJ/z2jsJhynxCvkEp8zJSMGj7ctij4QE24WPm
         Ws2bqre9fu2veOwjthMQTaNcg+C6s6SJgxYbxJPeFenevjkem0KEqZK7L6vizA5hGC2n
         7yspcM9ChlUXcTpCAdiPvToWkRzJdYsoXMU/dKS/T/SjT6gWm5JV5GIq9GJ+cselWJk0
         j7tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=JqHqv9Zx;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=JqHqv9Zx;
       spf=pass (google.com: domain of vitalya@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=vitalya@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Vitaly Andrianov <vitalya@ti.com>
To: <mpm@selenic.com>, <herbert@gondor.apana.org.au>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <t-kristo@ti.com>, <vitalya@ti.com>, <m-karicheri2@ti.com>
Subject: [PATCH 1/2] Documentation: dt: rng: add bindings doc for Keystone SA HWRNG driver
Date: Thu, 1 Mar 2018 07:54:59 -0500
Message-ID: <1519908900-10388-2-git-send-email-vitalya@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908900-10388-1-git-send-email-vitalya@ti.com>
References: <1519908900-10388-1-git-send-email-vitalya@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593740131120590051?=
X-GMAIL-MSGID: =?utf-8?q?1593740131120590051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Keystone SA module has a hardware random generator module.
This commit adds binding doc for the KS2 SA HWRNG driver.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 Documentation/devicetree/bindings/rng/ks-sa-rng.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ks-sa-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/ks-sa-rng.txt b/Documentation/devicetree/bindings/rng/ks-sa-rng.txt
new file mode 100644
index 0000000..cc8ee44
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
+hwrng@0x24000 {
+	compatible = "ti,keystone-rng";
+	ti,syscon-sa-cfg = <&sa_config>;
+	clocks = <&clksa>;
+	clock-names = "fck";
+	reg = <0x24000 0x1000>;
+};
-- 
2.7.4
