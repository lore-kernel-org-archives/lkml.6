Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6FD2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ua6ihsCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBTKtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:49:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46490 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:49:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so11714733pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 02:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BphEOsYTU6nIvEvMRHraeC6/Cz74egaHkPEpMr2eWk=;
        b=ua6ihsCiLkhoW8PwwZ2mkWtftnzAuOQSGgt+TwNtvVyApk8F3r4AdHYcBJitmXo3d0
         eR1jUCAFzLsUZK442KzUmSBzWVym0tV/2bFd8qacggXRncOWQv/sxFbe1m1Q8KhhBi2M
         N15UPtiesM9nLTUjcYxg5lyREF1+9fuR4iM7T73X0k89RS8pDZNxlPADtojgcdNG16Wr
         CQTbc4Y3+oYppY7zhgCOL8j/FwFRVAFhKVF11ROI8OSe+w9aidH1ac4gSlASXpOhCHbI
         scTlNcv/c+I/HGru7WiMHD89cM9VV/Z9l3V12ZvAKlKPsq3uSHj6oBBAMQJtXITT9S5C
         kyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BphEOsYTU6nIvEvMRHraeC6/Cz74egaHkPEpMr2eWk=;
        b=rONhCL4jOmeMCZy0OyYN9zhrmUzHfrv6/7I5hY9vLQlqT1BZ/SunCd/wEXLFBcmjmV
         HPFbW9FgiiO5ReqapnjGvzdbuSKFaMyQk5BbOfZi82SJJD6RyrOrM/UHI62MseCZubUn
         6og9KUqGqzOJV0Pd6Y5a7H5fyxS3u3vjawv//sc4WvYQShl7SzIq0oknOMJUG+7rRzrH
         H9OpZbNveK3belUOHvzSemoG/qvH7XhrxmKZEDlv8doyGwArDcrHJ3tlgoO82Q2ba54z
         2KU2015E2+BBqkRsFCkyPD2xLNY9b/dLHleS9wJ3T2DxecVmQhg77wdHbQLj4azNn3D2
         sZ1Q==
X-Gm-Message-State: AHQUAuYYJGrQ+R0WwgfJ8jTQMOz6wgYWU9ohaZgVnsB7Tg6YAiwH30Dc
        RjnP0pjxAM92DkUPsMNxDM3vMTwkiMkyNwBll8woSinT
X-Google-Smtp-Source: AHgI3Iaxo1SNDd0L5Ki8FfyFSjEX02FM0w9RRo4UCiaWFMsjwiU59X/uzKsHDp+Mof4rvruDypq9Zsk0zB+zGkLEUuY=
X-Received: by 2002:a63:1c42:: with SMTP id c2mr28322859pgm.265.1550659758399;
 Wed, 20 Feb 2019 02:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-2-tobin@kernel.org>
 <CAHp75VfP_gyx_+8XKhyJMShooPubpR2KJ7gvzu0Mbv3+TaFTxg@mail.gmail.com> <20190219215526.GC16094@eros.localdomain>
In-Reply-To: <20190219215526.GC16094@eros.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Feb 2019 12:49:06 +0200
Message-ID: <CAHp75VeW34Me+pPUgixfhZU036fEmHBkJ6igkeHPr4hN=rhF7g@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib/string: Enable string selftesting
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:55 PM Tobin C. Harding <me@tobin.cc> wrote:
> On Tue, Feb 19, 2019 at 12:55:09PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 19, 2019 at 4:44 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > >
> > > Currently we have a test module but it is not tied into the kselftest
> > > infrastructure.  In preparation for adding string manipulation functions
> > > and testing we should enable kselftest to utilize the test module.

> > > +       default n
> >
> > Redundant
>
> Cool, thanks.

> > > +       If unsure, say N.
>
> Does that mean that this is redundant too?

It's usual pattern in many help summaries, I don't know what way is better.

-- 
With Best Regards,
Andy Shevchenko
