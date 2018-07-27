Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE1C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF00208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQLl5DEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF00208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeG0PC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:02:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36197 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbeG0PC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:02:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id n21-v6so9109190oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAbMEN+2DJ5S6xDdkEXDNicooV0nOiDd5RKj1as19k4=;
        b=EQLl5DEQLsB4PrKBBennCV3eoA0nXTWnxGGYC359EMZaxpFPKgOhV0nJ2+HkSKApYz
         m+EBqopMquBBEavCkXU48RnKymu4/uTMeybMyWGsEWok6UMwL4Du1HDPv0Y2wLpTJIiJ
         SQvW3Yz0OraXA1Wyy4GMKipVhx01Hngjt2+bNhFtz4pRa0myQzM97aNan+4mvIIa9j7P
         pCchDnFF93u5DCqcL/3w2LHx2cJ/16dIMjS8CMZUfmRCF7ivX4lVhuT85RlqeqYSm520
         dfpKL6r/fDzN0peqsnycq+XwdQ7SxcFVujfQK21W7EjCnEv4tRtDJe8hN4OhtMS1xQ9U
         LDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAbMEN+2DJ5S6xDdkEXDNicooV0nOiDd5RKj1as19k4=;
        b=NYiOmUkv7oigPA3UZGpe2EsdlrkfguMwq2WS+pEmkwjLY32BIoInUbjLc51OTpzfuL
         5cNY4q6wi/if8+Em/F1lbpT5Foz5CCHGXt8WIASXczRcWwayaKqGjKHjBHsZSIHBiZNx
         pLQkvScQZS5vL1dJsJ79hSw9mU3eP/bApA8IHEzDA9d6I8luKB3dm+Ti6EKsAua4S34A
         p3q0cwoLJpNpW5EVJiPnD9hRg74ZPOugduK+SLbKh4lOYe5bCcwX62MyD7h8hFa8C07R
         NrJQugQn2ZJX5yu0m0T4zncT+rRBZhMbecCYG8h52lL/JaQmswtlutGz6iDe2OscV9B/
         11bQ==
X-Gm-Message-State: AOUpUlHRUyU5H0QNP2EVw7b+ILbgDppmb0gy6XzbhNhFrAaviz1e32yD
        G44Dz6dsiKrsdpa+WaSRih7qj6JyimbBAti1oluiQA==
X-Google-Smtp-Source: AAOMgpeKXGYf/apDcmU6CvvWnZ4yhxcnpID50p48pmay5q4vEARRoFmTrB5yB7HU9lKgvK36BFsgiBkLW2bhrYZI5us=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr6142483oig.221.1532698859228;
 Fri, 27 Jul 2018 06:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726153153.GA8327@kroah.com>
 <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
 <20180726181558.25a5c3b8@gandalf.local.home> <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
In-Reply-To: <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 27 Jul 2018 15:40:32 +0200
Message-ID: <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     Golden_Miller83@protonmail.ch
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg KH <greg@kroah.com>, Kees Cook <keescook@google.com>,
        salyzyn@android.com, kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 2:07 PM Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
>
> On July 27, 2018 12:15 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu, 26 Jul 2018 09:52:11 -0700
> > Nick Desaulniers ndesaulniers@google.com wrote:
> >
> > > See the section "Kernel addresses" in
> > > Documentation/security/self-protection. IIRC, the issue is that a
> > > process may have CAP_SYSLOG but not necessarily CAP_SYS_ADMIN (so it
> > > can read dmesg, but not necessarily issue a sysctl to change
> > > kptr_restrict), get compromised and used to leak kernel addresses,
> > > which can then be used to defeat KASLR.
> >
> > But the code doesn't go to dmesg. It's only available
> > via /sys/kernel/debug/tracing/printk_formats which is only available
> > via root. Nobody else has access to that directory.
> >
> > -- Steve
>
> I think the point was that when we take capabilities into account the root
> privileges aren't unequivocal anymore. The 'root' owned process with only
> 'CAP_SYSLOG' shouldn't have access to /sys/kernel/debug/tracing/printk_formats

Then they shouldn't have access to debugfs at all, right?
