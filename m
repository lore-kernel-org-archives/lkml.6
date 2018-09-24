Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C2C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF42C20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF42C20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeIYFZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:25:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38518 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIYFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:25:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id z13-v6so11442060qts.5;
        Mon, 24 Sep 2018 16:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sntkWnum36qVZfBM72w1Jk/PN7SLij+DjkMsFYrgChk=;
        b=dqKvzwhfGb+2NfwrO30hgsPS87Ujjo+WAFR17n5ROuD7aWCpRQ1JVoK3805EKifTl4
         qb9oyTNkKsg0KfbkQ1aeYuhhsA3TPcWOxsZ2RfafEZC9/XTNEae/04lco6JQ9GxnXJ3t
         y9KKhbUd6CYR4AmmapHtSE0Qu7/r+68SoIZIbvJ16Z6CK2CS/D9P/cXwHKPmZXLSVInP
         5R6JOMMh5jZhYtZppJayrvji8YYX5jUsz4I37p/FuA2EswQuCACLQjVkdy0NQjXXmesv
         vVYnjPyHpqQF3vGfugXjAWvCYAknzSlL45yYJE1Z3NOlkNI/Ow7r+Hq1e0uCNjqCfKZg
         A91Q==
X-Gm-Message-State: ABuFfog9cWBLR78U+uYzOKegpxYD9UMDFlxryH3K9cAdi4s+zpGbZrLN
        fYbNCvpjGHfMNpErUdFkSH4n/o6DnHBZl4xJhfc=
X-Google-Smtp-Source: ACcGV60aEtu2inOmzwY1eByRX1HMfoBUgvfhX/AqrXTur0GXFapiEGsS2AEQIUQtXi/Q2nMpr4d8zitMI/teXTmxQQI=
X-Received: by 2002:a0c:ad8e:: with SMTP id w14-v6mr846714qvc.149.1537831238185;
 Mon, 24 Sep 2018 16:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-4-git-send-email-firoz.khan@linaro.org> <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
 <CALxhOngGqB2hY1MaEpTZvpgKTP9rwqbnMpgRKT9NQuZ4CXOcew@mail.gmail.com>
In-Reply-To: <CALxhOngGqB2hY1MaEpTZvpgKTP9rwqbnMpgRKT9NQuZ4CXOcew@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 01:20:21 +0200
Message-ID: <CAK8P3a0sYYzFyLLjfUuvWOijTsqpOnG2HGDA4nSRmR6YkM6W9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] microblaze: uapi header and system call table file generation
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 9:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> On 9 August 2018 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
> > On 9.8.2018 07:27, Firoz Khan wrote:

> >> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> >> index fe6a6c6..99225ab 100644
> >> --- a/arch/microblaze/include/asm/Kbuild
> >> +++ b/arch/microblaze/include/asm/Kbuild
> >> @@ -30,3 +30,5 @@ generic-y += trace_clock.h
> >>  generic-y += vga.h
> >>  generic-y += word-at-a-time.h
> >>  generic-y += xor.h
> >> +
> >> +generated-y += syscall_table.h
> >> \ No newline at end of file
> >
> > This doesn't look right.
>
> You mean I have to keep something like this?
>  generic-y += xor.h
> -
> -generated-y += syscall_table.h
> \ No newline at end of file
> +generic-y += syscall_table.h
> \ No newline at end of file

The "\ No newline at end of file" line is produced by
git format-patch when you have accidentally removed
the newline at the end. Most editors don't even allow
you to do that, so I don't know what went wrong.

       Arnd
