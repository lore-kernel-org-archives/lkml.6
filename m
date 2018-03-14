Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELtxk0UdF5/NicSf1exwQxjWv0f2U6wHYZJcrPfXgEiwGvkJn0Db8mVBap0g9WFJ9Hv3vQgg
ARC-Seal: i=1; a=rsa-sha256; t=1521041845; cv=none;
        d=google.com; s=arc-20160816;
        b=Nk1oRS87fUiB9bQ0rloJIl/sff64JbTmtsSB+ElrVO0ZmLd7YdjGCmHjSbQAypqaC/
         VFJGHarGlYqnie5FN5v5Jt27bdVjLzPS7UGaH/bzCVMwu3vKTTcMsLMtpg3AX4yUzzBd
         Mt0ckyRmG4ZZ+T6XiwEBb+cGhCEUsnEq9Q/sr0XT/ko/DeG9HowdBiLp/sN5MvWSq6UW
         HAoIdOwVmWV1rZrUrnG+t7MGBeoLGJZNAJGI5i6u7JgFGD3Bm/XApljUXy0HCeL2mpsI
         Njh0gs4zVvBdaHkWknpNSxInW20u3nvwH9lJ9ZLRTWNJfcR3Ub2+QunDwFsfWISr6Gx3
         g8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=d3jAN6+UophfEBxqFo4bnnCnhQUQvIyazQ1KzRIjkCs=;
        b=cIUjfiq1bhv/W69N4QYkRqzMLvs569CeklUOlk6pWnm7DzSg7Ws7u69bM3MXCtRJuC
         IYmd/m6f+ik6pR3JXGGWY2Lixmcp5CFV7dIr+M3Oxn4YbuXecV19+fz1zhlI3lvfLcIx
         iIxAYxCqJOcfV5bO3QSOubGrF8mSI5cTg/195MW6pYVyP5IIYPXOFqB6ayl95OC5e3Xa
         2YnDGAsGvfqlPhf5DTOV6ENVSq76kCqhv/0xu/IYeeeXLm5Xd9wwW7u/eXjk+jDXu1JO
         n0VQRrtQ+yFJMQqjEt1o9bO1J2wAmbIgJAGReunRCuM8icUDVJHtZLk8vhnp09vOpHkB
         PPtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Aviad Krawczyk <aviad.krawczyk@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	netdev@vger.kernel.org
Subject: [PATCH 03/47] net: adi: remove blackfin ethernet drivers
Date: Wed, 14 Mar 2018 16:35:16 +0100
Message-Id: <20180314153603.3127932-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:xUQtU036lsa8rt6MvjCi/xCSqfav5B7rJWOrN3vhsWDm+gnkMBR
 9RIss8joBbEzh+v6z94d/KpWzpmPQeC6Gx1hYOneZidgeBdeqdGGLDjXRgh8kXyf0VQlmBX
 ghJSPSugGQIZlL1h3xUMGZmJ/kHAL+580p/V1L0qF13fhoZ1gioEd6kcE2pQGa29lLKaRsH
 Wh3C37SKcmJ7Y4hdAJrvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NfmvE3ICjkg=:f+0wIIp/ENWtyDH/tXUj13
 F0AzH3qufr9SlCTmTkLiwGm08qN3KMEcevIq2+ubPiOB9cl6oj7epKRURKW6iy86AXJH+5rpW
 BM80d0pk9jezQrVXk+UWB/d/PP2KZoFAMwlmj2iEPqlywuLitgp2JL8n2uJcFIR+UGkbRU3iK
 aRl+OOXD5VuAJ4sFDlI6JYcrD60p9yLLmoY0l3AD4B2lal+BDdJm93oId/rBZ+OHa9ZgxQE/K
 g6/W8B2Od28tOZIb7v2XKMSchRATO+jw4aixaS9OcpnKWaYKea7lxavnpKzQH5A2rYx7xKO3c
 9vbKyD50fno0muC8Ya3lpaW080ZPvrCCDLFoeK5IA36PIPET/BVBJYqLVrE6UVwhJldVkedXL
 Q/7mb0b4aOYBindtKQDMdDSbBPivyOrQkxZZSB4NkOmPXjYgfsiM44ygX0+/k7RwAfLcD7ovI
 wXxTVNIPlCjrQ+qVRAbA43zYY8mZNLG9Nc8W1dw3IvHuU6Xa+d20/IOGkiB35TV74IjBK90IB
 ydfPnenb1q9arp1A2uqNv4pEL6y196otJIx6e0W6pkukhA4temHids2/aoSYaeZFSwkxpBnQ/
 2nd6CzLj5RCxzO7lAZZYEo2ZDSj8h6MnTGjrd0eH6ksmqxMr67hVKKmqZEue0qn0RHm45IVlf
 3ifvwWdrt/X0kFV/HBbfllRgjtPR44ohSl907y625hQH6EMONsHIU5hB1Mo+OYh+/HSyb0bn+
 3Z/+xvTIC3CtaO9Nio4+DmK7McXpxGEpWd0Bxg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594927973878236601?=
X-GMAIL-MSGID: =?utf-8?q?1594927973878236601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so the bfin_mac driver
is now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/Kconfig        |    1 -
 drivers/net/ethernet/Makefile       |    1 -
 drivers/net/ethernet/adi/Kconfig    |   66 --
 drivers/net/ethernet/adi/Makefile   |    5 -
 drivers/net/ethernet/adi/bfin_mac.c | 1881 -----------------------------------
 drivers/net/ethernet/adi/bfin_mac.h |  104 --
 include/linux/bfin_mac.h            |   30 -
 7 files changed, 2088 deletions(-)
 delete mode 100644 drivers/net/ethernet/adi/Kconfig
 delete mode 100644 drivers/net/ethernet/adi/Makefile
 delete mode 100644 drivers/net/ethernet/adi/bfin_mac.c
 delete mode 100644 drivers/net/ethernet/adi/bfin_mac.h
 delete mode 100644 include/linux/bfin_mac.h

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 92be1ad3df59..074d760a568b 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -34,7 +34,6 @@ source "drivers/net/ethernet/arc/Kconfig"
 source "drivers/net/ethernet/atheros/Kconfig"
 source "drivers/net/ethernet/aurora/Kconfig"
 source "drivers/net/ethernet/cadence/Kconfig"
-source "drivers/net/ethernet/adi/Kconfig"
 source "drivers/net/ethernet/broadcom/Kconfig"
 source "drivers/net/ethernet/brocade/Kconfig"
 source "drivers/net/ethernet/calxeda/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index edef6069dd4b..135dae67d671 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_NET_VENDOR_ARC) += arc/
 obj-$(CONFIG_NET_VENDOR_ATHEROS) += atheros/
 obj-$(CONFIG_NET_VENDOR_AURORA) += aurora/
 obj-$(CONFIG_NET_CADENCE) += cadence/
-obj-$(CONFIG_NET_BFIN) += adi/
 obj-$(CONFIG_NET_VENDOR_BROADCOM) += broadcom/
 obj-$(CONFIG_NET_VENDOR_BROCADE) += brocade/
 obj-$(CONFIG_NET_CALXEDA_XGMAC) += calxeda/
diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
deleted file mode 100644
index 98cc8f535021..000000000000
diff --git a/drivers/net/ethernet/adi/Makefile b/drivers/net/ethernet/adi/Makefile
deleted file mode 100644
index b1fbe195d0e8..000000000000
diff --git a/drivers/net/ethernet/adi/bfin_mac.c b/drivers/net/ethernet/adi/bfin_mac.c
deleted file mode 100644
index 7120f2b9c6ef..000000000000
diff --git a/drivers/net/ethernet/adi/bfin_mac.h b/drivers/net/ethernet/adi/bfin_mac.h
deleted file mode 100644
index 4ad5b9be3f84..000000000000
diff --git a/include/linux/bfin_mac.h b/include/linux/bfin_mac.h
deleted file mode 100644
index a69554ef8476..000000000000
-- 
2.9.0
