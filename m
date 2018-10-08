Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB249C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A0320C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="Usyv7MVo";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="aHnzLLYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A0320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJIAdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:33:18 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:13426 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbeJIAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:33:18 -0400
X-Greylist: delayed 1707 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2018 20:33:15 EDT
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w98HIuKI001401
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 18:20:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=7f2VCYe/3fHRhUivFmg8qKkjCWdkAtBy26XT9ogAda4=;
 b=Usyv7MVocRQXdExXIoHfYJs+/+CyEU6oygmSYO6x5y1U86tI4lUYDrjamRZAvFnZ/WlF
 1x8PPkcDo1fihOLXUu+JSyt2AylgcQ24Y8lQyJFH9MNGgZxF/QEdSafd77iqIAex8cZ5
 oXonSyvdID8tHs2ogq8c+SExcqKqyyIx6LcF8I3+ichtzuAj5+rOBEy0dtYjhD34Zr4b
 cKXFLoleZtmhgzsgnUQcG/02BEhcCaWabdKdC76HU37zIy+qWAkpAaUyIabKeMOFBnxT
 Yc82ziZPR411nehR2w2hBQTq/6gWICZBsDX9Pdc80qmOmt9JRC/Fd+jcVHsRs09vcLHW MQ== 
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by mx07-00252a01.pphosted.com with ESMTP id 2mxjf0h7p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 18:20:32 +0100
Received: by mail-pl1-f199.google.com with SMTP id b95-v6so17886550plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7f2VCYe/3fHRhUivFmg8qKkjCWdkAtBy26XT9ogAda4=;
        b=aHnzLLYR3uHk+TgWLHtB76SzskTujTmri9iGJazNgoPri1EIsPmli1e7rGp1ADNcko
         GTzYAzRuQ6C/7+QZUewfzyHNnL2l21hNutbjS+SQKd/kDNjN/Rj+fa4QwHfpQe+m+MSd
         aXrnsXkxCK4l3+maNvsjC6ONh+1bDcExbPm6Kmw+yU2Nn5c9gTfcgmuXnNgvnvkvAhq/
         VJc3s292wUJGK8/7y4/3s+MM7Kq/1OhYGDXaLQla8LVuJJoOyTCZvFW4nQcOyLpQlvys
         9BBXiR7aabGViB4Z3OGSSlZQVO2kA4wAIV68pmIhb3BZ/TVwdrfIkYmM6muLcv9fvXXw
         /Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7f2VCYe/3fHRhUivFmg8qKkjCWdkAtBy26XT9ogAda4=;
        b=f42WdlZbNZdwf+lFXA0p8nzq6pKr01lmP5OTtjz++pURLZ+BTMI+H5sqAU7SuoA9PK
         y6gH5q0+tzgHSceksWkUFQ97ETwdTvCqxGuolbxpKqmvJCd+WsPUynwl9vm+iKT/zZfj
         62AkIF9bEuF1UO151Lm/nIp3Blt7LzzRo/7+FeT7SzYyr8k/DFEWyUoqow73/8eFo8z7
         IVIepb0R/tD/l9u+1i4QjHxSWIPvn0Lg/yr8tROajK7DvrW6zh3/UH2w+kjcHUUFQ27E
         pyydfvMc3iOstC+wEYHUenqbpI4k8HsozsSNQRhO4X6VM36RKu3kOPWuzEyExnpwtdRX
         WCAw==
X-Gm-Message-State: ABuFfogAxAIx3WR6Kmj73mtt0GVZL5oQ3XkD+KCK46Tdn/lqMdVYx6qC
        yqoxwVg6wMSpUlanfjBq0Ph5jL8GBFxrcRH2/s09xot6F5gQ046It9R3DzuOctut48XyZnNYv7U
        vy5/pxuAQQKdAkmk0okjGchsF7hrTL1Rp067sQEw=
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr14002928pfb.155.1539019230151;
        Mon, 08 Oct 2018 10:20:30 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60KR8059amc8JMX8w7lqfusblARspus5c0EC19X9goK2SJr7NxXxSe1n49IiVMB1VtXHJ6tKUCQXl1jDO1uQNs=
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr14002909pfb.155.1539019229902;
 Mon, 08 Oct 2018 10:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181008145012.31312-1-colin.king@canonical.com>
 <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com> <CAAoAYcO=qp7yb7392B_6wks2j2TaoxYXHtQPyH0kMkFMi+JW-A@mail.gmail.com>
 <663860283.72238.1539018547916@email.1und1.de>
In-Reply-To: <663860283.72238.1539018547916@email.1und1.de>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Mon, 8 Oct 2018 18:20:17 +0100
Message-ID: <CAAoAYcNMJd2429fZWd_E3w=MhBdZDADNtHkVtf1__VVcjSEBTg@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: remove extraneous setting of dev->colourfx.enable
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     colin.king@canonical.com, Eric Anholt <eric@anholt.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        bcm-kernel-feedback-list@broadcom.com,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 at 18:09, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Dave,
>
> > Dave Stevenson <dave.stevenson@raspberrypi.org> hat am 8. Oktober 2018 um 18:51 geschrieben:
> >
> >
> >  Hi Stefan.
> >
> > Thanks for forwarding as the linux-rpi-kernel list hasn't sent it to me as yet.
>
> AFAIK every mail with more than 5 recipients will be delayed.
>
> >
> > On Mon, 8 Oct 2018 at 16:48, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >
> > > Hi Colin,
> > >
> > > Am 08.10.2018 um 16:50 schrieb Colin King:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > >
> > > > Currently dev->colourfx.enable is being set twice, hence the first
> > > > occurrance is redundant and can be removed, so remove it. This minor
> > > > issue was introduced by commit 7b3ad5abf027 ("staging: Import the
> > > > BCM2835 MMAL-based V4L2 camera driver.").
> > > >
> > > > Detected by CoverityScan CID#1419711 ("Unused value")
> > > >
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > ---
> > > >  drivers/staging/vc04_services/bcm2835-camera/controls.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > > > index a2c55cb2192a..99831dd4365d 100644
> > > > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > > > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > > > @@ -588,7 +588,6 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
> > > >
> > > >       control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
> > > >
> > > > -     dev->colourfx.enable = (ctrl->val & 0xff00) >> 8;
> > > >       dev->colourfx.enable = ctrl->val & 0xff;
> > > >
> > > >       ret = vchiq_mmal_port_parameter_set(dev->instance, control,
> > >
> > > as long as the current behavior is correct, i'm okay with this patch.
> > > But the byte masking looks suspicious, so i hope Dave can clarify that.
> >
> > It's writing to the wrong structure member.
> > The function is used on the V4L2 control V4L2_CID_COLORFX_CBCR, which
> > is defined as:
> > V4L2_CID_COLORFX_CBCR (integer)
> > Determines the Cb and Cr coefficients for V4L2_COLORFX_SET_CBCR color
> > effect. Bits [7:0] of the supplied 32 bit value are interpreted as Cr
> > component, bits [15:8] as Cb component and bits [31:16] must be zero.
> >
> > ctrl->val should therefore be setting dev->colourfx.u and
> > dev->colourfx.v with those masks. dev->colourfx.enable field should
> > have been set when going through ctrl_set_image_effect for contol
> > V4L2_CID_COLORFX set to V4L2_COLORFX_SET_CBCR.
> >
> > I've confirmed with qv4l2 that that is what is wrong. That's only been
> > lurking there for almost 5 years - shows how often these weirder
> > effects get used.
> > I don't mind whether Colin's patch gets merged and then fixed up, or
> > drop Colin's patch and apply the correct logic via a new patch.
>
> no this patch shouldn't be applied. Does it mean you want to send the proper one?

Want to - not really. Ought to - I guess so.
I've got a bunch of checkpatch and other fixes to come too, so once
I've got a mainline kernel build back up and running I'll roll them
all up and blitz the list.

  Dave
