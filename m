Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbeCRS7Z (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 14:59:25 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40579 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCRS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 14:59:24 -0400
X-Google-Smtp-Source: AG47ELue88741g/p2SWoGy9D48mFPBYmwWvU0dVR7ksXHWp0YktJevJeEwavd+kH3AGzVJqWYH+NuMpUHOL3vS96Oj8=
MIME-Version: 1.0
In-Reply-To: <1521397579.27411.39.camel@perches.com>
References: <20180318171632.qfkemw3mwbcukth6@gmail.com> <1521397579.27411.39.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Mar 2018 19:59:02 +0100
Message-ID: <CANiq72=GbjqowrGsz77XcTNX0SFyomDVNc=ysnBXuFEr6tfKAw@mail.gmail.com>
Subject: Re: [PATCH v2] clang-format: add configuration file
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 7:26 PM, Joe Perches <joe@perches.com> wrote:
> On Sun, 2018-03-18 at 18:16 +0100, Miguel Ojeda wrote:
>>   * Uses clang's tooling support behind the scenes to parse and rewrite
>>     the code. It is not based on ad-hoc regexps.
>
> Did you look at the results of a typical and generally
> style conforming
> subsystem when reformatted with the new
> rules you propose here with
> clang-format?

Yeah, of course. The rules are trying to minimize the diffs across
kernel/ and some other places I tried.

Of course, I didn't test every place -- anyway, it does not make sense
to try everywhere, because there are several different styles around
and because of the limitations of the tool itself. Therefore, I
attempted to provide the best set of defaults I could find for
clang-format >= 4.

Also, note that people can override them for subsystems/folders by
providing their own .clang-format in their subfolder. Not that such a
thing will/should be common, but it could be useful for a few places.

>
> One of the issues with hard-n-fast code formatters like
> clang-format is taste.
>
> clang-format doesn't have any so it can't know when _not_
> to  reformat blocks according to its rules.
>
> Tools like clang-format are generally fine for a first-pass
> reformat of non-style compliant code, but are IMO generally
> unsuitable for continuous automated use.

Agreed with all that -- but I am unsure why you are making the remark.

Hmm... I am guessing you read what you quoted above as "let's rewrite
all the code"? :-) It does not say that -- what I tried to say is that
clang-format rewrites code (i.e. formats) by using the compiler
tooling support, not that we are going to use it to rewrite everything
around.

Note that there is support for disabling formatting of blocks in a
file, but I don't think it should be used anyway; at least not now.
The documentation included emphasizes this as well.

Cheers,
Miguel
