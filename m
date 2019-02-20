Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3678020685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfBTLAA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:00:00 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:44264 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfBTLAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:00:00 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 710AA15632; Wed, 20 Feb 2019 10:59:58 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
References: <20190216182132.12895-1-mans@mansr.com>
        <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
        <20190220090617.aprfndnidcamwcvy@flea>
Date:   Wed, 20 Feb 2019 10:59:58 +0000
In-Reply-To: <20190220090617.aprfndnidcamwcvy@flea> (Maxime Ripard's message
        of "Wed, 20 Feb 2019 10:06:17 +0100")
Message-ID: <yw1x36oiybbl.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime.ripard@bootlin.com> writes:

> On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
>> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
>> >
>> > This adds pinctrl settings for various missing uart options.
>> >
>> > Signed-off-by: Mans Rullgard <mans@mansr.com>
>> > ---
>> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
>> >  1 file changed, 45 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> > index af5b067a5f83..2295ff5adf48 100644
>> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> > @@ -944,6 +944,31 @@
>> >                                 function = "uart0";
>> >                         };
>> >
>> > +                       uart0_pf_pins: uart0-pf-pins {
>> > +                               pins = "PF2", "PF4";
>> > +                               function = "uart0";
>> > +                       };
>> 
>> We've had the policy of not adding pinctrl nodes that aren't used in-tree,
>> to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
>> /omit-if-no-ref/ directive, which would make the compiler discard marked
>> nodes if they aren't referenced.
>> 
>> So please add this to all the new nodes. It seems to work regardless whether
>> you add it before or after the label, though having it after the label seems
>> to make vim syntax highlighting happier.

Should we also add this to existing nodes?

BTW, I really do need all those uart pin options.

-- 
Måns Rullgård
