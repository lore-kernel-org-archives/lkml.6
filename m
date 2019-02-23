Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6D2063F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AiFjUkpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBWBA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:00:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42317 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWBA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:00:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id j89so3270048edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 17:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nojqNrZXUGOyyE/lFMsZPEN30tK072Yv0XO4ukmaVng=;
        b=AiFjUkpYD8VXUTzmMzr+YGYR5Tfzyk9NGZUASBgdAg3jgrTZlAm2Pjd42jgkGOOPbU
         n0Q2CDOA7qFj0YduR4vckyPdJrOfJ7yMGO3Kt9aSo/mh3uOryyIif/Qp6A1bUQeXscSt
         BP/E5qUo3AVucwPOYl5EV3HWrQeLXCfJFB9Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nojqNrZXUGOyyE/lFMsZPEN30tK072Yv0XO4ukmaVng=;
        b=rPWyYvBPxOEKJzaKn4A0UF5sPeeakhJd+vZEZUi1ykgqlugLTRHjE5z1GPZATWsHJw
         kr7drQARQUxkf7UURLH5MVtFmqvXxczbxUhaHuBNWO19odIlrk941HcubP/W8OU3/Yeq
         KXPivXmkvr6STnU8Bw42gAGPIF1Qq5qMTeo11MZ4X0+HxnCxB6SzycoU4tWg/qcPSzbl
         sK6HJ5YGClNyDg5zcHQFs6CPCAXKwx+FD9zd03Eje7TVhtbGM0tt+vl/z7ypFKOGgNXR
         tcGVDGpWseCN77NOE5OcsdWUa1+uGD1GCoLk148+AMz9B3/EbgXWKBjfdiWRc0gWHmmt
         JYLA==
X-Gm-Message-State: AHQUAubVkXw75DS22r5ivOz4GRw8EULDBkuIP81RYfOymMrg7MsGzIuH
        4CSbFY7ERdMmML8mNROTqmWduxAhlGI=
X-Google-Smtp-Source: AHgI3IbSaVDuIUg7VpyIqASxA7bN/NS6bVPv9JSWiXXfatj1ApUxQ+Gz4BD+/LQ15prbusW3xVvYMg==
X-Received: by 2002:a17:906:32c9:: with SMTP id k9mr121091ejk.237.1550883653912;
        Fri, 22 Feb 2019 17:00:53 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id v11sm755444edy.49.2019.02.22.17.00.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 17:00:52 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id b20so3268869edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 17:00:52 -0800 (PST)
X-Received: by 2002:a50:ac55:: with SMTP id w21mr5376328edc.121.1550883652446;
 Fri, 22 Feb 2019 17:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20190222225545.78031-1-briannorris@chromium.org> <82b7d3bb2799468a715e280366401f732d83cfdf.camel@perches.com>
In-Reply-To: <82b7d3bb2799468a715e280366401f732d83cfdf.camel@perches.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Feb 2019 17:00:40 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOy64dLEOXwQZ9Mv9+gD7qecv5njTYAMmV49qonOaswNg@mail.gmail.com>
Message-ID: <CA+ASDXOy64dLEOXwQZ9Mv9+gD7qecv5njTYAMmV49qonOaswNg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: don't complain about "undocumented" USB VID
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 4:52 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-02-22 at 14:55 -0800, Brian Norris wrote:
> > Documentation/devicetree/bindings/usb/usb-device.txt describes the
> > 'usbVID,...' compatible format, where VID is hexadecimal, with leading
> > zeroes suppressed. Allow it here without complaining.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3012,6 +3012,8 @@ sub process {
> >                               }
> >
> >                               next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
> > +                             # USB VIDs don't need special vendor prefix documentation.
> > +                             next if $compat =~ /^usb[1-9a-f][0-9a-f]{0,3},/;
>
> Maybe check the PID too?
>
>                                 next if $compat =~ /^usb[1-9a-f][0-9a-f]{0,3},[1-9a-f][0-9a-f]{0,3}\b/;

Ah, good point. I shouldn't be allowing, e.g.,
"usb123,something-that's-not-a-PID".

> Maybe add a test for uses of the leading 0?

I suppose that'd be good too. Would help catch problems with the PID,
at least. (VID problems would fall into the "invalid vendor prefix"
check that's already present.)

Thanks,
Brian
