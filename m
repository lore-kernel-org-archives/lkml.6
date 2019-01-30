Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ABDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564412175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spcdmv2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfA3CfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:35:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42155 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfA3CfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:35:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so9657562pga.9;
        Tue, 29 Jan 2019 18:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkj4FDWIV5lIKpY0+itOe11Q3GZ3pjdq8PP46ONWA6Q=;
        b=spcdmv2PPRm7uC4FA0Ftq9G7GwDBQutgce949h9wvbivjdDtdgxS9fy9WMlfyWaJFc
         yFx4u5q6MFilsFz3zjWk0d6XdbOoh3Ux5eT2EwnhUu77Y/b8lBlrYX4rKqN0sOqgRxTj
         TQc4gk6wass1x/g/75aSYvKzJIbl8B2p5LuNZ/8fjO5gnlM0LuLDUs7reY+O2bwH1DaH
         apAOfgDgqi3gtHxlMlRZKEaWG+3dXeEHzeiwZecjSaZ3QadkLXnrUW+Z6lzUIvi9kgxg
         6ISKO7MXJUUTn2zN6Ufhp4Lw0QMnpRAL7c83q2cYnuZTbidlz3MdXwGO+VSg3g5k5zWy
         IBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkj4FDWIV5lIKpY0+itOe11Q3GZ3pjdq8PP46ONWA6Q=;
        b=YhopgjA3tSfO7lMiZb/sZbsQM0UYyIYaMZNlOsW2hhyrHjUbEc5EKdb3KeQQj1WzJX
         LmZMVGPnqt472z1GkFjaYpGJoGh88PBuaYDmsxUUSvIItQ52NSUhMhOYAUn+dgB0X/SO
         PpavShgP28xE3F3X5txTBj5/m2B/Xjiy9C6DJbbZvzpGGwyljTzuTA9jbcYsG8JIifRh
         RrzkCMxNEulvqmeD8uFKrFySl6p2raRvGyKQnDzzib62tmzpaDiMoYTDZiVno0r5irQq
         tS7DfseM4/A+lDdI6+tnulC4FqfcGxayj8TwnE/SzOE62u/6JRUHnWUW6jJPT5TRA8Mt
         H+sQ==
X-Gm-Message-State: AJcUukePvMxBNrFMlkzB0pKA2Swge4F9sMD9+pHYM3adXE72V40XnjG/
        6+qXjpSdn47+nGQZD0ZKJfhYxTQrCA4+TNjeXxI=
X-Google-Smtp-Source: ALg8bN7pDGTqgj1Smn8uYdkTcB/n/leD0v3EYTH+XmHVDJTk4W/MKws2cidEEmSoxnrWX5Yx+PxDE42ows7AeB3qT3Y=
X-Received: by 2002:a62:43c1:: with SMTP id l62mr29239497pfi.22.1548815708365;
 Tue, 29 Jan 2019 18:35:08 -0800 (PST)
MIME-Version: 1.0
References: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com> <CAFqt6zaHuWfVWS1Aa4MQm-qE9Wjj68Bq5ioEWbk+hrg32VNRCw@mail.gmail.com>
In-Reply-To: <CAFqt6zaHuWfVWS1Aa4MQm-qE9Wjj68Bq5ioEWbk+hrg32VNRCw@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 30 Jan 2019 08:04:56 +0530
Message-ID: <CAJr6mf1j+nyYDanjX7pCvSjVjdqy9Y0WG5sJHtR42_E6U9_LbA@mail.gmail.com>
Subject: Re: [PATCH] sh: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Jan 17, 2019 at 9:57 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/irq.h which is included more than once.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?
> > ---
> >  arch/sh/boards/mach-dreamcast/irq.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> > index 2789647..69fa91c 100644
> > --- a/arch/sh/boards/mach-dreamcast/irq.c
> > +++ b/arch/sh/boards/mach-dreamcast/irq.c
> > @@ -10,7 +10,6 @@
> >   */
> >  #include <linux/irq.h>
> >  #include <linux/io.h>
> > -#include <linux/irq.h>
> >  #include <linux/export.h>
> >  #include <linux/err.h>
> >  #include <mach/sysasic.h>
> > --
> > 2.7.4
> >
