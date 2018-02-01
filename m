Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeBAWnf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:43:35 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:44955 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBAWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:43:29 -0500
X-Google-Smtp-Source: AH8x226Ifd1Lr9bgTx5YzddwQnNFDiYrhY8h04sfHMwltU+p1hX/99kSIP9elO2rsmLVDil9B9zyu1JPzVgwnnMQh1k=
MIME-Version: 1.0
In-Reply-To: <20180201204522.GD29988@eros>
References: <20180131024236.GA31627@eros> <20180201204522.GD29988@eros>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2018 14:43:28 -0800
X-Google-Sender-Auth: G5wNnQ2URH9ECk4AUWPqUVsCSbQ
Message-ID: <CA+55aFzG_KLCdZVb-qEC0786A3OK=tG-FFNzkMZC6dRtvn4uUw@mail.gmail.com>
Subject: Re: [GIT PULL] leaking_addresses.pl changes for 4.16-rc1
To: "Tobin C. Harding" <me@tobin.cc>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 12:45 PM, Tobin C. Harding <me@tobin.cc> wrote:
>
> It has just come to my attention that I should have pushed these changes
> to Linux next before requesting you to pull them.  Please feel free to
> drop this request, I can try again next merge window after going through
> linux next.

For something like this, I don't think it's a big deal.

A bigger deal is that it now wants perl-bigint, as of commit
8d8a77fb99bd ("leaking_addresses: add range check for vsyscall
memory").

And that is not apparently a common enough perl module to be installed
by default.

Sure, I just ran

    dnf install 'perl(bigint)'

and it did the right thing, but it does seem to be something of an
inconvenience.

And things are *slow*, to the point of breakage. I get

  timed out parsing: /proc/kallsyms
  timed out parsing: /proc/2177/smaps
  timed out parsing: /proc/2238/smaps
  timed out parsing: /proc/2336/smaps
  ...

and no actual output. I'm not sure what's up with that, and whether
it's related. Probably not, but I didn't start bisecting.

So I pulled it but then unpulled it due to issues during testing.

             Linus
