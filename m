Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755310AbeEHNv5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:51:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35821 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755189AbeEHNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:51:53 -0400
X-Google-Smtp-Source: AB8JxZo8f4tzxcFNXAf21TyqcNJyUTWPYm11Ri7RAnmYbKlcjFmKhiRFUHpq4otcjSEDLAnhGONWag==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] kbuild: disable new dtc graph and unit-address warnings
Date: Tue,  8 May 2018 08:51:50 -0500
Message-Id: <20180508135150.27762-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508135150.27762-1-robh@kernel.org>
References: <20180508135150.27762-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtc gained some new warnings for OF graphs and unique unit addresses,
but they are currently much too noisy. So turn off
'graph_child_address', 'graph_port', and 'unique_unit_address' warnings
by default. They can be enabled by building dtbs with W=1.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
I plan to take this via DT tree as it is dependent on a dtc update in 
patch 1.

 scripts/Makefile.lib | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5af34a2b0cd9..1bb594fcfe12 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -251,6 +251,9 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-unit_address_format \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-alias_paths \
+	-Wno-graph_child_address \
+	-Wno-graph_port \
+	-Wno-unique_unit_address \
 	-Wno-pci_device_reg
 endif
 
-- 
2.17.0
