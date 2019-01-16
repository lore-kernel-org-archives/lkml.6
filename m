Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705F3206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oSSqC/YF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfAPTwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:52:14 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42863 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfAPTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:52:13 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so4697787vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0opV3Y2wiIVBThPYKggJycuAfqtYtufOBgcluFNRZs=;
        b=oSSqC/YF4vwIKZlk0yBv+mMI84xqkr4GAtagv9UetDhzZWO4Mge1ZwA4n+iWIG4JDN
         uu4IPwRxy8mZhqgRzlo9lmq7+8aJU0M/9DoIyah4puESMRROkgUDAzwWHL2Ls0MbclJC
         BwH2ceY+Hkb8p7zSKszGjOiCDT7bW5v1tcLvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0opV3Y2wiIVBThPYKggJycuAfqtYtufOBgcluFNRZs=;
        b=lmVBYCm98pZQVySz1ZFpW09HNqaYHiJOqrs0GKsuk5WzHpMk94Amco208lW+f26koz
         KOD7AOo6m7wFhaO43+NJb+YD+Nz3irszOI79VBhfwA2Xgh6BdmionZCciNTCEf/MDMhN
         BWM7t1hD97hdER0lf7lFbGjINKwjE0c9RRfygvxC79aN0RBz4KnSy0PtYBmlIj6DOtDn
         3X1VeklUnODEv4v/OG/2zNMh+kvsNOYgEezFTX2jhqCvmHGGnXXgIaQBmB/z4WBavcnQ
         0zZW+7Bwqp3A3uPaJzZE/Xzg+cJMcIuCSNf8z92xK07+aGoMYS9CJt3fQzNy3TTN7v7K
         owxg==
X-Gm-Message-State: AJcUukfpqJQpauZ7Ujvxhnq0VBLUVVDKHt4MdZEfKw1hhJI2Xadg7yAW
        Tr7dDWsePcbxIwrM5jBw6rRp9wg3Sso=
X-Google-Smtp-Source: ALg8bN6SWDCwCbYhNWM1FA9Zy40D7WYyreLxd2f/jJEyA0g3qbYaOXCS898TQ+68tpjwHUcJ2/7dLg==
X-Received: by 2002:a67:485:: with SMTP id 127mr4596623vse.54.1547668332008;
        Wed, 16 Jan 2019 11:52:12 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id m89sm3620842vsh.22.2019.01.16.11.52.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 11:52:10 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id d201so1728023vka.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:52:10 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr4134454vkh.92.1547668329785;
 Wed, 16 Jan 2019 11:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-6-w@1wt.eu>
 <CAGXu5j+LvQsLSO+TtVr5hrUTYHA0Hqrc=pxPMv++erySJ8pV7g@mail.gmail.com> <ce0fca46-ff5e-beb3-5318-3a7c1e6da0e8@linux.intel.com>
In-Reply-To: <ce0fca46-ff5e-beb3-5318-3a7c1e6da0e8@linux.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 16 Jan 2019 11:51:58 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK90twOG1=iO7_YQVMhFqDYQZ90CSWX=fkKWR56h6Y4Cw@mail.gmail.com>
Message-ID: <CAGXu5jK90twOG1=iO7_YQVMhFqDYQZ90CSWX=fkKWR56h6Y4Cw@mail.gmail.com>
Subject: Re: [PATCH 6/8] ASoC: intel: skylake: change snprintf to scnprintf
 for possible overflow
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Willy Tarreau <w@1wt.eu>, Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:35 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
> >> index 5d7ac2ee7a3c..bb28db734fb7 100644
> >> --- a/sound/soc/intel/skylake/skl-debug.c
> >> +++ b/sound/soc/intel/skylake/skl-debug.c
> >> @@ -43,7 +43,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
> >>          ssize_t ret = 0;
> >>
> >>          for (i = 0; i < max_pin; i++)
> >> -               ret += snprintf(buf + size, MOD_BUF - size,
> >> +               ret += scnprintf(buf + size, MOD_BUF - size,
> >>                                  "%s %d\n\tModule %d\n\tInstance %d\n\t"
> >>                                  "In-used %s\n\tType %s\n"
> >>                                  "\tState %d\n\tIndex %d\n",
> >>
> > While working on a Coccinelle script to find more cases of this, I
> > noticed that this code is buggy: it keeps overwriting the same
> > position in the buf string: "buf + size" and don't take "ret" into
> > account at all. This needs to be:
> >
> > ret += scnprintf(buf + size + ret, MOD_BUF - size - ret,
>
> Thanks for the sighting. Indeed this looks like a bug, all other calls
> to snprintf use "ret" to modify the destination/length.
>
> The only explanation I have for it not being noticed earlier is that
> it's possibly not used - a 5mn test on 2 machines show the loop is
> actually not run (max_pin == 0).
>
> It'll take me a bit of time to figure out what exactly this routine is
> supposed to do, maybe we should do the cross-tree change first?

Sounds good to me. These patches are direct at maintainers, so please
apply at will. :)

Thanks!

-- 
Kees Cook
