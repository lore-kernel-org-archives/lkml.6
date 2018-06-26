Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D17AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAE5208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAE5208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeFZXEj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:04:39 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:46815 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933304AbeFZXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:04:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 04CCA181D3368;
        Tue, 26 Jun 2018 23:04:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slope63_283a0ed56dd3a
X-Filterd-Recvd-Size: 2726
Received: from XPS-9350 (unknown [172.58.27.131])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 23:04:36 +0000 (UTC)
Message-ID: <56a7221b36f3969d340c72bac34942dd59cdc47f.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dzickus@redhat.com, jtoppins@redhat.com
Date:   Tue, 26 Jun 2018 16:04:31 -0700
In-Reply-To: <98fe3602-864a-3963-ac56-a743f1b61700@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <98fe3602-864a-3963-ac56-a743f1b61700@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 18:52 -0400, Prarit Bhargava wrote:
> 
> On 06/26/2018 04:16 PM, Joe Perches wrote:
> > On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
> > > OSes have additional maintainers that should be cc'd on patches or may
> > > want to circulate internal patches.
> > > 
> > > Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
> > > can begin with a '+' to indicate the email and list entries should be
> > > added to the exiting MAINTAINERS output, or a '-' to indicate that the
> > > entries should override the existing MAINTAINERS file.
> > > 
> > > Also add a help entry for the .get_maintainers.ignore file.
> > 
> > I see no reason for this patch to be applied.
> > Why should it?
> 
> The kernel has other vendor/OS changes like my patch, for example, 4efb442cc12e
> ("kernel/panic.c: add TAINT_AUX").  From that commit message
> 
>     Add an auxiliary taint flag to be used by distros and others.  This
>     obviates the need to forward-port whatever internal solutions people
>     have in favor of a single flag which they can map arbitrarily to a
>     definition of their pleasing.
> 
> The same principle should be applied to my patch in that distros no longer would
> need to forward-port internal solutions similar to this.
> 
> > Why shouldn't this be in your private repository?
> 
> If you don't want it I'll carry it forward but that's a loss for both of us, and
> as pointed out in the above commit, other distros.  If you do want to reject the
> patch please let me know and I'll only submit the "get_maintainer.ignore" help
> chunk.

I doubt it's a really a loss for others as whatever
.get_maintainers.<foo> files would likely need to
be customized for each distro.

I think the whole thing should be ignored.
