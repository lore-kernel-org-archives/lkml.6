Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2808A20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="Zc93aDoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2808A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeKSVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:12:57 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:64543 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeKSVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:12:57 -0500
Date:   Mon, 19 Nov 2018 10:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1542624575;
        bh=XHB77YYF/OozDjNoEgCgyfUGNJ3ohuq/u8j/uxT2WPs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Zc93aDoIMcKd1Sg4xYeKebwG/nQPEBv33UEdZtXFyKiChRBJ+YSVW80aWxt28NPdT
         6ISjG3EcmJtseo5MbUhEt+bLwEPyPBWpnCPBwdPvltU8dR2nUMJZmUngM2XfRJbj+F
         YHdoI8v0qRomczGdK1ZvVCz5MkR+wAqGaMqDSVxM=
To:     Peter Zijlstra <peterz@infradead.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v1 2/2]: Documentation/admin-guide: introduce perf-security.rst file
Message-ID: <n06wPuXrWqZEywcNe2BID7GP8dShJlE4L4oLpxO9__duA3noKJO_maOemZwZGC7EHCW7Ur14war-RqLo5pco9uruYaGJMCPOyRVzPJrZyz4=@protonmail.ch>
In-Reply-To: <20181119104646.GB9761@hirez.programming.kicks-ass.net>
References: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
 <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
 <aDN4nC6p93nK7ILVP3EH-Y4RcKK4KH0ppQKFkIgxTVxkfbOHWjAYJXdTeuq39nbPkySKItZ_8VHN2PfQS_T08GBzeooD5cvc2Xd8oZxSp9s=@protonmail.ch>
 <20181119104646.GB9761@hirez.programming.kicks-ass.net>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 19, 2018 11:46 AM, Peter Zijlstra <peterz@infradead.org=
> wrote:

> On Mon, Nov 19, 2018 at 10:35:59AM +0000, Jordan Glover wrote:
>
> > On Monday, November 19, 2018 6:42 AM, Alexey Budankov alexey.budankov@l=
inux.intel.com wrote:
> >
> > > +>=3D3:
> > >
> > > -         Restrict *access* to PCL performance monitoring for unprivi=
leged processes.
> > >
> > >
> > > -         This is the default on Debian and Android [7]_ , [8]_ .
> > >
> > >
> >
> > AFAIK there is no support for '+>=3D3' in mainline kernel[1].
> > Debian and Android use out-of-tree patch for that[2].
> > Maybe someone should upstream it?
>
> NAK still stands on that. Alternative's have been proposed but so far
> nobody that cared seems to care enough to implement those.

So, I guess we can't document NAKed patches :)

Jordan

