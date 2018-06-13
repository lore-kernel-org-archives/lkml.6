Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D003C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0620891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD0620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935033AbeFMA3V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:29:21 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:38751 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934895AbeFMA3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:29:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1E7911822987B;
        Wed, 13 Jun 2018 00:29:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: balls37_6df65b0cd0736
X-Filterd-Recvd-Size: 3043
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Jun 2018 00:29:15 +0000 (UTC)
Message-ID: <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
From:   Joe Perches <joe@perches.com>
To:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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
Date:   Tue, 12 Jun 2018 17:29:14 -0700
In-Reply-To: <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
         <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
         <alpine.LRH.2.21.1806130631400.13763@namei.org>
         <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
> On Tue, Jun 12, 2018 at 4:32 PM, James Morris <jmorris@namei.org> wrote:
> > On Mon, 11 Jun 2018, Casey Schaufler wrote:
> > 
> > > If you want to break this up by security module I would take
> > > the Smack part as soon as James does the tree update. If James
> > > wants to take the whole thing at once you can add my:
> > > 
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > 
> > > for the Smack changes.
> > 
> > It's probably simplest for me to take them as one patch.
> 
> I would prefer if the SELinux changes were split into a separate
> patch.  I'm guessing John would probably want the same for the
> AppArmor patches, but take his work for it, not mine.
> 
> Joe, in general I really appreciate the fixes you send, but these
> patches that cross a lot of subsystem boundaries (this isn't the first
> one that does this) causes unnecessary conflicts in -next and during
> the merge window.  Could you split your patches up from now on please?

Sorry. No.  Merge conflicts are inherent in this system.

There is just no good way to do this as sending a set
of per subsystem patches guarantees partial application
of the entire set.

The nominal best way is for a script to be run and
applied at the top level rather than sending a patch
at all.

If you prefer, each sub-subsystem maintainer, at
whatever granularity desired, could apply the patch
to the appropriate subsystem by using
"git am --include=<subsystem_path>".

cheers, Joe
