Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED7AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C4A20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TnfqAI4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C4A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeHOT0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:26:34 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:33315 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeHOT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:26:34 -0400
Received: by mail-it0-f48.google.com with SMTP id d16-v6so17829480itj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOD4dkk5r9hxIWPW6Mp1FsWLoqAvHKhmAJliyWTxBsM=;
        b=TnfqAI4CPKcr9SDvH+n5ryNEeL04VUqFyU0NFolEDCsgRGHPnCRyjIcclFl4xDcMpM
         Xd4vJooErMC0RgqFC/CPdmnNPqIZMFuyI3k9vLzpJm8Tte1MhPARjo9eHVsfUG3WB9Nm
         oC/UIZlvN04+52P1yCAnVDrbvtdUl0f0ZyiNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOD4dkk5r9hxIWPW6Mp1FsWLoqAvHKhmAJliyWTxBsM=;
        b=Oal4nFAjycSvSXSpb4/2PKb5W4T3v8QWCnfOu6RFukuTlpmCKU8VISYm9cYLyTILtN
         S5kGRUh7SmONWpz5S0IIoDaRiZSgZPPNJrMghaCgSBf4KcawZyXPTJ3/4OMr3VlInaAe
         zSOnBeNGYmmhw/QpmH+bt+tm36fC1s3lDnK1HZKl+55r3rxN/hspyIKL2cgOjUgyluv4
         L7sRi8zB81bXAk6XsTmJmuhJvkpnkI9tqROWrmrgGZS6l9Kw9WOfuHLPA3nijeEPYL5m
         E9IsVVDvmijHb2fEyMIH4GQOenAGCeVLH1xyTiBH8fBff9nyCZKLup69r1G2HmtPbwKt
         3Hxg==
X-Gm-Message-State: AOUpUlF2nuXigoHhjwOffVDpPnY2sVnXIrnrgphvk55ffpPzbLcjle2D
        I726ygNIG6cDl1sNRQ3hkZrX3XwUqnQ0DuEfVM3Eyxk3
X-Google-Smtp-Source: AA+uWPwwvoCuzEHkUzUcVtLEcIIUIr/xKyJQhsG2xdjDB46ASOSyp8sv+re9rSqTSq7m8c3yz6Vequ3xVZ+wXGV99aY=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr18117687ite.1.1534350823200;
 Wed, 15 Aug 2018 09:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <aa4bedb7b1af45c59ff4e61f3f199287@AcuMS.aculab.com>
 <CA+55aFyeW7rqgGqOusZSz-jFP-CMH=hcyVGKhxyLxNeyBgLbqw@mail.gmail.com> <d87ba353f6fc44668969a8535790cdc9@AcuMS.aculab.com>
In-Reply-To: <d87ba353f6fc44668969a8535790cdc9@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 09:33:32 -0700
Message-ID: <CA+55aFwwon2MLEhw-ERLskWed8b58NseLYF-7OOQhhjMcD-A6A@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     David Laight <David.Laight@aculab.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 9:16 AM David Laight <David.Laight@aculab.com> wrote:
>
> >
> > But some libelf bug that is less than a year old is likely to bite people.
>
> See https://lkml.org/lkml/2017/9/10/186 for the libelf fix.
> It isn't anything like as rare as those emails suggest.
> An 'allmodconfig' build fails on a lot of object files after 4.15-rc9.

Ok, but that patch that fixes it was merged a long time ago already.
See commit 97dab2ae7e84 ("objtool: Fix object file corruption")

So I'm a bit confused by your issue. The thing you point to from last
year was literall fixed and committed to the tree in a couple of days
days.

> When I fell over the problem I found a few reports on the ubuntu lists
> but they all just said the ubuntu version was unsupported.
>
> There is this patch I did https://lkml.org/lkml/2018/7/26/266 that got
> no comments.
>
> But really something needs to be done to objtool.

I think you need to make a report about the exact problem with objtool
and your issue.

Not on the ubuntu lists, but to Josh.

             Linus
