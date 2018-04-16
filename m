Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4+CFUyWUV07IMwdllSZ7eQG1XGSADQ5kzmu4Gpt1/HfbLt/njLwMLf2uqgW91/tRuK419en
ARC-Seal: i=1; a=rsa-sha256; t=1523893352; cv=none;
        d=google.com; s=arc-20160816;
        b=EFFsSjZdDhB218cavY9LzANdLh1cJbFRpiOm6TKDoR+sSseNMQXmArKc/jXxJ0D5bS
         codbu4nrb08dZ6ItHoHBaYWdn94ESBqhsKApy8BeUXqwNXAb7vzbbFpN+K5uQV6+b9Y4
         y6VepntyuhWiNuWfRgx10gEtZt9keF9QkFipzTf0cL38IMOcnjj9z51lZCPZpXusZa5O
         MIIKH7BF0e0EefBjTE4SNHqIEhI8Op+aYbFrjQT7pQo+66w52ikK5nNc2QXzEJMhJq+j
         63/9Mqm2fyanJXEMwd0K5oBmtrQLnNUb5hHf4CQ/vWpM5kXkTDofIKiragBQznBCfhuy
         h3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=xYSM9Qb1MQG/0LnCI922LcJpXJR80XGJBen3B9H/aNI=;
        b=wUhf1Eqj/AfRLNk77ZeDttv2WtLff/noUgI041hxj/u1UEoIRtJVaGV12ry2YMF4z9
         WlUHmP4gvy3OjylOIbsbzoeyGLcZ84SqAqwpzDgMjyrygFpHe/KUfHCPbjYmTIKupKih
         unE1JxCETNxFtje2KQpv8qgIG/a6K8SINH5i16wf9/RFtAfjadIP2zG21CGLLDPyLtkD
         1kAnnGnNVVX7E49WQq/QWLEe6qWqE/LuoA9diwWrcO8adUSeSzH3trlW7Ym/BeixQJAu
         VySwemlISRBspQg33QzFuyhfeA10w38Z1nX1bFrCWf8Dh8gYVyCtK6FVv+nlLgkO0Pta
         /iGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=w8KRbQG8;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=w8KRbQG8;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w3GFfg6B014506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mathieu Malaterre <malat@debian.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>
Subject: [PATCH] MIPS: dts: avoid unneeded built-in.a creation in vendor DTS directories
Date: Tue, 17 Apr 2018 00:41:30 +0900
Message-Id: <1523893290-7958-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597917995942758168?=
X-GMAIL-MSGID: =?utf-8?q?1597917995942758168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

arch/mips/boot/dts/Makefile collects objects from sub-directories
into built-in.a only when CONFIG_BUILTIN_DTB is enabled.  Reflect
it also to the sub-directory Makefiles.  This suppresses unneeded
built-in.a creation in arch/mips/boot/dts/*/ directories.

While I am here, I replaced $(patsubst %.dtb, %.dtb.o, $(dtb-y))
with $(addsuffix .o, $(dtb-y)) to simplify the code a little bit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/dts/brcm/Makefile          | 2 +-
 arch/mips/boot/dts/cavium-octeon/Makefile | 2 +-
 arch/mips/boot/dts/ingenic/Makefile       | 2 +-
 arch/mips/boot/dts/lantiq/Makefile        | 2 +-
 arch/mips/boot/dts/mscc/Makefile          | 2 +-
 arch/mips/boot/dts/mti/Makefile           | 2 +-
 arch/mips/boot/dts/netlogic/Makefile      | 2 +-
 arch/mips/boot/dts/pic32/Makefile         | 2 +-
 arch/mips/boot/dts/ralink/Makefile        | 2 +-
 arch/mips/boot/dts/xilfpga/Makefile       | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index d8787c9..d85f446 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -34,4 +34,4 @@ dtb-$(CONFIG_DT_NONE) += \
 	bcm97425svmb.dtb \
 	bcm97435svmb.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
index 24a8efc..17aef35 100644
--- a/arch/mips/boot/dts/cavium-octeon/Makefile
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)	+= octeon_3xxx.dtb octeon_68xx.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index 5b1361a..9cc4844 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -3,4 +3,4 @@ dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
 dtb-$(CONFIG_JZ4770_GCW0)	+= gcw0.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index 51ab9c1..f5dfc06 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_DT_EASY50712)	+= easy50712.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index c511645..3c6aed9 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
 dtb-$(CONFIG_LEGACY_BOARD_OCELOT)	+= ocelot_pcb123.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index 3508720..b5f7426 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -2,4 +2,4 @@
 dtb-$(CONFIG_MIPS_MALTA)	+= malta.dtb
 dtb-$(CONFIG_LEGACY_BOARD_SEAD3)	+= sead3.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
index d630b27..45af422 100644
--- a/arch/mips/boot/dts/netlogic/Makefile
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -5,4 +5,4 @@ dtb-$(CONFIG_DT_XLP_FVP)	+= xlp_fvp.dtb
 dtb-$(CONFIG_DT_XLP_GVP)	+= xlp_gvp.dtb
 dtb-$(CONFIG_DT_XLP_RVP)	+= xlp_rvp.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
index ba9bcef..fb57f36 100644
--- a/arch/mips/boot/dts/pic32/Makefile
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -4,4 +4,4 @@ dtb-$(CONFIG_DTB_PIC32_MZDA_SK)		+= pic32mzda_sk.dtb
 dtb-$(CONFIG_DTB_PIC32_NONE)		+= \
 					pic32mzda_sk.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index 94bee5b..6c26dfa 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -6,4 +6,4 @@ dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= mt7620a_eval.dtb
 dtb-$(CONFIG_DTB_OMEGA2P)	+= omega2p.dtb
 dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 9987e0e3..285973f 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
-- 
2.7.4
