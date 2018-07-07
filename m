Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE409C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8722460
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dL+0Lfh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8722460
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGGCji (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:39:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54578 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbeGGCjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:39:37 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so18819356itb.4;
        Fri, 06 Jul 2018 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVQO2LqYYCt8CM93XltgLDOhOOwYcpSLKxJ5/k+FqNU=;
        b=dL+0Lfh/YjYNY+sXXcBqCCyEZOIsMOP3cP/ZJ9xafyOgFtIfEdnzzYzlUXIzDfD/Gz
         J17F1O7genD0TiPSD/ojZQzLb1zWbzPctT9xI3hy87nTZrFAflFaTq3QTV6PPt0fTubQ
         eV6T3DdXPQSmaM0QTxRLUo354BUw9Crs2gazA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVQO2LqYYCt8CM93XltgLDOhOOwYcpSLKxJ5/k+FqNU=;
        b=iOt1UlzMP+o+SwKzFjNXVafOKd6XYvSxqkFgY9iPxbTlFq8HAk/CYr2WRtMnR/0Ci/
         S62nzPIyuYb4GaNiZSqiIDK7C1nFP3yO6DXLJ2bmT+7WvPmZwByY3kZulLWhvJL0G6UC
         lmgXaVvnyH1AFs99l5ciEU29lr4U+8dCen3HwFUPGf/A3pTzU7bAe/FO8dl/xDDXL5kD
         gXZuE1HyBSS5oskbm7/XxhDAC2j1q2QvZ9zrDQEG4REc72f4ZFnJUDkk5uAgv8NO2JHa
         fvHhW3TFoND7dcaG4aA4Gc4LaR/0RW8a7kJ/6hclDWK/BpvI6QPxsLGDE7cMofaAPvrh
         Gn2g==
X-Gm-Message-State: APt69E26i5CnUOADMg9vAIWtW3fW5uw5AykTIeYJh7eWzLV7FtdwhvCz
        xTtgPPb2iMC6xSjfIiOlwCAs4LnW+W8dU/mvdsg=
X-Google-Smtp-Source: AAOMgpfZ8DRDY3hhRQ9P4cCJjbvETYCkY3jeQAWkgWMd3IJG//OQ9uEDMmrQ4u+MJN/C03s8vF5JB/PQNEM2Ly8zSw8=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr9619384itg.1.1530931176471;
 Fri, 06 Jul 2018 19:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com> <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
In-Reply-To: <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 19:39:25 -0700
Message-ID: <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Who actually does direct read/write to /dev/sg? Could we perhaps just
> add a config option to disable it entirely?

On the IB side, the argument was that there was some crazy binary-only
vendor management code that really wanted to use this completely crazy
interface.

I also think that the warnings are dubious. I'd rather add a
deprecation warning to the whole "read/write to /dev/sg" itself, and
then do what we did for ib_safe_file_access(), which was to just have
the permission checks.

It's not like a normal person should have access to /dev/sg to begin
with. So it's not like you can open /dev/sg0 and then try to fool a
suid program into doing the actual IO.

I'd hope.

Maybe I'm wrong, and there's some crazy "let's make /dev/sg available
to normal users" setup out there somewhere. At least for me, /dev/sg
isn't accessible to normal people:

  [torvalds@i7 linux]$ cat /dev/sg0
  cat: /dev/sg0: Permission denied

but maybe some distro decided that everybody should have direct device access..

Jann?

                 Linus
