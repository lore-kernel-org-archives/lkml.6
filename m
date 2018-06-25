Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C767C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E910D25CFA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E910D25CFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeFYPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:37:52 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:38946 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751631AbeFYPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:37:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9AD38181D330D;
        Mon, 25 Jun 2018 15:37:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fish20_a1f559606862
X-Filterd-Recvd-Size: 2987
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 15:37:49 +0000 (UTC)
Message-ID: <8f2948baf460575cde975a2cb5d11b960e8ae30f.camel@perches.com>
Subject: Re: checkpatch false positive (IMO): typo detected in truncated
 commit message
From:   Joe Perches <joe@perches.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jun 2018 08:37:48 -0700
In-Reply-To: <CAG48ez3ZD3+j2oBJ7XHW9ycbi9_H8QsKGg8A84tOTisjeZGgiw@mail.gmail.com>
References: <CAG48ez02K0N6h-nfbnY81QAZoX1_gi4DTxuHxf1bSYiifu2v7g@mail.gmail.com>
         <35b62e21e0de223acae0f9f468212ee9638c3544.camel@perches.com>
         <CAG48ez3ZD3+j2oBJ7XHW9ycbi9_H8QsKGg8A84tOTisjeZGgiw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 17:32 +0200, Jann Horn wrote:
> On Mon, Jun 25, 2018 at 5:23 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Mon, 2018-06-25 at 17:22 +0200, Jann Horn wrote:
> > > Hello!
> > > 
> > > I got the following message from checkpatch:
> > > 
> > > =======
> > > $ scripts/checkpatch.pl
> > > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch
> > > WARNING: 'calle' may be misspelled - perhaps 'called'?
> > > #15:
> > > Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
> > > 
> > > total: 0 errors, 1 warnings, 0 checks, 20 lines checked
> > > 
> > > NOTE: For some of the reported defects, checkpatch may be able to
> > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > 
> > > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch has
> > > style problems, please review.
> > > 
> > > NOTE: If any of the errors are false positives, please report
> > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > =======
> > > 
> > > I believe that it is appropriate here to truncate the commit message
> > > of the fixed commit.
> > 
> > It's not.
> 
> Looking at a bunch of other recent commits, I'm guessing that the
> accepted format is to use the complete commit message, without
> linebreaks, even if it goes over 75 columns?

More common is to wrap the commit message on multiple lines.

For instance, the first commit match in -next:

$ git log --format=email --grep=commit -1
From 1421f2b6b1aac2379844ba27ba09b0dc37ec2daa Mon Sep 17 00:00:00 2001
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Fri, 15 Jun 2018 09:43:47 +1000
Subject: [PATCH] kernel/kexec_file.c: add walk_system_ram_res_rev()

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM in
[...]

