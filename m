Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7432C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964F520817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964F520817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeKHLot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:44:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48830 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728540AbeKHLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:44:48 -0500
X-UUID: 9e352ba2feab4fe2980993515ead938b-20181108
X-UUID: 9e352ba2feab4fe2980993515ead938b-20181108
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 94144425; Thu, 08 Nov 2018 10:11:28 +0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 8 Nov 2018 10:11:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 8 Nov 2018 10:11:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 8 Nov 2018 10:11:12 +0800
Message-ID: <1541643072.23791.3.camel@mtksdaap41>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings
 for MT6797 SoC Pinctrl
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <amit.kucheria@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 8 Nov 2018 10:11:12 +0800
In-Reply-To: <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
         <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 02D1F885EC93A8EBF109608354F831C0FAC9070FDF064EAF73905E1C6B8D1BC52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-07 at 23:18 +0530, Manivannan Sadhasivam wrote:
> Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/pinctrl/pinctrl-mt6797.txt       |   83 +
>  include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 +++++++++++++++++
>  2 files changed, 1451 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
>  create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> new file mode 100644
> index 000000000000..bd83401e6179
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt

Sorry if this is discussed.

What's the difference between this and
Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt?
Should this be added to pinctrl-mt65xx.txt?

Joe.C


