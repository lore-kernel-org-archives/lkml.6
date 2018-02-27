Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519740584; cv=none;
        d=google.com; s=arc-20160816;
        b=A5hDod8HUXmx60pNp5pJLlM28lcm8rbg/EqhlV1as5znOLNB2ifhJYKmQUg1oOQA+8
         2zxLCDluszRtJQKti7B5BikTAX2PSrvu1himQOkK12wFEfx+mGT1zXRffUENetQp64rh
         6ghFS77pveUuDgJZgfT+C8/2nTVgz2hQoAPh/WM7JfCdhiEnJiw/2rF9/yVEvnJy2zrb
         6unbQGl1STk5bX2NqRbFIlNxZr2YtiCACrv8r9Z+ts9JSY/JzXkAfFndm/Jn0EEaigxj
         4VJx6I19UBJ7Nofa0+lezzxpLcXrqUIOIJQUqaCjvFomuj1WlPoNvMr0gBDqsBXDpCt/
         YGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=pXfACuIkE0tumvZyUY0pIlpeWKLMZLhqTYTRETC8BFg=;
        b=I3UPNOnUbbJ1nRU+AUBH8nYz0jTai2+l4kyhI8ab24HBhMdQsr7V9VLozmqQI8bL5m
         rnEKTD+Sv2M8dJQOkygFfdrxZW2GJOY0GILFmlrkrbMRZ/fBFzV5dxg7HRTsyvRvUOwh
         vxcbAGJETRBoNYBzS2c4UsWnib43yVK8FTAnmLlMCTyX1My4oy8cjyITcwqbwxrIRszH
         IYS/FjWxqKkXPJ/NNO0SnzStCRmQ1UVQPlo/NJGxinj3DthfjQl8P1YID/ntbIMqLf8l
         zmdyJmnq8fzDNX/FPspzwXC8Xnk5jlL6JYjNTKRs3BfvxQabO5LURwd4Sq91ERFb4yi7
         ZkMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cxu9l47q;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cxu9l47q;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtQb0doiYC4Ev6czpcKFzBLZ2LdYMS8lrV4kx1PE0OAbbv5w+MvD4iVOGORlFx+Y0KTvcKepg==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/3] dt-bindings: stm32: Add bindings for Extended TrustZone Protection
Date: Tue, 27 Feb 2018 15:09:25 +0100
Message-Id: <20180227140926.22996-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180227140926.22996-1-benjamin.gaignard@st.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563503379166103?=
X-GMAIL-MSGID: =?utf-8?q?1593563503379166103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Extended TrustZone Protection driver is very basic and only needs
to know where are the registers (no clock, no interrupt)

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt     | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt b/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
new file mode 100644
index 000000000000..6db093847a13
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
@@ -0,0 +1,13 @@
+STMicroelectronics STM32 Extended TrustZone Protection driver
+
+Required properties:
+ - compatible : value should be "st,stm32mp1-etzpc"
+ - reg : physical base address of the IP registers and length of memory
+	 mapped region.
+
+Example for stm32mp1:
+
+etzpc: etzpc@5c007000 {
+	compatible = "st,stm32mp1-etzpc";
+	reg = <0x5c007000 0x400>;
+};
-- 
2.15.0
