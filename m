Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E289E20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E289E20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeGLKdT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:33:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56155 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeGLKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:33:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A1F8520703; Thu, 12 Jul 2018 12:24:21 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0A6EC2069C;
        Thu, 12 Jul 2018 12:24:21 +0200 (CEST)
Date:   Thu, 12 Jul 2018 12:24:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180712122420.7c3ebd4e@bbrezillon>
In-Reply-To: <CAK8P3a3raE9rmyvgxR0YVmYSCN4tumYS1TCexCuTEUXjy_9kSw@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
        <20180711164120.3e32fb08@bbrezillon>
        <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
        <20180711191212.3855bb25@bbrezillon>
        <CAK8P3a2djk8c6STaxJC0MCkBddyOafk4WbG2LdfPf0V1EYiqmQ@mail.gmail.com>
        <20180712000932.3b04ee9d@bbrezillon>
        <CAK8P3a13GX67YEci2J8Rxn6O4FBjjD82X+w3hyGMT3TDbtFkTg@mail.gmail.com>
        <20180712104658.220ef8f6@bbrezillon>
        <CAK8P3a3raE9rmyvgxR0YVmYSCN4tumYS1TCexCuTEUXjy_9kSw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 12:03:05 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> >> want to be in b) rather than c). An example of this would be
> >> an input device on a PC: If the user operateds the keyboard
> >> or pointer and we have handed off ownership to a sensor hub,
> >> we never get an input event, right?  
> >
> > Correct. I guess we could try to regain bus ownership in case we have
> > IBIs enabled. Or we let the secondary master give the bus back to us
> > when it sees IBIs it can't handle, as described in section 5.1.7:
> >
> > "
> > Once granted control of the Bus, the Secondary Master maintains
> > control until another Master is granted Bus control. After the
> > Secondary Master transitions to the Current Master role it could
> > encounter Bus management activities besides the data transfers that it
> > itself initiates. Some examples are the In-Band Interrupt, or the
> > Hot-Join request. One optional possibility, shown at Section 5.1.7.2,
> > is that the Secondary Master performs the Current Master’s actions with
> > the full capabilities of the Main Master. Another optional possibility
> > is that the Secondary Master, while serving in the Current Master role,
> > could defer some actions to a more capable Master, as described in
> > Section 5.1.7.3.
> > "  
> 
> Ah, so the current master can ask a secondary master to take over
> again even if  the secondary master has not requested to be come the
> current master?

Yes. Then the inactive master can refuse of course, but it is working
both ways:

- an inactive master can ask for bus ownership
- an active master can ask an inactive one to take over

> 
> >> > I agree. This being said, moving to a representation where the bus is
> >> > implicitly represented by the master_controller instance shouldn't be
> >> > too difficult. So, if you think we should try this approach I can do
> >> > the modifications in my v6.  
> >>
> >> I'd say let's wait before you do that change, possibly add a comment
> >> in there now to remind us of what an alternative would be.  
> >
> > You mean I should keep the i3c_bus object?  
> 
> I mean the ongoing discussion shouldn't stop you from posting a v6.

Ok.
