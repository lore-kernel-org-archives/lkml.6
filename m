Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513204-2-9755076529406542363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.68', Host='mail-pg0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513203; b=feTUEPAmHqCcDyaWQEaT9soooAsmS+vevOKZdsczn4BSsCb
    ogvGtdzVEHJhb5zEkPe08fl+Oz0JTDAybRTOBmlvN84Xv4jkrUwRjewC4EPUV+3U
    kFFs6LVvJ/2hfKwUEprrZRWu9t6SvFSzdX78F/OMvovmS08dQRW2HHx5f6qK/sda
    qjV/sRT1wp++unH40rq7EzSWLWRDfr3lc9dOmE/jixgBxnOSd5qBpG61RB6wrBse
    JRBZLZ1DBY0EKl6un7xcpgUI+awabh1ib5SHWG9zFsOCBlmSYPRAkpubQcaGINhP
    g1LFLCEIwnkGjk8YK7sS14lRrLeRfisfeQRdRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513203; bh=+lPp8ALocok2xGlDtZUFOwnSEReLEcNLEXE8KwGMOEc=; b=u
    iTFmVX8RXuhbgCNZUP+47OF3Nm9PM5rj1b7zpeHU+5fOPBU4hYcdPKoMTltEdahN
    QjFFIc+Uu1E1jDWngMTV9WoZma5thPFLmEDc996ViwJloRtsBpi+4JUXsZPPOQvT
    BLutxsoY/UlQEa5kv09epP/oKcMlNy+MG5DB5njrjPspovk0MdsoP+OW9wdJyvwA
    oCjh5T0afiqbZ7Wr6lByd/PaqECAt063KPuf+CHKivxTlL5vdBqynSrPQjxeqVY/
    E3caGRZZR/St4nlCpkpOuCYvFDwJcZxRD770C4HVv/IZdQSfVtH0/Ca5zKm6/TYl
    AR55+KihcEAdP4Elay7Bg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZlZWTf+p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k9Tj77WA;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZlZWTf+p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k9Tj77WA;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224ixMrNvJpA5PKMPwoIYlPo10n+bUu97SvKMQox3dU0gfTKTpmaLELDANYbLEW6s67glBL3Lw==
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
Cc: green.hu@gmail.com
Subject: [PATCH v7 34/37] dt-bindings: nds32 SoC Bindings
Date: Tue, 13 Feb 2018 17:09:38 +0800
Message-Id: <d8d6fc1ab339328f6f7de9764a62b28bdf999c7a.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds nds32 SoC(AE3XX and AG101P) binding documents.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/nds32/andestech-boards     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/andestech-boards

diff --git a/Documentation/devicetree/bindings/nds32/andestech-boards b/Documentation/devicetree/bindings/nds32/andestech-boards
new file mode 100644
index 000000000000..f5d75693e3c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/andestech-boards
@@ -0,0 +1,40 @@
+Andestech(nds32) AE3XX Platform
+-----------------------------------------------------------------------------
+The AE3XX prototype demonstrates the AE3XX example platform on the FPGA. It
+is composed of one Andestech(nds32) processor and AE3XX.
+
+Required properties (in root node):
+- compatible = "andestech,ae3xx";
+
+Example:
+/dts-v1/;
+/ {
+	compatible = "andestech,ae3xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+};
+
+Andestech(nds32) AG101P Platform
+-----------------------------------------------------------------------------
+AG101P is a generic SoC Platform IP that works with any of Andestech(nds32)
+processors to provide a cost-effective and high performance solution for
+majority of embedded systems in variety of application domains. Users may
+simply attach their IP on one of the system buses together with certain glue
+logics to complete a SoC solution for a specific application. With
+comprehensive simulation and design environments, users may evaluate the
+system performance of their applications and track bugs of their designs
+efficiently. The optional hardware development platform further provides real
+system environment for early prototyping and software/hardware co-development.
+
+Required properties (in root node):
+	compatible = "andestech,ag101p";
+
+Example:
+/dts-v1/;
+/ {
+	compatible = "andestech,ag101p";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+};
-- 
2.16.1
