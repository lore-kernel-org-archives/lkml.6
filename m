Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB1C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C22206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="da0gHnAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfAHK50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:57:26 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41121 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfAHK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:57:26 -0500
Received: by mail-oi1-f171.google.com with SMTP id j21so2937966oii.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xWpzVdg/e6UzVOjrd4RtIckInPRkRyaSSS21wxmlbwE=;
        b=da0gHnAe+uyOwsRktXvfE71bVxMFbgEknQBo2D2+GGapQ6j6CWkaA9mrLq/9UeWD5N
         2817lc9ysrpAgHmY1vTrhVh5C125a4jSO0tPE/JdUcLLWYLzV4IFB3R1p45DLDlHdk/1
         RbMVB1lmLbn0er0GvmSOinw6IQI3E6LGjvXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xWpzVdg/e6UzVOjrd4RtIckInPRkRyaSSS21wxmlbwE=;
        b=do4OWPmdmM+2YoWTif+Amvoo6wNxh+an39asIy0EGpvkNhxQryD6X72anVj7sw3hTr
         HqQX+l5geXF22a5o2oWbasd1M0esP9gZvqMVpioUpGq5HdKHInlBeUeiQOMi276sHTVh
         vrP09YGV9N+emUEgCvVK+Ms3l5NEBEWMS0w2DWwUcTOMTyT2l6J7sEKy4Vh5a+Cjj9oQ
         /GA8twG+DXMi4sGxDibcWZNUolS31bs2vIpgIKmNRqmUCJCUgMu9QA9wf9uQJkV4XMf5
         rlBz62EiOKWdffyrKXniJOYemHhE4oovjia8Q+7hRcFu6CVeYzabIoki5v2wwfda9Tyo
         zUwA==
X-Gm-Message-State: AJcUukeSnV9QAgjkNozrL186WX0WG9aP5drqKoJpTJhtma5V4ITaS554
        9b0rBFgJCjXtXga3JD0/FYUWRwbWBsDI4WlErnLfWw==
X-Google-Smtp-Source: ALg8bN785s8id1Mhe/zipIcUqyQef83MGcXhYd7OHCu7MT/49DFLViIwU3g2vSL/Z1k2XsLyvWZ9lDPZruQWGHRhtCc=
X-Received: by 2002:aca:f103:: with SMTP id p3mr805419oih.94.1546945044745;
 Tue, 08 Jan 2019 02:57:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
 <20190108004632.GA3247@icarus>
In-Reply-To: <20190108004632.GA3247@icarus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 8 Jan 2019 11:57:13 +0100
Message-ID: <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
Subject: Re: New IIO/counter driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 8 janv. 2019 =C3=A0 01:46, William Breathitt Gray
<vilhelm.gray@gmail.com> a =C3=A9crit :
>
> On Mon, Jan 07, 2019 at 02:45:37PM +0100, Patrick Havelange wrote:
> > Hello,
> >
> > I'm in the process of adding a new IIO/counter driver, however I also s=
aw
> > that there was a work in progress to have a separate counter subsystem =
(
> > https://marc.info/?l=3Dlinux-iio&m=3D153974167727206 ). But it seems th=
ere is
> > no recent progress on it.
> > What is the state of those patches ? Is it still interesting to develop=
 the
> > driver as an IIO/counter , or should I use already that new subsystem ?
> >
> > Best Regards,
> >
> > Patrick Havelange.
>
> Hello,
>
> I am still open to merging this patchset and maintaining the Counter
> subsystem. However, I took the lack of response for my latest
> submission to indicate a loss of interest in this patchset's approach.
> If there are still people who want this, I can rebase and resend this
> patchset for submission; the past few versions have primarily been code
> clarity and documentation changes so I believe the core design itself is
> somewhat stable now.
>
> Just let me know how best to proceed and I shall be happy to oblige --
> whether to continue maintaining this patchset or to drop this design in
> favor of improving the existing IIO Counter code in the kernel.
>
> I'll CC those from the patchset submission to keep them in the loop.

I confirm that I still interested to get those patches merged.

Regards,
Benjamin
>
> Sincerely,
>
> William Breathitt Gray
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
