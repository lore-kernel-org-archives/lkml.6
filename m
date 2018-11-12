Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2500A22503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CObHfrkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2500A22503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKMCGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:06:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39845 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKMCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:06:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id n11-v6so4541337pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NEZfahB7N0Ba9s5LVm2YEJ2DQJNsXJY70tJpylX1CRI=;
        b=CObHfrkQgc9QInVlmV4WaUg07HLLUwKiy7nZkAXxBf20y9sMJscnPMELND6IVKFIOc
         ke3LK6D20ZbTD6KJwto6xqYn2Sif811VCAYAQrEshZCLHoF53fyLS04oDWqKGycT3DEO
         Kpy+mEGC5nrinSV/zqtYpxXS55l+8/dKTVeRATo6xphfs2YjCZhdpY1KnvID99T6PoVt
         thO7c1GmHv1UM7Uunv9/tVsjdtOxyqTjEvYLC58xd6QPTH64jmvh7bpdU2ppPakP1NU7
         H3JfTbQZC10Ynd42Q48lyDMIx9Hgu10HwG2jiaGebEpZwbLMJ73/Y5uRcpX/QYqby9IU
         MVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NEZfahB7N0Ba9s5LVm2YEJ2DQJNsXJY70tJpylX1CRI=;
        b=dcCeJO0Hqc3pKa1+tX/9NPhjJDxeANpAb7Lt5OSH6sqwZ2WzR+iG7iwLON+OdfJAls
         bkTmkH8JPARIR597RqBEgDlsReEjfiwim7m4TYiEPCTcY0CaKBkaTRBjU3S+p5KPs9mZ
         cezPH8WgmPFVkL2v91XfyIEKwNpklAkzOf6SdjVMQzN3WCEForqw7SU4z2mYNpGEjZHt
         2LV/tWmkEri+wLu7MhGqfIN5daLwxrVF5gUwQ12aL0OMYU2yksjlnBGTIdZmqjcsTDI9
         AIK/uRfTQAuLFv21R/TAmQPRiRiG2vhi6vJWoyFQBk3v6j+UcNlQr7aTF/sXA4flI/d1
         1L1A==
X-Gm-Message-State: AGRZ1gLCeiCQMjQx4orRBHbEeQ5TReuZAunebVkelDsxZgcdf1ybFAMu
        qlRc3khvN0GK4a7ewjUjS8g=
X-Google-Smtp-Source: AJdET5fD3sUWKhUsYkEOOaHka99hvdZDl8R8h3LdQkGJamDFwTRbuL9+SuK3g+eiR7nrxfPwcel4GQ==
X-Received: by 2002:a63:e247:: with SMTP id y7mr1297887pgj.84.1542039143340;
        Mon, 12 Nov 2018 08:12:23 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id z7sm7819138pga.6.2018.11.12.08.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 08:12:22 -0800 (PST)
Date:   Mon, 12 Nov 2018 21:42:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-apb-ctrl.c: Switch to the gpio
 descriptor interface
Message-ID: <20181112161214.GB5367@nishad>
References: <20181111054405.GA32548@nishad>
 <20181112151739.GI13311@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112151739.GI13311@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:17:39PM +0100, Johan Hovold wrote:
> On Sun, Nov 11, 2018 at 11:14:14AM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/greybus/arche-apb-ctrl.c | 158 ++++++++++-------------
> >  1 file changed, 65 insertions(+), 93 deletions(-)
> 
> > -	apb->pwrdn_gpio = of_get_named_gpio(np, "pwr-down-gpios", 0);
> > -	if (apb->pwrdn_gpio < 0)
> > -		dev_warn(dev, "failed to get power down gpio\n");
> > +	apb->pwrdn = devm_gpiod_get(dev, "gb,pwr-down-gpios", GPIOD_OUT_LOW);
> > +	if (IF_ERR(apb->pwrdn)) {
> 
> Looks like you didn't even compile test this one. :(
> 
> > +		ret = PTR_ERR(apb->pwrdn);
> > +		dev_warn(dev, "Failed requesting power down GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> 
> Johan

Sorry about that, I'll check and resend.

Thanks for the review.

Regards,
Nishad
