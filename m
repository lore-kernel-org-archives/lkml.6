Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5F256C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14240208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFVbSxc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14240208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeFLQAV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933574AbeFLQAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:00:17 -0400
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com [209.85.128.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373F0208B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528819217;
        bh=SkSKIBQ5l1tGKE9gK7FfuVTXSTwDDWbmoDA6knuV4MU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lFVbSxc+5IomiweQKy6NrQQud97TRL7/sdYwd9cwwEr47KHOsFNP9JPXJ4rFJSnPT
         MbPAWWY27aVZQuL4crQRF352+xJX9VkQrrmCrENmV4IFvPhozXFY3C247Ta6Wq0PFN
         5XFEK6U4WLqk7mgambIj68AnKnVn0jS22xu0UgJ4=
Received: by mail-wr0-f177.google.com with SMTP id w10-v6so24655003wrk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:00:17 -0700 (PDT)
X-Gm-Message-State: APt69E1zeWLW/bkbkvaAsk8xWn1i0/h/gnKU9/Ogvpi7sgPYjdDHJM0t
        /Pw/T5vXjjDqr7cowS0SwSH9d7H3NbE01ld1IV2kfg==
X-Google-Smtp-Source: ADUXVKLOh3wvvKEO3n9pxcaz/w57rzt9U/K+rTv55aPv3ymKxDys04mikHUoKM0ng1gVSgMcUWKccWpGTFYrdMn+IHk=
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr791913wru.120.1528819215598;
 Tue, 12 Jun 2018 09:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
 <1528815820.8271.16.camel@2b52.sc.intel.com>
In-Reply-To: <1528815820.8271.16.camel@2b52.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jun 2018 09:00:03 -0700
X-Gmail-Original-Message-ID: <CALCETrXK6hypCb5sXwxWRKr=J6_7XtS6s5GB1WPBiqi79q8-8g@mail.gmail.com>
Message-ID: <CALCETrXK6hypCb5sXwxWRKr=J6_7XtS6s5GB1WPBiqi79q8-8g@mail.gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     bsingharora@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 8:06 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> >
> > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > This series introduces CET - Shadow stack
> > >
> > > At the high level, shadow stack is:
> > >
> > >     Allocated from a task's address space with vm_flags VM_SHSTK;
> > >     Its PTEs must be read-only and dirty;
> > >     Fixed sized, but the default size can be changed by sys admin.
> > >
> > > For a forked child, the shadow stack is duplicated when the next
> > > shadow stack access takes place.
> > >
> > > For a pthread child, a new shadow stack is allocated.
> > >
> > > The signal handler uses the same shadow stack as the main program.
> > >
> >
> > Even with sigaltstack()?
> >
> >
> > Balbir Singh.
>
> Yes.
>

I think we're going to need some provision to add an alternate signal
stack to handle the case where the shadow stack overflows.
