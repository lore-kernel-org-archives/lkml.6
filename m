Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362BD2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ps+Rbzuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362BD2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeHNGdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:33:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37892 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbeHNGdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:33:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id a4-v6so12754427lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 20:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3z96xJatzBoJwONfdtNQgm90qovpwIM2BJ3FzfFuT8=;
        b=ps+RbzuhG60PVMs/YtO0hzHsOXD2si9Z5D2UJHlqsQmw5aMkxZ4fSsU6cJXS29e4NJ
         viDIK984lnXpfrqRDIXBos3Qil3lEWCiYvJhZQuXaE6tH/vNDp2y1trKNPqxzDUUUkHO
         VTzG4xuwjYNY+oZ2h1gLS0jMgQzQam3BQcrc07m0xU7KVFH49xqgdpxjKl7cvPl5NF/g
         GsYO88mGvyuVvSkY9Mygo/CIgKCZYqxQrx1iAg01ahdGInT55SsqFob3dutaP9abbUBX
         OvJj6RIXmIHhpFFGpNMTRbsILp0Wib0TYmMbPP9nHztUcGeqq7y8kKRpMzOtvpv2jkKd
         SEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3z96xJatzBoJwONfdtNQgm90qovpwIM2BJ3FzfFuT8=;
        b=cktJDfZY88x0w/Xc1ccnDO5elZvnx2VzW9nzyAyLXgOpVto0Bp9ZoE123dndd75CMg
         9a16VgYXhx7JkoxkPhWPsP3t3lA6mupJ2NdAIwwySSMDbGz0gBgo4qAQ4ThtqzJyZHqH
         0xgJqBVC4RF4atiZ+4mxc2344RbpLJpWNCIUZhzstvR+kawkRzVOiiOxtjMp4QxRYeSE
         wtSPcrgDcA3fepaatYuc2o4e9w/Mxme5ETm+5PjOthb77EOdtWwg4Z50jNaXaJ2vNICU
         gqz4Sn1r7LpSUotP7CBIL/nppjpknQ6AguIJ+EMxiagH0JoTISAB4AAe2CCzMlr0LDvW
         WwwA==
X-Gm-Message-State: AOUpUlEXJBLY3EeIACtJe/i/CflYzumxpW6HMkMD3UAMuiqHsr+Np9wD
        1WtEof6zWa8IrlIWl1zA7Wi6MwYWdCRxeOb3J2Drfw==
X-Google-Smtp-Source: AA+uWPxaA7Ss2rY+6L32myYOkmmaXXlf+QMcX3we0WXJGUfY+KF90WmzhA2vOWMiVEBkhD0TGur4P/zWPBvbVhS6iFg=
X-Received: by 2002:a19:8f8f:: with SMTP id s15-v6mr12209487lfk.96.1534218486239;
 Mon, 13 Aug 2018 20:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com> <20180813233839.190855-6-rkir@google.com>
 <a7a81091a1856bcd2ec7dd6a17270dd999058475.camel@perches.com>
In-Reply-To: <a7a81091a1856bcd2ec7dd6a17270dd999058475.camel@perches.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 13 Aug 2018 20:47:54 -0700
Message-ID: <CAOGAQerZ9D2gs+dmv5VKH_0GZQvnGY=juQLQa3qQ-cEm4qn1tQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] platform: goldfish: pipe: Fail compilation if structs
 are too large
To:     joe@perches.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for reviewing my patches. I decided to put BUILD_BUG_ON
close to places where it is important that these structs fit into a
memory page to give some context.

Regards,
Roman.
On Mon, Aug 13, 2018 at 6:48 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-08-13 at 16:38 -0700, rkir@google.com wrote:
> > From: Roman Kiryanov <rkir@google.com>
> >
> > Since the driver provides no workaround prevent in cases if structs do
> > no fit into a memory page, it is better to fail complation to find about
> > the issue earlt instead of returning errors at runtime.
>
> Minor earlt/early typo
>
> > diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> []
> > @@ -797,9 +798,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
> >        * needs to be contained in a single physical page. The easiest choice
> >        * is to just allocate a page and place the buffers in it.
> >        */
> > -     if (WARN_ON(sizeof(*dev->buffers) > PAGE_SIZE))
> > -             return -ENOMEM;
> > -
> > +     BUILD_BUG_ON(sizeof(*dev->buffers) > PAGE_SIZE);
> >       page = (char *)__get_free_page(GFP_KERNEL);
> >       if (!page) {
> >               kfree(dev->pipes);
> > @@ -842,8 +841,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
> >       struct resource *r;
> >       struct goldfish_pipe_dev *dev = pipe_dev;
> >
> > -     if (WARN_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE))
> > -             return -ENOMEM;
> > +     BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
> >
> >       /* not thread safe, but this should not happen */
> >       WARN_ON(dev->base != NULL);
>
> Why separate these BUILD_BUG_ONs into 2 different functions?
>
> Why not just
>         BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
>         BUILD_BUG_ON(sizeof(struct goldfish_pipe_dev_buffers) > PAGE_SIZE);
>
