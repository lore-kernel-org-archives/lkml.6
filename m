Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B64C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABCD2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABCD2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJIAWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:22:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:22:16 -0400
Received: from null ([172.19.249.46]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MRx1t-1gFyxT0qAj-00Szj0; Mon, 08
 Oct 2018 19:09:10 +0200
Received: from null ([172.19.249.46]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MRx1t-1gFyxT0qAj-00Szj0; Mon, 08
 Oct 2018 19:09:10 +0200
Date:   Mon, 8 Oct 2018 19:09:07 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc:     colin.king@canonical.com, Eric Anholt <eric@anholt.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        bcm-kernel-feedback-list@broadcom.com,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <663860283.72238.1539018547916@email.1und1.de>
In-Reply-To: <CAAoAYcO=qp7yb7392B_6wks2j2TaoxYXHtQPyH0kMkFMi+JW-A@mail.gmail.com>
References: <20181008145012.31312-1-colin.king@canonical.com>
 <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
 <CAAoAYcO=qp7yb7392B_6wks2j2TaoxYXHtQPyH0kMkFMi+JW-A@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: remove extraneous setting of
 dev->colourfx.enable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Mha2mCu5K2SP0T56JvZHlNYwoJxH9bXGQSszDN2wn8UiVB3qvFr
 LaCTN13LqiMjFz9hpl8p+lOSiQXpoQZ19odZtKBB55w+pj3FSRvFP+ClYWzsHuaBfDs4NRX
 g8zB3IzdGYT+Y7+2sOtfs5w3iC1NgIho2s84tlEa2QRmNqG7ZX0zaIzCMjhrISUwA4HZmGR
 upqzS3Pwk4Vg5Cog8lCFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PQCDf4YbXiY=:B+9K9RI7JT5xRhX1vHB93K
 7v9ZLu173pCWKF48MGYIQx3CVTjSjk0PsEJ7hZA77c8HqQBtAiL6EyJR2dYCrUaHSy8s/B238
 RuYh3z8wHY3+Af3syvsiNb7TF/9NxVlMkumwpjCjbfsqU3RkTRYSkIPbQW3FdjN80JszPg+w+
 b4KN7Erl76IMeo4PgDFN8fQMFraJKJoEj6YzFjuYV/QmIJlig5Afes4yG9sy0YFZti25CxHGq
 gI3VPH9HERrmmVL+ueZcXkysB/CPFpXmFaxim9HZUy/5erX1gOi+B8bpy7KbtPMztxz2B3mZ6
 VgWU8dneTswEHnxdCksrXcCcwSt+X5jRTEJUkx+fA35BQ8SXO0kmvz5OZqv1ma0AO3LrwaMSI
 zv6HzqIunUFWS7rfbu7C37qdKdseCEG/M85A+wZorSJ50jeHjNTr2fV+SMzHZtq8hI93DRN6M
 ZNBq8738jN7HZxSl4mjV7wVJmHKQJ6n/3Wr1JUY7y9MyYKuRZ8LJIFHFHVQ3/v7qSSHWcqHSh
 xMbGC/kOov7Iwt0nDhiFbPaH2qDWkMggabBb5xEIhbWDKsdgpTLUpiM6tT7wsNqC8QzxNyZUK
 ULwaVJn8A71tCKdBXj9BFg+xMRvZ4D7yKzH/HUR596Kr4kktryB/AJS2SeTdAfccUWEpJoGqU
 VyZH0Y5W4M3ssQTTaCA9MNnwRyYa10+yyu2cpvwT/RLOzts6a7nvspbiIEWifonUp8/L54V1g
 kmakxN3+4S/Q+O4H
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> Dave Stevenson <dave.stevenson@raspberrypi.org> hat am 8. Oktober 2018 um 18:51 geschrieben:
> 
> 
>  Hi Stefan.
> 
> Thanks for forwarding as the linux-rpi-kernel list hasn't sent it to me as yet.

AFAIK every mail with more than 5 recipients will be delayed.

> 
> On Mon, 8 Oct 2018 at 16:48, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >
> > Hi Colin,
> >
> > Am 08.10.2018 um 16:50 schrieb Colin King:
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Currently dev->colourfx.enable is being set twice, hence the first
> > > occurrance is redundant and can be removed, so remove it. This minor
> > > issue was introduced by commit 7b3ad5abf027 ("staging: Import the
> > > BCM2835 MMAL-based V4L2 camera driver.").
> > >
> > > Detected by CoverityScan CID#1419711 ("Unused value")
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/staging/vc04_services/bcm2835-camera/controls.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > > index a2c55cb2192a..99831dd4365d 100644
> > > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > > @@ -588,7 +588,6 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
> > >
> > >       control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
> > >
> > > -     dev->colourfx.enable = (ctrl->val & 0xff00) >> 8;
> > >       dev->colourfx.enable = ctrl->val & 0xff;
> > >
> > >       ret = vchiq_mmal_port_parameter_set(dev->instance, control,
> >
> > as long as the current behavior is correct, i'm okay with this patch.
> > But the byte masking looks suspicious, so i hope Dave can clarify that.
> 
> It's writing to the wrong structure member.
> The function is used on the V4L2 control V4L2_CID_COLORFX_CBCR, which
> is defined as:
> V4L2_CID_COLORFX_CBCR (integer)
> Determines the Cb and Cr coefficients for V4L2_COLORFX_SET_CBCR color
> effect. Bits [7:0] of the supplied 32 bit value are interpreted as Cr
> component, bits [15:8] as Cb component and bits [31:16] must be zero.
> 
> ctrl->val should therefore be setting dev->colourfx.u and
> dev->colourfx.v with those masks. dev->colourfx.enable field should
> have been set when going through ctrl_set_image_effect for contol
> V4L2_CID_COLORFX set to V4L2_COLORFX_SET_CBCR.
> 
> I've confirmed with qv4l2 that that is what is wrong. That's only been
> lurking there for almost 5 years - shows how often these weirder
> effects get used.
> I don't mind whether Colin's patch gets merged and then fixed up, or
> drop Colin's patch and apply the correct logic via a new patch.

no this patch shouldn't be applied. Does it mean you want to send the proper one?

> 
>   Dave
