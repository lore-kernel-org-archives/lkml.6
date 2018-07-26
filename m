Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC7FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EE9205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtLHxLmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EE9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbeGZSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:10:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33155 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbeGZSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:10:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so1527582pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwjGkkxbzIP3HexbpYWjbsytD7jTgi6TvX7HC75ZQGM=;
        b=DtLHxLmElBlcfwEwuaSpo9caDt4xhiuuRQOmd7/NwJtHYPgRUnhSJWnRFpspAasXZs
         S3t3EwAjfFMfzXiO5N1pyLe9NF10p7Ho8mMzrH3+dJg7XTuhXjy4lf0QUqSYubME+M2X
         e06lEEtOer/R7b91V38pBllBYXqCt2uDi+6Pfcdn6oSvESg5q7v9GK4abEHHrggEDWFu
         uDT9HIJYflHvbzmF1DkvlA5WdcPbq9SgjYuLxgiinkbJxEVWwz0l7beTfrGkFGFjvTiK
         aG5j2vUXa94cUKOEkFEHUOxVwWbXH6aJfrDA+8HI41ER5cydlCpsebWfkjI6VSQrnLMw
         IyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwjGkkxbzIP3HexbpYWjbsytD7jTgi6TvX7HC75ZQGM=;
        b=YRCsA1SXzd+tkDZW/i/L8kox/cAAu3QDTHv/19sKJ2XtCIE6vDtnMXJE7JQbVpQ32j
         XTMuajYCs3F1Zs8+CjtzbsSJCWUGhSa3XvwCv+m4w+SEWQ0Y4vEwdclJGqISniFkI/BH
         u4+lfVn1Eo0AdrKJMKGlDM01oRzYZ/o3aZBsGanZ5BE9JqOOElcVrCYgSyK8B8pG0tAP
         R9tTjuasA5PA725qLfUxC5baL6GSBI3sFsV94gWcVoQhu8H5RlQUH1dcayW1vJHzVIFe
         mrGpRR4JpubcC5GgVyWcO9eNlFjyMblbHg1X5kTxpSeAK9MiAHFaCa0WHQ/7BgykpYux
         zNew==
X-Gm-Message-State: AOUpUlEkJKT3Kuf/g1dP8rxl4P6qI/5o/T7Vr77WT8mHKhKQb7w9GVss
        RtgoaX6r5lRunqaJyGDPrJH+B6n2UTSLdfQTOIkedA==
X-Google-Smtp-Source: AAOMgpfDGG2sfNsIrrW7iHX+kjn158MEcgbUJ066j0HN95WA72JMHaSdT6Cf9sgIPgB+DcCZZUv7A2a37oljuWdJrKQ=
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr2664542pgz.192.1532623942398;
 Thu, 26 Jul 2018 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726153153.GA8327@kroah.com>
In-Reply-To: <20180726153153.GA8327@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Jul 2018 09:52:11 -0700
Message-ID: <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     greg@kroah.com, Kees Cook <keescook@google.com>
Cc:     salyzyn@android.com, rostedt@goodmis.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        kernel-team@android.com, stable@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 8:32 AM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jul 26, 2018 at 08:14:08AM -0700, Mark Salyzyn wrote:
> > On 07/25/2018 06:07 PM, Steven Rostedt wrote:
> > > On Wed, 25 Jul 2018 13:22:36 -0700
> > > Mark Salyzyn <salyzyn@android.com> wrote:
> > >
> > > > From: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > Switch from 0x%lx to 0x%pK to print the kernel addresses.
> > > >
> > > > Fixes: CVE-2017-0630
> > > Wait!!!! This breaks perf and trace-cmd! They require this to be able
> > > to print various strings in trace events. This file is root read only,
> > > as the CVE says.
> > >
> > > NAK for this fix. Come up with something that doesn't break perf and
> > > trace-cmd. That will not be trivial, as the format is stored in the
> > > ring buffer with an address, then referenced directly. It also handles
> > > trace_printk() functions that simply point to the string format itself.
> > >
> > > A fix would require having a pointer be the same that is referenced
> > > inside the kernel as well as in this file. Maybe make the format string
> > > placed in a location that doesn't leak where the rest of the kernel
> > > exists?
> > >
> > > -- Steve
> > Thank you Steve, much appreciated feedback, I have asked the security
> > developers to keep this in mind and come up with a correct fix.
> >
> > The correct fix that meets your guidelines would _not_ be suitable for
> > stable due to the invasiveness it sounds, only for the latest will such a
> > rework make sense. As such, the fix proposed in this patch is the only one
> > that meets the bar for stable patch simplicity, and merely(!) needs to state
> > that if the fix is taken, perf and trace are broken.
>
> Why would I take something for the stable trees that does not match what
> is upstream?  It feels to me that this CVE is just invalid.  Yes, root
> can read the kernel address, does that mean it is a problem?  Only if
> you allow unprotected users to run with root privileges :)
>
> What exactly is the problem here in the current kernel that you are
> trying to solve?

See the section "Kernel addresses" in
Documentation/security/self-protection.  IIRC, the issue is that a
process may have CAP_SYSLOG but not necessarily CAP_SYS_ADMIN (so it
can read dmesg, but not necessarily issue a sysctl to change
kptr_restrict), get compromised and used to leak kernel addresses,
which can then be used to defeat KASLR.

-- 
Thanks,
~Nick Desaulniers
