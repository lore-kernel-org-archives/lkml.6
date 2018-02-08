Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBHXPn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:15:43 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40215 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHXPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:15:41 -0500
X-Google-Smtp-Source: AH8x2266jP4EFjD2KS4LDBsLQfkRBSiqozYTDDchHi4lVn1T43ih5WKePpWMVm+SfJ+c/CZA9hsQMw==
Date: Fri, 9 Feb 2018 00:15:36 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        alsa-devel@alsa-project.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] ALSA: ac97: kconfig: Remove select of undefined symbol AC97
Message-ID: <20180208231536.xnlrldm4to4pfv57@huvuddator>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <CAFkk2KRafUf3ki2R7B1pE_wzYkYn-OdeqLnvL0kScSxdzDMEXw@mail.gmail.com>
 <87lgg587ys.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgg587ys.fsf@belgarion.home>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AC97_BUS_NEW Kconfig symbol selects the globally undefined symbol
AC97.

Robert Jarzmik confirmed in https://lkml.org/lkml/2018/2/7/96 that the
select was put in by mistake and can be safely removed, with no other
changes required. Remove it.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 sound/ac97/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/ac97/Kconfig b/sound/ac97/Kconfig
index f8a64e15e5bf..baa5f8ef89d2 100644
--- a/sound/ac97/Kconfig
+++ b/sound/ac97/Kconfig
@@ -5,7 +5,6 @@
 
 config AC97_BUS_NEW
 	tristate
-	select AC97
 	help
 	  This is the new AC97 bus type, successor of AC97_BUS. The ported
 	  drivers which benefit from the AC97 automatic probing should "select"
-- 
2.14.1
