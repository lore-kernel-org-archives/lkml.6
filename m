Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2510C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A769A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1yqDCQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A769A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeLJJwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:52:42 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41311 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeLJJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:52:42 -0500
Received: by mail-pl1-f179.google.com with SMTP id u6so5000841plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAS8Km65NvaNcUp4Gwcc8T+PDsTMZrT5n8pVib/Lejo=;
        b=j1yqDCQC9dTU6bw4+UMz04c8LnYqXnltQtTN9mqTrZTjniljpRlbnX+Cb0Y6z6OjCl
         2ETH4Q0UgCJkPSys2v1T1y/u7sI0qCwPLSfm/jKTx8sO0r+e24+OMrtIYqz1aPgTwjJZ
         cbuI5frywApIDeBk3NPDCiPi8iuWH2UjxhtxH+dkrJnv+ekHDMTi9TlbkrpuGhAclo+a
         0RyIPOZmOq6VjKD1eMIDfFynCjCBfWeoGW1l2vtHYAYYLBNLTnONklO2LZVHugZ9uXt9
         RIrkkp3pxKhbSDpwzIohAAdFsmZM9bUgghjeoUYkkRhUYU0W2qk1es2n3+I/3tjbSqzI
         QWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAS8Km65NvaNcUp4Gwcc8T+PDsTMZrT5n8pVib/Lejo=;
        b=ZzJskbVgK6hfp38sgUQHr6V8nS+LylK4ok0Ih1Z7RyCX9D0wDTqTgGd9yYfYDCYFTS
         W177JwHjTttf4SQsDu9+BTcH1UKPi+Ghkh8Tk52Yv4dHN5WpwNJ0DDqL0u04d9YipM1V
         8xQs67nDpNk6f7VQoB5rjddB8n05pmUYajNxZZZte67T2sa4h2ttELVY5v2+4DDPT7mZ
         sn3BS/TarFgE1Xzb3p62YPhRDaKizna8iEcL6hNhR7nczqG3GY7x7HZPa8GHPo6eaLuD
         Dv4UwntFTImSA+5Xiw0J/ceKNKUw3NhNHWLydVWRGDM9/G4LJOF8j6R9xfB/8wT3iUXL
         ZiPg==
X-Gm-Message-State: AA+aEWYJBe5kFJ/+SZdssB7V2c4jIy820BIlEcyMNPVXvzcvqHQngN94
        +nYK9Kbuf76dv1cfJwb57o55qTkBkI+thXSb+I0SxXrL
X-Google-Smtp-Source: AFSGD/VBjnEEYqaXHKK8ZndMFTzFf2kDIo+6lQVjoeReaYBfJc3gsxA3ZkiINbcPMaWKjL1Z7uk0mnbYQGhgPJNTcQI=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr11771124pld.87.1544435561600;
 Mon, 10 Dec 2018 01:52:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgHSX8x6mOB0xZibbg-xc3veqsQEnHZ1+3H2DbO5MU5Rw@mail.gmail.com>
In-Reply-To: <CAHk-=wgHSX8x6mOB0xZibbg-xc3veqsQEnHZ1+3H2DbO5MU5Rw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Dec 2018 11:52:30 +0200
Message-ID: <CAHp75Vf6Au7yY4zdn5=qMjMvDKCi-LVAW45sjzB5f0C+m3VYHw@mail.gmail.com>
Subject: Re: Linux 4.20-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 1:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Most of it looks pretty small and normal. Would I have preferred for
> there to be less churn? Yes. But it's certainly smaller than rc5 was,
> so we're moving in the right direction, and we have at least one more
> rc to go.
>
> I say "at least", not because I'm particularly worried about the
> technical details and any outstanding bugs, but because of the whole
> holiday season timing. I still suspect that what I'll do is release
> 4.20 just before xmas (so with the usual "rc7->final" cadence) but
> then just leave a dead week for the holiday season. Again encouraging
> everybody to send in their pull request for the merge window *before*
> the holiday season, but I might just either ignore them for a week, or
> take it very slow and easy.

Linus, due to my vacation schedule and possibility that Darren might
be also busy with some stuff, would be okay to send PR this week, for
example?

-- 
With Best Regards,
Andy Shevchenko
