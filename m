Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E20C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34F320842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="wbOAREI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34F320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeIYQxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:53:31 -0400
Received: from erza.pados.hu ([176.9.136.194]:59856 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeIYQxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D1ClI2SlRb1BjnOlcG4xctxVkPf9gJNPeNCEkPkqOm8=; b=wbOAREI4OygkXj9JJMDjCBfbR/
        KrdHeqW4H64IqXhiwiXNUKcMTq8k9pTW3Q/ruMQ2wKrqwY8orUz0YzATbVgeDotHFTtVj+VTkf5of
        b8CPDqXjq6yUWKP7JldJpIUacONJvvzGTRBPYpGnR695tGuX+8+AXqtA6So2333aD06Zr06NUxLr1
        LGr8LyumgaUgU51XZE7B+3+SAkI5bEP2gQ+y/OpxHId4K8PdUXwc2Up9gBFnTvcOIAPqg5+B9fDFk
        NKDpqiQqAO0iAVHna+fn0DUsosGoTV5qhWmMK0tx9JGFzilc/b4EBFKXv+MFCnUCFG2GR2HkUo6eo
        nIYuDm0Q==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g4krQ-0001Ya-4p; Tue, 25 Sep 2018 12:46:32 +0200
MIME-Version: 1.0
Date:   Tue, 25 Sep 2018 10:46:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <e4a12a0856d083eed0994ab888bc8869@pados.hu>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180925100635.GC3332@localhost>
References: <20180925100635.GC3332@localhost>
 <20180924143151.2273-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi, >> +#if defined(CONFIG_GPIOLIB) >> +static const char
   * const ftdi_ftx_gpio_names[] = { >> + "CBUS0", "CBUS1", "CBUS2", "CBUS3"
   >> +}; >> +#endif > > We want to keep the ifdeffery to a minimum, so move
   this inside the > gpiolib ifdef below (and possibly even into the function
    where it is > used). > > Also note that these names are shared with FT232R,
    but not with FT232H. > [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=0A>> +#if defined(CONFIG_GPIOLIB)=0A>> +static const char * const =
ftdi_ftx_gpio_names[] =3D {=0A>> + "CBUS0", "CBUS1", "CBUS2", "CBUS3"=0A>=
> +};=0A>> +#endif=0A> =0A> We want to keep the ifdeffery to a minimum, s=
o move this inside the=0A> gpiolib ifdef below (and possibly even into th=
e function where it is=0A> used).=0A> =0A> Also note that these names are=
 shared with FT232R, but not with FT232H.=0A> =0A=0AWhat naming do you su=
ggest then?=0A=0AMy personal preference would be however to leave this na=
me as is, because=0Athis patch only adds support for the FT-X. Even if su=
pport for others can =0Abe added relatively trivially after this, there i=
s explicitly no GPIO =0Asupport for FT232R *yet*. If somebody else adds G=
PIO support for the FT232R=0Ain a later patch, he/she should make corresp=
onding adjustments themselves,=0Aincluding naming changes. IMHO.=0A=0A>> =
+static void ftdi_gpio_set_multiple(struct gpio_chip *gc,=0A>> + unsigned=
 long *mask, unsigned long *bits)=0A>> +{=0A>> + struct usb_serial_port *=
port =3D gpiochip_get_data(gc);=0A>> + struct ftdi_private *priv =3D usb_=
get_serial_port_data(port);=0A>> +=0A>> + mutex_lock(&priv->gpio_lock);=
=0A>> +=0A>> + priv->gpio_value &=3D ~(*mask);=0A>> + priv->gpio_value |=
=3D *bits;=0A> =0A> gpiolib doesn't clear bits not in mask for you, so yo=
u need to OR with=0A> *mask here to avoid setting random other bits.=0A=
=0AI guess you meant AND here?=0A=0A>> + if (priv->gpio_output & BIT(gpio=
))=0A>> + return 0;=0A>> + else=0A>> + return 1;=0A> =0A> This could just=
 simplified using negation (!), but perhaps this is=0A> easier to parse a=
s it stands.=0A> =0A=0ASorry, it is not clear what your preferred action =
here is. =0ASo should I leave it as is then or not?=0A=0AKaroly
