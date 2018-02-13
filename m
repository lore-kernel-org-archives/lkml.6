Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513061-5-6146642802732049769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.66', Host='mail-pg0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513061; b=fI45nhOWr+/ploWT4ud1o77y2zccRP/U0d0dD/q0+g71sHN
    Bhtl64jAG/3vfaxDT1d9iL+OmIsfXIdxvXVzas1UdrfCsfmasnIbYu8+55iHETbt
    mNu2LnYctDkSJZDDrPOITa/yT5Hc319VwyWwJsuuAlOApdnc8TROzd7KlIE5x1XO
    HGpcV6TCrVtl5IiufWvC1Ehx1JopXLZAoxoQTPyTvMtyFV6GGvjBgvZ7+GfQScBd
    a2dUylYigRz92ySGOtgfzK8voeYnXN77L01doLj7j9lQqBQqlPir/yENrGvRrsX1
    dYgP9t/WdNArEkluQvzlc+xt4Yp1SmNnC1LkB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513061; bh=x3FTzZHXxHvAUhh6d+9ZQkYzOrGoDthddBEATx8T3DI=; b=g
    mg5cNw+sM16/wVV0pqyrg6ce7EFnWBls4Yus938cA0zSnmkJHXZzQrMcCjA3xX1q
    19ak5qN06WHGItoLSMYk2pjGlHdzpNAOl8EFq5Cj/R/hpoBc5M45jD+ki29sjhqz
    RsfVvv15KS7H0qKUAecGBEbhbxufpo8AVaq61LJJJ8N07OftMBHOdpET+RwVbLmk
    Dq6nnFp5dy99tQg53QnokdH03MPJCfdk7RyzKprXVrz9XKeGi+Ke6v1PC3gByAwQ
    /ZqiBW/Ar9i7+EsDru3V2OtmNt/11fRr9uIYUKBMMQQdl79iUqhohC0bocjCuPwE
    YUdePGvTeQWwa6p/3QZOQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ixieXlXc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PpRIKqhP;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ixieXlXc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PpRIKqhP;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225Cne1vWR1mXO0KBvA2ahFvOm3cLgdhWCMGbzRyERmEedXSJKOziL6Ls2I2Ho1FhZDmNbl5uA==
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
Cc: green.hu@gmail.com,
	Peter Hurley <peter@hurleysoftware.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 04/37] earlycon: add reg-offset to physical address before mapping
Date: Tue, 13 Feb 2018 17:09:08 +0800
Message-Id: <968497070242f849dd70ab1fa81635451f8fda7f.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It will get the wrong virtual address because port->mapbase is not added
the correct reg-offset yet. We have to update it before earlycon_map()
is called

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: stable@vger.kernel.org
Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT properties")
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/earlycon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 870e84fb6e39..a24278380fec 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -245,11 +245,12 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	}
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
 		port->mapbase += be32_to_cpu(*val);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
+
 	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
 	if (val)
 		port->regshift = be32_to_cpu(*val);
-- 
2.16.1
