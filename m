Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nuD6bk5Z1omwGxbjv+u87lBeH6BN7tlIHqmPTb89hHIVtgXkixX1sZaYXbvjrW29txatg
ARC-Seal: i=1; a=rsa-sha256; t=1519218419; cv=none;
        d=google.com; s=arc-20160816;
        b=LtHcY9pRZmKhvCwbvTY2esahEQ3ZkrlICklYwh1Ra0u+Clm2KSvTlTqw4wX/Ivw9bo
         pgdWEXww+2dGTphojJ/AnZtZ4VKMrYAT4ZJ0yuVQQrNxu8kL0ue4xPo+mnnJOZwMYu5T
         3Y3QsvEZu+WN5nNHuwSE8tsp1Epdpe81dxtyxfMLLXLozMJyZvfr967f7Ge3kjphuPpN
         WrPjlDfQ68FEG9dGR4KAkxIIU3/11nuBWHVU8CM3GdV7C6/dH82PoTmvcALfRmNCTbfh
         U3xAbxZWOAc2B7KsVD22TXb24mR/IyYYbJmhHeAMNL/IHJBrfgtbVg0EIa4IyXgYwjtB
         jizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5cWS4r65/9Op06zPBZLcDwHPO7EKVxzoVuOgwqLuUeg=;
        b=qciZUnimoDjwd00rmpl2ZF9xVCsZmEQlxQLb3whV3vUN7PyrDdBHOSD8kpw9WKBDuq
         WVQUwbPK4tlBgq4JgUY3iRfcJ4Qa5oqutFLaKJbMgZ0nPpdrW0dULJBY6ejBtfBRzl+p
         5fAO4mljvlOl84ArolVSAX/uFFCqpVq5t2zvLVq0kUuHMWAPTKf4EO22DYQWOrcgoJSH
         EJ7os2Pwe3Su55gr3zKDxHorppMITTx8xEL0kextX9RUzV4477xZZFViRMneNFnE+BtM
         J2s8v8vCA0+eQnMWu1UCQLtrwHjeuuKfWoM25Kz70k2hau0HsrmOZCLAUoZg7mzLhViX
         n3Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.15 033/163] arm: spear13xx: Fix dmas cells
Date: Wed, 21 Feb 2018 13:47:42 +0100
Message-Id: <20180221124532.069334488@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014663549542696?=
X-GMAIL-MSGID: =?utf-8?q?1593015972763846418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit cdd10409914184c7eee5ae3e11beb890c9c16c61 upstream.

The "dmas" cells for the designware DMA controller need to have only 3
properties apart from the phandle: request line, src master and
destination master. But the commit 6e8887f60f60 updated it incorrectly
while moving from platform code to DT. Fix it.

Cc: stable@vger.kernel.org # v3.10+
Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/dma/snps-dma.txt |    2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |    4 ++--
 arch/arm/boot/dts/spear13xx.dtsi                   |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -64,6 +64,6 @@ Example:
 		reg = <0xe0000000 0x1000>;
 		interrupts = <0 35 0x4>;
 		dmas = <&dmahost 12 0 1>,
-			<&dmahost 13 0 1 0>;
+			<&dmahost 13 1 0>;
 		dma-names = "rx", "rx";
 	};
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -142,8 +142,8 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
-					<&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
+				dmas = <&dwdma0 12 0 1>,
+					<&dwdma0 13 1 0>;
 				dma-names = "tx", "rx";
 			};
 
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -100,7 +100,7 @@
 			reg = <0xb2800000 0x1000>;
 			interrupts = <0 29 0x4>;
 			status = "disabled";
-			dmas = <&dwdma0 0 0 0 0>;
+			dmas = <&dwdma0 0 0 0>;
 			dma-names = "data";
 		};
 
@@ -290,8 +290,8 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x2000 0 0 0>, /* 0x4 << 11 */
-					<&dwdma0 0x0280 0 0 0>;  /* 0x5 << 7 */
+				dmas = <&dwdma0 4 0 0>,
+					<&dwdma0 5 0 0>;
 				dma-names = "tx", "rx";
 			};
 
