Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9410C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F862146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeL1PGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:06:32 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbeL1PGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:06:32 -0500
Received: from oxbsltgw03.schlund.de ([212.227.220.147]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBE3k-1gUbia3HCQ-00CiqB; Fri, 28 Dec 2018 16:06:06 +0100
Date:   Fri, 28 Dec 2018 16:06:05 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Message-ID: <513165257.381448.1546009565830@email.ionos.de>
In-Reply-To: <87y38abzu7.fsf@anholt.net>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
 <1941132339.131316.1545481176339@email.ionos.de>
 <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
 <1232214204.268730.1545919526431@email.ionos.de>
 <87y38abzu7.fsf@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:us9xatHzMPMq6vAt9kXYUHE+Be5QQSMjKmPVxFKjI43Nekr0dsf
 CcGbMfbvESd3HJ3K7G6FG2ocwqzkeFfJDgoluzOl8BdtxiO/2EFXS0yc+kzTWQU+JPnJUnQ
 nLy2iS5MY2HVcEnxszIPncboQV0BSLGMseiP6kxd++XPL4fbYzSk4/kqV4JXvoj5RE5o85E
 O4zPrctYyWGFYCqTR0Qfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W+B3ZzUNDLU=:bg65cl90U0SxqHUyq+SJy8
 tvHpJWVwb7o6TCz5VGzvUqvjltJ3j/DHpUwB4O6ISBQrSafZMib8gAHp97DZt9P8DpsdYEO2n
 +RAhLSsKi8Rkgo7wSOIwXaUN3GYVv6nTbzxBfzgJWip6IG6+jgP/MF5XDLJ4geyAoNU87NTeq
 DmRwbdTxPZpkRepPGQAVLpxhVWeyMZDVmysWH2h3ZGpDo5DodY+DjckZbNONZshy3oltL+Z2/
 ZP9WNbp/MftMRgAd5yxofnMitbmQRc8ftbzokZkFMGLTWcJvxZQUB7IBwO1FOSS3+1ahc8m9/
 B5YsYiMyCQN0V06XaGHe6IL4SinrlpPb/+P1LcK3mtIowgArruF5D864FPaPRJzN+6FdTAKC9
 0bKvVKm6+cBRFBjrIn2rO5Iq3zXc8LeNPd/tMi7W/PCH+SypTAof6S9qsxyq4zWYHuOgfCSTd
 xTM0tnVlcOJ8nY2t3unwB6rHbWlrxV/6mBvZpWcsVPVmlEy266vmyljRZH5UZW/jJT2GcS20Q
 lTqzTj6Y+oJnrxIQ6neG7oPHtHJPyUWfHvtW2EVCkVsB8B0mVRDY1ZHZUDY9Zg+rLHni09D6E
 tYduFu8LJkKxJIp+7e71MdSV3fwDFYIvgAxWG221fs/nzQ7TFat8oOFydHgokch2XL8+Wouip
 elU2g2u4PdHdxjtf3zzmeMZbEn74AXu6JEWQTllkN+iUR4q24T+9et4Hv0etooq5xIClfRUye
 DMseFRf/O3Ln+3BPFUgUt2uanpm4BUYyOQzXjPzojyvqZQgdsh/ZmbeS4O0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 27. Dezember 2018 um 19:15 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Paul,
> >
> >> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 2018 um 10:10 geschrieben:
> >> 
> >> 
> >> Hi,
> >> 
> >> On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
> >> > Hi Paul,
> >> > 
> >> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> >> > > 
> >> > > 
> >> > > The driver's interrupt handler checks whether a message is currently
> >> > > being handled with the curr_msg pointer. When it is NULL, the interrupt
> >> > > is considered to be unexpected. Similarly, the i2c_start_transfer
> >> > > routine checks for the remaining number of messages to handle in
> >> > > num_msgs.
> >> > > 
> >> > > However, these values are never cleared and always keep the message and
> >> > > number relevant to the latest transfer (which might be done already and
> >> > > the underlying message memory might have been freed).
> >> > > 
> >> > > When an unexpected interrupt hits with the DONE bit set, the isr will
> >> > > then try to access the flags field of the curr_msg structure, leading
> >> > > to a fatal page fault.
> >> > > 
> >> > > Fix the issue by systematically clearing curr_msg and num_msgs in the
> >> > > driver-wide device structure when a transfer is considered complete.
> >> > > 
> >> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >> > > ---
> >> > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> >> > >  1 file changed, 3 insertions(+)
> >> > > 
> >> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> >> > > index 44deae78913e..5486252f5f2f 100644
> >> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> >> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> >> > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >> > >  		return -ETIMEDOUT;
> >> > >  	}
> >> > >  
> >> > > +	i2c_dev->curr_msg = NULL;
> >> > > +	i2c_dev->num_msgs = 0;
> >> > 
> >> > AFAIU this would reduce the chance of a use-after-free dramatically but not completely.
> >> 
> >> Do you have a specific case of use-after-free related to these
> >> variables in mind that this cleanup would not fix (except for the
> >> timeout case)?
> >
> > okay i was wrong about the use-after-free. But i'm not sure about this scenario on the I2C bus shared with the VC4:
> >
> > 1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
> > 2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
> > 3. ARM core catches this interrupt before the VC4
> 
> We don't share I2C buses with VC4, though, right?  That would just be
> totally broken.

All i remember is this comment on Github:
https://github.com/anholt/linux/issues/89#issuecomment-280111496

and currently all 3 I2C busses are enabled for the ARM core in bcm2835-rpi.dtsi.

Stefan
