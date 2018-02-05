Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBEEHn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:07:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:16813 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751979AbeBEEHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:07:39 -0500
X-UUID: 7b2c3e2a3e994417a2ad146de51fef4b-20180205
Message-ID: <1517803655.1173.12.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD
 device
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>
Date: Mon, 5 Feb 2018 12:07:35 +0800
In-Reply-To: <72058f8d-c83d-d0e6-dc07-83c9f5fc2710@gmail.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
         <d6669277f5232446b4798a6b724074b18d5c21aa.1515639336.git.ryder.lee@mediatek.com>
         <72058f8d-c83d-d0e6-dc07-83c9f5fc2710@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-03 at 15:26 +0100, Matthias Brugger wrote:
> 
> On 01/31/2018 08:42 AM, Ryder Lee wrote:
> > As the new MFD parent is in place, switch probing method to adapt it.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mt7622-aud.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> > index 13f752d..8c18536 100644
> > --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> > +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> > @@ -142,11 +142,12 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
> >  {
> >  	struct clk_onecell_data *clk_data;
> >  	struct device_node *node = pdev->dev.of_node;
> > +	struct device_node *pnode = pdev->dev.parent->of_node;
> >  	int r;
> >  
> >  	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
> >  
> > -	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> > +	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),
> 
> We will need a fallback here for older device tree bindings.
> 
> Regards,
> Matthias

Up to now, I didn't see both driver and bindings are used anywhere.
Should I still care about that?

Thanks.
