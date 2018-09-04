Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97069C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB0A2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="ggQDs/wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB0A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIDWT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:19:29 -0400
Received: from erza.pados.hu ([176.9.136.194]:48926 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RsaR4h8O9eeLT1QeZ8lVsfaBgBLgis0ynEDQWGgzDo4=; b=ggQDs/wMPCIn/mOZSWVZ4KEcZV
        XnBnbM0c91sF8w5yFu4W0vU3Vm0jvnpxGHJFqkGUPxDxmFWbpVE5bNmBslFsdrAAFSbYdFyJdDO/p
        J9rswacPEy5w8sFxyYoaF/baR5vklyOVgWwHtjq23HjLFAtHhISuancJrOsHO9UHeBQFLw0TJ2h7A
        P/AbmjpIdWT4grGkGcPPCRE7tfR9eUyPPyIQN6cr6qHaUcCrca12iRFEewxKF7aAemihsHyT4VOtP
        2L03pnstGS+80slAnAauM5EccY/ZvgVoUAy1HStK7g+vQ3nyP3RTJ5qJX8K0by0S9r2uzlHN5TmjE
        cUACl18Q==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fxFVs-0008Aa-LB; Tue, 04 Sep 2018 19:53:17 +0200
MIME-Version: 1.0
Date:   Tue, 04 Sep 2018 17:53:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <2d91567c930ae5770cc55f92c37a9c6d@pados.hu>
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for 
 FT230X
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>,
        andy.shevchenko@gmail.com, ajaykuee@gmail.com,
        daniel.thompson@linaro.org
In-Reply-To: <20180904124924.GA7278@localhost>
References: <20180904124924.GA7278@localhost>
 <20180825204744.2307-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Thanks for the review, I am on the road most of this week,
    but I will submit a new patch this weekend with all your feedback incorporated.
    Until then here are my inputs / answers to some of your points. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: checkpatch.pl]
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, I am on the road most of this week, but I will sub=
mit=0Aa new patch this weekend with all your feedback incorporated. Until=
 then here=0Aare my inputs / answers to some of your points. =0A=0A> Actu=
ally, after thinking about this some more, it may be better to just=0A> c=
onfigure all pins during probe. The device is managed by the kernel,=0A> =
and we can't really consider what user space may have done before, at=0A>=
 least if we can't query the device. Better to be in a consistent state=
=0A> while the driver is bound.=0A=0AThe CBUS pins do not affect the UART=
 communication in any way, so if we're=0Anot using the GPIO, I don't see =
any reason why we should destroy the CBUS=0Astate just for the sake of kn=
owing what value they have, even though we don't=0Aset or use or need the=
m and there is also no interaction. But if you wish so,=0AI'll set them d=
uring probe, I just think we are disabling a possible use-case=0Awith no =
added gain.=0A=0A>> checkpatch.pl emits a bunch of warnings, recommending=
 const for structs.=0A>> I am unsure if this makes sense, existing code i=
n this same and also=0A>> other modules does not adhere to this rule eith=
er. I fixed everything else.=0A> =0A> Really? Checkpatch doesn't complain=
 here. Were you using the --strict=0A> option, perhaps? Don't do that...=
=0A> =0A=0AYeah, that's what happened. I'll drop that flag.=0A=0A>> + /* =
device's direction polarity is different from kernel's */=0A> =0A> Why so=
? You could just replace gpio_input with gpio_output. I think that=0A> ma=
y be preferred.=0A=0AThat doesn't change the fact that for the kernel (fo=
r example in=0Aftdi_gpio_direction_input or ftdi_gpio_direction_output) '=
1' is still input.=0AYes I know we can do the inversion in those function=
s "for free" by setting=0Ainstead of clearing and vice-versa, I just thou=
ght it is better if I choose=0Ato stay with the kernel convention and tur=
n it device-specific at the deepest=0Alevel possible. Not arguing, just e=
xplaining what my motivation was. I'll=0Achange it as you requested.=0A=
=0A>> + if (!priv->gpio_used) {=0A>> + /* Set default pin states, as we c=
annot get them from device */=0A>> + priv->gpio_input =3D 0xff;=0A>> + pr=
iv->gpio_value =3D 0x00;=0A>> + result =3D ftdi_sio_set_cbus(port,=0A>> +=
 priv->gpio_input,=0A>> + priv->gpio_value,=0A>> + FTDI_SIO_GPIO_MODE_CBU=
S);=0A>> + if (result)=0A>> + return result;=0A>> +=0A>> + priv->gpio_use=
d =3D true;=0A>> + }=0A> =0A> So I think this initialisation should be do=
ne at probe instead.=0A=0ASee my point further above.=0A=0A> Factor this =
out to an eeprom helper that can be reused by other chip=0A> types.=0A=0A=
Yep, I'll consult the other gpio patch regarding this as you suggested=0A=
in the other's review. By the way, sorry for the parallel submission,=0AI=
 wasn't aware of Poulain's patch in this same month.=0A=0A>> + priv->gc.n=
gpio =3D 4;=0A> =0A> Shouldn't this be handled the other way round? IIRC =
there are two FTX=0A> device types with four pins, and one type where onl=
y one pin is=0A> accessible.=0A> =0A=0AThere are 4 devices with 1 GPIO, 1=
 device with 2 GPIOs, 2 devices with 4 GPIOs,=0Aand 1 device with 6 GPIOs=
. Source: http://www.ftdichip.com/FT-X.htm (2nd table)=0ADo you still wan=
t me turn this over?=0A=0A>> +#else=0A>> +=0A>> +static int ftdi_sio_gpio=
_init(struct usb_serial *serial)=0A> =0A> As the test robot reported, the=
se should take a port as their argument.=0A=0AYes, I already sent in a v2=
 for that. So my patch incorporating your feedback=0Awill be v3.=0A=0ATha=
nks again,=0AKaroly
