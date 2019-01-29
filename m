Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3771C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98DD2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfA2Fk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:40:59 -0500
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:42777 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbfA2Fk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:40:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9D7118368EF5;
        Tue, 29 Jan 2019 05:40:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scarf45_4268684d3b636
X-Filterd-Recvd-Size: 1941
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Jan 2019 05:40:56 +0000 (UTC)
Message-ID: <533e48bd35d360cec8d749f3b70425c1eb5e6e9d.camel@perches.com>
Subject: Re: [RESEND PATCH v2 8/8] Input: sx8654 - convert #defined flags to
 BIT(x)
From:   Joe Perches <joe@perches.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Richard Leitner <richard.leitner@skidata.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Jan 2019 21:40:54 -0800
In-Reply-To: <20190129002518.GH34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
         <20181218084002.19454-1-richard.leitner@skidata.com>
         <20190129002518.GH34692@dtor-ws>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 16:25 -0800, Dmitry Torokhov wrote:
> On Tue, Dec 18, 2018 at 09:40:02AM +0100, Richard Leitner wrote:
> > Some of the #defined register values are one-bit flags. Convert them to
> > use the BIT(x) macro instead of 1 byte hexadecimal values. This improves
> > readability and clarifies the intent.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> 
> Applied, thank you.

Not so sure this should be applied.

> > diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
[]
> > @@ -46,7 +47,7 @@
[]
> >  /* bits for I2C_REG_IRQSRC */
> > -#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
> > -#define IRQ_PENRELEASE			0x04
> > +#define IRQ_PENTOUCH_TOUCHCONVDONE	BIT(7)
> > +#define IRQ_PENRELEASE			BIT(6)

Shouldn't this be BIT(3) and BIT(2)
or did you mean to change the values too?

If so, this change should be noted in the commit message.

