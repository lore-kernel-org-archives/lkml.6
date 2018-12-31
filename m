Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E83C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4682133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SqN7DDP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeLaSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:18:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeLaSSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:18:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so24076514ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RLp7N2bv/VXzmKuxFVMgoVmav//VtI8k+vRHbVad/c=;
        b=SqN7DDP8mq5HNZCWaanDDALpbhYvnCRg9JT0BRikuXtxBCT3HOYgFS2moAlt/IbVGC
         oZI2r0EymfIDlP5wFQgKsqe5gyFrOZm85UE+3996LqeFgmpKXIHM/Q+A8nu6QmPheUuq
         cNYld69KQIkd+VbsxKDcylk2RBmaRtSi1PCdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RLp7N2bv/VXzmKuxFVMgoVmav//VtI8k+vRHbVad/c=;
        b=k5En55L1xSTRtRZeKDjF/Yy/v77/a2KAbNpjTaWWXCPvvmLAPNLCRuOFoOx33d9qp8
         tplxdhsz0QKbWhFtPyp7Ofhi8vM5c/8B/y4UvrsblJeIo52FLCsH6knlvPVxhdlValXk
         eEVgoJsk9rQ4CnR98uaximmD+UlGk+T0sIeOTmU+y4ltVU38V3HaT9Rz8vCqTxv2Adrn
         F6tFyIyUeyAQ+bYTSi8BqJEhFDXNUzMcsh0lMqzDrnFGcRUqIdHX9ax9ReiOzUBm3XNe
         s2JcIudbKHnEqefXEIDt3QAzJtq29dMFCrBFgwZNBsG1Q0xuBTRaY444KLlXIqzLlOxV
         tlTg==
X-Gm-Message-State: AA+aEWYFtsNF7gqMeYeCxzBjI6PtTsWGXB3zcgEGqk5GVIjYiUJ7MZNf
        H0SzgvWflZ3/FDJA7cEtA1Ewjn/Gp2g=
X-Google-Smtp-Source: ALg8bN7wZOlJcPu26Hy9OgbC8HrrnPmURsb7OIovJdKEvYNnczLGUVLENXbmCQZ6BFZHpXzChx8AjQ==
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr18305186lje.88.1546280279201;
        Mon, 31 Dec 2018 10:17:59 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 11sm9447202lfq.89.2018.12.31.10.17.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:17:58 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id l10so18652866lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:17:58 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr19897408lfg.117.1546280277768;
 Mon, 31 Dec 2018 10:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20181228182813.01ae131a@gandalf.local.home>
In-Reply-To: <20181228182813.01ae131a@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Dec 2018 10:17:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9rpBhJ9r_AH=RuvaD8u1V1VKpY8diqZtpqdToYRdCwA@mail.gmail.com>
Message-ID: <CAHk-=wh9rpBhJ9r_AH=RuvaD8u1V1VKpY8diqZtpqdToYRdCwA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Update for 4.21
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 3:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v4.21

No such tag.

> Tag SHA1: bcf1ea7cb12ce702d1d0660dfba0c3462c0b04e1
> Head SHA1: 3d739c1f6156c70eb0548aa288dcfbac9e0bd162

I can see branches with that commit SHA ("for-next" and "ftrace/core")
but there is no tag with that name or that SHA1.

Forgot to push out?

Btw, please don't include the whole diff in the same email when it's
~seven thousand lines and over 200k in size. Yeah, I'm on a fast
connection, but that isn't *always* true. Did lkml even take this
email?

                     Linus
