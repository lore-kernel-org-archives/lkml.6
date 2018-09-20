Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA3ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD26121523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjrte2Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD26121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeIUA6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:58:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40237 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUA6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:58:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so9415323ljc.7;
        Thu, 20 Sep 2018 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmU7478bXwYjEN1q+kpxKyblHgiBlaxkmj/9Njks/Fo=;
        b=Sjrte2Wptx6UPGVRb5nDGRUeKv7kWq9+boMzhFBP0Lo8Byxn0OUx6jhvd7QTMDn8Hq
         0bUXpuQNojmd6PHTLEPdTVtXunmFCCGBmIfueG4GXvs9rbCkDd5z7/jeYJEKMQbrZerU
         eGE4Q9wb5jWtXMvQ5GT9Rf89rprzsGAUSVeklUvOeXSu7nD007ObIOq4f+RYuKj8pNZS
         H29cNpRE0hnisxlqx6IcdSKhCQ//Xnu760sgUyTvtRcCQFISwGWvo1T5duofABWlnyRu
         z2gkZ16AZhMPWjDlMd6xW73ZnK7+5nAu5JTwHJvetS6xg0IhB7oqkK5XOyDRHLZAiGIG
         WEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmU7478bXwYjEN1q+kpxKyblHgiBlaxkmj/9Njks/Fo=;
        b=EKDybG0BssjniBK61vbsFgtDE0Jy2geyRmaMa6EHvn628WWTAlgss6TzbgYbOzkLVp
         gBqj1Af4s9BlknXwOmPBGJHXdy+deCjSLOr09Hux+k/IBh1VtXsksYS0/pIORIQ3xOE5
         w3oxKOG/Rw5c0TkM3sskS23Pz7T4LTX0jXQN+xx3nyBTezV7cHdwhAoad+PpMTJyIdB+
         fPDME+DGIKdpKDeQcl0H+axQ/li8xr3AYYb4iIo5UaXAv54xylzvqsQu3aIxdHNsEsUE
         BZHVWThUJBh8zcAQGkMbyDBXedebFlV1LrAi2F7m9OHlgquXOH52jZ51kgFYxlPLIHGk
         RXlQ==
X-Gm-Message-State: APzg51DeYzuSw6nfwBJCX9CoSTnIeNiI23JsrAa2Nfwl5nV/zw1mNik1
        i1L9BmmcdRShJvH+eVAqo8BSLPdREc2h+l2X/sE=
X-Google-Smtp-Source: ANB0VdbF/+UJGY1nGLWgGJw/Q9jHQSz51piERE4DsplPSpxggYXbh31h0kV1lgddMmTC8JxN1YJQRwov76GvHR0RdXQ=
X-Received: by 2002:a2e:680a:: with SMTP id c10-v6mr27658698lja.59.1537470780574;
 Thu, 20 Sep 2018 12:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
 <20180920184552.4919-1-ricardo.ribalda@gmail.com> <20180920185405.GA26589@amd>
 <CAPybu_2hjrq=r+kpAHKxX59gOXfbqGf9CUPh9CNqv7WGqJsrQQ@mail.gmail.com> <20180920190855.GC26589@amd>
In-Reply-To: <20180920190855.GC26589@amd>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 21:12:44 +0200
Message-ID: <CAPybu_2mNE7Jmfm2n60Z9Hk_iO+-zLgtu4xn72pJUSXBitVg=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] [media] ad5820: Add support for enable pin
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:08 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2018-09-20 21:06:16, Ricardo Ribalda Delgado wrote:
> > Hi Pavel
> >
> > On Thu, Sep 20, 2018 at 8:54 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Thu 2018-09-20 20:45:52, Ricardo Ribalda Delgado wrote:
> > > > This patch adds support for a programmable enable pin. It can be used in
> > > > situations where the ANA-vcc is not configurable (dummy-regulator), or
> > > > just to have a more fine control of the power saving.
> > > >
> > > > The use of the enable pin is optional.
> > > >
> > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > >
> > > Do we really want to do that?
> > >
> > > Would it make more sense to add gpio-regulator and connect ad5820 to
> > > it in such case?
> > >
> >
> > My board (based on db820c)  has both:
> >
> > ad5820: dac@0c {
> >    compatible = "adi,ad5820";
> >    reg = <0x0c>;
> >
> >    VANA-supply = <&pm8994_l23>;
> >    enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> > };
>
> Well, I'm sure you could have gpio-based regulator powered from
> pm8994_l23, and outputting to ad5820.
>
> Does ad5820 chip have a gpio input for enable?

xshutdown pin:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf

(AD5820,AD5821, and AD5823 are compatibles, or at least that is waht
the module manufacturer says :)


>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



--
Ricardo Ribalda
