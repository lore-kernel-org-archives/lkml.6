Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeCSOX0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:23:26 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:39406 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932703AbeCSOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:23:24 -0400
X-Google-Smtp-Source: AG47ELuYeXUyoo2oEyyHaZO5v/NrPfstQY2yJ4nRSQgNJjx9Kv0ePR1aQFt14XttMWa9zRiLRwL/ZA==
Date: Mon, 19 Mar 2018 23:23:19 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tools: Fix str_error_r() Werror=restrict build
Message-ID: <20180319142319.GA561@tigerII.localdomain>
References: <20180319055504.757-1-sergey.senozhatsky@gmail.com>
 <20180319141612.GA2143@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319141612.GA2143@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/19/18 11:16), Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 19, 2018 at 02:55:04PM +0900, Sergey Senozhatsky escreveu:
> > Commit c8b5f2c96d1bf6c ("tools: Introduce str_error_r()") added
> > an str_error_r() wrapper which makes gcc8 unhappy due to
> > restrict-qualified parameter aliasing violation:
> > 
> > ../lib/str_error_r.c: In function ‘str_error_r’:
> > ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
> >    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
> >    ^~~~~~~~
> > cc1: all warnings being treated as errors
> 
> I applied Josh's patch, just printing '[buf]', that is good enough, I
> think.

Sure. Do you need the whole "strerror_r(%d, %p, %zd)" in this case?
Seems that printing out just `errnum' should be good enough.

	-ss
