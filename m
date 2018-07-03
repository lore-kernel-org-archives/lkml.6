Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0076C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AF422AAE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AF422AAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeGCCju (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:39:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:33826 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbeGCCjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:39:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w632ddCO017857;
        Mon, 2 Jul 2018 21:39:40 -0500
Message-ID: <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Tue, 03 Jul 2018 12:39:38 +1000
In-Reply-To: <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
         <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
         <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
         <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
         <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
         <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
         <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
         <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
         <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
         <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
         <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 19:26 -0700, Linus Torvalds wrote:
> On Mon, Jul 2, 2018 at 7:15 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > It's whitespace-damaged on purpose. It's probably broken shit. DO NOT
> > USE UNDER ANY CIRCUMSTANCES.  Think of it more as a "something like
> > this might work, but probably doesn't". Maybe it gives you an idea,
> > although that idea might be "Linus has finally lost it".
> 
> Even if it were to work, it should probably just be done inside kernfs
> and exposed as some kind of "kernfs_remove_if_empty()" function.

That would be harder, we'd have to expose it via a
kobject_del_if_empty() then.

Since we control completely when things are added/removed from the
gluedir and have a big fat mutex for it, I don't think locking is much
of an issue. At least in that specific case.

> We happen to know that we hold the lock that creates all the entries
> in the glue directory (and we don't allow users to move or create
> stuff, afaik, even if we alloc chmod etc), so there should be no
> races, but a generic kernfs helper function would probably have to get
> proper locks and check it the right way.

Yes that or document very clearly under what circumstances that
function can be used.

>                 Linus
