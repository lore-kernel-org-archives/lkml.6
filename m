Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A90C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A62080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzS47Rt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0A62080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbeKVJZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:25:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33887 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390288AbeKVJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:25:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so5950629oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3FMEDsZInXhnswagiHhBthQ6heysrNaLGS/9ZfO7uw=;
        b=VzS47Rt66GFvNWfCDJ1DW/b0qFkwE7ib46Do+PS92hb5mTKPxFPj0KwoGl2+V/1nuP
         GojHCWtpSuW0JtcEnCk15qGvA/XiDmlNL6xQ9OD82Lc69vdfWTXsmvpUqWWU1fwGcQn0
         7iG6mmLB8nSSC8bpaxQMHMaYuROj9hML44D1ixk5fDbjXUNInYbnkm6fvKHqpkoUdnor
         PqywlqMs3oyKhdJSVL1CyfbBBwTqOLTpU3FZFOimqQxD6kvALu04ekmXu9pHpwHdQw3K
         gSMfDQqX+WhdmqjpvtsmFK/MWFvkvvj2N6U8uL9WHTDDEXSYEPcb1h2ucumFBHIBHXuc
         SHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3FMEDsZInXhnswagiHhBthQ6heysrNaLGS/9ZfO7uw=;
        b=auPLNRK9k7OLkiFJGrjyj5jRZy/3AgPQQPW9gx1g+71ym2WaWMxyXMOcL9fA6FwZHy
         w51XV7TWKPS6iwF/heJHRV4m+GEE9ki24f/qOfA5PFr30KDPnoELUDPeWSC+Vmu6p+4l
         hYVkAhvPQcpAv51ktBKhvLHTYMioNowXuq68PN+GQs/RuIUiPF5PNQVwgke2XPE3lbMj
         AQA0HDj0v1q26AVZVO+NAzEJKfnQ12yG8dGAX+t25ZKrWnelU++jLLspEns54WuYaDv3
         7kIBS9Dy46RlnNGMj2Ic4UaxV+seCdhVQyr1lUVPY4XnhbJlxI588xlMPTnfXECA85qV
         ccNg==
X-Gm-Message-State: AGRZ1gJhcqzdPZPfS+KGN0vGVd0F8j6Pkzce8jJmYcfdYh9Gh+v8CixB
        brJAdqAtZf4K4ahzEIWJjhgxgFf8zLwY+cszGE9CPrW+BdQ=
X-Google-Smtp-Source: AJdET5dIuffKwcytEzOvewd47/n+DDj/gOQUkVaZ+6JH8NgrWwulKw66ocQJH2jBtvXYdgf4nlIMfBhpRMknD75ulwU=
X-Received: by 2002:aca:c413:: with SMTP id u19mr4484546oif.209.1542840551558;
 Wed, 21 Nov 2018 14:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org> <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
In-Reply-To: <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 21 Nov 2018 23:48:45 +0100
Message-ID: <CAG48ez3kgFC74jTmxqL5aPgmqcN-W4E9bR7Fz3V=Vt4qkpx2Pg@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>, primiano@google.com,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, guro@fb.com,
        pdhamdhe@redhat.com, dennisszhou@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux@dominikbrodowski.net,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:40 PM Daniel Colascione <dancol@google.com> wrote:
> On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed, 21 Nov 2018 12:54:20 -0800 Daniel Colascione <dancol@google.com> wrote:
> > > +u64 read_pid_generation(struct pid_namespace *ns)
> > > +{
> > > +     u64 generation;
> > > +
> > > +
> > > +     spin_lock_irq(&pidmap_lock);
> > > +     generation = ns->generation;
> > > +     spin_unlock_irq(&pidmap_lock);
> > > +     return generation;
> > > +}
> >
> > What is the spinlocking in here for?  afaict the only purpose it serves
> > is to make the 64-bit read atomic, so it isn't needed on 32-bit?
>
> ITYM the spinlock is necessary *only* on 32-bit, since 64-bit
> architectures have atomic 64-bit reads, and 64-bit reads on 32-bit
> architectures can tear. This function isn't a particularly hot path,
> so I thought consistency across architectures would be more valuable
> than avoiding the lock on some systems.

Linux has atomic64_t/atomic64_read()/atomic64_inc() for this, which
should automatically do the right thing - processor-supported atomic
ops when possible, spinlock otherwise.
