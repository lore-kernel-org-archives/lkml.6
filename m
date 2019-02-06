Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B748C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E102020821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfBFPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:39:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbfBFPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:39:01 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1grPHr-0007KD-Cx; Wed, 06 Feb 2019 16:38:55 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1grPHq-00080w-DS; Wed, 06 Feb 2019 16:38:54 +0100
Date:   Wed, 6 Feb 2019 16:38:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190206153854.52bqbwf2ty2j7rvj@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com>
 <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
 <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
 <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
 <20190206124055.GF21676@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206124055.GF21676@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:40:55PM +0100, Thierry Reding wrote:
> On Wed, Feb 06, 2019 at 12:07:30PM +0100, Uwe Kleine-König wrote:
> > On Wed, Feb 06, 2019 at 04:18:47PM +0530, Yash Shah wrote:
> > > On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > > > > DT documentation for PWM controller added.
> > > > >
> > > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > > [Atish: Compatible string update]
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > ---
> > > > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
> > > > >  1 file changed, 33 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > > new file mode 100644
> > > > > index 0000000..8dcb40d
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > > @@ -0,0 +1,33 @@
> > > > > +SiFive PWM controller
> > > > > +
> > > > > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > > > > +supports one period for all channels in the PWM. This is set globally in DTS.
> > > >
> > > > You can simply drop this if the first user can set this using the usual
> > > > interface. Don't you like this suggestion that I already made a few
> > > > times now?
> > > >
> > > > Did you consider to make the driver support only a single output with a
> > > > more flexible period setting?
> > > 
> > > We cannot consider supporting only single output since we have boards that
> > > use the additional PWM channels to control individual LED brightness
> > > of a tri-color LED.
> > > If we go down to one channel, then we can't control the brightness of
> > > the individual LEDs.
> > > It will break the use case.
> > 
> > OK.
> > 
> > > I am considering the below approach, let me know if it's fine by you.
> > > 
> > > - Drop the global period property and allow the only first user to change period
> > > using the usual interface.
> > > - A note in the binding that all PWMs need to run at the same
> > > period. If the driver already refuses to apply incompatible periods,
> > > the users are going to notice that they've got the DT wrong.
> > > - In driver code, count the users using the .request and .free callbacks.
> > > Based on this, allow changes to period iff the user count is one.
> > 
> > Not sure you need to point this limitation in the binding doc. Other
> > than that this is fine.
> 
> I think it's useful to point this out in the binding documentation since
> it's something that device tree writers will want to know.

OK, we're talking about an FPGA implementation but I still think if the
dt-author is the first to know about this limitation this is too late.
The hardware designer must know about that, and they don't look into the
bindind documentation. The binding documentation should IMHO only
describe the binding and functional limitiations of the device are out
of scope.

The binding for the Freescale network interface doesn't describe that it
only supports 480 MBit/s in its GHz mode, and that's good. The binding
for i2c devices doesn't describe that a reboot in the middle of a
transfer might block the bus.

The target for the binding documentation is to document how a given
device is described in a device tree. It's not there to duplicate
information that belongs in the reference manual.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
