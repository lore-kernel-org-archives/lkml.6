Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA2C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A16213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="cwW9G6sI";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="MOgVh5Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A16213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJIAhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:37:24 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:2873 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbeJIAhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:37:24 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w98Gma8W013851
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 17:52:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=Abi7SKaikRz7HRu/sOiDuCJhbJ7ajtC2u1yo1pmr0oc=;
 b=cwW9G6sIE+hdXvAKoAf4qvFyYnEa9Bq03PYJlxZTO7/2x01r3eYMsVdWo7jWSNWlEpIp
 qylocaRRrzi0VfgzjNeGeRQ6fsl4FeZF9oIbblq6SVCdgGoIs2FMHS9AlQOYbeICwz1G
 QBma25hPeQy2Azqm23Sz8PLIS7RNkmHuQ9ibW5toxxKcPMNPdTDVUwFWSHouvzkH1cq2
 ODlNxiaFTrom5NBPapiZAkmbX8pEeADKQvDlPHqHjQjbwU/v5AreGhCxvAUKgGdiMtgu
 XxFBXvsMZox5LCaJVRa/RRg/E04m7nEhUdtWbyeCYIJwDQLmYeYBtrVqAtBeldB7h+2J 0g== 
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by mx07-00252a01.pphosted.com with ESMTP id 2mxjf0h7bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 17:52:11 +0100
Received: by mail-pf1-f199.google.com with SMTP id h76-v6so17596417pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abi7SKaikRz7HRu/sOiDuCJhbJ7ajtC2u1yo1pmr0oc=;
        b=MOgVh5QyMwIjvFArTTd8qkw4yWJkTi7d0/QWttUuCIYQU2K4TZGzevs2KvdS+3c6k0
         EOAlxEnlg1Y2K0KVu5LqnVFIS4x//O1EGerckGs8a1DEMEE/MCzEgLPaXmk4GaLveBbd
         FmIBpFlj/WzRX95OGBnPbN4ZSA+JlrBG7GKIdAWR/4H0IvKa1WX1/O9t/mngYDBneV2G
         tOPmATdFLDp0n7ysM728OYUA69nf3MuI+MOtrJ3ei/9YvdqaAFX4jcQL7prdCFUoBUT5
         XX1uaISjpbdo+YmvpsiW18WCIn0OHJOjLnZypzOckHhaSY9gC/BrXrnVTO0aYN0kdu3P
         7YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abi7SKaikRz7HRu/sOiDuCJhbJ7ajtC2u1yo1pmr0oc=;
        b=SQt7BDrH3YJNwgkvvQTFLFNZyJwvJ7v2VTNNxS0JVxsGCl8JeI/7VXu7xRgzrQBb34
         9Rykhq7SAYoP/UbrSS9bca0euNFRg8aYUIpRbBaOD4x+ikdzuV8k1Rh4zEM5/hvl3ebn
         ugQy3dbqcwrhJOl5lH4zp32Fkw60tr/vEyBzghkklxYj9Mv5getYf6vhpqWz0uPhICki
         CKXwkGqsoZWscHdKYEx8bvgBWSGo1eZi5erBrpbWLkz77PCg39wDEovXQxioxHoTtyBk
         0Zhfr0kWtIHM/F650pfgOpyH5HQfvSvqMK9B/eHQyDNyLOkvV4Cku+uqbqzVUAPr4rhB
         d7tg==
X-Gm-Message-State: ABuFfohnya5OR1keiRC7MdVva3n57Cz3hmUbElagnVEw5eLtv3CuD3Fz
        oSvpGffbzhuuutisOWAKz4bhonxeefBGhVMaFH2oDwjsySIASAudIno3MQ7b/erTTjW/uKrbj7o
        ClDjd6ZHJ3jlyx/rfxDsgsUpo/GPHIhf3UWx6zZI=
X-Received: by 2002:a63:8c4:: with SMTP id 187-v6mr21866382pgi.396.1539017529123;
        Mon, 08 Oct 2018 09:52:09 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60L9wNsdgPYcIcwcusELRl2ophzoO1VTcVDEZbC1AQYWLDcWE79O3R8MfL/skY6QJMUUtDcOyEPEJvUofsuCtI=
X-Received: by 2002:a63:8c4:: with SMTP id 187-v6mr21866365pgi.396.1539017528840;
 Mon, 08 Oct 2018 09:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181008145012.31312-1-colin.king@canonical.com> <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
In-Reply-To: <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Mon, 8 Oct 2018 17:51:56 +0100
Message-ID: <CAAoAYcO=qp7yb7392B_6wks2j2TaoxYXHtQPyH0kMkFMi+JW-A@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: remove extraneous setting of dev->colourfx.enable
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     colin.king@canonical.com, Eric Anholt <eric@anholt.net>,
        Greg KH <gregkh@linuxfoundation.org>, f.fainelli@gmail.com,
        rjui@broadcom.com, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Stefan.

Thanks for forwarding as the linux-rpi-kernel list hasn't sent it to me as yet.

On Mon, 8 Oct 2018 at 16:48, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Colin,
>
> Am 08.10.2018 um 16:50 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently dev->colourfx.enable is being set twice, hence the first
> > occurrance is redundant and can be removed, so remove it. This minor
> > issue was introduced by commit 7b3ad5abf027 ("staging: Import the
> > BCM2835 MMAL-based V4L2 camera driver.").
> >
> > Detected by CoverityScan CID#1419711 ("Unused value")
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/staging/vc04_services/bcm2835-camera/controls.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > index a2c55cb2192a..99831dd4365d 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > @@ -588,7 +588,6 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
> >
> >       control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
> >
> > -     dev->colourfx.enable = (ctrl->val & 0xff00) >> 8;
> >       dev->colourfx.enable = ctrl->val & 0xff;
> >
> >       ret = vchiq_mmal_port_parameter_set(dev->instance, control,
>
> as long as the current behavior is correct, i'm okay with this patch.
> But the byte masking looks suspicious, so i hope Dave can clarify that.

It's writing to the wrong structure member.
The function is used on the V4L2 control V4L2_CID_COLORFX_CBCR, which
is defined as:
V4L2_CID_COLORFX_CBCR (integer)
Determines the Cb and Cr coefficients for V4L2_COLORFX_SET_CBCR color
effect. Bits [7:0] of the supplied 32 bit value are interpreted as Cr
component, bits [15:8] as Cb component and bits [31:16] must be zero.

ctrl->val should therefore be setting dev->colourfx.u and
dev->colourfx.v with those masks. dev->colourfx.enable field should
have been set when going through ctrl_set_image_effect for contol
V4L2_CID_COLORFX set to V4L2_COLORFX_SET_CBCR.

I've confirmed with qv4l2 that that is what is wrong. That's only been
lurking there for almost 5 years - shows how often these weirder
effects get used.
I don't mind whether Colin's patch gets merged and then fixed up, or
drop Colin's patch and apply the correct logic via a new patch.

  Dave
