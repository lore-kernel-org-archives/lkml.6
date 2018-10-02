Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EEDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B9D205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgN/+/04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B9D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJBRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:40:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33879 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeJBRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:40:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so1335516ljk.1;
        Tue, 02 Oct 2018 03:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AB0N5P4EIZa1N4v2qx84+2bTrFhdIGoEHMUbNXUC7Zw=;
        b=dgN/+/04pWf0cDYotQI7Xw5KRwgH4sINN/aT9FnFkpUqsfnp21FInzw6pwxcFO3va5
         P9PVXexMLd8/JJf0mxrz+fYfRUKfB21VWpxX6RQOTmU8S9cZnhg2LLz804YfQFJ2vGNV
         RuhPH2OQffXs9L5GMhJKAtabDZHWaBj/xSIIhvN8Q5k7dIKymPWYJAZ4agcs18F7fTuX
         HKzEvpMvLjYbcJ2d6Hd7agVCc7pam0Rj2aqkTAptxjIWaNcX4GreEtQMI3fIPX07qUwD
         0+EY9Fs/sj4XrZQcqXbO4MVG3rvir8IGZu5IqOOGeoxM+7FfbtAiG3pDBksRY+t+rBni
         rBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB0N5P4EIZa1N4v2qx84+2bTrFhdIGoEHMUbNXUC7Zw=;
        b=hZVEjyP1QV712/pB1MNbSAbhph8e/eVJ02/jbmHSy3mp9WcsEpixmcE0yMewGz53t7
         fLfessuQjHdZ4lInivvJ0mwR8u0XBAnbbTTPEFpiBMvDz0HOr0d5BUEaphQ9IEA8tS9F
         Po1mNwEjv4IOaNRiy9i+REvDE+IT2MkHdGRkktqfHf1EQ6kihOHikQGfje3nzbVXfVky
         SVK5ASnQddIW1cmN+0B+aMFhU3Ps23aDuGY/NXTpCTTATpuhzTvImgpQ4mWJ9ZWZM6gH
         UvAQ7e4tbkUvicxDH/pavRsmUBbahsvM1Dd4n9LFPLKl5RdHP3rjcUAMydpEAyviUsUP
         DWjw==
X-Gm-Message-State: ABuFfojB1iSPd8pnfeeMNLPUVsCgs6AEp3mlbbEDQdqH/TZeYqHJKrUC
        wz6+JvBw8o55ANX0Lsp6iC4LsskMWRqPvot+E24=
X-Google-Smtp-Source: ACcGV63advlHhxtDLp9MTKyTC3dzUJXUwlcmXUg0lNuF9M3+42xpq9VBpm6RK1iAfmXHW2nUZBrHsGUq4n5grx+hk+k=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr9011745lji.140.1538477859532;
 Tue, 02 Oct 2018 03:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
 <20181002073222.11368-2-ricardo.ribalda@gmail.com> <2128166.ZAkUExjJHM@avalon>
In-Reply-To: <2128166.ZAkUExjJHM@avalon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Tue, 2 Oct 2018 12:57:22 +0200
Message-ID: <CAPybu_1xmsuQVx94Lx+5UyX_+aerPdGVsgVkoNy=XkS98nmAmw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] [media] ad5820: DT new optional field enable-gpios
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent
On Tue, Oct 2, 2018 at 12:35 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tuesday, 2 October 2018 10:32:18 EEST Ricardo Ribalda Delgado wrote:
> > Document new enable-gpio field. It can be used to disable the part
> > without turning down its regulator.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> > 5940ca11c021..9ccd96d3d5f0 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > @@ -8,6 +8,12 @@ Required Properties:
> >
> >    - VANA-supply: supply of voltage for VANA pin
> >
> > +Optional properties:
> > +
> > +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity
> > of +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the
> > enable +GPIO deasserts the XSHUTDOWN signal and vice versa).
>
> After reading this one more time, I think the text is at the very least
> confusing. The logic level of the enable GPIO is the same as the logic level
> of the XSHUTDOWN pin. The latter being active low, asserting "enable" will
> deassert "shutdown", but talking about "desserting XSHUTDOWN" is confusing.
>

what about:

- enable-gpios : GPIO spec for the XSHUTDOWN pin. When the XSHUTDOWN pin
is asserted the device is enabled.

> > of +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the
> > enable +GPIO deasserts the XSHUTDOWN signal and vice versa).

> >  Example:
> >
> >         ad5820: coil@c {
> > @@ -15,5 +21,6 @@ Example:
> >                 reg = <0x0c>;
> >
> >                 VANA-supply = <&vaux4>;
> > +               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> >         };
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>


-- 
Ricardo Ribalda
