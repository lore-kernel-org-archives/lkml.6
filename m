Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938630AbeBUQvC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:51:02 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55560 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbeBUQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:50:58 -0500
Date: Wed, 21 Feb 2018 17:50:54 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/19] soc: renesas: Identify R-Car M3-N
Message-ID: <20180221165053.xx6gqdyja2zfghmy@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVw4OSPP7XYLGuE7SfVjOk_6VK847NdsVwszBX9XshQ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVw4OSPP7XYLGuE7SfVjOk_6VK847NdsVwszBX9XshQ3A@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:40:34PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add support for indentifying R-Car M3-N (R8A77965) SoC.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/drivers/soc/renesas/renesas-soc.c
> > +++ b/drivers/soc/renesas/renesas-soc.c
> > @@ -149,6 +149,11 @@ static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
> >         .id     = 0x54,
> >  };
> >
> > +static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
> > +       .family = &fam_rcar_gen3,
> > +       .id     = 0x55,
> > +};
> 
> Note that the list was sorted by SoC part number.

Thanks, I have moved the above structure to between
the similar structure for m3_w and v3m. The result is below.

> > +
> >  static const struct renesas_soc soc_rcar_v3h __initconst __maybe_unused = {
> >         .family = &fam_rcar_gen3,
> >         .id     = 0x56,
> > @@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
> >  #ifdef CONFIG_ARCH_R8A7796
> >         { .compatible = "renesas,r8a7796",      .data = &soc_rcar_m3_w },
> >  #endif
> > +#ifdef CONFIG_ARCH_R8A77965
> > +       { .compatible = "renesas,r8a77965",     .data = &soc_rcar_m3_n },
> > +#endif
> >  #ifdef CONFIG_ARCH_R8A77970
> >         { .compatible = "renesas,r8a77970",     .data = &soc_rcar_v3m },
> >  #endif

From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH] soc: renesas: Identify R-Car M3-N

Add support for indentifying R-Car M3-N (R8A77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 000834321774..ea71c413c926 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -144,6 +144,11 @@ static const struct renesas_soc soc_rcar_m3_w __initconst __maybe_unused = {
 	.id	= 0x52,
 };
 
+static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
+	.family = &fam_rcar_gen3,
+	.id     = 0x55,
+};
+
 static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen3,
 	.id	= 0x54,
@@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7796
 	{ .compatible = "renesas,r8a7796",	.data = &soc_rcar_m3_w },
 #endif
+#ifdef CONFIG_ARCH_R8A77965
+	{ .compatible = "renesas,r8a77965",	.data = &soc_rcar_m3_n },
+#endif
 #ifdef CONFIG_ARCH_R8A77970
 	{ .compatible = "renesas,r8a77970",	.data = &soc_rcar_v3m },
 #endif
-- 
2.11.0
