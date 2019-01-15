Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2992C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBEF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFzq3jSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfAOAkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:40:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36515 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfAOAkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:40:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so419289pgm.3;
        Mon, 14 Jan 2019 16:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KYdEe7mCbCLkq6/hMQNg7hfiL2DeDnOSEiu87HS7RTE=;
        b=rFzq3jSWMUUh19/zwgJFGyUS+zuCcqgv7uRUyqaAvh7G3T9rysLqbxg+0Wj1e/6lhK
         JVDYdXv1K6asf9OQlRagqAHhIcT53GDxtYclhZeXmYtE0fixpqXQQqcP4GrCbS1TOgxR
         97hf+Ov33hIixs2PlTP0Yq7zUpxlyX69JdnaaUf1ShvngsZ5rspfaDVhTwPSs5VmcLIh
         ntcxvDKxTRGxkeoa5vW+UDt3y/jU6DBkWm9D1ch8l3nJfWWNQWaAlbvfhrvQxR+F8ttQ
         86bMwP2gOU2fQGfgan8WCOBQFXUXo9PYrssqXboE98cPwoeTVBMp+NB1IoyDrpCfCpNG
         CRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KYdEe7mCbCLkq6/hMQNg7hfiL2DeDnOSEiu87HS7RTE=;
        b=MnOQwWl4X7x2ul9aZwSS1EVFewkQBcK7EtShheb3z0dUmPZY0fjztnRQZnM33nbpED
         /5xdrUUpzm8bMunh7+jER8OGncQBK6m0uh2ifjgWaLgEHuaOYt3ck54XYzwpIWc5vt9N
         vXpOudc8Qk5XauKYG7XS0Fgxgl2L+2my1KzlxTVvFRP9Dv/pXgmy8uZ+sMC+FVX0f5dK
         dT3mAqa7m5ddjDiCwiwfcom4ic4QAPeBF3x+DEjDopZ0Q480mWs2wEqDJV1G9X008S6N
         P2nHmibbogUX5niHsaqjPcShLeeOdGJiGHcPYPZvSi36FkBbsGuxhNwP6we5j0nDJhU4
         Qm7A==
X-Gm-Message-State: AJcUukcCsdklFMJBTq0W51S3xbPJ1rlH8x/A8GQ1wjeDV39yF1Ee7pjv
        8P4xlIEqvmYEEMS1H152+mc=
X-Google-Smtp-Source: ALg8bN6ItbUo+xZlAQ5lQzc/bCN/gsW4B/u0qepCmTUquTg7JDHPUspxYxjq0dzN90Hr+Gu8Dpzsvg==
X-Received: by 2002:a63:5455:: with SMTP id e21mr1209256pgm.316.1547512810746;
        Mon, 14 Jan 2019 16:40:10 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id w23sm1794966pgc.72.2019.01.14.16.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:40:10 -0800 (PST)
Date:   Tue, 15 Jan 2019 08:40:02 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, linux@armlinux.org.uk,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190115004001.hm4arwq5oxhr6up5@mail.google.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
 <20190114112115.1cbf21c0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114112115.1cbf21c0@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
On Mon, Jan 14, 2019 at 11:21:15AM -0500, Steven Rostedt wrote:
> On Sat, 12 Jan 2019 14:57:01 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that kernel doesn't know the prototype of functions. So
> > fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> > 
> > In this patch, only x86 and ARM platforms are supported.
> > 
> > Here is example showing the error is caused by vmx_create_vcpu() and the
> > error code is -5 (-EIO).
> > 
> > with echo 1 > /sys/kernel/debug/tracing/options/funcgraph-retval
> > 
> >  3)               |  kvm_vm_ioctl() {
> >  3)               |    mutex_lock() {
> >  3)               |      _cond_resched() {
> >  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
> >  3)   0.704 us    |      } /* ret=0x0 */
> >  3)   1.226 us    |    } /* ret=0x0 */
> >  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> >  3)               |    kvm_arch_vcpu_create() {
> >  3)               |      vmx_create_vcpu() {
> >  3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
> >  3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
> >  3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
> >  3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
> >  3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
> >  3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
> >  3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
> >  3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
> >  3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
> >  3)               |    mutex_lock() {
> >  3)               |      _cond_resched() {
> >  3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
> >  3)   0.594 us    |      } /* ret=0x0 */
> >  3)   1.067 us    |    } /* ret=0x0 */
> >  3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> >  3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >
> 
> Hi Changbin,
> 
> I'm rewriting a lot of the function graph tracer code to have
> kretprobes be able to work on top of it. It's still a work in progress.
> It would be easier to add something to that work when its done than to
> do it now.
> 
I cann't wait to see it! I can rebase my cheanges after your work. Thanks!

> Thanks!
> 
> -- Steve

-- 
Cheers,
Changbin Du
