Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2394AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3F020842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="GrxGVlBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3F020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeIYQy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:54:27 -0400
Received: from erza.pados.hu ([176.9.136.194]:59902 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeIYQy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ra6erTFXNgk9I4H0Q2TCK8OkN8Hip+9TONBJKg0TXDQ=; b=GrxGVlBJ3MqSj+s5HYl022n9PS
        Z0QevHk9Bk59upMFhPEjl9qcrUcfO122uxO0T894MgEEJBDV0CJKG7dUGoYyaCyiNzfml8UCLoE+x
        yDBlvt+Ywmbxm60NJ211sDJLicfxpPxyUN8Ry6O4FAu/7AbDtmNCJAIpyG2TuBEhxsVPCKvqWGfbd
        jEDTOFr378B3XrVW/SbQdF4FM6RXFh5VO36qTOQ9l3WDvHf14EkTzZyNzzjsCm2IZJ/EzulDC/cSX
        MlblHH5ADXN0yZnM1lwV5zsvXDz0bJhjUZ39roY85KPymmldOKJf/LE5n2uKWcZofHH7MkPqshgDN
        P9xH0ELw==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g4ksK-0001Za-Uz; Tue, 25 Sep 2018 12:47:29 +0200
MIME-Version: 1.0
Date:   Tue, 25 Sep 2018 10:47:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <d4f25792e9d0d008577021c85e01a809@pados.hu>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180925101523.GD3332@localhost>
References: <20180925101523.GD3332@localhost>
 <20180924143151.2273-1-pados@pados.hu> <20180925100635.GC3332@localhost>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  >> gpiolib doesn't clear bits not in mask for you, so you
   need to OR with >> *mask here to avoid setting random other bits. > > That
    was of course meant to be: *AND* with *mask. > Ah, okay, one question from
    my previous e-mail down. [...] 
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

>> gpiolib doesn't clear bits not in mask for you, so you need to OR with=
=0A>> *mask here to avoid setting random other bits.=0A> =0A> That was of=
 course meant to be: *AND* with *mask.=0A> =0A=0AAh, okay, one question f=
rom my previous e-mail down.
