Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELuOkliPc6LVdJc6DauriAfIoqfJNBGXrkozuhvhW1WXrLHkmGNrHTMoBnoMRxvU8O7ygmFB
ARC-Seal: i=1; a=rsa-sha256; t=1521041827; cv=none;
        d=google.com; s=arc-20160816;
        b=qoJX8EEIgPmojxDT+rhFk4pFrsvotZmnozBargIVuwiCDbCP97zkDqZOmtbuYbKsNc
         7fP75PfVCIJse9JKeXmCFeTFdXW5kRLkWFIhRRxhOR3KnNkPBnvIBXhc0TbH7ZdknPi/
         ygd7J4f9xX5Hk1XsIyLxyk4b4KJycxOVcQlRjlNhvzlFwqQJAdKvhAHlfvX8NQLKfmLy
         qaeZ3wZWMF9CZfTAYvg1b5h5HcJ/VZkJ06y3vN1Hna+yjzmFboI0iWbfixV0U1R6ZwA8
         5tJJ3KTV0vmRtR2YqYk+e/S5hxlj5/3W7yrACT6wbUtP7i6nPe9kC/AqifVMl6YA0mqd
         vu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=u+78dRGSavScXNuu+bzfUNnxBdC1dp/JMQNgN7lE0E8=;
        b=QOQU6OZ+INC2+x2PgOzfdkMXj63OsfV9E7HHOWKb0eknlp670RAnlSyCqskWH0IGTo
         TdhEx0W/TqiQkHldjXnWbeveryRAwrihL0R1XxDfxUysSvjnI1Ux5UtTe4soTHUPv2AK
         bWiHKzQgfrm0hE1wsEtzjgZ6Dbm239CUA74w1zxb+5TUHc1SREj1hn+j2wndFXAY0JHu
         f7tCpjczWYhmCyc2Rl+krqgzM52it8HjRg5XRKQLdmXNan+do3OxCoNLBUXWyJk3Z4Ss
         qBq9gwtPUMqETKqDlTDVehqiR673NJMVL+p58RCqNzmgbkVYFm65ncdPDVfcSA1jHFsm
         SOwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.133 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.133 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Zhao Chen <zhaochen6@huawei.com>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Aviad Krawczyk <aviad.krawczyk@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org
Subject: [PATCH 02/47] net: tile: remove ethernet drivers
Date: Wed, 14 Mar 2018 16:35:15 +0100
Message-Id: <20180314153603.3127932-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:V29GfJZr6x8WcVn3AUUkIhFxRFiLo+v9Bebkdw+s9Jf8hs4ro2h
 Ou/Z5aiyKCxMPfahiGtZmwlUd2k5d9xYBov7SAVRFqESIdNc6m+fk1eD84CROprL9nUdhKt
 hTCt3UfiNCwPwaG3MROHXK+/YxRGbF5Nvf82TOuYyCuJh4yZoZ1KozFFxk/JXsiPHezBday
 htjuljB8Qrj90jsQJWHsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3wzt/buZ95g=:WQPDxAspxjZu9fsNBI54u6
 LMAZIYtRz+Hs5mEu5mZiJOkrh6c2QccpMDVypV5c055Pba6Hh+rsgnn8XNBBbEFBUaznzeAAz
 QGRKC4Y3aCSSBY2JDJJrXbql5l32RhVsUfIue+5ttolcEHh0KC4/XJLGXJmzgKUcJDGw09XZB
 T/U3CqZSIZ3V1EKTcRvrHy53zwxhxLHb9UPSJkJAlJBJstLE8g4pn2B7kdSK1Rr/jkvUKlVMn
 FfwvtgT72hd7DA3xO1416TS0Jqd/5E3fXgsbt2k0ZURp5or0ZizysP2ptbeHkHM0AeFxj15vX
 MmdQ0CWbxlqDnuj8wZCN+W48YQH0+W0X37DdAPR60IPm2OZe0PCuGdEM5ttbknXVST1ZRulbH
 udo2viZq5CkTYAbTJzsNA+zb2uCdGFPzSIwDxQA8A9XBaPBH1jD9fC7mQZJFTaVusHwMBEYgH
 R3CN/TyMd16B8tRSyynNjfYAofv1tdbPWMAGFAncbqTm4dYW1rR7OweDnV1BcUEvY6GkQXkDm
 4yEQy6JDx69fhvYqiRgztQyTDgdEVMMrfjWPDPTALKwZWzjWq2PA2mYaNi47Mit/+olelV2S+
 GPmo4RXiciogNwhaVQ1mMxTwCitTrZvy+tNuplnwXdf6mQFZKaxsq9NUGgaOu3ZNUd4SaY4g8
 HX/dRuihar/qK/o+NxyztvnneUSMNz8gGqJdHbxiHeKsxrLKgmF8wSERKbADtQtEdij717La/
 2kIUyUuVXj+D6ofrQ8cGJmOiZxg65aNHa5zNgA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594927955022600655?=
X-GMAIL-MSGID: =?utf-8?q?1594927955022600655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tile architecture is obsolete and getting removed. From all
I can tell, later ARM based products use a different ethernet driver,
so we should remove this one as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/Kconfig        |    1 -
 drivers/net/ethernet/Makefile       |    1 -
 drivers/net/ethernet/tile/Kconfig   |   18 -
 drivers/net/ethernet/tile/Makefile  |   11 -
 drivers/net/ethernet/tile/tilegx.c  | 2279 ---------------------------------
 drivers/net/ethernet/tile/tilepro.c | 2397 -----------------------------------
 6 files changed, 4707 deletions(-)
 delete mode 100644 drivers/net/ethernet/tile/Kconfig
 delete mode 100644 drivers/net/ethernet/tile/Makefile
 delete mode 100644 drivers/net/ethernet/tile/tilegx.c
 delete mode 100644 drivers/net/ethernet/tile/tilepro.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index b6cf4b6962f5..92be1ad3df59 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -176,7 +176,6 @@ source "drivers/net/ethernet/stmicro/Kconfig"
 source "drivers/net/ethernet/sun/Kconfig"
 source "drivers/net/ethernet/tehuti/Kconfig"
 source "drivers/net/ethernet/ti/Kconfig"
-source "drivers/net/ethernet/tile/Kconfig"
 source "drivers/net/ethernet/toshiba/Kconfig"
 source "drivers/net/ethernet/tundra/Kconfig"
 source "drivers/net/ethernet/via/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 3cdf01e96e0b..edef6069dd4b 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -88,7 +88,6 @@ obj-$(CONFIG_NET_VENDOR_STMICRO) += stmicro/
 obj-$(CONFIG_NET_VENDOR_SUN) += sun/
 obj-$(CONFIG_NET_VENDOR_TEHUTI) += tehuti/
 obj-$(CONFIG_NET_VENDOR_TI) += ti/
-obj-$(CONFIG_TILE_NET) += tile/
 obj-$(CONFIG_NET_VENDOR_TOSHIBA) += toshiba/
 obj-$(CONFIG_NET_VENDOR_TUNDRA) += tundra/
 obj-$(CONFIG_NET_VENDOR_VIA) += via/
diff --git a/drivers/net/ethernet/tile/Kconfig b/drivers/net/ethernet/tile/Kconfig
deleted file mode 100644
index bdfeaf3d4fce..000000000000
diff --git a/drivers/net/ethernet/tile/Makefile b/drivers/net/ethernet/tile/Makefile
deleted file mode 100644
index 3d0ae1f07fc9..000000000000
diff --git a/drivers/net/ethernet/tile/tilegx.c b/drivers/net/ethernet/tile/tilegx.c
deleted file mode 100644
index b3e5816a4678..000000000000
diff --git a/drivers/net/ethernet/tile/tilepro.c b/drivers/net/ethernet/tile/tilepro.c
deleted file mode 100644
index 56d06282fbde..000000000000
-- 
2.9.0
