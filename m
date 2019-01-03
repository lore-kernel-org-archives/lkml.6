Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C1C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD2C2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfACOQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:16:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727650AbfACOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:16:50 -0500
X-UUID: e1d564f916d64e99b630e56d666104a1-20190103
X-UUID: e1d564f916d64e99b630e56d666104a1-20190103
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 803180767; Thu, 03 Jan 2019 22:16:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 22:16:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 22:16:34 +0800
Message-ID: <1546524994.6818.56.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance
 state support of scpsys
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Fan Chen" <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 3 Jan 2019 22:16:34 +0800
In-Reply-To: <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
         <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 10:17 +0530, Viresh Kumar wrote:
> On 02-01-19, 22:09, Henry Chen wrote:
> > Add support for performance state of scpsys on mt8183 platform.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 47926a7..e396410 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/power/mt8183-power.h>
> > +#include <dt-bindings/soc/mtk,dvfsrc.h>
> >  
> >  / {
> >  	compatible = "mediatek,mt8183";
> > @@ -243,6 +244,26 @@
> >  			      "vpu-3", "vpu-4", "vpu-5";
> >  		infracfg = <&infracfg>;
> >  		smi_comm = <&smi_common>;
> > +		operating-points-v2 = <&dvfsrc_opp_table>;
> > +		dvfsrc_opp_table: opp-table {
> > +			compatible = "operating-points-v2-mtk-level";
> > +
> > +			dvfsrc_vol_min: opp1 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
> > +			};
> > +
> > +			dvfsrc_freq_medium: opp2 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
> > +			};
> > +
> > +			dvfsrc_freq_max: opp3 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
> > +			};
> > +
> > +			dvfsrc_vol_max: opp4 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
> > +			};
> > +		};
> >  	};
> 
> I don't see a patch which makes use of this OPP table using the required-opps
> thing. Where is that ?
> 

Those user drivers of mt8183(e.g. camera, video decoder,...etc) are
still preparing, so I send this RFC series to check if it is feasible
first then they can apply the interface and send for review later.

Henry 


