Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeBZWnk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:43:40 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:51472 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeBZWnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:43:39 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.26.24) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <50a2fd51-8bdb-d2b7-c2b3-7df638fdedde@robertabel.eu>
Date: Mon, 26 Feb 2018 23:43:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20180226224338.10041.88383@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2018 17:49, Miguel Ojeda wrote:
> On a general note, the code seems a bit convoluted for what it does,
> specially without the comment written in the commit message :-) Isn't
> it simpler to use a tiny array in the stack and put the numbers to be
> converted instead of modifying the input sequence and dancing with
> pointers?

That's what I felt at first, too. If we can drop the backwards
compatibility of repeated xy commands, the whole affair gets much
easier, but will unfortunately break existing use.

Ex. ^[[Lx004y002x006; --> x6y2, because repeats of x would just
overwrite earlier values. That's what the while loop allowed in the
first place.

I suspect the while loop to parse was just a clever way of parsing y
followed by x and x followed by y using the same code and the
overwriting behavior is actually an unaccounted-for side-effect.

Regards,

Robert
