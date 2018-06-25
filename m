Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFFA25E04
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFFA25E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeFYQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:16:33 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:51400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751958AbeFYQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:16:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EC7211805B2E2;
        Mon, 25 Jun 2018 16:16:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bone01_38c3c91ea2c33
X-Filterd-Recvd-Size: 4193
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 16:16:29 +0000 (UTC)
Message-ID: <263e7cee7dcc18db39f663cbc07b4985a1f8f891.camel@perches.com>
Subject: Re: checkpatch false positive (IMO): typo detected in truncated
 commit message
From:   Joe Perches <joe@perches.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jun 2018 09:16:28 -0700
In-Reply-To: <CAG48ez2y_T5RfjF8sjM=vQBzoTBgeXenwMdc=-DB9XE-Vi73-w@mail.gmail.com>
References: <CAG48ez02K0N6h-nfbnY81QAZoX1_gi4DTxuHxf1bSYiifu2v7g@mail.gmail.com>
         <35b62e21e0de223acae0f9f468212ee9638c3544.camel@perches.com>
         <CAG48ez3ZD3+j2oBJ7XHW9ycbi9_H8QsKGg8A84tOTisjeZGgiw@mail.gmail.com>
         <8f2948baf460575cde975a2cb5d11b960e8ae30f.camel@perches.com>
         <CAG48ez2y_T5RfjF8sjM=vQBzoTBgeXenwMdc=-DB9XE-Vi73-w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 17:49 +0200, Jann Horn wrote:
> On Mon, Jun 25, 2018 at 5:37 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Mon, 2018-06-25 at 17:32 +0200, Jann Horn wrote:
> > > On Mon, Jun 25, 2018 at 5:23 PM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > On Mon, 2018-06-25 at 17:22 +0200, Jann Horn wrote:
> > > > > Hello!
> > > > > 
> > > > > I got the following message from checkpatch:
> > > > > 
> > > > > =======
> > > > > $ scripts/checkpatch.pl
> > > > > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch
> > > > > WARNING: 'calle' may be misspelled - perhaps 'called'?
> > > > > #15:
> > > > > Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
> > > > > 
> > > > > total: 0 errors, 1 warnings, 0 checks, 20 lines checked
> > > > > 
> > > > > NOTE: For some of the reported defects, checkpatch may be able to
> > > > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > > > 
> > > > > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch has
> > > > > style problems, please review.
> > > > > 
> > > > > NOTE: If any of the errors are false positives, please report
> > > > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > > > =======
> > > > > 
> > > > > I believe that it is appropriate here to truncate the commit message
> > > > > of the fixed commit.
> > > > 
> > > > It's not.
> > > 
> > > Looking at a bunch of other recent commits, I'm guessing that the
> > > accepted format is to use the complete commit message, without
> > > linebreaks, even if it goes over 75 columns?
> > 
> > More common is to wrap the commit message on multiple lines.
> 
> Really? Even in the "Fixes:" line?
> 
> > For instance, the first commit match in -next:
> > 
> > $ git log --format=email --grep=commit -1
> > From 1421f2b6b1aac2379844ba27ba09b0dc37ec2daa Mon Sep 17 00:00:00 2001
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Date: Fri, 15 Jun 2018 09:43:47 +1000
> > Subject: [PATCH] kernel/kexec_file.c: add walk_system_ram_res_rev()
> > 
> > This function, being a variant of walk_system_ram_res() introduced in
> > commit 8c86e70acead ("resource: provide new functions to walk through
> > resources"), walks through a list of all the resources of System RAM in
> > [...]
> 
> I just grepped through Linus' tree for precedent on the "Fixes:" line;
> these are the first couple I found:
> 
> f5e350f021e04ea41d2e5d58487c33b05ba3d25b: overlong "Fixes:" line
> 6c6da92808442908287fae8ebb0ca041a52469f4: overlong "Fixes:" line
> 964d978433a4b9aa1368ff71227ca0027dd1e32f: overlong "Fixes:" line
> 71c8fc0c96abf8e53e74ed4d891d671e585f9076: overlong "Fixes:" line
> b5b7dd647f2d21b93f734ce890671cd908e69b0a: overlong "Fixes:" line


> So it looks like the consensus is to use the full commit message
> without truncation or linebreaks there?

Correct.

I didn't notice your patch was for a fixes: line.
Those are exempted from the long-line checkpatch test.


