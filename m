Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCEFC46475
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7798208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 23:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISx2D9M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7798208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeJGGdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 02:33:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42399 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJGGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 02:33:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so6548649pfn.9;
        Sat, 06 Oct 2018 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTD+V4rVUBJwtZym+oF530Q9EfXcZIu3tdedku3p7Kg=;
        b=ISx2D9M14LIVFbQ0shf8peb0josA6iv9Dg0jeGd2spvWmyDKBGfQFBPg3i+hrf+rHg
         jmphJXCxQyJSXcaec0EZ04G7tuQwyKcJR0f5uqHP4fuGEF2EDTM/FqCmuflYbyP38Wc0
         Gbt+SjbjjVcuo0IKvH7LWeLCRqzBz2JNqFoCXgIUpnS1S4sV1FtmqXJQL0ZJmI98xO08
         z1pC7/GNU686hxYSYns+pUQjQC9q8q0dPCjOygUUSmI8StITrVVHqyveCaIFcly6eKbt
         oC9ym+yc0tlltCyuutyz5GYJXR/OsdKnISXj5Uwz2Nx9iUCU10NbRt8FzRtDlpYh10d4
         L5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTD+V4rVUBJwtZym+oF530Q9EfXcZIu3tdedku3p7Kg=;
        b=AgdIk7AAHXWbW8u92b2xmAT4x/vsGf81/9yC0DdTa2oSByKAiYAtJJlEU+Y5Nm4Xlf
         EFxrjtLvcs+5sJMjThlESVg90coHN3lcZMgH30JmpZcak7d3as0cpsH0MDTZmobMAlXc
         xXI3y35jbyq8ZGxiIuSJvldkqPD/Ih46uCPjm0coHJvsiym8c3AU49Kwo1WS83qVnuRs
         KApAjjAhDOOBPmwx/2NM7YIa7lqHlLTxaBWG8kwAaXjIf9htzUeP8PoOuY1EDWfWojAI
         DYOKMRYY6YKXDtWW8W6kxgp6n9sk0X7bXJZf/FfoJbwcpEnoyy9R0SZt8OirCInJZc6G
         s4VA==
X-Gm-Message-State: ABuFfoggIfPPbu/zyEZBLTtH9QlK/yxtebAYEd05uxI/u9we+ezNJWUn
        UApSmpeVfOCix17pXE052JClKbHh6Gm1/hOh2n4=
X-Google-Smtp-Source: ACcGV62ProrkfAGv1TelZk9Mx2eJ4cENtGPrwGxH4tdr4DUTL3LOaDPe+QqcRh4oVCa+bGptjXSjwrFziMJIjd7gbX4=
X-Received: by 2002:a62:184a:: with SMTP id 71-v6mr18440653pfy.246.1538868474078;
 Sat, 06 Oct 2018 16:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
 <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com>
 <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com>
 <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com>
 <697659653.32427271.1538515234390.JavaMail.zimbra@redhat.com>
 <CAH2r5muV-vC6twZbNQQ3DHoXJTdaUwhzZi7YH+rhxr0BiMseJQ@mail.gmail.com>
 <633521295.32428133.1538517226400.JavaMail.zimbra@redhat.com>
 <CAH2r5mvXVDfYdJxPKLRJ0QAb_6mUHo4cfhxmkA7c19_GOR0p_Q@mail.gmail.com> <390397598.33123368.1538854368976.JavaMail.zimbra@redhat.com>
In-Reply-To: <390397598.33123368.1538854368976.JavaMail.zimbra@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 6 Oct 2018 18:27:42 -0500
Message-ID: <CAH2r5mtHr_EF+s0QwCxcUE_OG7x1yhbBPd0+ZhRXLqbQG4Ct4Q@mail.gmail.com>
Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
To:     rfreire@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe simplest approach to address your request is to add a less noisy
(pr_notice, or pr_info if you prefer) as xfs does in the example you
mentioned:

> xfs_log.c:              xfs_notice(mp, "Mounting V%d Filesystem",

Would be small addition to the following in cifs_debug.h

/* information message: e.g., configuration, major event */
#define cifs_dbg_func(ratefunc, type, fmt, ...)                 \
do {                                                            \
        if ((type) & FYI && cifsFYI & CIFS_INFO) {              \
                pr_debug_ ## ratefunc("%s: "                    \
                                fmt, __FILE__, ##__VA_ARGS__);  \
        } else if ((type) & VFS) {                              \
                pr_err_ ## ratefunc("CIFS VFS: "                \
                                 fmt, ##__VA_ARGS__);           \



On Sat, Oct 6, 2018 at 2:32 PM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Hi Steve! o/
>
> Appreciate your time and review.
>
> For a v3, what would you like more: a pr_info() straight away in the code
> for the message, or, writing a new cifs_info() function wrapping
> over pr_info, like we have in cifs_dbg (which translates to pr_debug or pr_err)?
>
> Waiting for your comments. Thanks!
>
> ---
> Rodrigo Freire - Principal Technical Account Manager
> GLOBAL CUSTOMER SUCCESS - Partnering with you to help achieve your business goals
> redhat.com | TRIED. TESTED. TRUSTED. | redhat.com/trusted
>
> ----- Original Message -----
>
> > From: "Steve French" <smfrench@gmail.com>
> > To: rfreire@redhat.com
> > Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> > <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel Shilovsky"
> > <piastryyy@gmail.com>
> > Sent: Saturday, October 6, 2018 4:09:30 PM
> > Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
>
> > On Tue, Oct 2, 2018 at 4:53 PM Rodrigo Freire <rfreire@redhat.com> wrote:
> > >
> > > Hi hi again Steve \o
> > >
> > > I do see potential for a ftrace rewrite for the cifs_dbg messages.
>
> > Was looking at this on current kernels and debugging mount is probably
> > fine for developers (or users) - plenty of debug messages get printed
> > via the dynamic ftrace points. In practice some would prefer less
> > noisy trace logs so the minimum set for some would be something like
> > this (which already works with current cifs). If we want to add some
> > default log messages on mount to dmesg instead of the trace-cmd log,
> > maybe we should log them at a slightly less noisy level (as we see
> > with xfs and btrfs) so they will be more log friendly




-- 
Thanks,

Steve
