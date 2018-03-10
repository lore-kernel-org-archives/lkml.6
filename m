Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvisndpFrojrdet0tv7qMp1yFg1es0WuHhQdF9XeD9c970a4S/q0wE92QZjHclNf5YIs2wx
ARC-Seal: i=1; a=rsa-sha256; t=1520641226; cv=none;
        d=google.com; s=arc-20160816;
        b=IA0r+JPynOUtClOiFVSojpuKO1ImQxmACkLK79ElImVpAMPbeQnALtjMe9f56lWke0
         11Lz95D+/ITPiFIv73/DmgTP2FCTeHakJwDWf5o5Ws8P/zuDSCgyJU+k/ICr9smORevl
         XfxWrQKkexJPzxIVSVM2QJAPICUtH9YUpZIN9JxJBTC0eVoeDuUfRbKXNEETAJFzbqPf
         l658M1eV4+udQcb1LgApr/m72TXbDN3oW4vk4NoTg5kkz6HGcUJm76g2qeoZl9QF0LH2
         rXvgk2GjRKIFSEDJkD0yN+QiOb8dfZigCGOkCa5wvPbzLy3tD6sKzfz9ImpuDJWWnix6
         Qq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ENZp48t8Ifbg3fBZ1oHIpx9ochiXUyoHYpJrcSrdaHc=;
        b=a8HCqT60Tqbw8qxat75LXKZl7/M7arhdy3cS0bD5k2WQSNM3OD1NtzlGaNC3eJuVt/
         rAQsBNMFj52ZOyNTsNCaE2den327VETm3hT58RmLtt5bM3xrrYbHCVeEH0qf60u2nEiP
         grkO89uv/PzPnV9Yq3dRgNCo+IujGihbr6Dra2GS3YpcGsmlu/WwQ9d0040o9hoaogMf
         0W4Pto7/XTZYESllzpI83WzXgIfZVPp55nWNtauFzS5xALJzEdG7+37H+DsC0/R/Kyuy
         yJUOu2Nt7Zz5pBNZq/ZwFEvNaundMoTDQ+avMW8kJCrUdKyNADHSCzXs2khqXbmXaRsk
         T1qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.4 09/36] ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
Date: Fri,  9 Mar 2018 16:18:25 -0800
Message-Id: <20180310001807.718853915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507808977901535?=
X-GMAIL-MSGID: =?utf-8?q?1594507894813068413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>

commit 8aa36a8dcde3183d84db7b0d622ffddcebb61077 upstream.

The MACH_ARMADA_375 and MACH_ARMADA_38X boards select ARM_ERRATA_753970,
but it was renamed to PL310_ERRATA_753970 by commit fa0ce4035d48 ("ARM:
7162/1: errata: tidy up Kconfig options for PL310 errata workarounds").

Fix the selects to use the new name.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.
Fixes: fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
PL310 errata workarounds"
cc: stable@vger.kernel.org
Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-mvebu/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,7 +37,7 @@ config MACH_ARMADA_370
 config MACH_ARMADA_375
 	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select HAVE_ARM_SCU
@@ -52,7 +52,7 @@ config MACH_ARMADA_375
 config MACH_ARMADA_38X
 	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_38X_CLK
 	select HAVE_ARM_SCU
