Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE66ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788542148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LU2bFkvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788542148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJRBkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:40:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43744 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeJRBkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:40:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so21744134oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu0t0XJeQphBUWCRVduJCR5CedGpkF1xif1rN8ADshk=;
        b=LU2bFkvLY4mXySZFcZ+kU8W2lhWWLtJj/S3256op0A4GHLThNfD7yCfKscbXgM72C6
         wqk2yG3eecm+yHwmC901IjM1Dm6pOru+ifNN6ow1A/uE8+Q+2MAZX8R2ih95nPXcYeuc
         9ScbQck+p06CoAgiW7dOkBHmGbupEnhR+i+rWUZsMES0A2OoJOktoKUM++wLDEBPOuaq
         HZoDaRBMSy8kHOn9wGGLd/pKJaMbCvg7sBV8KUT2YTomYjcR5l5YIiCjcCbFPpcSzFl4
         rw9Qh32osjUTEhZGhtKeHLyc2y/zAFH2TqPd98bD42boCYRlnDBdcWmEcvBgqG2uvTuq
         6a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu0t0XJeQphBUWCRVduJCR5CedGpkF1xif1rN8ADshk=;
        b=WCmLso5txugEeS8pVEwuTG4ExNtIPuKRIt+fs9Og1uHhOhP5DNDBEQrgG01FEj0V2n
         UGQxcRU+z6xImMX/PdGwiNwd4GKdZC8A+W8bHVinJ9EZBq8jxxROI/8Uc1iAg+KX79uF
         kjLm+6QJRfFYm79gIniib0eJmhetFMBtsYZD8U6GqRpL+TxYrXNfD6csCsbARyXtA9z1
         dNTGXcCRoB6fuxaRW/EU9XW8TUAYnIpdK6joJ+yO0QqJ+iyTs9KtT/b3TZXXzI7kX20G
         57ZqJOz8Q7mLQtEe7LTpjjO+V4Zs3sOxF+oRsGenAuGPf32E7WdDWfwuaWJnY0X5qy28
         tpww==
X-Gm-Message-State: ABuFfohzACjbfHzFhCghXs4D4vpMMdElS6g8ItOfkpypKJQ4hYeZdboU
        uHel7oJ4YnmfnV0zh4+XZaJoxP3yPH7O/7uv9w61Jg==
X-Google-Smtp-Source: ACcGV60KyLnTXcO54K8i+FVrVQ2yYWuMtWx/qGrao5sFqBY7CbaIvq8aTY/WiaVIPxVOflOGIweHjjNCctI5nFFhEOQ=
X-Received: by 2002:aca:a9c2:: with SMTP id s185-v6mr14837591oie.137.1539798208546;
 Wed, 17 Oct 2018 10:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com> <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
In-Reply-To: <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 10:43:17 -0700
Message-ID: <CAFd5g46WZ9A0bDf3G2jkuc=w-hkyk8cMdF=HWzdO8nxNuvjpWA@mail.gmail.com>
Subject: Re: [RFC v1 06/31] arch: um: enabled running kunit from User Mode Linux
To:     kieran.bingham@ideasonboard.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Tim.Bird@sony.com, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 8:29 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Brendan,
>
> I very excitedly jumped on these patches to try them out, as this is
> essentially something I was trying to do a few weeks back.
>
> On 17/10/18 00:50, Brendan Higgins wrote:
> > Makes minimum number of changes outside of the KUnit directories for
> > KUnit to build and run using UML.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Makefile             | 2 +-
> >  arch/um/Kconfig.rest | 3 +++
>
> But this file isn't present on v4.19-rc8
>
> It looks like the file is removed at f163977d21a2 ("um: cleanup Kconfig
> files")

Whoops.

>
> What version have you currently based these patches on?

This patch set is based on 4.18, but I have versions for 4.4, 4.9,
4.14, 4.16, and 4.17.

I will rebase this patch set to 4.19-rc8 and send it out shortly.

> Do you expect to keep a branch somewhere that's easy to pull in?

I have one here: https://kunit-review.googlesource.com/c/linux/+/1030
(you can check it out with git fetch
https://kunit.googlesource.com/linux refs/changes/30/1030/4 && git
checkout FETCH_HEAD)

>
> Please add me to the CC list as an interested party on later versions :-)

Will do.
