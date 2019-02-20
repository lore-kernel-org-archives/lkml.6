Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0876EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C412421773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="n8RKas0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfBTIPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:15:48 -0500
Received: from mout.web.de ([217.72.192.78]:35409 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfBTIPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550650519;
        bh=NXnQT6dkMMaFCgp+VnpGa0BxgTd4vfdDoOOtl3p0XFg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=n8RKas0JDEjyBeErnSsfPlv8vEc5PLALFuvAiP+jQNTRCxvlEI2CImh0P0sQ/6Q4F
         p8oA7rPY6LQ1Y4gbdKgK7N9T+iNhUzQ0GUKvJ87PuJHoF3QlPYylbe0gXtBerE5qNv
         fduzmghjiaXz5MlZZX9OersPZ/uj4Eza/s0TGeVw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from neuromancer.fritz.box ([2.203.163.97]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUFI-1gTrpv2NPE-00SimA; Wed, 20
 Feb 2019 09:15:19 +0100
Message-ID: <1550650517.5256.2.camel@web.de>
Subject: Re: [PATCH] HID: roccat: Mark expected switch fall-through
From:   Stefan Achatz <stefan_achatz@web.de>
To:     Jiri Kosina <jikos@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 09:15:17 +0100
In-Reply-To: <nycvar.YFH.7.76.1902191415550.11598@cbobk.fhfr.pm>
References: <20190211215334.GA6216@embeddedor>
         <nycvar.YFH.7.76.1902191415550.11598@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNJpr9O3sKn32RXS702IjzRqmPbE+EiXx/MuVcVrECIcwcLU7Gb
 77MqOPQ04oSWXuIoHv76IBeYR9zm8C73o/dFKrWHBhzmZ/9S8UCIXAwXmbg+7tWJLica1MS
 V53X01BuPNlUvf0wvFoqIC1XVnne8BGlwnVmAO5hCWHHGp7AdWZL3/FaoD4FmXkeKemIBtd
 gA6Qp/BWyJrJEbSvgTkjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzQDQukZKnY=:PBOl5Y8klrsL9Q3UgA/H+n
 DjOzDbmIgpATL6EdRrZaIh/jupKXWd7zGpLgRV+ec4cBHQ78kkK0yXjnrBAfY1WaCJUnDiLOX
 xAXGBB9leIH5L5rz+SAKNKX6vsm/v2fzkXXGQiv7auvBp56OuJYI5Dr8brH/mEuIXcUcBK0U5
 OYN0EN6uYOVsLTJ4QzkSHPTKDxk2eumP6zYJ/OfTsWLG0La/InAHzgiTLcT4edWuuLwrf4sat
 VqlhCCUA7dSlS90b8fyY/mg33RxDfGRtd+LXFALOJBBDb2AkpvUDajyqixyMhO7S0FKary9td
 NYcn1mOrWScephla/VyWSDljB0Soyu+fW4VsWALQbckad4rIa4HVM4HgAfPv1rGmiYtjE+2f3
 lhhmF7RcENqRDb3ovHC2Yh7Lj7kh2RW91rBkCRYsFYjXGoKxawQr8kFSX1WKsUkKOB1+fZYbp
 9oIQnEfShZhkw9D0rizC5nW8k15NiSOtKppbXacyA7djKtrVDvAXKTyodv5wva3dOTg1/lkj7
 IzwmmbWgD12GnzEJ3F+SU9lNjmhT/3/Br5IGkLapYEMtpzaBXZZDoFcDtUWw1wcuXnuk4FtXJ
 frVAeEz6LJP7i47KHAV5kFDu96dCW5+Tt0unNLzBhl3ggQgnYR5zJC0qZSfWvHHYgXUgIrM/0
 amv7xQQNUCKy9w8BwYyEroEa2JobYczwlMsrn+pC3i8pA9F/u+M6IcQfYMZtGvtv4sOn6DmFI
 ForOZv08iELPMH7B83aWs9raE8SJgw7tA+N6LgEFTyq+I9EOXVeU8ovJsHScybF8Sn/PLv/pR
 cj50iwS27NVtOYsyRScwOLyLlZEljXXVa96EhwmnAMAdEaPKiQgrVwtFBfEW21gJhh6qNPoXh
 Z+/K3+1ybLJhH064rElafpx+RlmGMdjbqjfe2jkE9ylviEOM6vW8psTFgDm9YoUKyiH/dSTfH
 UHEmkcupFIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 19.02.2019, 14:16 +0100 schrieb Jiri Kosina:
> On Mon, 11 Feb 2019, Gustavo A. R. Silva wrote:
>
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> >
> > This patch fixes the following warning:
> >
> > drivers/hid/hid-roccat-kone.c: In function
> > =E2=80=98kone_keep_values_up_to_date=E2=80=99:
> > drivers/hid/hid-roccat-kone.c:784:20: warning: this statement may
> > fall through [-Wimplicit-fallthrough=3D]
> >    kone->actual_dpi =3D kone->profiles[event->value - 1].
> >    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      startup_dpi;
> >      ~~~~~~~~~~~
> > drivers/hid/hid-roccat-kone.c:786:2: note: here
> >   case kone_mouse_event_osd_profile:
> >   ^~~~
> >
> > Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/hid/hid-roccat-kone.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-
> > roccat-kone.c
> > index bf4675a27396..c4dd6162c1d6 100644
> > --- a/drivers/hid/hid-roccat-kone.c
> > +++ b/drivers/hid/hid-roccat-kone.c
> > @@ -783,6 +783,7 @@ static void kone_keep_values_up_to_date(struct
> > kone_device *kone,
> >  	case kone_mouse_event_switch_profile:
> >  		kone->actual_dpi =3D kone->profiles[event->value -
> > 1].
> >  				startup_dpi;
> > +		/* fall through */
> >  	case kone_mouse_event_osd_profile:
> >  		kone->actual_profile =3D event->value;
> >  		break;
>
> Stefan, could you please confirm that this is intended behavior?
>
> Thanks,

I already confirmed this 7 months ago but as I see only in a reply to
you.
Yes, this patch is correct.
Stefan

