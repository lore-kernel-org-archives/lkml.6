Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94DBC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6841218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWP8UNN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBIQti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:49:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38119 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfBIQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:49:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so5530403lja.5;
        Sat, 09 Feb 2019 08:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1gI8Zrbgf67gTz6FH6HJeQDuuHQ1TpXgfCnjb7wzNo=;
        b=JWP8UNN7Dnk9k46Hyia7Eb30yeuDaZO8ho467Jo1HYkbM6L2C96VT9+FLPAjPYni7g
         K90yv/VwprRe4A5+Zp0+xr06/g5A7mz+OGGxnmEuQu5H6pxLyCUV4fcCDpK4dNr7VAwM
         ncjGqUI3K4lkmOxv1TFinyEPg0HTalRAe0LMsZzQzfgVGqJ70E23kBCXlPrupKhjdpys
         T6hTglwKZcVAFAtm9ZpVUFr4wIrraw5hRzAuk/AwZH9NyeEuN5R4ckfu9mPYEzOiDJ05
         qVr56KTHljRRmfi5XiqYjO7RmPUCLItTuhOOeOgxaE0R4ru+NTsWnNBjQ2MxQd02AorU
         fNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1gI8Zrbgf67gTz6FH6HJeQDuuHQ1TpXgfCnjb7wzNo=;
        b=d8uCIUKU9aJEVhFit57jnIYk63rcM16kCmO1vVhm6vhLai2nFNVI9Eaqaool+cCbJL
         0uxC0to8m2wQkGpWdHdgSnfCvtW67IpvDjnh2cFPTEyp+qqw5r80vqzzlGD4JdVbCjTy
         gg6L8egC2+W4sI/5d122khbh+2siJxt03E0LH/7oahQr+4FT4f5D3l3lhwqgCA51vuAc
         055OxsqKgli59fd4aSo6Ed1+TJXJB2H3rEvEU8WbSGZE3llQgPXjVs1Fshn+YkKHnNqO
         6ASJCktD3Q8jg5WLyqiXHtf1/vnBapVRlDqJnNKHdcJwS+hlNAI+R0owVRbKeuxlXp4x
         Fc3Q==
X-Gm-Message-State: AHQUAuZKs3NLvMDHGo8cn+g8BA1CYboER2UKrAjOZSqeuT5ph7ZyDbOp
        fXctoXLaD3RjqRhLRX7O2rc=
X-Google-Smtp-Source: AHgI3IZUmKvyfkrCdtZPIF+67uFtSKXpnnDIJPhXtarKFzQWVImKSWWRSuUtc3tPL6YIxqlmyZ8vmA==
X-Received: by 2002:a2e:9249:: with SMTP id v9-v6mr36050ljg.164.1549730975144;
        Sat, 09 Feb 2019 08:49:35 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id a9-v6sm623591ljf.52.2019.02.09.08.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 08:49:34 -0800 (PST)
Date:   Sat, 9 Feb 2019 17:49:12 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, pmeerw@pmeerw.net, johan@kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190209164908.GA2888@arch>
References: <20190201215759.14569-1-tduszyns@gmail.com>
 <20190201215759.14569-4-tduszyns@gmail.com>
 <20190202171247.0d0fc122@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190202171247.0d0fc122@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 05:12:47PM +0000, Jonathan Cameron wrote:
> On Fri,  1 Feb 2019 22:57:59 +0100
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> > Add device tree support for Plantower PMS7003 particulate matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> Hi Tomasz,
>
> Sorry, I clearly didn't look at this in enough detail on earlier versions.
> I think the set gpio is rather device specific so should have a vendor
> prefix.
>
> I would also like to get an opinion on the generic name from the devicetree
> maintainers before we start to standardise on it.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  .../iio/chemical/plantower,pms7003.txt        | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > new file mode 100644
> > index 000000000000..cbad95480e04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > @@ -0,0 +1,20 @@
> > +* Plantower PMS7003 particulate matter sensor
> > +
> > +Required properties:
> > +- compatible: must be "plantower,pms7003"
> > +- vcc-supply: phandle to the regulator that provides power to the sensor
> > +
> > +Optional properties:
> > +- set-gpios: phandle to the GPIO connected to the SET line
>
> Hmm. This is a somewhat 'unusual' one so should probably have a vendor prefix.
>

Makes sense. I'll respin the series with this extra change you're
suggesting.

> > +- reset-gpios: phandle to the GPIO connected to the RESET line
>
> reset is common and clear in meaning, so vendor prefix probably not appropriate.
> > +
> > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > +
> > +Example:
> > +
> > +&uart0 {
> > +	air-pollution-sensor {
> > +		vcc-supply = <&reg_vcc5v0>;
> > +		compatible = "plantower,pms7003";
> > +	};
> > +};
>
