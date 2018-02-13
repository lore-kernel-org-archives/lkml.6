Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518513258-2-6730328418842717051
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513257; b=SkCzoQ8Cpc0er0Na2RDPWym6TAelJUK7DBPT36eENPXA7+c
    3dFc+Vq9rR82bmJOCuTEF/JrT0V9YRxAYmunuO3C89VJu0/oCamDMGBkBfkwDMGh
    TEQAdMh5BmxBNDv1DNtF5Tl3L9ziv8qTTmnepcJyJ3RgT1hlxc+75YxgFSBvyemd
    NAPEs/073bzP5QW50zWV1/gjFcQLgIoeXgsTtu6ANU9UyTrk95Kmf8UMU0YErYqB
    iinK6onab9j2T1pui1tjlPTb3er838vZPZLLlbHgiyabiyVnOcOcwiQ52oFRIGjP
    tv0ty5iSQ6I/kCqCvDzdHFoIb3I5HkfA8Lh/u1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513257; bh=SxzJt8bxgi7RFecsa1BGXjkYgEBMvyXUQKe3S/yFMUY=; b=v
    4KvNuOT3+TR/ALbFeMh0KW75JT3a6rEFM2oz372QtmiEpsOue4pacqxE3s1lmc9i
    phgMHoO2LZI6lEONdOWvDq6dH+ltolBKJjcXz6V3OOUDLPUuMX+heOULzWFuj7SE
    Hm3TjMLs9fERW7zzfsoU3QagD6PABh8R8o+fxoP/IPzoIAT1ilNi/i0HulRdRIIL
    fil1rEFsSLxPnILkTcFc88IA/qsswZwijvzFiti31Vs9MRh88m+a+viUIq8Ay6lZ
    1cYBjEFrq8ou//lavfo007y31XHObblP4SCcGR8Svudsp287UcsYja8sENzKRBbV
    tujQARqymJXXfRd34G/qA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NW6Lthh4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BdU6gpLE;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NW6Lthh4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BdU6gpLE;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226VSS80n+jaTa1LdD7xfJneLt7JDSr9xrqslh5u7fUFD2P7eJHsOeEIccUjuW7w3wLNOaJPTQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: Rick Chen <rickchen36@gmail.com>,
	green.hu@gmail.com
Subject: [PATCH v7 3/3] dt-bindings: timer: Add andestech atcpit100 timer binding doc
Date: Tue, 13 Feb 2018 17:13:19 +0800
Message-Id: <6b5451c70123e06b47935720223da0792fcea3f8.1518505425.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rick Chen <rickchen36@gmail.com>

Add a document to describe Andestech atcpit100 timer and
binding information.

Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../bindings/timer/andestech,atcpit100-timer.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt b/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
new file mode 100644
index 000000000000..4c9ea5989e35
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
@@ -0,0 +1,33 @@
+Andestech ATCPIT100 timer
+------------------------------------------------------------------
+ATCPIT100 is a generic IP block from Andes Technology, embedded in
+Andestech AE3XX platforms and other designs.
+
+This timer is a set of compact multi-function timers, which can be
+used as pulse width modulators (PWM) as well as simple timers.
+
+It supports up to 4 PIT channels. Each PIT channel is a
+multi-function timer and provide the following usage scenarios:
+One 32-bit timer
+Two 16-bit timers
+Four 8-bit timers
+One 16-bit PWM
+One 16-bit timer and one 8-bit PWM
+Two 8-bit timer and one 8-bit PWM
+
+Required properties:
+- compatible	: Should be "andestech,atcpit100"
+- reg		: Address and length of the register set
+- interrupts	: Reference to the timer interrupt
+- clocks 	: a clock to provide the tick rate for "andestech,atcpit100"
+- clock-names 	: should be "PCLK" for the peripheral clock source.
+
+Examples:
+
+timer0: timer@f0400000 {
+	compatible = "andestech,atcpit100";
+	reg = <0xf0400000 0x1000>;
+	interrupts = <2>;
+	clocks = <&apb>;
+	clock-names = "PCLK";
+};
-- 
2.16.1
