Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBJOOU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:14:20 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40158 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeBJOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:14:18 -0500
X-Google-Smtp-Source: AH8x225HKhsQhK0yLxRf1PGTna+J0sjpXX1kMdwbY9X6YEptBhlEtO7lAJlDLslRPtbcoSpDVqfrcw==
Date: Sat, 10 Feb 2018 15:14:05 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com
Subject: [PATCH v2] auxdisplay: img-ascii-lcd: kconfig: Remove MIPS_SEAD3
 reference
Message-ID: <20180210141405.syaeuuktkebsp5jy@huvuddator>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-17-ulfalizer@gmail.com>
 <CANiq72kaCDcUHFuJ0P4CA-0KGgg+a8T+66p0aPwatAjfvDB8bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72kaCDcUHFuJ0P4CA-0KGgg+a8T+66p0aPwatAjfvDB8bA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3f5f0a4475e1 ("MIPS: generic: Convert SEAD-3 to a generic board")
removed the MIPS_SEAD3 symbol and moved the setting of IMG_ASCII_LCD to
the board-sead-3.config defconfig file, but IMG_ASCII_LCD still
references the removed MIPS_SEAD3 symbol.

Remove the reference.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
Changes in v2:

 - The wrong commit was referenced in the commit message.

 - Mention that IMG_ASCII_LCD is now set via the board-sead-3.config defconfig
   file.

 - Clarify that Kconfig is involved. The previous commit title was
   "auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 reference".


 drivers/auxdisplay/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 2c2ed9cf8796..3cba78d36eec 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -137,7 +137,7 @@ config CFAG12864B_RATE
 config IMG_ASCII_LCD
 	tristate "Imagination Technologies ASCII LCD Display"
 	depends on HAS_IOMEM
-	default y if MIPS_MALTA || MIPS_SEAD3
+	default y if MIPS_MALTA
 	select SYSCON
 	help
 	  Enable this to support the simple ASCII LCD displays found on
-- 
2.14.1
