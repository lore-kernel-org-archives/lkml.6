Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF34ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FC21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTGilprg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0FC21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeITWM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:12:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40911 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeITWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:12:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so5372816qkd.7;
        Thu, 20 Sep 2018 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7OsRJQ8lMnbnCCd91LUHXhmUNXYEOPVk7W75hhk+o78=;
        b=fTGilprgxiKCs4U164CWmHy6xTooPqAOmfDJ3Y+NRep6KwLRKU9ltqaGaNFSXjYUnP
         hEesTIdNeYxK72T5+IhQuU0MyYsJDAqK1JuyU+wmXGtJen68OQr1PyB2Bl8gpl4Zpr9C
         38e2dgd0BlOt1PWJWUVWAlOwt/72Wu9K+cabOXFxtWWOs+luo/vEHvUOtgZqQyC7Y7Av
         O59NdqoEPGv6rfHSwzLodPLEPRwZjMjdyhCGqPnJ6vrgx/qnayfqdX5ErIPdX7VK0qzQ
         aYlQnqQsO9mAol0n2AsR8fan3UriOsIgnztIYqmgaPnecMvRQ7feAwHJ0a1IS7vBKZLY
         a/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7OsRJQ8lMnbnCCd91LUHXhmUNXYEOPVk7W75hhk+o78=;
        b=F+4H3jYxC5675pxyqMwaH/Hv5cjZHrFkFVWLeABMcGvmEGkjfCHhsKZXtaEVbxXyZK
         VstVsUTmCzqa61+XuMD7pG9Fk/io6orVb/EexRbGm6NpwTXBnaRocbPxpm4v4AKzjRM9
         B6Ms3x6n4IikC8Qq2mU7acm4nXpV0ZzDaHOtXpyV/jLA32T4b4m/J2V5ZGfMowiYxlkn
         H7F0CCCLiKc6QUwSiF5wmlHakGKz8my2CFnvEFRmkRa13ZVkzcB8P+PJ6BYPiDpeQk3d
         eVCMIoPV+F8rRok/R4NNj/l0GCEHiD/knk2wgoqmzgpDMEd+3uNlyWcAmd3qCzxjrZA7
         NQAQ==
X-Gm-Message-State: APzg51DK9skqXtmWBnGdRH+NJQS8WHJZ6Y9sw7713OfVqkLIWBjdz2Kz
        MQ7wQ04p1A1NhZ8I0gwyHIn1AyOff3VTOrA2krgX73GWZCc=
X-Google-Smtp-Source: ANB0VdauWW8sSQQkOKLvTFXKk63jVNYRR9CFUas0bkMWyFT03LMkCL37nh80Nld6AzaaWdUwVm93+hAdx1pCiA9niJI=
X-Received: by 2002:a0c:a202:: with SMTP id f2-v6mr28176302qva.170.1537460920775;
 Thu, 20 Sep 2018 09:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 09:28:20
 -0700 (PDT)
In-Reply-To: <CA+55aFyApn2d+bv_3LGwXKnLpj2zdX6HYw_9cYZoNUVPi-Bu_g@mail.gmail.com>
References: <20180831080714.4f94fba9@canb.auug.org.au> <CA+55aFyApn2d+bv_3LGwXKnLpj2zdX6HYw_9cYZoNUVPi-Bu_g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 18:28:20 +0200
Message-ID: <CANiq72kseYacgu91NuDGaH1cb+9Jind=0bAt-7baPi28YGbgsQ@mail.gmail.com>
Subject: Re: linux-next: disabling -Wstringop-truncation
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Andi, (Linus),

On Fri, Aug 31, 2018 at 3:17 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Aug 30, 2018 at 3:07 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> I am now mainly using gcc v8.2 for my builds and -Wstringop-truncation
>> causes so many warnings that I am sure to miss others, so I have
>> applied the below to my fixes tree until the noise reduces.
>
> Applied.
>
> If people want the warning with W=xyz, then this is still the correct
> patch, and we should add a line to re-enable it in
> scripts/Makefile.extrawarn.

For reference, I am sending the v5 of the Compiler Attributes series
with the __nonstring patches appended on top, and I am adding the
warning back as well, on W=1.

I think W=1 is better: there are not that many warnings compared to
those in W=2. AFAIK, it is relatively easy to achieve a clean W=1 (and
most code should at least try be W=1 clean, no?). Also, note that now
people can use __nonstring to suppress that warning (if applicable);
and that using properly __nonstring can detect even more problems
(i.e. adding __nonstring may trigger additional warnings, e.g.
-Wstringop-overflow); so I think we should encourage the use of
__nonstring.

Cheers,
Miguel
