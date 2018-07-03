Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EABC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655C424ED6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655C424ED6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeGCCKK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:10:10 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:41318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753608AbeGCCKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:10:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5B6B71821F426;
        Tue,  3 Jul 2018 02:10:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: worm14_7576c4f138416
X-Filterd-Recvd-Size: 2387
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Jul 2018 02:10:07 +0000 (UTC)
Message-ID: <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
From:   Joe Perches <joe@perches.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, peter.enderborg@sony.com,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 19:10:05 -0700
In-Reply-To: <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com>
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
         <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
         <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
         <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 21:15 -0400, Paul Moore wrote:
> On Mon, Jul 2, 2018 at 5:31 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2018-07-02 at 16:51 -0400, Paul Moore wrote:
> > > On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> > > > pr_fmt can be used with the pr_<level> macros to prefix
> > > > arbitrary content to logging messages.
> > > > 
> > > > So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> > > > that use pr_<level> and remove embedded "SELinux: " prefixes
> > > > from the format strings.
> > []
> > > What tree did you base your patch on?
> > 
> > next-20180619 on the day it was sent.
> > 
> > > Please base SELinux patches
> > > either on the SELinux tree or Linus' tree.  The SELinux tree can be
> > > found at the links below:
> > > 
> > > * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > > * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > 
> > It's almost always better to use selinux/next.
> > Why should this patch be different?
> 
> Yes, that's what I said, please base your patch against the selinux/next branch.

Again, this patch was based on that branch on the date the
patch was sent.

It still applies today to -next.

