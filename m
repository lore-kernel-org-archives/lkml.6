Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907652087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMI4WBjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907652087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJHOll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:41:41 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35236 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:41:41 -0400
Received: by mail-lj1-f175.google.com with SMTP id o14-v6so16918766ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyX0buiN4UVj/jk3Wox3uSReRVqsRY7WN8uICIK1Pys=;
        b=AMI4WBjIOp4OOjp2KFAad6YS3nUnN27clw3eYAzeJDZt3BVcKgy7cNvFiSBYx7Z9h1
         HNp1ytiaSJ1knRxKXNuZj8baDyzw7ZrDSwjckLom7A1mpAkOo6kjYIhreV2ZiOzphZCx
         K7azKKGi10m5uv0JcLRaMbQhPtDevSrUSuS3Rv8gJtzf8pZ2nA46yh/5FXQA0y/UKOo8
         m6+S30MFCHyZT9CvK7bHxEFQ6BFlCKaaWCzpAIB196xBr5vJp8OTDEsX3xNymcU2YzPt
         TUNPTAtkq8njRqwJq2DsFIYI86mdbSh2AizwpGJuUXrOb66buEl0riVPpVLXHCJfAKnG
         SUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyX0buiN4UVj/jk3Wox3uSReRVqsRY7WN8uICIK1Pys=;
        b=nELD7Ly8MB30VIhlvVl+S2+lOTs0GOmn0ENyhfQ71vuxW7yl9BvmMS6A9i9rOWre7y
         WryQgwyuPPM6naqLOOh/TK1Xugkw5hNMbuk8sl8MB/jHA2xlmthtksTRMFgH9awRCWre
         3EWbapT03rGuszkGQ5jzVz9rbmLWUFjdkvuHBAvk2veDXGsO9bk/PLpRwWgiZrrVCdJd
         GuokwmqvaPMe7VQksCg+MAFA1e4cG3dVdJ6M1UIB1ijXcyFscjJ8dZctGW7CNH70+oVh
         +afLNBxlavDfZq2wXCKOTgvAOtq9gg25+S+MaXbog4c/57/s6oZZ5PZ+3x9LHj00zoqG
         jVzQ==
X-Gm-Message-State: ABuFfoghYuDJSr8v7NJHZZui6Za5N/Nu9YPeQUJWlE7Uxo+Db7xq7B91
        uqr7453imLf+TVWYoQgdNJ/C/dC6Qlvcyttmdq8=
X-Google-Smtp-Source: ACcGV61lmsrq3RiGxCuw40bbtaWP7nL3faGKyv5NHqGbZ3najDjoYNx42As7MknRBzxVniiTDhvgTbX6Oj4XzxrwzTk=
X-Received: by 2002:a2e:8684:: with SMTP id l4-v6mr14602184lji.52.1538983879835;
 Mon, 08 Oct 2018 00:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
In-Reply-To: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Oct 2018 09:31:08 +0200
Message-ID: <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     Jason@zx2c4.com
Cc:     Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Oct 8, 2018 at 4:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Joe, Miguel, others,
>
> The shiny new .clang-format file lists a number of nice iterators in
> the ForEachMacros category, the consequence being that there is a
> space between the iterator name and the opening parenthesis. This
> strikes me as the right thing to do.
>
> However, checkpatch.pl complains about it:
>
> WARNING: space prohibited between function name and open parenthesis '('
> #65: FILE: ratelimiter.c:65:
> +               hlist_for_each_entry_safe (entry, temp, &table_v4[i], hash) {
>
> It would seem that .clang-format is right and checkpatch.pl is wrong?

Checking quickly, it would seem most of the kernel does not put a
space there (a minority does), e.g.:

  git grep 'list_for_each[a-zA-Z0-9_]* (' | wc -l # 67
  git grep 'list_for_each[a-zA-Z0-9_]*(' | wc -l # 13892

So in that sense, checkpatch.pl is right (even if it is not a function call).

Now, I put the list there because otherwise clang-format would put
braces in the next line, which looks even worse.

I am not sure if there is a way to make clang-format do what we need:
  * SpaceBeforeParens does not have an option to distinguish normal
loops from macro ones.
  * SpaceBeforeRangeBasedForLoopColon does not do it (which makes
sense, but it was a nice try :-)

We would probably need to implement SpaceBeforeForEachMacros (or a new
option for SpaceBeforeParens). I haven't had the time to look into
adding the missing support for the few things that the kernel style
requires, sadly, but it is in my TODO list.

Cheers,
Miguel
