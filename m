Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4352084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544621587;
	bh=5ChCtH3Tc+O6CY4zHCh78LRvo9uIS0nX7aBcIemIIio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q8EQI9h0fniCBLTdJzKPoao6A/lMv8Ud/bAlbL9JcURiU8qxh5s13YT09ZZ0z67Z5
	 vNxTsmLIT+3cJNC0fysHJVn+/NySeSJHXiP4YlFZ0+q+Olu2LKeQnLyzhVTpArsqsL
	 haWeTRkTscFGLvI0quVhkFoSXsENJfql6FkM0tBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4352084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeLLNdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbeLLNdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:33:06 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C3620879;
        Wed, 12 Dec 2018 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544621584;
        bh=5ChCtH3Tc+O6CY4zHCh78LRvo9uIS0nX7aBcIemIIio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IDQ2RJFbU/lMBsN0UCXLyu8ClKDJhpEFNcqYrHkIsEhToc+y9pRHJcFcUyLvaE8mx
         WAPE7q1OVQ5zU14pJzw1TC2Vf9bCCBgDjp60EsMdYIYhtXe3JL+9+f5U76YDW7ICoN
         cjBpLQyPMrOYgZZlJYiR2vz/NvpnQiYxwrsTRdJY=
Received: by mail-qk1-f179.google.com with SMTP id y78so10686130qka.12;
        Wed, 12 Dec 2018 05:33:04 -0800 (PST)
X-Gm-Message-State: AA+aEWZfyvIRWBiMcPWS/CxTxjUuAbTPVW6vxrrRKlDvmfTo+dddAeiE
        4tgOkzY6A0+C4X6tSYavZ0j8FZWp9zAMxKP81Q==
X-Google-Smtp-Source: AFSGD/VWPmfMJsZnvIrZRTIrLzNJoeSuct9pEZVkSFdyZBMCcJICWHsQ+1bNMnqVlVogBRZUC7SPyYiw1pEFluN9JUI=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr18472219qkg.147.1544621583631;
 Wed, 12 Dec 2018 05:33:03 -0800 (PST)
MIME-Version: 1.0
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
 <20181211221324.GA14658@bogus> <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
In-Reply-To: <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Dec 2018 07:32:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
Message-ID: <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:13 AM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 12.12.2018 00:13, Rob Herring wrote:
> > On Tue, Nov 27, 2018 at 11:57:25AM +0000, Claudiu.Beznea@microchip.com wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> Add documentation for regulator modes and suspend states.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> >> index ac955dea00d1..4017527619ab 100644
> >> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> >> +++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> >> @@ -15,11 +15,17 @@ Optional input supply properties:
> >>    - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
> >>
> >>  Any standard regulator properties can be used to configure the single regulator.
> >> +regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
> >> +specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
> >> +file.
> >>
> >>  The valid names for regulators are:
> >>      REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
> >>
> >>  Example:
> >> +
> >> +#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
> >
> > This file belongs in this patch.
>
> I'm using the defines in this file also in driver. I was thinking that if I
> would include this file in this patch the driver compilation would fail if
> the patches would be accepted via different trees.

They won't be.

> Would you like me to have different defines in driver and this new header
> or could happen that these patches to be included in the main tree via the
> same tree (e.g. regulator tree)?

No need for different defines. The subsystem maintainer will take
everything in this case.

Rob
