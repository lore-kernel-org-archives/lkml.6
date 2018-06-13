Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 18D93C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C373C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C373C208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbeFMTaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:30:24 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:50835 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751898AbeFMTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:30:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 24C5A837F27D;
        Wed, 13 Jun 2018 19:30:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: heart90_1fe954299fc0d
X-Filterd-Recvd-Size: 4733
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Jun 2018 19:30:19 +0000 (UTC)
Message-ID: <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
From:   Joe Perches <joe@perches.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Date:   Wed, 13 Jun 2018 12:30:17 -0700
In-Reply-To: <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
         <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
         <alpine.LRH.2.21.1806130631400.13763@namei.org>
         <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
         <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
         <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
         <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
         <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 12:19 -0400, Paul Moore wrote:
> On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
> > > On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
> > > > On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
> > > > > Joe, in general I really appreciate the fixes you send, but these
> > > > > patches that cross a lot of subsystem boundaries (this isn't the first
> > > > > one that does this) causes unnecessary conflicts in -next and during
> > > > > the merge window.  Could you split your patches up from now on please?
> > > > 
> > > > Sorry. No.  Merge conflicts are inherent in this system.
> > > 
> > > Yes, merge conflicts are inherent in this system when one makes a
> > > single change which impacts multiple subsystems, e.g. changing a core
> > > kernel function which is called by multiple subsystems.  However, that
> > > isn't what this patch does, it makes a number of self-contained
> > > changes across multiple subsystems; there are no cross-subsystem
> > > dependencies in this patch.  You are increasing the likelihood of
> > > conflicts for no good reason; that is why I'm asking you to split this
> > > patch and others like it.
> > 
> > No.  History shows with high certainty that splitting
> > patches like this across multiple subsystems of a primary
> > subsystem means that the entire patchset is not completely
> > applied.
> 
> I think that is due more to a lack of effort on the part of the patch
> author to keep pushing the individual patches.

Nope.  Try again.

Resistance to change and desire for status quo
occurs in many subsystems.

> > It's _much_ simpler and provides a generic mechanism to
> > get the entire patch applied to send a single patch to the
> > top level subsystem maintainer.
> 
> I understand it is simpler for you, but it is more difficult for everyone else.

Not true.

It's simply a matter of merge resolution being pushed down
where and when necessary.

See changes like the additions of the SPDX license tags.

> Further, where the LSMs are concerned, there is no "top level
> subsystem maintainer" anymore.  SELinux and AppArmor send pull
> requests directly to Linus.

MAINTAINERS-SECURITY SUBSYSTEM
MAINTAINERS-M:  James Morris <jmorris@namei.org>
MAINTAINERS-M:  "Serge E. Hallyn" <serge@hallyn.com>
MAINTAINERS-L:  linux-security-module@vger.kernel.org (suggested Cc:)
MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
MAINTAINERS-W:  http://kernsec.org/
MAINTAINERS-S:  Supported
MAINTAINERS:F:  security/
MAINTAINERS-

If James is not approving or merging security/selinux or
security/tomoyo then perhaps the F: entries could be
augmented with appropriate X: entries or made specific
by using specific entries like:

F:	security/*
F:	security/integrity/
F:	security/keys/

