Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44280C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33B620878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu40SnPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33B620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeLFRLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:11:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33781 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLFRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:11:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so1029037oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yePnYrJcSAK4+esNkdVus29dgqVz98C+LdFXdrYcJ2I=;
        b=Zu40SnPvPAgYkNLRi6XWyUPDjcC2xLzjl532BmUBc9IPPWh9JASbbEDwMFGCrfgma3
         810WW6DI6HL/jKX+5L7e3K1wAk4+2rJG+9p10U1NzYuAV6qDCv0wgck1Zf8EdieGf0pN
         scIqOZ2orJhVnv3KHGCKK4kUMg9gol2dNO2oh4uzaK9QYlzB1VyZTQoLSYUeywrN2C9R
         MHodWTUaT851288P7JAdz4A+kM+cuqmvBvz4W1+M+rS+zNRtqrUL1E9WEm0s5PY3BCnK
         KKwXNXhrBIC1mzMSG+KO1jgu8bVu2xdRchbxlKyX8i/rlGjh63payS1JsCyU7g2JP7OT
         46fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yePnYrJcSAK4+esNkdVus29dgqVz98C+LdFXdrYcJ2I=;
        b=APkMf/Yzw7WCFQ5afyP/UUqfPli7KDNDRxAf+eR+Sw2Ji8lXhM5M9WHbbOJDmTmoQk
         fLnBErvNZF8V8a8ziuK78jnhfL6GTznb7DfP5gz/7AHgo3NkfjPYh1KxQUPqQsA/0Lm/
         7KdJ9VyxeZgAHqcb6FaXtqF5IvibRNlI9myvgyS3lWb+/fLClTcLwmzFI+MpcqMNCy51
         7YfVeko9ngRRtaTwaH4rGo/+hF+QtVdWy5yxwHn2H+KOfgVWpLILjqBspKIop0QC71IS
         lsMN4Er/tnl9QgnLSHrta0/mdgq+kPw4lLBd1LsA8rIi1XcCxyNdroKF7k9kpIQR3ycN
         PNug==
X-Gm-Message-State: AA+aEWZ41Lr92uWYDJgilLcqDYaqhft7RT5uwCcFg0KO2ZzoyghNwonh
        48bPh7DH4IoCPQOqwH3XfJ0/F5OYyyLvFDOPCB0=
X-Google-Smtp-Source: AFSGD/WYfZRds1halERBVJ7cdKbIJFnsj94Pm0hDVnUt4nrBih1ZGVKtRm8PsZUBgOIKES58273YDq5UuAxkVqPJJNY=
X-Received: by 2002:aca:e3d3:: with SMTP id a202mr17025964oih.79.1544116308027;
 Thu, 06 Dec 2018 09:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
 <20181206150156.28210-2-david.abdurachmanov@gmail.com> <CAGXu5jKfnE_RJL7aA5x-qqYdA9zoTTtKwahg0r5fyW5GqFLgdA@mail.gmail.com>
In-Reply-To: <CAGXu5jKfnE_RJL7aA5x-qqYdA9zoTTtKwahg0r5fyW5GqFLgdA@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 6 Dec 2018 18:11:36 +0100
Message-ID: <CAEn-LTr5tUHCQfCaoJn1KBz1Yqs03MMO_n=Em-X87LK3b-AkOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: add support for SECCOMP incl. filters
To:     Kees Cook <keescook@chromium.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        luto@amacapital.net, Will Drewry <wad@chromium.org>,
        Green Hu <green.hu@gmail.com>, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 5:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> > The patch adds support for SECCOMP and SECCOMP_FILTER (BPF).
>
> Can you add support to tools/testing/selftests/seccomp/seccomp_bpf.c
> as well? That selftest finds a lot of weird corner-cases...
>
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> > index 1c9cc8389928..1fd6e4130cab 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -81,6 +81,7 @@ struct thread_info {
> >  #define TIF_MEMDIE             5       /* is terminating due to OOM killer */
> >  #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
> >  #define TIF_SYSCALL_AUDIT      7       /* syscall auditing */
> > +#define TIF_SECCOMP                    8       /* syscall secure computing */
>
> Nit: extra tab needs to be removed.

Will fix it.
I need to cleanup my vim configuration for tab with.

david
