Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ACDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25132175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livid.pp.ru header.i=@livid.pp.ru header.b="eKKRgjz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfBFMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:01:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43209 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbfBFMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:01:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id z18so4028898qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 04:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=livid.pp.ru; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9JLYkj5kAyNqDP+ARJLiQQxjhGYLveQYTvF/T/df6E=;
        b=eKKRgjz85oiKJgKT65Mg7caHhbbsfsPOwVU6pZGIwpOci7S3xmRzc2mzb6mFd4Wlq5
         xKidPh2DfHTXgGjj+3IgWuxZbiDu/wUVuVSrQNbNUf5iRe2rRPCz6cCsLWN4G9AT2cK6
         RHP2FL+qvUezLcyav2PUHUzQrjRwrhVPGFJUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9JLYkj5kAyNqDP+ARJLiQQxjhGYLveQYTvF/T/df6E=;
        b=hD89ibCiIXkkrHvLn5chPsL8UcQjAdlR1/GAKG3bxXzjdaZ7Vc0A333tLnRtUrq7iM
         eFM8qPFwTA2a18Sy78u8Y0PiGLdjK2o7JgwgYJ9iI8SNlNrn9p4tqd+r4YRyb5Cg0S7y
         E5LX2CGX5nnhD+d5yt79e4j0pW53wXlocVZhLDXKpkl0cp6AJN/IjTFWWSHu0lMOsPJR
         ixWpA/qC0a2I0LwSLrxxhK9kEf9ddfJovMBo902VH0k9F3uM4kFFcgoeLxMQ77iEm81b
         GAw7DWGfv+gc8XclRi5c9heGkwaAbjm3OaTtrQ1uNRuwW/oEKrVZN7VxZAWY8W6spqq1
         vnOg==
X-Gm-Message-State: AHQUAuYaQbRVp9biX3gxdj/GL+9+KslAT106jxI0ccegdeoblbdFNoOM
        IxnR33Po33oD0gaMTuIFbhx5QwlxqO/7yYpjAbO8cg==
X-Google-Smtp-Source: AHgI3Ia/Dp1hjkYVp8LAxQlRv6t0FaEvbrIcRepJ7OO6tHEpL4puEwI8EFidQt8wzytg3PfU+6Gjz706t27cew/qeh0=
X-Received: by 2002:a37:9906:: with SMTP id b6mr7157554qke.208.1549454516519;
 Wed, 06 Feb 2019 04:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20190115161354.6806-1-root@livid.pp.ru> <C672AA6DAAC36042A98BAD0B0B25BDA94CB280EC@BGSMSX104.gar.corp.intel.com>
 <CA+A=rXGckxCsEPAG_DczMgLwS2+K3SXFUnHnXQrOOr+9WOWj9w@mail.gmail.com> <C672AA6DAAC36042A98BAD0B0B25BDA94CB2885A@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <C672AA6DAAC36042A98BAD0B0B25BDA94CB2885A@BGSMSX104.gar.corp.intel.com>
From:   Nikolay Yakimov <root@livid.pp.ru>
Date:   Wed, 6 Feb 2019 15:01:45 +0300
Message-ID: <CA+A=rXE_4q1ioEFTD2iXcS3PLvErXVepZ+uQgj9UW6vKfozxqw@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix configuration selection issues introduced in v4.20.0
To:     "Gopal, Saranya" <saranya.gopal@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there.

Sorry to nag, but it seems we came to the conclusion that there's
indeed a problem with the current code, and then collectively decided
that we're done. Can I do something to expedite this? Are there any
issues with my proposed patch? If there are, what can I do to fix
those? Alternatively, perhaps it would be easier/faster if a bona fide
kernel developer could fix problems described in this thread (well,
actually, I believe we're down to one somewhat pressing problem, which
could be fixed just by moving some code around)


On Thu, 17 Jan 2019 at 06:53, Gopal, Saranya <saranya.gopal@intel.com> wrote:
>
> > The result is this:
> > Before f13912d3f014a, if an RNDIS device has non-vendor-specific
> > configurations after the first one, that one would be selected.
> > After ff2a8c532c14, the first configuration would always be selected
> > for RNDIS devices. Besides, there are several redundant checks in this
> > case, which is, if nothing else, confusing.
> >
> > Hopefully I've explained my point clearly enough.
>
> Agreed. Thanks for pointing it out. I somehow missed this :(
>
> Thanks,
> Saranya
