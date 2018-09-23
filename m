Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E12C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EAF2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8uPHVbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EAF2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeIWRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:22:03 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43939 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeIWRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 13:22:03 -0400
Received: by mail-qt1-f176.google.com with SMTP id l16-v6so5590812qtq.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iLoYfljNU65ch6RlLlHM7KTBXHJzyxQHTyzfFTRRcM8=;
        b=O8uPHVbA7zEhO3lSPZkXnmAY8NLfIuTs1cIe8fdOH6sfMP/R55OVZWHWD/uHqaa9q2
         aPKsJmMNbhaxfu7MtdyHf/nhw2kHAO5xMGxwTnOrqkpsHYdZ/YrZNgryXfTJXEDBvx47
         jiv4wOuZ32MCSDJaYRU2atymTSc+yoAAMoeYgkPNbqUulDjks9D8Ql/K6DRdHA5sRcwl
         Q7c6NtObqTv0DjVr35I5mK+MeRCRB5BDI/BiG8iHEKp6/ACdtxC7k2TH1OKkKu48y5WS
         TB7hXhO6khKGrELEeYS0PNN5ZJ8AqoWevkogpXuIJkYMiLMelu4Ctjb6rYMejSWzRcmt
         Ew6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iLoYfljNU65ch6RlLlHM7KTBXHJzyxQHTyzfFTRRcM8=;
        b=Mp3mmUaYUGkZ4zZ5THYXeAqoohVmV171Ugs6aT8F0yqN34M151895mDwvEEolUi7JK
         FHgb104nhoLGZDWU2t6nd6jjPiOyVBbqU9DwGyBBSBV7qMN1uRyTGJ9hLQVPXhPQBi3Z
         uxjtkdANsvZ4a5khIlznpKeFGE+eO72s3Su/Er80AqnRM/dnUJv6EgU8MljhQiSLwHjM
         M8FXSMXFrpcITjy8jjt5ewEEHqhR8iYNg+vbFWKfTS9asIPhMZtzWspwJO1eLUMo3cMZ
         3GjBLZjeC0YtSk9aT4szdd3oTDVV6IVm5JpYmH9kJhY30CU6ayyuZ+YbHMBWtxoWofRC
         Y/7w==
X-Gm-Message-State: ABuFfohBNRicNeraZzAzOZAIC0zvqliFzl8ylGyt4MYaR1qJ5X8OyXfN
        2TNOToxQaPg6VW/AQcuqCuiDQ9GcREkJMKWeUSM=
X-Google-Smtp-Source: ACcGV629kEuNfhzHW5Ssr6/JlPla8ekhpwjKJNc4WcClgwnSXFYSjVlvUEwCtEbRIP6Z1QmQx4lDcoQ53ODFdB0wUJQ=
X-Received: by 2002:a0c:87b1:: with SMTP id 46-v6mr3538979qvj.202.1537701893500;
 Sun, 23 Sep 2018 04:24:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 04:24:33
 -0700 (PDT)
In-Reply-To: <CAFLxGvxZmuXb6KbGggQf4y1_Tkv=Ri3PuE4Jnfwbs1VuA9z2QQ@mail.gmail.com>
References: <20180912035352.11191-1-diego.viola@gmail.com> <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
 <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com> <CAFLxGvxZmuXb6KbGggQf4y1_Tkv=Ri3PuE4Jnfwbs1VuA9z2QQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 23 Sep 2018 13:24:33 +0200
Message-ID: <CANiq72nQ0KZn6TCSk7pxMsbEAtwKG1ZAp0CwmZ=LmNZCgHoFrQ@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Diego Viola <diego.viola@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Trivial patch monkey <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Sun, Sep 23, 2018 at 10:59 AM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Sun, Sep 23, 2018 at 3:00 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Hi Diego,
>>
>> A few things, since it looks like this is your first patch.
>
> git log...

Oops! I guess I mistyped the search string, sorry Diego!

Cheers,
Miguel
