Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93559C04EBB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5548B208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9xvzow8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5548B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeJPFlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:41:08 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46753 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeJPFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:41:07 -0400
Received: by mail-pf1-f180.google.com with SMTP id r64-v6so10331704pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/90pkrnEVMR461DnsdHg2gnOJuyWG/ZciqdVhYl+uQ=;
        b=Q9xvzow8NI9z00XfehNf2cFtby3pf1Yy9smEVoO7hIqjKfMGaa8CQuEbTgwYZzpCE3
         y34DuDhv/arDPmKUbmV+kLlfuXqJ2q6XFI0+KJbmGCp1hKF49g+PVXrgU4u0mIth0wod
         Eyzonr+YDmCFlZ/xXR0nMwqj/R7NEBaZ2UcZBQ4x59Mehj1Pe/xq0U6A3CkMgKm54PpZ
         oBxYLaKC52kGxOPh+XwpZfIp8PJmBqzZ2v0lIbBcqlWrS9OcRpBCOFsHPMJ0ro3Z8I8y
         bZAlcIuEbRSd+m7HttSDsOd1e556EgQ3JecdHzkFlCIKoAmNRej6x78ePCv/vg8PVZGl
         ZqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/90pkrnEVMR461DnsdHg2gnOJuyWG/ZciqdVhYl+uQ=;
        b=bMVh7UOuTzNoK6zI9AqXd5tvkZspX+gJYf5hMC72n1Y+ytMk/iJJOuIN5zlL/ett8P
         VmkFpRSUOZmxcq1SNvSjtFBwOh5bc5OBT94714eYdXvhHzkOGTGkEEFuNujE6DURztX0
         fMjwCfhP8buuCF2Pt8usEj4dKMSRnc1jnrks+kOGCUJhb6tKg5l3B77DvwB5evkxl6cW
         2uswA8viodw20NQHWcWcbWfXXt0A+gn1ytLffVZhgyeeSmHnPfpJ7RATMKKhDj0yUMmb
         fKvvVrWynaZ1vL8X0RlGjIzvI+TIk3W15YvqA+RawuRi+VkRofxw8pcVns6EVHXsnjRZ
         BxGA==
X-Gm-Message-State: ABuFfoj11YWT334Ejp5OWAwttFFMHmHiZ7y+3ITbHw0WQbXj6mEiUcYC
        Yz2+lDVAUlf0LrytkKx+h5+7i3j3M3yZRrWcUvMh8Q==
X-Google-Smtp-Source: ACcGV61aKdFnBLKXlf5x+dp+pN8CK8nw8Cp42aLRzZE52A1mFjfVRCmXe87LmRaOtvoT3pWkxvv5RRVthk4/Wj7j/Ug=
X-Received: by 2002:a63:2f42:: with SMTP id v63-v6mr3515716pgv.202.1539640441007;
 Mon, 15 Oct 2018 14:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
In-Reply-To: <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Oct 2018 14:53:49 -0700
Message-ID: <CAKwvOdmXVY1iA-VAs-Ns3qVVnMTeU6v4RqxoS2=SJcSeQ23_og@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     David.Laight@aculab.com
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 2:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: ndesaulniers@google.com
> > Sent: 11 October 2018 21:31
> ...
> > by swapping h2 and h3.
> >
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> >         va_start(argp, h3);
> >                        ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                                ^
> > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > standards explicitly call this out as undefined behavior:
>
> I guess that problems arise when all the arguments are stacked
> and va_start/va_arg use naive pointer manipulation.
> In that case &h3 might be 4n+3 aligned so va_arg() will access
> misaligned stack locations.
>
> I doubt any modern compilers (where va_start and va_arg are builtins)
> will get this 'wrong' even when all arguments are stacked.
>
> Seems clang is being over cautious.

Yes; did you have feedback on the Denis' proposed fix, or another?

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Thanks,
~Nick Desaulniers
