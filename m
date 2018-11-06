Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4050C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708A20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwLLGRg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B708A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeKFLwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:52:06 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36572 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeKFLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:52:05 -0500
Received: by mail-it1-f195.google.com with SMTP id w7-v6so15727199itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 18:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHfi2PHUegkJrR6TNpX+c3LLXBTzTzlLIYiwuawm08k=;
        b=PwLLGRg3RsfWj0UJ9/XTxQPUnDpYEQ8OwjJb82xFjqldrAH+WqfuLPmgfK4oF0MvMK
         UStHkC3urjCv18lb+F3+tz785PBsww1ZM9stiS0cqswBCSIQkEdN3DonFaz/D2wJzbKI
         uAvzqMvI9zqTSh9FfSpRlapAAIPUIXdI/hZP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHfi2PHUegkJrR6TNpX+c3LLXBTzTzlLIYiwuawm08k=;
        b=HQ7N1wUhP12nhUqb1sJkkVkkMUXVpgfq7/y5/jUJX2JoFZYajSFugNLS76O09o3CUp
         0O9hvgpFxJ1gZWpb64Y1H/JyXrOYqLSGrgoVdQ6Q/Gfc39wcCcaOgr/vcGxiLsDl2Zl+
         XDzJlRHZJZXF4gwkLG4v3Ap364yFq0diGYYk7adqlQyScQ4PpcpMUELyxi2porA2GYC2
         +4n1e68CnFhIJ6y2xzfxSVgHSfbfcPiO/Mbk+pUF2lZBPheRTveYlmsgZd04ITG52v8K
         F0svwMp2udgn3KeLSg8R3dHZX4AGAYoBJvoscqRdjMlgdlfMq0T3kkXNc2/9ppcnDfCl
         rlMQ==
X-Gm-Message-State: AGRZ1gIbmX+N28NimxO+AUGEzlUvRelhVU5nqXg4DzORH4UvM4pyyUNO
        iJd4GDOZchBfqlBo+YCp7LIM4TuHGjv/zrQKieF5KQ==
X-Google-Smtp-Source: AJdET5d6S3o2nkq75rFldwrS4jVPgZM8Fl9SEQGJkopWvT9hDq9owR9Iw+dMED6jbVYmLJ9MmmZE9isiOiXn9RHU1kA=
X-Received: by 2002:a24:430e:: with SMTP id s14-v6mr529184itb.83.1541471355961;
 Mon, 05 Nov 2018 18:29:15 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfK1AYn7LyF0ssAyFRGBJmCJEH6jP4+05RXR0n6+-udtDw@mail.gmail.com>
In-Reply-To: <CAMo8BfK1AYn7LyF0ssAyFRGBJmCJEH6jP4+05RXR0n6+-udtDw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 6 Nov 2018 07:59:04 +0530
Message-ID: <CALxhOni=HJ=88Hw3EqG9ayuEp4xTE0HfeEj3jgF8hrFBXLh3hQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] xtensa: move SYS_XTENSA_* macros to non uapi header
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Tue, 6 Nov 2018 at 02:59, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 1, 2018 at 6:56 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > All the SYS_XTENSA_* macros used by sysxtensa syscall
> > handlers are resides in the uapi header file move to
> > non uapi header asm/unistd.h as it is not used by any
> > user space applications.
>
> These definitions are meant to be used by the userspace to
> perform atomic operations in the absence of atomic access
> instructions in the xtensa CPU variant.

Ohh. I can revert these changes.
Thanks for your feedback.

Firoz

>
> --
> Thanks.
> -- Max
