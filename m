Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486DEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1819520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548968763;
	bh=btNfkjQVHvcWdFhRlQwZsiVcv+LPRfd7uNPHVSwQ+OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aBBeShU+2/S61sLUsAYUXypNj82e0EQ/0ElQVZ6afRVHMSbZomgfWwe5OcFGi4+fw
	 VB/HCCVES4w7aD8COdmvmiR1102/aHH5jtUIUH/RT50uRdGBn9RuRPotLXX6e66iaj
	 gIA4ke9x/Pxpa1Z2HXjscaE66xEF+3CjHApzloa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfAaVGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfAaVF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:05:59 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEC4218F0;
        Thu, 31 Jan 2019 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548968758;
        bh=btNfkjQVHvcWdFhRlQwZsiVcv+LPRfd7uNPHVSwQ+OU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oP4Q4XVAZOovPdTfqpue0S2xmFE+YjJRLhsYtvglwWIYY0uRj6Vd38UK/ZXKZ73xU
         K/rRSB6+oLV0UwfWcTiKZQ1ryWuPNcACA4YXy8hQJnLy3q+tBD/0O35yQt/GUYc2T6
         DwAwAvgkTQtnNagyGVTjgcv0yKGPAYrVvmBt8X6I=
Received: by mail-qt1-f179.google.com with SMTP id e5so5069156qtr.12;
        Thu, 31 Jan 2019 13:05:58 -0800 (PST)
X-Gm-Message-State: AJcUukdlR/fACkXn/FPN6r0ofSQCEuV5w27WuU2YRL9i+nId6xjmLShh
        HgJubFxbgDgtUzWv7M87Iy3EzEFg9+f/u1AD/Q==
X-Google-Smtp-Source: ALg8bN61MV7OhtjGkOyKCCzv/J834t7721Wp2JIcAAbUrxa861IK63WoST0E0Voy/rRutdtQTFBkUQfgdaxbnwc/mWU=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr36037546qts.144.1548968757566;
 Thu, 31 Jan 2019 13:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129085531.32364-1-markz@nvidia.com> <20190129085531.32364-5-markz@nvidia.com>
 <20190130195355.GA1652@bogus> <a6cd5f7c-d8a5-3f93-b1cf-4da3e4760dff@nvidia.com>
In-Reply-To: <a6cd5f7c-d8a5-3f93-b1cf-4da3e4760dff@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 31 Jan 2019 15:05:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK6z2NbJeRB48S-kmDrHj5B8H6hciR04+_Tzq4_V2jH_Q@mail.gmail.com>
Message-ID: <CAL_JsqK6z2NbJeRB48S-kmDrHj5B8H6hciR04+_Tzq4_V2jH_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mfd: max77620: add documentation for low battery monitoring
To:     Mark Zhang <markz@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, blaws05@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:29 PM Mark Zhang <markz@nvidia.com> wrote:
>
> On 1/31/2019 3:53 AM, Rob Herring wrote:
> > On Tue, Jan 29, 2019 at 04:55:31PM +0800, Mark Zhang wrote:
> >> Adding documentation for low battery monitor properties:
> >> - maxim,low-battery-dac-enable
> >> - maxim,low-battery-dac-disable
> >> - maxim,low-battery-shutdown-enable
> >> - maxim,low-battery-shutdown-disable
> >> - maxim,low-battery-reset-enable
> >> - maxim,low-battery-reset-disable
> >>
> >> Signed-off-by: Mark Zhang <markz@nvidia.com>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/max77620.txt | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> >> index 484b17e4fba5..5fed0a463b80 100644
> >> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> >> @@ -142,6 +142,20 @@ Optional properties:
> >>                      Device supports 100/1000/3000/6000 Ohms.
> >>                      Default will be set to 1000 Ohm.
> >>
> >> +Low-Battery Monitor:
> >> +==================
> >> +This sub-node configure low battery monitor configuration registers. Device has
> >> +support for low-battery monitor configuration through child DT node
> >> +"low-battery-monitor".

Missed this the first time, but there's not really any reason for
these to be in a child node.

> >> +
> >> +Optional properties:
> >> +    - maxim,low-battery-dac-enable: Enable low battery DAC.
> >> +    - maxim,low-battery-dac-disable: Disable low battery DAC.
> >> +    - maxim,low-battery-shutdown-enable: Enable low battery shutdown.
> >> +    - maxim,low-battery-shutdown-disable: Disable low battery shutdown.
> >> +    - maxim,low-battery-reset-enable: Enable low battery reset.
> >> +    - maxim,low-battery-reset-disable: Disable low battery reset.
> >
> > Do you really need 3 states with the 3rd being prop not present.
>
> Yeah, so I think we can just keep 3 of them and shorten the names a little bit
> (lbm stands for "low battery monitoring"):
> - maxim,lbm-dac-enable
> - maxim,lbm-shutdown-enable
> - maxim,lbm-reset-enable
>
> Does this look good to you?

Yes. However, are these 3 mutually exclusive? If so, then perhaps
'maxim,low-battery-mode = "<dac|shutdown|reset>"'?

Rob
