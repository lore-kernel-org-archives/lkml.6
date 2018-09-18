Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA7ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D14206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="vrrPIZ7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D14206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeIRPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:07:27 -0400
Received: from erza.pados.hu ([176.9.136.194]:41174 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbeIRPH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pRLruqAu5UIkefxjI6ufy+FsBjthtPNNH3su70bp428=; b=vrrPIZ7Hx085dYK/ro77cEMJMp
        SZceJWLpem2wBmah+yz5hCs6m8eP8WNAW1Ms4i1tWd9rGI5VGSNz6QzKsQ3lBBDsobENR/uMuhgta
        uAsoG6lBEg/7Es6e9Kn5hmQdlV/4RN8RN5NystvPKTcRe1YVyENfaEXaUfZdJuuBdRGMdduUCRJTn
        eyE54qAdWWa6+OPp4UkP1uVHE9n1Nxmm7urg0hKKh62bwcE8lpRD1c+Dfi5TzjbI5MGVOgHQWslnB
        zROSDQFfEXASr5EsB2hqSwlzdeQHj7jaHIFA/PSZlzwPDSEySqFQZrT+enpiB5NNaL3xJ69DWjmqw
        OXCsaF3Q==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g2CPy-00016z-13; Tue, 18 Sep 2018 11:35:38 +0200
MIME-Version: 1.0
Date:   Tue, 18 Sep 2018 09:35:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <ef753ab98cf19ce4482e76864d406c1e@pados.hu>
Subject: Re: [PATCH v4] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180918091634.GC3943@localhost>
References: <20180918091634.GC3943@localhost>
 <20180916175847.3288-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  >> + goto out_free; >> + >> + /* Chip-type guessing logic
   based on libftdi. */ >> + priv->gc.ngpio = 4; /* FT230X, FT231X */ >> + if
    (le16_to_cpu(serial->dev->descriptor.bcdDevice) != 0x1000) >> + priv->gc.ngpio
    = 1; /* FT234XD */ > > As I mentioned in my last mail: I've asked FTDI about
    this, but I fear > that FTX234XD has bcdDevice 0x1000 and we may need to
   just always > register all four pins after all. > [...] 
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

>> + goto out_free;=0A>> +=0A>> + /* Chip-type guessing logic based on li=
bftdi. */=0A>> + priv->gc.ngpio =3D 4; /* FT230X, FT231X */=0A>> + if (le=
16_to_cpu(serial->dev->descriptor.bcdDevice) !=3D 0x1000)=0A>> + priv->gc=
.ngpio =3D 1; /* FT234XD */=0A> =0A> As I mentioned in my last mail: I've=
 asked FTDI about this, but I fear=0A> that FTX234XD has bcdDevice 0x1000=
 and we may need to just always=0A> register all four pins after all.=0A>=
 =0A=0ATo avoid missing 4.20, what is the latest time I should wait for F=
TDI's answer?=0AOr should I just submit v5 as it is now and you'll incorp=
orate FTDI's feedback=0Awhen you receive it?=0A=0A=0A>> +static void ftdi=
_gpio_remove(struct usb_serial_port *port)=0A>> +{=0A>> + struct ftdi_pri=
vate *priv =3D usb_get_serial_port_data(port);=0A>> +=0A>> + if (priv->gp=
io_used) {=0A>> + /* Remark: Exiting CBUS-mode does not reset pin states =
too */=0A>> + ftdi_exit_cbus_mode(port);=0A>> + priv->gpio_used =3D false=
;=0A>> + }=0A> =0A> This should go after deregistration or we have a tiny=
 race window here.=0A=0ACan you elaborate on that to make sure I get it r=
ight? =0ABy "deregistration" do you mean deregistering the GPIO chip belo=
w in the same method?=0ADoes that mean something can call into our module=
 while this method is running?=0AIf not, I'm clueless about the possible =
race here.
