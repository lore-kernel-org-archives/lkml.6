Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895DAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3824125CB4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isLuN2OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3824125CB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966459AbeF0WGg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:06:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39204 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966278AbeF0WGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:06:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so3468748wro.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=822kS9DEiZa/8GhvCWkpTRHn8vPFlTFFBEL5xbYeZhY=;
        b=isLuN2OLDJ8YYsOn7DjTZfpaqyU/XJdSQgyW2Pzq0bA/ii3OYEXvIG88t4Aq7LU415
         20x5n8EMl0EGHIGFKOWwreusZTFcTdVq60NJ8yhFp9OEmgZtYZPTl87s14wX5Se1pKot
         6AksOv+W9L9DMkQeuW/Q7w2oXLcmRVncykPeIuOA3QaWFvHSTVLTpJ9miRSrnc8OV+Lo
         Airz0okZjCM9o3x5yaFRJLNOgphbnL885md1b0WzYLU2SuKfAUSqyXA0PMkfw2AXBbfC
         xQMu4pNpaHrD+DvL5ZAbABnZJHuwB0u/BQZrVqCKRi31pqA/zt+JIKTr8pbOW4torFRw
         jVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=822kS9DEiZa/8GhvCWkpTRHn8vPFlTFFBEL5xbYeZhY=;
        b=akEJ57kFuMNCBTkPKtTRwIPPVAxxUb1HS4+Pup67wPdHifzIM2713Z1r0kH/qxZRr0
         0pHaUcE7eTpS3hCIuDcF560JHRH4k72XIzsd0v2qaN/v4H1jB83/Tf59fOVZqdjxmIWd
         ocEgQ3m2lqxe4MJYx4pbOKmK5WeGZ9YpCAIRytF18eHYyV6ZCl1QtryD5/0SuZTR8vRj
         rJ7D5/I5RaAJUjXHBAybzRErg725Rq9yDRVxDn60vDuhXbmTo3ttwlEegqSYKsJ5MsgI
         qLxeGOV4TF8miJBJ2zOOxviL9l4W1PorrB8k1V1RdKicEI/oVxrnxUz51zztIKmdZZmD
         fFvg==
X-Gm-Message-State: APt69E1drRXwkFQ2MVuPIgR+pG8G26POYr2mzpijgviWRmh9FOJOB5vK
        xg0bLw33gHoOB5oCQg6EpT0=
X-Google-Smtp-Source: AAOMgpfQAFURJ7poRX2mb6mhzL1nH4u6T17UsOthAAsqY2ID4NtM6UmsxBprT0QhsyOhsk6GVIWisw==
X-Received: by 2002:adf:f3d2:: with SMTP id g18-v6mr6285769wrp.279.1530137194038;
        Wed, 27 Jun 2018 15:06:34 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id s3-v6sm5680352wrp.76.2018.06.27.15.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 15:06:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>, wens@csie.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.kocialkowski@bootlin.com
Subject: Re: [linux-sunxi] Re: [PATCH] drm/sun4i: Implement zpos for DE2
Date:   Thu, 28 Jun 2018 00:05:07 +0200
Message-ID: <5955444.QSmitHbQH2@jernej-laptop>
In-Reply-To: <8012754.crdjCMeE0H@jernej-laptop>
References: <20180627164514.4777-1-jernej.skrabec@siol.net> <20180627182500.eanqagmcfmsgzos2@flea> <8012754.crdjCMeE0H@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 27. junij 2018 ob 22:58:28 CEST je Jernej =C5=A0krabec napisal(a=
):
> Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a):
> > Hi!
> >=20
> > On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > > Initial implementation of DE2 planes only supported fixed zpos.
> > >=20
> > > Expand implementation with configurable zpos property.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >=20
> > Thanks for that work. I guess you should expand a bit on the exact
> > setup you're doing here.
>=20
> OK.
>=20
> > Are the pipes working the same way on the DE2 than on DE1, ie does the
> > pipe blending applies before the alpha blending, and therefore you
> > need to make sure that there's not two planes with alpha going to the
> > same pipe?
>=20
> I'm not familiar with DE1 and I'm not sure what the problem is.
>=20
> However, there is an issue in DE2 when alpha blending multiple planes if
> bottom-most plane doesn't cover all screen. In this case alpha blending
> produce weird result on screen. Fortunately, there is elegant solution.
> Black opaque fill color is enabled for pipe 0 (always at the bottom), whi=
ch
> covers any "undefined region" and that makes alpha blending happy again.
>=20
> Alternatively, blending modes between planes could be tweaked or disabled,
> but I found aforementioned solution is much simpler and you set it only
> once.

I forgot to test one corner case - what happens if pipe 0 has alpha channel=
=20
enabled. I think it still has to work, since there is background color whic=
h=20
IMO is meant for such cases.

> > Also, you seem to use the pipe and channels indifferently now, why is
> > that?
>=20
> Why do you think so?
>=20
> Channel always represents HW unit, for example, on H3, mixer0, channel 0
> always represents VI plane, channel 1, represents first UI, plane, channel
> 2, second UI plane, etc.
>=20
> Pipe 0 always represent channel at the bottom, pipe 1 channel on top pipe=
 0,
> etc. Initial, fixed zpos implementation really had 1:1 mapping, but now it
> can be different.
>=20
> Register SUN8I_MIXER_BLEND_ROUTE holds pipe <-> channel mappings.
> Bits 3:0 represents pipe 0 and holds channel number. Bits 7:4 represents
> pipe 1, etc.
>=20
> Additionaly,  there can be holes, for example, pipe 3 and pipe 0 are enab=
led
> and pipe 1 and 2 are disabled.
>=20
> I hope I answered your questions.

Looking at DE2.0 documentation, chapter 5.10.2 (pp. 87) might give you some=
=20
answers. Block diagram seems much simpler than that of DE1.

Best regards,
Jernej



