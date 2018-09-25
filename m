Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02166C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8F920858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="FmywNyAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8F920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeIYRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:18:09 -0400
Received: from erza.pados.hu ([176.9.136.194]:60482 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeIYRSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W4rq+iRc66zEBK+MlGH7JeXX8504geujMm1XGcfnxGM=; b=FmywNyAfnoeHpAemx6vG1XH1dg
        cKJFpKNcLJmM3dMhXeBnL6sUbKKzES+2m0qGWpv0qT9aFgRtXAaM4yo2qh1LKCUbHrJI8RU59Nwsc
        M9UIqxCdLxKU57/8dUrjKjh42CGyq4hpmSquX/eCqvDrHtAMWLjeCKmNc2szcuLnLsmmQfEwWK6bg
        hs/qXHmwt38h6hsIxu1Mx/+bQgHN2eBkWFHHqoUge6ZAufaX77ekrJm01JNCDU6MfDc7LFe447rj4
        dXOf0+8RrzuPXq6QjIDe3VPGFZoP/WNGeFI80A8LBWUyrIiz/uY9LkEvw9tAreh95VRgPNOq5H2OF
        QAlwDttg==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g4lFB-0004FZ-Us; Tue, 25 Sep 2018 13:11:06 +0200
MIME-Version: 1.0
Date:   Tue, 25 Sep 2018 11:11:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <6fdea2db02ece8c7b51fb03a112fa4c0@pados.hu>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180925110021.GE3332@localhost>
References: <20180925110021.GE3332@localhost>
 <20180925100635.GC3332@localhost> <20180924143151.2273-1-pados@pados.hu>
 <e4a12a0856d083eed0994ab888bc8869@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  >> + if (priv->gpio_output & BIT(gpio)) >> + return 0; >>
   + else >> + return 1; >> >> This could just simplified using negation (!),
    but perhaps this is >> easier to parse as it stands. >> >> Sorry, it is not
    clear what your preferred action here is. >> So should I leave it as is then
    or not? > > Just do > > res = !(priv->gpio_output & BIT(gpio)); > [...] 
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

>> + if (priv->gpio_output & BIT(gpio))=0A>> + return 0;=0A>> + else=0A>>=
 + return 1;=0A>> =0A>> This could just simplified using negation (!), bu=
t perhaps this is=0A>> easier to parse as it stands.=0A>> =0A>> Sorry, it=
 is not clear what your preferred action here is.=0A>> So should I leave =
it as is then or not?=0A> =0A> Just do=0A> =0A> res =3D !(priv->gpio_outp=
ut & BIT(gpio));=0A> =0A=0ALocking here? priv->gpio_output is a u8, there=
 is no way it can be partially=0Awritten. Or am I missing something else?=
=0A=0AKaroly
