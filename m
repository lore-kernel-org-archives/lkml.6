Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE79C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEBD2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="S2CIGOvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEBD2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIDWeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:34:06 -0400
Received: from erza.pados.hu ([176.9.136.194]:49438 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeIDWeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e2aL5W4lgrcMk481gorzHpDIjeOYOlu5nWqLZqbKXK0=; b=S2CIGOvv6MHvjo23WEkgD2xSOg
        zVpQUJkfZT6sH+V6fssyitJ+6eAaD7jHEeRHQ44rYoo0leSLslaJZnQYu3Gj4OAK9IQ+fCJMD9dfw
        A05qOxaEcg5RiirfgkkAziaonzvWZ3PAs8KH81KvYOM6wcpwKcTajt9pjuvYtWY4+WQEsIrHPZegH
        pAUayyo1Xq+tkt14oojiLj1Dz8J2TsWKA98pdnDAR7591r0UZK+wAn9436JQKw7QISDkkrX/PXw+X
        wOv4+zRhfcareFi56y+sLmNU2LO0iOePPC5yhidAn8xIFs7Yvotorfc7YdPCOtWY7zkkyWPCs8f4s
        dwrWEZHQ==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fxFjz-0008O5-4Z; Tue, 04 Sep 2018 20:07:51 +0200
MIME-Version: 1.0
Date:   Tue, 04 Sep 2018 18:07:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <680c039b5fb2beafa48ea12e492341db@pados.hu>
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for
 FT230X
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>,
        andy.shevchenko@gmail.com, ajaykuee@gmail.com,
        daniel.thompson@linaro.org
In-Reply-To: <2d91567c930ae5770cc55f92c37a9c6d@pados.hu>
References: <2d91567c930ae5770cc55f92c37a9c6d@pados.hu>
 <20180904124924.GA7278@localhost> <20180825204744.2307-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  >>> + priv->gc.ngpio = 4; >> >> Shouldn't this be handled
   the other way round? IIRC there are two FTX >> device types with four pins,
    and one type where only one pin is >> accessible. > > There are 4 devices
    with 1 GPIO, 1 device with 2 GPIOs, 2 devices with 4 GPIOs, > and 1 device
    with 6 GPIOs. Source: http://www.ftdichip.com/FT-X.htm (2nd table) > Do you
    still want me turn this over? > [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: ftdichip.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> + priv->gc.ngpio =3D 4;=0A>> =0A>> Shouldn't this be handled the othe=
r way round? IIRC there are two FTX=0A>> device types with four pins, and=
 one type where only one pin is=0A>> accessible.=0A> =0A> There are 4 dev=
ices with 1 GPIO, 1 device with 2 GPIOs, 2 devices with 4 GPIOs,=0A> and =
1 device with 6 GPIOs. Source: http://www.ftdichip.com/FT-X.htm (2nd tabl=
e)=0A> Do you still want me turn this over?=0A> =0A=0AAaah, but those oth=
er devices are not UART bridges. I see what you mean now.=0AThe point for=
 me when developing th original patch
