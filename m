Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513199-2-6198633454962190705
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.66', Host='mail-pg0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513199; b=iFPQ22shMXZ4HYhIxEPtIq+0FUVWtbRDJcVsW0CGJ3VLeAu
    yXO2xhpcTOhcKn01GdRlV37RVxVYoyf48Wjhnm+/8lw6yz6D7GGEsGHN/FyhFIBZ
    ZEwDnIRkSDl7jqAH0jy3hkv3MsMYQug0pvEiryoMawGbGd6BxZEAbXKgaJ2lL2Vm
    P96xF1DDXcbJ/wNVMK2hhdD2aDLJEtrsH8t6BUPhoe2opu5oL5A8ekXNyKUDFh+Y
    zaU/nsK5Z9b/mBm/KD4btF6bt7HhlRSgdCbjIfozvukj1Od9lt+dbycHdqZHcPWu
    /14c4brChHs1nfuyvlx/aXB6ydjAfyj7aUmKKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513199; bh=9GNN5/eDYaRTcQL8+bleNVpe4Rx30K78mmkR8uC1MrQ=; b=D
    TPqSESE+1Ja0g/e7WZinStBv5fRcU4Ng5xbNIg+9mkJTt6cjiERKIqGRwnC5hmCH
    YZL1u0bS9Z5zW3fsnTvCdlHe8lGPaJ627l6EVul8R777gTLN4479i2JGpRMd2A7d
    f99JtI+GbLTkrEziqtGq41nkoivlwWrja4UW9rqsqvkwkw1IZSqBMM63LsV/iEN9
    WwwrGReNf1BMJu4X8ujiuWpvMIb9eJfF7VRrnsafHO6QFDdzPQsUuPQjnJQlUdxg
    IjQ/uFn/tGxdq+/+GURoLvTSqEk7YuSHUprSgD8c/msUUGmLUso3ZGIGU3jdwd0L
    tczeRDWk1cgi/bqzibhUw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KSeL7CLU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d/gPT/bn;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KSeL7CLU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d/gPT/bn;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225fe9IihPoCyE5KFu41atCLzDlTzl6z2ofRs2ZLCNRMhmEOB5Mfwc0k3zjAPh6QRDH+YVGMng==
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
Subject: [PATCH v7 33/37] dt-bindings: nds32 L2 cache controller Bindings
Date: Tue, 13 Feb 2018 17:09:37 +0800
Message-Id: <98f2057a0a26cfba1220386ebb9a0c389ac9c95b.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds nds32 L2 cache controller binding documents.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/nds32/atl2c.txt | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt

diff --git a/Documentation/devicetree/bindings/nds32/atl2c.txt b/Documentation/devicetree/bindings/nds32/atl2c.txt
new file mode 100644
index 000000000000..da8ab8e7ae9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/atl2c.txt
@@ -0,0 +1,28 @@
+* Andestech L2 cache Controller
+
+The level-2 cache controller plays an important role in reducing memory latency
+for high performance systems, such as thoese designs with AndesCore processors.
+Level-2 cache controller in general enhances overall system performance
+signigicantly and the system power consumption might be reduced as well by
+reducing DRAM accesses.
+
+This binding specifies what properties must be available in the device tree
+representation of an Andestech L2 cache controller.
+
+Required properties:
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: "andestech,atl2c"
+	- reg : Physical base address and size of cache controller's memory mapped
+	- cache-unified : Specifies the cache is a unified cache.
+	- cache-level : Should be set to 2 for a level 2 cache.
+
+* Example
+
+	cache-controller@e0500000 {
+		compatible = "andestech,atl2c";
+		reg = <0xe0500000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
-- 
2.16.1
