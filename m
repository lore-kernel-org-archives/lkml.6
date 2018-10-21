Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6667ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 04:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814EC205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 04:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5mXPkeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814EC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJUM3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 08:29:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42852 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeJUM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 08:29:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so34021894lje.9;
        Sat, 20 Oct 2018 21:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MNQfSkJBOmbT03Ak/vQRrAaCyw3Ier5klZZhm8tj9k=;
        b=J5mXPkeRqXBn5h6Ur59TpNPpn5YLfLNX+1MUVCdq4dKueBcmA5tOEsMdLQflFfYQNY
         iamg/9tp1BzwoA3Psxjzp2g6ybGCOEQBg+3haZiQADidpFr+lmSBB1S8SyEk9KzNStlR
         Nvkf05l5VL52/DHJDm2D0r71PO4+V5ADxe+VGP0htqV8c4+lv0qX69jRfinVyEM0MQp0
         3Ekf+zAsQ76/7MXsXAbTMp0La8ScNrYHfGsRA5CaV4QLEjboRwCtk05w+9tGURMxFJZL
         YeZ0PVEb4GWBcMEdOBDH+Vtaa2pr9CDEM+KKD++1fvL6h0JFRQ7o3HIV5UE5WsZ9k6yY
         e2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MNQfSkJBOmbT03Ak/vQRrAaCyw3Ier5klZZhm8tj9k=;
        b=eyyQ76M/y/LzjrRFJYScl7WjVn2vjU+Yy+sLMuxuIjKljZo+P+qde4xkzOMPhAHPgJ
         3afRVpMQHokhpQiy4pkXlv+0ijV4aciTyWauZpmCuv+82fjas90MCEKCK62vXBClBFNz
         /Zj4pz9ZoiT/Ly7bEvdeheNgBt3OH+TnVDbvMkU2oDWcC9yYmLITdAeQqucUdtkgObPf
         wHvD3UowLQlu5zZq5MJb0E616KZencsHib6mPcpFGbbYLYor0qCfcAPRrtt0LpXwskTR
         6G0WRYW03RauD+5LZwpmZ8pQDrOgcGAaypB/2NYoQlkKMJG8cVBArSVqY1cI0n8wsqnX
         MC0w==
X-Gm-Message-State: AGRZ1gLfGqBThen/cbcxHP6ITEGXsJ86Xy5H4YgFtqJW2QfhbUSdUCgt
        gSvHBUZPSD8roHdxh4vmmUdnwbwnjPjKyZF0Qus=
X-Google-Smtp-Source: AJdET5fhHrmlOd8ko604QVQfRRBHPabshg/FC2e0GQ/GxxMwq1DLXli7eydXlF2NRylgC1AKcs/ZE6BTN1MRHuReqxo=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr1969356ljd.94.1540095365480;
 Sat, 20 Oct 2018 21:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181017031241.669-1-kys@linuxonhyperv.com> <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com> <20181017050705.GE22447@kroah.com>
 <20181017062255.oiu44y4zuuwilan3@mwanda> <CANiq72kQwhOFC5=vaNZW9qpmohot3ATRJVnn95A8eJ2w2xCNMQ@mail.gmail.com>
 <20181020192207.a6mne4npklprlyym@mwanda>
In-Reply-To: <20181020192207.a6mne4npklprlyym@mwanda>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 21 Oct 2018 06:15:53 +0200
Message-ID: <CANiq72kX5yVC88W1Y8aTLvsZ4OS-bg9iLvuvo95dkocn2bCGeg@mail.gmail.com>
Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by
 incorrect clean-up
To:     Dan <dan.carpenter@oracle.com>
Cc:     olaf@aepfle.de, sthemmin@microsoft.com,
        Greg KH <gregkh@linuxfoundation.org>, jasowang@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable@vger.kernel.org, Michael.H.Kelley@microsoft.com,
        Robo Bot <apw@canonical.com>, devel@linuxdriverproject.org,
        vkuznets@redhat.com, haiyangz@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Sat, Oct 20, 2018 at 9:22 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sat, Oct 20, 2018 at 04:42:07PM +0200, Miguel Ojeda wrote:
> > Using an attribute is indeed better whenever possible. In C++17 it is
> > an standard attribute and there have been proposals to include some of
> > them for C as well since 2016 at least, e.g. the latest for
> > fallthrough at:
> >
> >   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf
> >
> > I have taken a quick look into supporting it (typing it here to save
> > it on the mailing list :-), and we have:
> >
> >   * gcc >= 7.1 supports -Wimplicit-fallthrough with
> > __attribute__((fallthrough)), the comment syntax and the C++
> > [[fallthrough]] syntax.
> >   * gcc < 7.1 complains about empty declarations (it does not know
> > about attributes for null statements) and also
> > -Wdeclaration-after-statement.
>
> I'm not sure I understand about empty decalarations.  The idea is that
> we would do:

That paragraph tried to explain that gcc < 7.1 did not know about
__attribute__((fallthrough)); i.e. that everything was introduced in
gcc 7.1.

Anyway, the conclusion was a neuron misfiring of mine -- in my mind I
was thinking clang supported the comment syntax (when I clearly wrote
that it didn't). Never mind --- thanks for pointing it out!

>
>         case 3:
>                 frob();
>                 __fall_through();
>         case 4:
>                 frob();
>
> #if GCC > 7.1
> #define __fall_through() __attribute__((fallthrough))
> #else
> #define __fall_through()
> #endif

Yes, of course, that is what we do for other attributes -- actually in
-next we have pending a better way for checking, using
__has_attribute:

  #if __has_attribute(fallthrough)
  #define __fallthrough __attribute__((fallthrough))
  #else
  #define __fallthrough
  #endif

>
> So long as GCC and static analysis tools understand about the attribute
> that's enought to catch the bugs. No one cares what clang and icc do.

Not so sure about that -- there are quite some people looking forward
to building Linux with clang, even if only to have another compiler to
check for warnings and to use the clang/llvm-related tools (and to
write new ones).

> We would just disable the fall through warnings on those until they are
> updated to support the fallthrough attribute.

You mean if they start supporting the warning but not the attribute? I
don't think that would be likely (i.e. if clang enables the warning on
C mode, they will have to introduce a way to suppress it; which should
be the attribute (at least), since they typically like to be
compatible with gcc and since they already support it in C++ >= 11),
but everything is possible.

>
> We wouldn't update all the fall through comments until later, but going
> forward people could use the __fall_through() macro if they want.

Agreed. I will introduce it in the compiler-attributes tree -- should
be there for -rc1 if no one complains. CC'ing all of you in the patch.

Cheers,
Miguel
