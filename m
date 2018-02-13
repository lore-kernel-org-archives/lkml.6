Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513190-2-14243288407818309703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513189; b=s+P6+/K4w9BQTCSRpkwcK5uZn72CGlOYze8ZeCqV7rFLYq7
    rGWPcq7iFbmgpyTwN4SwDBPBe1tHG66y2uvs4Z6bEnHho0s5wtM7CZh3OHUfUVFx
    U3Bt9NT7eSAjq10eg8t4vcD7Bzbzy5xwjS3A7f0PWjKjPaS3M9FaRTPK74zp0Iyn
    kVk0EsqTenfe9fB+xlifrgpMNlEcfFornYW609r8FGKEBb1BsHtChzUrq5NyknHb
    toQwLYLs7nB6l+p0TkaoznBrZr0zOoevJCeDbrruMURJIzXXBA3+UbSizn/XHtrV
    Eap1hwJDmhcjx3bHF/ceIEJIMNMCpqaa1EsG4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513189; bh=H33K6T7Mfq3OTKyuBkOcF9dTSFyxL0FZbTzUmXKULKg=; b=v
    n4fVzpNSObTrPcjpYXTsYsrRlMg8XuczL4AfdpFoKRFOR0LoSL+KvLz9ewwTblMt
    MF/zGPengBPARt0Iu19vau8gg7W6vxdVn2+TTKgj3LBCGgEYM3VYrPYTKaxdGnUQ
    A/DJrp3+FX+pHf6xGHjsI49XHmqlD5OEZVgFTxGdNW6RUUVDVt2E7lZu47OTRdZF
    vi/WO3D81dExs3DCqC058emceQAFhCeUqn4A3avskSYO7MLQgBvQiskkaoTGYYT2
    OsLRi7GvG7fnmoBmnY/wObpaQzjUKvvwYEyoglsp+PTUi2gxJRbj5iDpqHXATtpy
    Hdz2srlZPGHK/m+zzkTug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mvYmCh8R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U3ORW1hn;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mvYmCh8R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U3ORW1hn;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225qgplCaSFjq4t7uWZbeAnWO15FKTpzdjAp7/45S+N9ncKlJjU59QktEHutVipQkm6UnLsR5A==
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
Subject: [PATCH v7 31/37] MAINTAINERS: Add nds32
Date: Tue, 13 Feb 2018 17:09:35 +0800
Message-Id: <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a maintainer information for the nds32(Andes) architecture.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..bf7c2ac6bb5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -868,6 +868,17 @@ X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 
+ANDES ARCHITECTURE
+M:	Greentime Hu <green.hu@gmail.com>
+M:	Vincent Chen <deanbo422@gmail.com>
+T:	git https://github.com/andestech/linux.git
+S:	Supported
+F:	arch/nds32
+F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
+F:	Documentation/devicetree/bindings/nds32
+K:	nds32
+N:	nds32
+
 ANDROID CONFIG FRAGMENTS
 M:	Rob Herring <robh@kernel.org>
 S:	Supported
-- 
2.16.1
