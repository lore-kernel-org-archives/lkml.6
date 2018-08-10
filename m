Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C43C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02960223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LapSvuuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02960223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeHJLym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:54:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37984 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeHJLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:54:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so6658306ljc.5;
        Fri, 10 Aug 2018 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OhLEnYtCb9DR28RXgK1fIuIHVoRhE1vmXNLqwDz2Bfk=;
        b=LapSvuucfQk4hUqN2cPIdOR2p34Zws4qG58EdWSqg/2Ec0piu2hn4tZnLL67Su0O7D
         QHtY4G43x5xBbiZ9rYVeVyBdlkfiUAjhkIDxBLmVyKlPFNcBc3iUspC6ggSVSOMIm4bO
         9s2ijL8tfKgE4X2edcpkByPo/e6ZCaAShxCsfO/c6AHglFaFq4IODxyPwkg9MZ4eT3hu
         Niq0RDlUBnwfCAxINxalkMA3H1YXa7xh8qAfUE+5r736myJmc/1wCQmHdOHHxVNiBj6/
         hbpUcAD3FYmItElBogVnoHMFMLL+FSjVbXXl5clJ7jHOCIH/9udkhiDxqDpEAbwc8PVQ
         iuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OhLEnYtCb9DR28RXgK1fIuIHVoRhE1vmXNLqwDz2Bfk=;
        b=CqfHHHipGAZjOjfJERL/EteP7qt1hQ99Rt1t6FYQ0bj8CphpeFOEUl3QaNT4v+cvnR
         FVNj9IEepG7e2W7UmKD4owUG7Psdd961Xnkm2K4Sue6+BiZbuw0qw4AWmccDwqBBedc7
         QLnZOtMRgx0pnjHAIKlClbJm9iXjXoBCGXjWGxXADMxi6Y0RQlGd31vJSIy/D8J7yusm
         drWWAO76CI35iMp7GAsv4QTCV1v1XWjUhiseEmCjPil65grqh8jlqje+ot7SZ4+SN+pM
         oQ3PkxPwoPTrVr3Jd5piKTqGE7t7fH9g1bzfQQ84uAcr0pPym7W0Avnp7hbXXeRUnlj7
         K+Dg==
X-Gm-Message-State: AOUpUlENmc6QeE2WYi6yzS6QFxtbo51OOtN1N+kxexYTIp5fvYl71w0Y
        T/VQSHOYUv/ULq05L1xprU8=
X-Google-Smtp-Source: AA+uWPxwbsJvdh+n0LSqEVNShvaltqcHxCx3MpRyW1//vsEhGtBUB3ZUUXCyIAFvP6m0wa8H4UVj+w==
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr3991797lji.10.1533893137210;
        Fri, 10 Aug 2018 02:25:37 -0700 (PDT)
Received: from localhost (0x3e2c8754.mobile.telia.dk. [62.44.135.84])
        by smtp.gmail.com with ESMTPSA id q65-v6sm1858891lfb.80.2018.08.10.02.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 02:25:36 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
        <20180709094304.8814-4-esben.haabendal@gmail.com>
        <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
        <87k1ozzquk.fsf@gmail.com>
        <20180809162652.r34omvkctzxte422@pengutronix.de>
Date:   Fri, 10 Aug 2018 11:25:34 +0200
In-Reply-To: <20180809162652.r34omvkctzxte422@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 9 Aug 2018 18:26:52
 +0200")
Message-ID: <87zhxuo9o1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Thu, Aug 09, 2018 at 02:06:43PM +0200, Esben Haabendal wrote:
>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>>=20
>> > On Mon, Jul 09, 2018 at 11:43:03AM +0200, Esben Haabendal wrote:
>> >> From: Esben Haabendal <eha@deif.com>
>> >>=20
>> >> Always update the stopped state when busy status have been checked.
>> >> This is identical to what was done before, with the exception of error
>> >> handling.
>> >> Without this change, some errors cause the stopped state to be left in
>> >> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read()=
 and
>> >> i2c_imx_xfer().
>> >>=20
>> >> Signed-off-by: Esben Haabendal <eha@deif.com>
>> >> ---
>> >>  drivers/i2c/busses/i2c-imx.c | 12 ++++++------
>> >>  1 file changed, 6 insertions(+), 6 deletions(-)
>> >>=20
>> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
>> >> index d86f152176a4..1db8e6790afc 100644
>> >> --- a/drivers/i2c/busses/i2c-imx.c
>> >> +++ b/drivers/i2c/busses/i2c-imx.c
>> >> @@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_stru=
ct *i2c_imx, int for_busy)
>> >>  			return -EAGAIN;
>> >>  		}
>> >>=20=20
>> >> -		if (for_busy && (temp & I2SR_IBB))
>> >> +		if (for_busy && (temp & I2SR_IBB)) {
>> >> +			i2c_imx->stopped =3D 0;
>> >>  			break;
>> >> -		if (!for_busy && !(temp & I2SR_IBB))
>> >> +		}
>> >> +		if (!for_busy && !(temp & I2SR_IBB)) {
>> >> +			i2c_imx->stopped =3D 1;
>> >>  			break;
>> >> +		}
>> >
>> > Would it make sense to assign to ->stopped independent of for_busy?
>>=20
>> What do you mean?
>>=20
>> Assigning to ->stopped on each check for I2SR_IBB in loop, independent
>> of the for_busy argument?  I don't think so.  The additional assignments
>> would be to the same value as it is set to already.
>
> Currently you have:
>
> 	if (for_busy && (temp & I2SR_IBB)) {
> 		i2c_imx->stopped =3D 0;
> 		break;
> 	}
>
> 	if (!for_busy && !(temp & I2SR_IBB)) {
> 		i2c_imx->stopped =3D 1;
> 		break;
> 	}
>
> The semantic of this is the same (apart from always updating .stopped)
> but is imho easier:
>
> 	i2c_imx->stopped =3D !(temp & I2SR_IBB);
>
> 	if (for_busy !=3D i2c_imx->stopped)
> 		break;

Yes, that should work also.
Shorter, but IMHO a bit more convoluted to read.
Let me know if I should send a new version with this change.

/Esben
