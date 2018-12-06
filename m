Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D16AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24B320989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24B320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeLFIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:54:12 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:43095 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:54:12 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 6 Dec 2018 17:54:09 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO WMRRD11NA101CK) (10.178.30.142)
        by 156.147.1.125 with ESMTP; 6 Dec 2018 17:54:09 +0900
X-Original-SENDERIP: 10.178.30.142
X-Original-MAILFROM: chanho.min@lge.com
From:   "Chanho Min" <chanho.min@lge.com>
To:     "'Oleg Nesterov'" <oleg@redhat.com>,
        "'Ingo Molnar'" <mingo@kernel.org>
Cc:     "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Linux List Kernel Mailing'" <linux-kernel@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Peter Zijlstra'" <a.p.zijlstra@chello.nl>,
        "'Pavel Machek'" <pavel@ucw.cz>,
        "'Michal Hocko'" <mhocko@suse.com>, <seungho1.park@lge.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com> <20181203074700.GA21240@gmail.com> <20181203115601.GA31795@redhat.com> <20181204091736.GD73770@gmail.com> <20181205143618.GA9535@redhat.com>
In-Reply-To: <20181205143618.GA9535@redhat.com>
Subject: RE: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
Date:   Thu, 6 Dec 2018 17:54:09 +0900
Message-ID: <02a901d48d41$40aff110$c20fd330$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIyDiMBIRrrGJHCkbd/uAm7qO0xxAFZXsAJAsWB798CKEutVQITr4gzpHOHoRA=
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Oleg Nesterov [mailto:oleg@redhat.com]
> Sent: Wednesday, December 05, 2018 11:36 PM
> To: Ingo Molnar
> Cc: Linus Torvalds; Linux List Kernel Mailing; Rafael J. Wysocki; Chanho Min;
> Thomas Gleixner; Peter Zijlstra; Pavel Machek; Michal Hocko
> Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
> 4.20-rc4)
> 
> Ingo, et al,
> 
> Sorry, I am sick and can't participate this discussion right now,
> 
> On 12/04, Ingo Molnar wrote:
> >
> > * Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > we really need to narrow the (huge) scope of ->cred_guard_mutex in exec
> paths.
> > >
> > > my attempt to fix this was nacked, and nobody suggested a better solution
> so far.
> >
> > Any link to your patch and the NAK?
> 
> See https://lore.kernel.org/lkml/20170213141452.GA30203@redhat.com/
> 
> No questions, the patch wasn't pretty. And imo we need to rework the security
> hooks in the long term.
> 
> Oleg.

I am sorry for the reverting this patch. It's also my fault that
I didn't check lockdep. But, We decided to keep this patch in our product.
Freeze fail is a real problem we've had for the last two years,
whereas lockdep's notice is not a real problem.
We hope this issue will be resolved soon.

Special thanks to Oleg,
Chanho

