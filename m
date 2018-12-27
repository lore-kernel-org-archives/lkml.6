Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2442C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907222148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeL0OFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:05:53 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:57157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeL0OFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:05:52 -0500
Received: from oxbsltgw01.schlund.de ([212.227.220.145]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3DaN-1gdsni1hE5-003g2j; Thu, 27 Dec 2018 15:05:27 +0100
Date:   Thu, 27 Dec 2018 15:05:26 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>, linux-i2c@vger.kernel.org
Message-ID: <1232214204.268730.1545919526431@email.ionos.de>
In-Reply-To: <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
 <1941132339.131316.1545481176339@email.ionos.de>
 <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:bkHrRQSzEZAB3EkVyauNGzE9blzsvZJTbZfxiCMtNSBZBy1BzlJ
 0uyYAI8QNl9zetV7oJvwirP74XLhDur2QfBa0oc08bxPuAT6jSmFLFFhqR+vg3l4COSI52Y
 620kn9pOsA4TfrZHXk2CQzDuBkjLBw0cEcpxEhJOOl1aC+N0lfRwK1aoNAF9wAtXspiwt0u
 KTHjFZKcFuPEaC2L8YU9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r2FXzmONG+w=:MNB21GyzlDtQSWfAN9SG9J
 CeVhx5Sq5BeKlSRHRbbN10rR02+jWzrRVhHjAwTK9H9xaDiGHlIvgC2k+OWFp/t5Gghd++DPJ
 YD8tAKpUR31YQxytiOjotRUx/g+lXXlsQrvXAL7RpR4jukzgNy0HsV4hJKSWNYoSp519pPvvq
 ddqI/INFqs4MtlMzm/rL/G3PfNX1RSDHqrbBdaXSuAW503XTDA14ajsBmMJ0S0I61m6Gt7zhC
 Umb+ldN9X/Eivv3aRxy+xNj7dPhPgwJYEC1nf+saAVdPdtjuaYR52oFBRrjOHSb2cnicMxtqO
 74GfgeTMTyR07XFS+cN24KNoaBw3ZWBKepdwtXXey51RqA0TwLLTAMlXRsEXgqTGFKP7RbJOg
 7phGohipzXpJmJA+kS2KF47/K5bC8CH85FZFmeMEX4EKKe+kkHD+UDCJARrj6iAIegj0FD7ui
 sINT6kOBzGWD5JS64Ax6y5u0xLjdGst0EQ1a5ZkfkkYr2qrPduVBepNEv58GdU18gyDIHoFC7
 HjvK/D5M6eIB2abgG0vfoT/XH6MVXkYnOj06y9Fu0NLoNKZbuj/wSsYYZmJj0y1reJs1ZggyN
 v6TMDpU5y2xMSx6Hk/Zq+YamSlDmW4yLHBDKVpYCuDrepJ4qT5NiEgMDa3krMn3wLKhqVk9iW
 OO5SWf3+YSujHfcmO+lprspPDDOcMvBH7eObbTbgAZotB1Ua+KkDK4ta+0mdhKLQupwpHChl4
 82CWAPObpzwSAHcH7UPEdonfZgq6BNegCOml4RWRRMkSxPe7HwGS/kFiHpQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 2018 um 10:10 geschrieben:
> 
> 
> Hi,
> 
> On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
> > Hi Paul,
> > 
> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> > > 
> > > 
> > > The driver's interrupt handler checks whether a message is currently
> > > being handled with the curr_msg pointer. When it is NULL, the interrupt
> > > is considered to be unexpected. Similarly, the i2c_start_transfer
> > > routine checks for the remaining number of messages to handle in
> > > num_msgs.
> > > 
> > > However, these values are never cleared and always keep the message and
> > > number relevant to the latest transfer (which might be done already and
> > > the underlying message memory might have been freed).
> > > 
> > > When an unexpected interrupt hits with the DONE bit set, the isr will
> > > then try to access the flags field of the curr_msg structure, leading
> > > to a fatal page fault.
> > > 
> > > Fix the issue by systematically clearing curr_msg and num_msgs in the
> > > driver-wide device structure when a transfer is considered complete.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > > index 44deae78913e..5486252f5f2f 100644
> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> > >  		return -ETIMEDOUT;
> > >  	}
> > >  
> > > +	i2c_dev->curr_msg = NULL;
> > > +	i2c_dev->num_msgs = 0;
> > 
> > AFAIU this would reduce the chance of a use-after-free dramatically but not completely.
> 
> Do you have a specific case of use-after-free related to these
> variables in mind that this cleanup would not fix (except for the
> timeout case)?

okay i was wrong about the use-after-free. But i'm not sure about this scenario on the I2C bus shared with the VC4:

1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
3. ARM core catches this interrupt before the VC4

Stefan

> 
> The msg_buf element (in association with msg_buf_remaining keeping its
> previous value) could also lead to similar problems, so I'm thinking of
> making a bcm2835_i2c_finish_transfer function to group all the cleanups
> and call that right after wait_for_completion_timeout.
> 
> > Btw: Why did you leave of the i2c transfer timeout case?
> 
> I should definitely have included it, actually.
> 
> Cheers,
> 
> Paul
> 
> > Thanks
> > Stefan
> > 
> > > +
> > >  	if (!i2c_dev->msg_err)
> > >  		return num;
> > >  
> > > -- 
> > > 2.20.1
> > > 
> -- 
> Paul Kocialkowski, Bootlin (formerly Free Electrons)
> Embedded Linux and kernel engineering
> https://bootlin.com
>
