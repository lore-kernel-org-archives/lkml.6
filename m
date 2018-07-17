Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6D620693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP81qsB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6D620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGQVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:34:05 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38643 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbeGQVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:34:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so1579295uak.5;
        Tue, 17 Jul 2018 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bO7Xs2fMtXdjJqlmDVk7bkjPabeiVg1xz712teaXtqI=;
        b=lP81qsB7gczMgjlc6nUo22x+HaVTnR8BJOum3nIYoz6QqTVFmZgMWwthBk1f8gRwzj
         M615rxyUd7L0MXXBc2N08MhwfbP7YQHGL3kr5xl2qUMG0FWMeaYxoLRm2/eZHo1xcIDy
         JaIOfk/hxPy2SPF6xvVgGErbrGs7VJHuNWd+a46d4b7igsM4wqck4LP9GZXWbtqPRH4z
         hzvY70052p0H6jAIihmwoFz889ZA7HQxqeFwznWCrSLzWk95jegLmBctcX9lTF0+fGox
         uS+RsDR0FfykVd4CWdPhSWIM56xpsbeghtlHFI/enmNb6PuI/T29S3W0EEN42uVugZ60
         knlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bO7Xs2fMtXdjJqlmDVk7bkjPabeiVg1xz712teaXtqI=;
        b=ueACnqPOl2d+fKgybpeVe65o2FN5Ue7jL0xCCPrhfwPn/nxvIXP9oNkIQGhTuN97tQ
         PlmEBLmOWAQ6a84bZB4zYBSGKWAJMETZZkhYWl/ApvOKJ6o28VTKR7TOe9CIbdbU1PV/
         NnuxaxJYLV9zVFY1D2Lsq++SVid+3XlZ26iNLg7sEoqecMlmS7qpB6ofItnlNWUctwa6
         GsKwc7ykzgqhTP/gfHgkC89ngdJA1n9TckxgkS9FbpHO+FxloMiP/84gWC3dyVfdh8H2
         LjfExEtznpq5us+MVH2WEI7DCvQqZnNfFY2qQtdv8hFCHyW2gTddL4643Nz4g4dFc4kb
         DRhw==
X-Gm-Message-State: AOUpUlFjgz0Ik4yEs0nMpOLhIel/sIQ+ObMYmB50iDOGYb+L2McVNRRf
        +8kw2YZHaqGN0Lkc2aGTOK8jXQ2NBgPv+zvmHNA=
X-Google-Smtp-Source: AAOMgpefHO65mOVwsLxXsuBt/4HHWrbjB2QUB1Tji/rVyiJ2OYoXauWksCYSQjhPLyS12VHfpOnrtMYjxL5c67n5Pnw=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr2167159ual.28.1531861178812;
 Tue, 17 Jul 2018 13:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:59:38
 -0700 (PDT)
In-Reply-To: <CADfjVriarrPnxixjun1g0m7izp4kMCvP4vXuPtNTth7_LWXrMA@mail.gmail.com>
References: <20180717145525.50852-1-colyli@suse.de> <20180717145525.50852-4-colyli@suse.de>
 <CADfjVriarrPnxixjun1g0m7izp4kMCvP4vXuPtNTth7_LWXrMA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Jul 2018 23:59:38 +0300
Message-ID: <CAHp75Ve7w8HxAcRXozsctFETuBtA0VD6jAsExEb6Wtq4UYRNAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] lib/test_crc: Add test cases for crc calculation
To:     Noah Massey <noah.massey@gmail.com>
Cc:     Coly Li <colyli@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 9:51 PM, Noah Massey <noah.massey@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 10:56 AM Coly Li <colyli@suse.de> wrote:

>> +               pr_info("test_crc: %s: PASSED:(0x%016llx, expected 0x%016llx)\n",
>> +                       name, crc, expval);
>
> I don't think we should have specific kernel output for passed tests.
> If a new test is added which follows this pattern, the 0-day will fail
> because the kernel output would change. Along the lines of "silence is
> golden", if no test hit the error output, we're good.

Agree.

>> +       if (err == 0)
>> +               pr_info("test_crc: all %d tests passed\n", i);
>
> Similar to previous comment: we should not report the number of passed
> tests, since adding a test would invalidate previous golden output.
> Also, consider the situation where some tests are conditionally
> executed depending on kconfig.

We do similar in many test modules and I know at least two that had
been changed in order to get new test cases.
Are you proposing to change 'em all?

-- 
With Best Regards,
Andy Shevchenko
