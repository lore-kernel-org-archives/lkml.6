Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061CCC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A532B20893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A532B20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGZRy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731740AbeGZRy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:54:57 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87DFC20891;
        Thu, 26 Jul 2018 16:37:20 +0000 (UTC)
Date:   Thu, 26 Jul 2018 12:37:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180726123719.0db9dca0@gandalf.local.home>
In-Reply-To: <CAKwvOdknFPpyQx17EbixnydJukuX4kH8=xVTS_9qnsERKCoPkQ@mail.gmail.com>
References: <20180725202238.165314-1-salyzyn@android.com>
        <20180725210717.3b807191@vmware.local.home>
        <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
        <20180726112245.3c1bf91d@gandalf.local.home>
        <CAKwvOdknFPpyQx17EbixnydJukuX4kH8=xVTS_9qnsERKCoPkQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 09:32:07 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Jul 26, 2018 at 8:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 26 Jul 2018 08:14:08 -0700
> > Mark Salyzyn <salyzyn@android.com> wrote:
> >  
> > > Thank you Steve, much appreciated feedback, I have asked the security
> > > developers to keep this in mind and come up with a correct fix.
> > >
> > > The correct fix that meets your guidelines would _not_ be suitable for
> > > stable due to the invasiveness it sounds, only for the latest will such
> > > a rework make sense. As such, the fix proposed in this patch is the only
> > > one that meets the bar for stable patch simplicity, and merely(!) needs
> > > to state that if the fix is taken, perf and trace are broken.
> > >
> > > Posting this patch publicly on the lists, that may never be applied, may
> > > be the limit of our responsibility for a fix to stable kernel releases,
> > > to be optionally applied by vendors concerned with this CVE criteria?
> > >  
> >
> > The patch breaks the code it touches. It makes it useless.  
> 
> Doesn't that depend on kptr_restrict, or would it be broken if
> kptr_restrict was set to 0?

Is that what governs the output of kallsyms?

-- Steve
