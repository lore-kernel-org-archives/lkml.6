Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89517218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO83QJ2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfADVXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:23:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36378 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfADVXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:23:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so33242243otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UReQFNEERMBJ0OWfEaIz0ms+GAa38JxGmsKI116KA8E=;
        b=lO83QJ2WZxbuIWOqrdp121xCLOe5+UHspFtSOuMlaTL1y6Po3sAqe8JxhYvoBoVNbF
         GQoLqqPGRfmWxrXXv0bvH4MCGmY5mX8zwwDnAlHMmb3dhZw6oC0FT4bluVN/+olkx4Tq
         zZcC7eSFgJUAxhIK4R70wkPoP2R+vKqm/b9bd5aTXWoBulnXcbSPUJWybDtXiJn2i4qw
         MydBY/0q6swrOn3D7spGaelg69u/sg5dEteJX5XkcF45QjwttdYHALeT+6hpoHQ3VE1h
         6M5nJtcXjyGr7xrtZi4fKyBROHBfNYP9VESwY9+7LBkpslWUxYzvHlCmGhnWXDM49aXS
         HCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UReQFNEERMBJ0OWfEaIz0ms+GAa38JxGmsKI116KA8E=;
        b=e5Y70+pt+im9o4qcQJvnPSABMUOZHLrWzezTSefiQJ5pphBZ8I3NKuPsuSDJXs2wla
         tQ/b4SJ8jRcFoyVTXLp7gVgcCr42bFOCAZskU36K8uwehto2X2KUg1a+uscypWrkjIlN
         VLQKkM3BsWORfOT/zIOn7msBq4Hqth8OEvbsrLT114OJyDNzC/pNpTo7arwL+cf2gRRm
         fSSTCWoRJaKmOmlJ+kH7Y/Q0sDUiGAXtpFFfKh8Ivev6dQyEY0X+MiVuLu6yojUXCCmo
         a3vEpp3S38lnt2G+dc8/Dk1U9ePoCj+E3P9vTQQm45BLH2MxBbajLi/UNUa7Qr3y07Ds
         r3DA==
X-Gm-Message-State: AJcUukfK0qud4D3A+5FP7m6qDKJuZacXwywgHbFKlkx9/4xygL5Ctp2F
        dvNMYBOnQShXLV3J29WKjwgkbKJX3NmiM8foTpw=
X-Google-Smtp-Source: ALg8bN6nBdOo9ZFjdIm2bcOhw6YYz4ca9kItBs//qlKDK7Oms+2GUQg8RR/alKyEdD1pCX8RQjGxtUxq9px+i8EOF8k=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr35899146otl.12.1546637034830;
 Fri, 04 Jan 2019 13:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20181221094553.13137-1-muvarov@gmail.com> <BL0PR11MB33295D7A045B9EDE271DA8B19F8D0@BL0PR11MB3329.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB33295D7A045B9EDE271DA8B19F8D0@BL0PR11MB3329.namprd11.prod.outlook.com>
From:   Maxim Uvarov <muvarov@gmail.com>
Date:   Sat, 5 Jan 2019 00:23:43 +0300
Message-ID: <CAJGZr0KJh9DU+8VOodx7mcjt0jeAZhRZZz5gj+q7mTukSmGHhw@mail.gmail.com>
Subject: Re: [PATCH] usbnet: smsc95xx: allow to down ethernet link
To:     RaghuramChary.Jallipalli@microchip.com
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        UNGLinuxDriver@microchip.com,
        Steve Glendinning <steve.glendinning@shawell.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 3 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 16:19, <RaghuramCha=
ry.Jallipalli@microchip.com>:
>
> > allow ifconfig ethX to down ethernet link. Ethernet part of chip is swi=
tched to
> > power down more and on ifconfig up driver does soft reset and restores =
it's
> > state.
> >
> Thanks for the patch.
> If I understand the issue correctly, the ethernet link is not going down =
in power down mode? Pls clarify.

Issue was that if you down interface with ifconfig eth dow, then
ethtool showed that interface is down. But actually pairing ethernet
link is still up.
Later if ifconfig eth up is called then soft reset is called and
pairing ethernet link when down and up. So to down ethernet link I
just followed spec
a) disable autoneg b) enable powerdown bit.

> Does these changes be applied to smsc75xx driver as well??
>
Might be if they have the same sequence for powerdown ethernet part.

Best regards,
Max.


> Thanks,
> -Raghu
>
>
