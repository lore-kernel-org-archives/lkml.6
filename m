Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p7TJFmUrGVuDGQAAmS7hNA
	; Thu, 07 Jun 2018 12:57:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 32CF1608B8; Thu,  7 Jun 2018 12:57:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrI5FS3U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63C19602FC;
	Thu,  7 Jun 2018 12:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63C19602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbeFGM5C (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:57:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41440 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbeFGM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:57:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id w23-v6so6447703qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JOaXc7G2PSQtn4Xpj1Dy1SJRmEwQmSx+b9/SqHJJtFY=;
        b=hrI5FS3UIkfZIS73PYNLisqFatNDT2TgIvyML3JRKVNARLjMCtWNCS7eiSgAjO49t6
         17UCv9ER1ynlNye0jRiiSTXM8JiEE8TQ/ZDPMTiv/CiEmF9ZzF+ync+H+ztUYZnqUjuq
         K2vFwzEEfPfDHnix7vRvxDku2AyvTOSIj195pQe43STQE8dOth+1CbR69Yz92BZ0/t7W
         X1+7AIuaZZ3dVe5QY1YA4RXszOHoe6f/HcFIe6mngQAZp7Ilm22QYHyarRoy+D07tc5O
         ImYZjtCy7wpLl9UI/LGUuaKP6HdPbSKN88chS5kphH3sUz28oo5gS/H1PgbC+pmR+6PE
         Uxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JOaXc7G2PSQtn4Xpj1Dy1SJRmEwQmSx+b9/SqHJJtFY=;
        b=YQa0DB7OTQ2HTeyRdRy17IqJ6crIqfkjhsiMmrZdd7ef4Tul8ZjvATDiDtJzbc0GGX
         l3Mhh3WynQiGZDfH/dSFyILsXd9w+V5QqBYFOqbT+38pFSO21089Gfhiph93Ll8+HbVy
         +1ZKHfKqxo75FSfy3FWY736+HcJgtrL0WkHXCbAZiqEOGORqqQQAKCvn1G8BGT7dSyd7
         SmwiiSZSPHKkttlE9pBwNoancMVPTaq0c6oegx6AikWtBf/0ratG8AS+CRvsaFGCNIXH
         BYiDmPPdND7am2uwxypHfFuuvt2n3f1ivM6HgkFXJ1yPameOEN0AVc1JvBURkFzMi+Fx
         Yt9w==
X-Gm-Message-State: APt69E2qEG1evOeOo4+mTCJ1+jWv8noyoq2iDG0JnQM8sNdQ5edWULGy
        Cb10/Q6253XQ0YTxF2djFzDoevtSratmUquboeE=
X-Google-Smtp-Source: ADUXVKLuzgm1ZRclnJ23a4pkoFPZ3O6Tw0l7LJBxQF1h8woRzeB5Xk6lODy3w7UGH8qh3uVp7DtQLqTYwf4bM9394LI=
X-Received: by 2002:a37:5307:: with SMTP id h7-v6mr1307331qkb.384.1528376220666;
 Thu, 07 Jun 2018 05:57:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 05:56:40 -0700 (PDT)
In-Reply-To: <20180606202528.GX2233@mellanox.com>
References: <20180606201556.GA10832@ziepe.ca> <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
 <20180606202528.GX2233@mellanox.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Jun 2018 14:56:40 +0200
Message-ID: <CANiq72nSdfhq7dBJ64wAaX1Fviyjnq9BE-_GEM8bdKqWFL0aFg@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Set IndentWrappedFunctionNames false
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 10:25 PM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> On Wed, Jun 06, 2018 at 01:18:59PM -0700, Joe Perches wrote:
>> On Wed, 2018-06-06 at 14:15 -0600, Jason Gunthorpe wrote:
>> > The true option causes this indenting for functions:
>> >
>> > static struct something_very_very_long *
>> >     function(void *arg)
>> > {
>> >
>> > While a quick survey suggests that the usual Linux fallback is the GNU
>> > style:
>> >
>> > static struct something_very_very_long *
>> > function(void *arg)
>> >
>> []
>> > AFAIK the above describes the more common choice in the code base?
>> >
>> > Not sure who's tree this is supposed to go through.. Andrew I guess?
>>
>> I believe so yes.
>>
>> I expect there will be more refinements to .clang-formata
>> as perhaps more people experiment with it too.
>>
>> Acked-by: Joe Perches <joe@perches.com>
>
> Thanks Joe,
>
> I saw your note in the original mailing-list thread and just wanted to
> say the way I use clang-format is editor based.
>
> I have a hotkey that triggers clang-format to reformat the current
> statement, or current hi-lighted region. If I don't like it, then
> 'undo' puts it all back for manual adjustment..
>
> This way I am selective of where I apply it, and I find it is
> something like 95% of the time good, IHMO.
>
> Big time saver for wrapping long lines, moving code around (eg
> indent,de-indent) and other mundane daily tasks.

Indeed, I agree that currently this is the best way to use it (until
and if we get full support for the kernel style in clang). In the
documentation I wrote I mentioned this point. It can also be useful
file-wide to quickly spot style issues: apply clang-format - inspect
git diff - reset back.

Cheers,
Miguel

>
> Cheers,
> Jason
