Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1944821902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISrD8kek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfBSLGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:06:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44092 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBSLG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:06:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so269567pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPETnU+mWBKOD5sx7k+2RWTN0s+o3IDgyt+zCQDa7lA=;
        b=ISrD8kekBFHx72RhdohRPqXd8xe3dxS/DjvqpTDTzUSSobCBqQ/AFbdfiNLIw/bs/D
         b4U5zp8uyFV2o3YdaVAHzQPo6dBBRiA1aRCI5cCtd8QflTQEz+uIzY2Y3VB1y+RbSWOt
         +zjLNS30xsP1W4Omv2WRwLCBMhBFOKozqrqFDqS769/Yu2ll99DvysXbQVQB9CH204yb
         ujbP5M++JIqU7MKXLKmUqC8+Zp3/Gtt1lUgSmNuclkfSNv+O0VTqxr1EslIKavks2xAI
         GF8vaEdzmNRgRsA6N+pOWVRJRjvFXl08PrilYEEPK/Brs9EhVzpGKpNW/a1QAXumsFUE
         kQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPETnU+mWBKOD5sx7k+2RWTN0s+o3IDgyt+zCQDa7lA=;
        b=g7YCRYjPhfoLn9pQu9hNoqypKFNW2z+4cKKLZ9GO6lyB2gcs2FXGJzs9aBfh1kup2W
         aVBY+apZKaFhbcw7BNBwVND61KnGilN3VRTFBZsvRBP6QfSLh2haYsJ3Y+FzJyBrhLdD
         Z28YbxYz7/XA3WfV9DnAxKeXFXGCsDklBzKhci4H6TOIPr8MpoSRHPaXKbDKHs0d2239
         IPhbrbJJfo+27nLMsnwXy9kfoBISyTfv4onYbFn8ci2v9agopUoKyPNytWJDZPtKEdj9
         vqco09r8OxrEVxOhz6FDJHuLOTBqma8YAaUTEWY3ZGfE6KPMSQE3lfejOqiKro+6IFeZ
         J+Pg==
X-Gm-Message-State: AHQUAuadXQuq1nKmzvNq7KIuQxz57ee5G5tam67clzYZV4gnNW5YbvMs
        4yFezYNFQ155tMFmCvZ84eMyYBwjvM/YjcjRe0k=
X-Google-Smtp-Source: AHgI3IYwfB42sKZHbGQWSRLrygo6cUuEJATwjd1f6lejILr05WJbvMb2HFNJnE6qQlswMBBdOqvGANaaxNYjfO4+ibg=
X-Received: by 2002:a63:f148:: with SMTP id o8mr23534628pgk.337.1550574389138;
 Tue, 19 Feb 2019 03:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20190208152310.29531-1-pmladek@suse.com> <20190208152310.29531-10-pmladek@suse.com>
 <20190219030300.GA640@jagdpanzerIV>
In-Reply-To: <20190219030300.GA640@jagdpanzerIV>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Feb 2019 13:06:17 +0200
Message-ID: <CAHp75Vckf_aJqpK75-7xmN-u3aVs8nUrAOWiRzSLP5Gh3uHUEQ@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address
 and value
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 5:07 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:

> Suppose, in my driver I want to sprintf() IPv4 address. The longest
> possible address is 3 * 4 (%d%d%d) + 3 bytes (dots) + terminating NULL.
> E.g. 111.111.111.111
>
> So I can allocate a 16-bytes buffer (stack or slab) and accidentally
> do an %piS sprintf() on a corrupted in_addr struct:
>
>                 char buf[16];
>                 sprintf(buf, "%piS", in_addr);
>
> forcing sprintf() to write "(invalid address)" to a 16-bytes buffer,
> but the thing is - strlen("(invalid address)") > 16.

It would print as many characters as buffer allows. In your case above
the use of sprintf() is a bit fragile.

But yes, the error messages should not be longer than 8 / 16 bytes
depending on 32- or 64-bit build we have.

-- 
With Best Regards,
Andy Shevchenko
