Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E7C04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AA92146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="L9Gl45N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AA92146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeIRQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:00:01 -0400
Received: from erza.pados.hu ([176.9.136.194]:42970 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbeIRQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u8uBV0Z7F0fwoxVu4vprfNWklycAQeXOxqQ4v4mTZa4=; b=L9Gl45N431BH25Q0calmn6p7Xu
        wU5w0cEw+3rPjvLKIcJ6aKo5gYYiLvQNrs9yzbNtcZe9WfmmchOMO86dECHWAU5s780ULZTPghEiM
        g/bcekG070JjA2mBwU2wcI5B2BWIkjfNLtkQCZCSHAc43KeVHcHqa5JUSmQKRsbL43e3Qy+Q8+a+h
        u3Qcf7uQ1qjxXBjsiPgKAafe1o/L6nz0IVqYo1zfnCW01pvKlJnk6Gko4YzhplLQSxtdic0SBNRBs
        vW1zAqOzHeXihH2W2nhEvfxpy9s1+kQRCdkv4sXWw8FH+bbK/1dDTviQZEWEY3bdBkjGRXorfoJ2F
        WVYOcHyw==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g2DEe-0006VO-QE; Tue, 18 Sep 2018 12:28:00 +0200
MIME-Version: 1.0
Date:   Tue, 18 Sep 2018 10:27:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <6e1a6550cbf886cb7dcfea641244bdcf@pados.hu>
Subject: Re: [PATCH v4] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180918094515.GD3943@localhost>
References: <20180918094515.GD3943@localhost>
 <20180918091634.GC3943@localhost> <20180916175847.3288-1-pados@pados.hu>
 <ef753ab98cf19ce4482e76864d406c1e@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  > We'll get this into 4.20 either way, there's plenty of time.
    But I guess > we could play it safe and always register four pins, and if/when
    we get > more info about FT234XD we can implement registering just one pin
    in a > follow up patch. > > Sounds good? If so I'll just merge your v5 (registering
    four pins) next > week. [...] 
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

> We'll get this into 4.20 either way, there's plenty of time. But I gues=
s=0A> we could play it safe and always register four pins, and if/when we=
 get=0A> more info about FT234XD we can implement registering just one pi=
n in a=0A> follow up patch.=0A> =0A> Sounds good? If so I'll just merge y=
our v5 (registering four pins) next=0A> week.=0A=0AOfc, thank you.=0A=0A>=
> Does that mean something can call into our module while this method is =
running?=0A>> If not, I'm clueless about the possible race here.=0A> =0A>=
 Correct, you can get gpio callbacks until the gpio chip has been=0A> der=
egistered (anything coming in after that would be a gpiolib bug).=0A=0AI'=
m just puzzled by the fact that this can still happen even while the port=
 =0Aremoval code is running. It also makes me ask the question what else =
here can=0Arun in parallel. Don't we need mutexes here-and-there in the f=
tx gpio functions too=0Ain this case? Or does gpiolib make sure to serial=
ize multiple pin and direction=0Asetting calls?=0A=0AThank you,=0AKaroly
