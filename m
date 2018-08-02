Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E098C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA7820862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Lh8ct7/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA7820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbeHBBvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:51:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57060 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbeHBBvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:51:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D374A8EE13D;
        Wed,  1 Aug 2018 17:03:26 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0AadFO385JDD; Wed,  1 Aug 2018 17:03:26 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4551B8EE079;
        Wed,  1 Aug 2018 17:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533168206;
        bh=qHs+q+7TA9fsBoWZ1bi4xsUdUqAOiWKyGUUiuCBDld4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Lh8ct7/m0fhfMOx//84fowpSNv9EntSrZA80ICBa7MVEHuHkjA4JQ/arjNp3Hy/Nw
         PEc4mIqTthoha5RX4D48w1MyWzVe2mWD0mlGvo/mCkvMr2LC0ilXD6zdiFEOlNrQhU
         ZpasVgjAQM2Fc0UhEZ/IfqeY5gzlh3kSeHNVo0us=
Message-ID: <1533168205.3158.12.camel@HansenPartnership.com>
Subject: Re: linux-next: Tree for Aug 1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <tom.leiming@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 01 Aug 2018 17:03:25 -0700
In-Reply-To: <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
References: <20180801175852.36549130@canb.auug.org.au>
         <20180801224813.GA13074@roeck-us.net>
         <1533163965.3158.1.camel@HansenPartnership.com>
         <20180801234727.GA3762@roeck-us.net>
         <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 07:57 +0800, Ming Lei wrote:
> On Thu, Aug 2, 2018 at 7:47 AM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> > On Wed, Aug 01, 2018 at 03:52:45PM -0700, James Bottomley wrote:
> > > On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
> > > > On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell
> > > > wrote:
> > > > > Hi all,
> > > > > 
> > > > > Changes since 20180731:
> > > > > 
> > > > > The pci tree gained a conflict against the pci-current tree.
> > > > > 
> > > > > The net-next tree gained a conflict against the bpf tree.
> > > > > 
> > > > > The block tree lost its build failure.
> > > > > 
> > > > > The staging tree still had its build failure due to an
> > > > > interaction
> > > > > with
> > > > > the vfs tree for which I disabled CONFIG_EROFS_FS.
> > > > > 
> > > > > The kspp tree lost its build failure.
> > > > > 
> > > > > Non-merge commits (relative to Linus' tree): 10070
> > > > >  9137 files changed, 417605 insertions(+), 179996 deletions(-
> > > > > )
> > > > > 
> > > > > -----------------------------------------------------------
> > > > > ------
> > > > > -----------
> > > > > 
> > > > 
> > > > The widespread kernel hang issues are still seen. I managed
> > > > to bisect it after working around the transient build failures.
> > > > Bisect log is attached below. Unfortunately, it doesn't help
> > > > much.
> > > > The culprit is reported as:
> > > > 
> > > > 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
> > > > 
> > > > The preceding merge,
> > > > 
> > > > 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
> > > > 
> > > > checks out fine, as does the tip of scsi-next (commit
> > > > 103c7b7e0184,
> > > > "Merge branch 'misc' into for-next"). No idea how to proceed.
> > > 
> > > This sounds like you may have a problem with this patch:
> > > 
> > >     commit d5038a13eca72fb216c07eb717169092e92284f1
> > >      Author: Johannes Thumshirn <jthumshirn@suse.de>
> > >      Date:   Wed Jul 4 10:53:56 2018 +0200
> > > 
> > >          scsi: core: switch to scsi-mq by default
> > > 
> > > To verify, boot with the additional kernel parameter
> > > 
> > > scsi_mod.use_blk_mq=0
> > > 
> > > Which will reverse the effect of the above patch.
> > > 
> > 
> > Yes, that fixes the problem.
> 
> That may not the root cause, given this issue is only started to
> see from next-20180731, but d5038a13eca7 (scsi: core: switch to
> scsi-mq by default)
> has been in -next for quite a while.
> 
> Seems something new causes this issue.

Read my other email about how to find this.

https://marc.info/?l=linux-scsi&m=153316446223676

Now that we've confirmed the issue, Gunter, could you attempt to bisect
it as that email describes?

Thanks,

James

