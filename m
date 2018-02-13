Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513066-2-11317365944481497236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513065; b=BR2VGj8a6bzDWPbCnLOTtyphjmpZei1YfY4oy+qa6C4EL6d
    99j0w2Judb0uUcNKWZJcXOEH6rwnPCcSeRaVS/RF36Wg/CaMf2mXO7JKgPtvzcXg
    NCzUi6WMyxfNBLuoRzTaDFuD7U46F0SKAj0OD9o7GaY/TZxuuSb9rz0gAuZe0A//
    mDYdRk8Dlpvoo/TCojdA26oR+ssw6e9/LrEoF/Qnd7gmSsZyaJ0xVDkYCaCPol9B
    0OIqLutvgXy5oaSeTl4+dhLiKpP7srWvPTkHuLap7ZIA1JlnBXLq/zRg+x4NLIFS
    wnt3FSdDHO/8D8eEmeFOOgM8362cVjb2hqeqYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513065; bh=9Yn/fA77hc1YKuNfrPNOEHgPscZ00tHZH83YNlgDMj4=; b=Z
    OlMjUrodndkUUpXINyAIYuY4z4s/ueb8jE8qmcQAEnjC9B653NPxz+bfohzUfply
    aKpaE87rvQxj1iOEBhKcYd0WUqP/VYmryQiiHEft5XL3useuYbJ/smZHbeRV0I8n
    SauqYsC/Qt7g4cdD/GwOIar9Gt7b6GdxuUvQAwMlvH53GDJgFtO+pSMRumbHquFo
    N2s5PAL6AGNmtHgFSRC3SokNPenEYbHdE6R6GkPyVuUxFHy6QOkbz+RGaOmm5icc
    XUBzH82OVSQWKkvEOjlkEM+E9RPPRjr1BPblc54PUlzTWOVdzRhj+gfE/O05MNhq
    IopqFTjRtR7wnwblsY0Ng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B3A2gfKX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X1qm/PVX;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B3A2gfKX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X1qm/PVX;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227W0gj6RPOWvoXFggjsm7s+vSmgC2cPYMqF1eIxsBUgkedGB9PjBzAhaE+5LKl6UV2XtGRhUg==
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
Subject: [PATCH v7 05/37] drivers/video/concole: add negative dependency for VGA_CONSOLE on nds32
Date: Tue, 13 Feb 2018 17:09:09 +0800
Message-Id: <30ead4b33eb84bd2d0b2d51c7644d7733b14283c.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

nds32 does not support VGA console, so prevent that kconfig symbol from
being enabled for nds32, thus fixing these build errors:

  drivers/video/console/vgacon.o: In function `vgacon_save_screen':
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1327:
  undefined reference to `screen_info'
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1327:
  undefined reference to `screen_info'
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1328:
  undefined reference to `screen_info'
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:1328:
  undefined reference to `screen_info'
  drivers/video/console/vgacon.o: In function `vgacon_init':
  /NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:591:
  undefined reference to `screen_info'
  drivers/video/console/vgacon.o:/NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-nds32/drivers/video/console/vgacon.c:591:
  more undefined references to `screen_info' follow
  make: *** [vmlinux] Error 1

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..27bb893cf6b2 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.16.1
