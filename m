Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F77C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED9A208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED9A208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeG0L6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:58:02 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:53274 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730026AbeG0L6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:58:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4C83014D37;
        Fri, 27 Jul 2018 10:36:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: color66_749997c5a6d5c
X-Filterd-Recvd-Size: 2639
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 10:36:41 +0000 (UTC)
Message-ID: <1a75fda0861a0b2bce208fbf9b53785bf0e76fa2.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>
Date:   Fri, 27 Jul 2018 03:36:39 -0700
In-Reply-To: <9f0377fa74bd4964912ba5a4fc76526d@AcuMS.aculab.com>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
         <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
         <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
         <9d7441a14897426f8ed5befe8da0cad3@AcuMS.aculab.com>
         <0a6d2ecfacf3786228de664c8e01f6de10314c1b.camel@perches.com>
         <9f0377fa74bd4964912ba5a4fc76526d@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 10:21 +0000, David Laight wrote:
> From: Joe Perches Sent: 27 July 2018 11:09
> > On Fri, 2018-07-27 at 10:04 +0000, David Laight wrote:
> > > From: Andrew Morton Sent: 26 July 2018 20:28
> > > > On Thu, 26 Jul 2018 12:25:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > 
> > > > > I'll give it a spin, see how noisy it is.
> > > > 
> > > > Actually, I would prefer if the message, changelog and title
> > > > used the term "passed by value".  It's a more familiar term
> > > > and it is possible for a passed-by-value aggregate to in fact
> > > > be passed in registers.
> > > 
> > > You need to detect (and ignore) 'small' structures.
> > 
> > checkpatch is stupid and basically can't do that
> > as it has no context other than the current line.
> > 
> > It would need a list of specific struct types to
> > ignore.  Care to create and send that list to me?
> 
> Does it even have the type?

Yes, kinda.  But only on the line being matched.

i.e.: <const> [struct or union] [type] [name]

> If it has the prototype it could ignore aggregates that
> are marked 'const'.

checkpatch has no visibility of any prototype.

It might make sense for this sort of check to be
added to coccinelle or maybe as a compiler warning
when the struct is larger than some size.

Original thread for Julia:
https://lore.kernel.org/patchwork/patch/967890/

