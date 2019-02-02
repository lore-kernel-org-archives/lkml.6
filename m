Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B84C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 20:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719462084C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 20:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IYQVwQ2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfBBUiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 15:38:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45396 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfBBUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 15:38:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so8600956oie.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AR5MVtgesJV+JXsUKdXq+iio6Xvx3b3brHzJ4mMWxYE=;
        b=IYQVwQ2pdoIJYUNh5bQA0rexBOFSW7tsKMThJ7LikyEHqOQUa2JsQrR0W7CEIx/+NR
         0995uvVYKQk1Oq0lEILh93492wpjRc3Vto+y6yz6qJ1NdE1RxLWmUA7GUQ6dfUtZrgNt
         3HZhK+jf8wevAP62a4SdNdJ3Wi/9VgUCTsneXQvxmN0JYVcAOSF2LivioOiy1hmjytjZ
         Bkn82PIStw8AyILQL6MhlVqtDjqwn65BHZmTnpkYgroTp67M9W4giM8SFuMLsQ/AkQcB
         7oQZmlOMe0qMEyjtrmKa8FbPCxpqDd8lmsIDXDe8NdFWGKa6ZVafmQgvlMSVYuL0Vrg7
         RPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AR5MVtgesJV+JXsUKdXq+iio6Xvx3b3brHzJ4mMWxYE=;
        b=GAk3kOWIMxB7vaPiJdB+RflDEGTTUG9xD1oWDWnT8DvLc4ru+0sHI/QjaSJkG59U5e
         BFBzwrvMXDgbVcOGQS7FIaTiQD+QPlOY0RT6igN6T7dqahs966aVtBLl2udVnvtkTbEr
         itCTNtahscELoljrO112nybfkeSvO8e+O5ihNDyScbDkhvFN9ufAG+VAe+yT3MCIRgC1
         6D7DYHoYKfV9RVhXDBItV/SXtUZXfGMm49AEJaaNKQ25mVRhtGhFEuP0tWxBKau2+JKz
         OkBHF5ZJJT3F0bq7XfKl+gnh9Cs/FbDwWih+Zsec4vwe2aUE/ns+G8HsNHIa2BHZR1Te
         Qj/w==
X-Gm-Message-State: AHQUAua8VhFkDf4aJVsIaZ59YLNQSsM0XlOFowQkpwQPle9MDrv/Tg/S
        cUQvknZnWcjbwYybGCj9UgMiZ5e1kS0jsE95ySDguQ7nbfY=
X-Google-Smtp-Source: AHgI3IYCVpQ2yWQxfSQR4s2Fl1JGWl9Wu/OKNlaRFsWzBOVbl1sP5hX/UiT6yHHz00FgSLaZ9DJoSodTvb7W9H9P7L4=
X-Received: by 2002:aca:5205:: with SMTP id g5mr3356769oib.149.1549139903679;
 Sat, 02 Feb 2019 12:38:23 -0800 (PST)
MIME-Version: 1.0
References: <f0086a11a40fb97503fb559b53dcc94c9f873e32.camel@intel.com> <CAHk-=wgXh57rgtmSEvbKd69QYtBTRzU3QH36rKcFGiETRj45Sg@mail.gmail.com>
In-Reply-To: <CAHk-=wgXh57rgtmSEvbKd69QYtBTRzU3QH36rKcFGiETRj45Sg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 2 Feb 2019 12:38:12 -0800
Message-ID: <CAPcyv4g2-DtUPE3MHKXgR9=Gbs9RoC=k2YY1-7wWukUHEZMGnA@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm fixes for v5.0-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 2, 2019 at 11:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jan 26, 2019 at 3:31 PM Williams, Dan J
> <dan.j.williams@intel.com> wrote:
> >
> > Hi Linus, please pull from:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.0-rc4
>
> Hmm. One more pr-tracker-bot note: going through the pull requests
> from the last week, I notice that this one didn't get a pr-tracker
> response.
>
> It looks like lkml still hates you, so your pull request email never
> made it to the list despite being cc'd. And thus it never makes it to
> the lore and pr-tracker-bot infrastructure either.
>
> Have you tried looking into why lkml has that red-hot hatred of your emails?
>
> Because it does seem to be personal - you have pissed off the email
> gods some way. Did you get a bounce?

No bounce, but I at least have good company in the shunned group.
Mel's analysis of the impact of page-allocator randomization [1]
somehow also missed lore.kernel.org, but lkml.org caught it [2]. Add
Dave Hansen on the outside chance his mail scripts have caught other
instances of patches sent to the list but not archived in
lore.kernel.org.

[1]: <20181012082213.GE5819@techsingularity.net>
[2]: https://lkml.org/lkml/2018/10/12/309
