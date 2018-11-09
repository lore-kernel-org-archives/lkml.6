Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AAAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D712A21104
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D712A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKJBjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:39:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45731 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJBjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:39:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id d135so2338797qkc.12;
        Fri, 09 Nov 2018 07:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxQj1Ty4UPnpBUoEGrpOe//TOkC5Q7DBIlC9a99bFpA=;
        b=hddjn5B1AczX5E25IYliHza2d8/XD968gjtMo4pZ8NDPg3oXVnfm4JOCqGp1p1cw+Y
         xiB60LsY2i3zthEAIJgp/8BcMlr5BLxmmP1chzZ6WI39RJbPyKBZ3tIEnmPgjnkq0hf6
         WNI730+9zR9MorlVHg5Ulu/FfkGR1i5oackdJ5+eUDhd4fmWduF5bv0IGx6NcRWeL+0T
         oYMLJ/qodS8SQaE12Wq3IX4j+431xOGgtPDRu/3ETtzOB6R0sdWkfvJLL2zBnCeR40w/
         3VAWnObqE38QjA7zWG4Zli7mB3UEB7/gWk/TMQhhDF3rtSI+STW2XsgXgxtXpk/7Ta7N
         nmPg==
X-Gm-Message-State: AGRZ1gKAGEO6nCZiZN0KdKtXsSVIGdGv8zrh+HirhZm/WSLsyY5dzKkG
        i5dormsRv19X7D200FB83skwAPf6ChncvulLSAM=
X-Google-Smtp-Source: AJdET5dnnsXwSH3keGIZet6iDfaT+0wFcBWP4zsrdf5G5JzOPxg0DpZ+6Jc9OSUPk7B8e6kETKPVoEXhjpx2c7ryEhk=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr8302239qkm.343.1541779121138;
 Fri, 09 Nov 2018 07:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
 <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com> <20181109114818.GB30658@n2100.armlinux.org.uk>
In-Reply-To: <20181109114818.GB30658@n2100.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Nov 2018 16:58:24 +0100
Message-ID: <CAK8P3a26XmBpG3VzwUgSdd_Xo_S2ezSvA9mjKckRFr9p38j-dg@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable binding
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Borislav Petkov <bp@alien8.de>, jlu@pengutronix.de,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 12:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 09, 2018 at 12:40:06PM +0100, Arnd Bergmann wrote:
> > On Fri, Nov 9, 2018 at 8:04 AM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > >
> > > Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> > > properties which can be used to enable/disable ECC on the Marvell aurora
> > > cache.
> > >
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> >
> > Why do you need both enable and disable? Wouldn't one of them be enough here?
>
> It isn't an "on when ecc-enable is present, off when not" because the
> current behaviour is to preserve these bits in the control register.
>
> If we were to implement it as "if no ecc-enable property, turn off
> ECC" then that would drastically change the behaviour - systems which
> were configured for ECC suddenly lose ECC support.
>
> Since we don't know which have it and which don't, we can't implement
> the option like that.

What I meant was why we need support force-disabling it. I understand
that we need to allow leaving it at the boot-time default as well as
force-enabling it.

       Arnd
