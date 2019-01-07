Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B773DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923372147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfAGLE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:04:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35703 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726888AbfAGLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:04:27 -0500
X-UUID: 3362d471a04d403cbb7a17bbe9257f95-20190107
X-UUID: 3362d471a04d403cbb7a17bbe9257f95-20190107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 160994866; Mon, 07 Jan 2019 19:04:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:04:14 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:04:14 +0800
Message-ID: <1546859054.6818.126.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on
 scpsys bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 7 Jan 2019 19:04:14 +0800
In-Reply-To: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
         <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 3D2415C0AEB49D232C6ED296E50AE70C96799812009A42BA4E753082113069E82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 12:45 -0600, Rob Herring wrote:
> On Wed, Jan 2, 2019 at 8:10 AM Henry Chen <henryc.chen@mediatek.com> wrote:
> >
> > Add opp table on scpsys dt-bindings for Mediatek SoC.
> >
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
> >  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> > new file mode 100644
> > index 0000000..036be1c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> > @@ -0,0 +1,24 @@
> > +Mediatek OPP bindings to descibe OPP nodes with level values
> > +
> > +OPP tables for devices on Mediatek platforms require an additional
> > +platform specific level value to be specified.
> > +This value is passed on to the mediatek Power Management Unit by the
> > +CPU, which then takes the necessary actions to set a voltage rail
> > +to an appropriate voltage based on the value passed.
> > +
> > +The bindings are based on top of the operating-points-v2 bindings
> > +described in Documentation/devicetree/bindings/opp/opp.txt
> > +Additional properties are described below.
> > +
> > +* OPP Table Node
> > +
> > +Required properties:
> > +- compatible: Allow OPPs to express their compatibility. It should be:
> > +  "operating-points-v2-mtk-level"
> > +
> > +* OPP Node
> > +
> > +Required properties:
> > +- mtk,level: On Mediatek platforms an OPP node can describe a positive value
> > +representing a level that's communicated with a our power management hardware
> > +which then translates it into a certain voltage on a voltage rail.
> 
> Work with the Qcom folks and create a common level property.
> 
> Rob

Ok, I see the reply from Rajendra on
https://lore.kernel.org/patchwork/patch/1027082/
I will follow the new common property, thanks.


