Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35817C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF6620651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="jC9CHrCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfAOJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:18:04 -0500
Received: from erza.pados.hu ([176.9.136.194]:41762 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOJSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5ivtTZOvbYVZkdYqNidvtx8BFRa8cdhv17J2FrZ9PlA=; b=jC9CHrCFzmes/W/oDk+eTnZC2A
        pmGrniOMIYP6gqIXi3qbosIEW5geU3s8r8cQuQLK9Zr2/ibNDkpdhHQas5Mxqrvy+3tMvm2nCPZAt
        IPBSKzXFVu2HxN4VWN9m7+K8Db9yXBKvmHvBUgmul4hiEJZKqXHPj9TxT6rqhjIsITsg99SlR5QkS
        IRbDuQ/bazp9haxM8c21AJG9q5ZnKx1z6h/OdJQqkd9Qsicw0xTw/TMSV0rYuxrQRmKYmiSJVsY6a
        mUJwNNgP0IQjwe0Fmj5/zQ8pmEv6BwEPEuz0x5y4+Ov0SZqPFNm43jv0j6a87a/wuXFZATULDRGRc
        4LPWGMvw==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1gjKrA-00005M-Rc; Tue, 15 Jan 2019 10:18:01 +0100
MIME-Version: 1.0
Date:   Tue, 15 Jan 2019 09:17:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190115085743.GL3691@localhost>
References: <20190115085743.GL3691@localhost>
 <20190114194352.4579-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  > I think it's better to add the autopm call to gpio210x_gpio_get/set
    > only. This will allow for a simpler patch, and keeps the autopm handling
    > confined to the gpio paths. I'll submit a v2. >> @@ -1383,6 +1397,7 @@
   static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int >>
    value) >> } else { >> u16 wIndex = buf.state << 8 | buf.mask; >> >> + usb_autopm_get_interface(seri
    [...] 
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

> I think it's better to add the autopm call to gpio210x_gpio_get/set=0A>=
 only. This will allow for a simpler patch, and keeps the autopm handling=
=0A> confined to the gpio paths.=0A=0AI'll submit a v2.=0A=0A>> @@ -1383,=
6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned i=
nt gpio, int=0A>> value)=0A>> } else {=0A>> u16 wIndex =3D buf.state << 8=
 | buf.mask;=0A>> =0A>> + usb_autopm_get_interface(serial->interface);=0A=
> =0A> Also make sure to always check for errors from autopm_get().=0A=0A=
I checked everywhere else, the reason I didn't check here is on purpose b=
ased on your previous feedback. The caller function here doesn't have a r=
eturn value, so the only way to return errors is to log, but in my last p=
atch to ftdi_sio you made clear that errors from autopm_get shouldn't get=
 logged. Trying to call usb_control_msg() even though the device could no=
t wake does not cause issues, and the return value from usb_control_msg()=
 clearly identifies the reason for failure (failure due to autosuspend), =
so error information is not lost either. So I thought not checking here h=
as no real disadvantage and I still stay conformant to your previous guid=
ance.
