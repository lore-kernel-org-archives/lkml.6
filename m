Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D65C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3828720894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Dhjt0RUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3828720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbeHBAtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:49:03 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56120 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbeHBAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:49:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 707108EE13D;
        Wed,  1 Aug 2018 16:00:55 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eltpNI_0z5zv; Wed,  1 Aug 2018 16:00:55 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DD73D8EE079;
        Wed,  1 Aug 2018 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533164455;
        bh=H/PPsmkDeYx1rpDTotXPISBNpOS/GDS7kPcyMwFvfOQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Dhjt0RUYGPvN6wqY97XUTY/UiUq0khlTQp+qPbEuvUhel4oKz9J+i2rQLMGApsagv
         dE91SqfO11Gad+oXmfOKr1N35mLibI+w2CbcYiSbu/7I2OBzsAkEeZFRlQ2v4xQE95
         cGyUFIKGtIE7l2wKItfsPx98Up9OBTj7pZpNhqwU=
Message-ID: <1533164454.3158.3.camel@HansenPartnership.com>
Subject: Re: linux-next: Tree for Aug 1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 01 Aug 2018 16:00:54 -0700
In-Reply-To: <1533163965.3158.1.camel@HansenPartnership.com>
References: <20180801175852.36549130@canb.auug.org.au>
         <20180801224813.GA13074@roeck-us.net>
         <1533163965.3158.1.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 15:52 -0700, James Bottomley wrote:
> On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
> > On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20180731:
> > > 
> > > The pci tree gained a conflict against the pci-current tree.
> > > 
> > > The net-next tree gained a conflict against the bpf tree.
> > > 
> > > The block tree lost its build failure.
> > > 
> > > The staging tree still had its build failure due to an
> > > interaction
> > > with
> > > the vfs tree for which I disabled CONFIG_EROFS_FS.
> > > 
> > > The kspp tree lost its build failure.
> > > 
> > > Non-merge commits (relative to Linus' tree): 10070
> > >  9137 files changed, 417605 insertions(+), 179996 deletions(-)
> > > 
> > > -----------------------------------------------------------------
> > > -----------
> > > 
> > 
> > The widespread kernel hang issues are still seen. I managed
> > to bisect it after working around the transient build failures.
> > Bisect log is attached below. Unfortunately, it doesn't help much.
> > The culprit is reported as:
> > 
> > 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
> > 
> > The preceding merge,
> > 
> > 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
> > 
> > checks out fine, as does the tip of scsi-next (commit 103c7b7e0184,
> > "Merge branch 'misc' into for-next"). No idea how to proceed.

So what seems to be happening to cause this is that there's a patch
somewhere between the merge base of my scsi-next series and the next
tree and the patch just before scsi-next was actually merged that
actually causes a boot failure with blk-mq enabled.  Could you try to
find this patch?  I think the way to do it is to try to bisect this
range of linux-next using the command line

scsi_mod.use_blk_mq=1

Which forces block mq to be the default and seeing where the first boot
failure is (you don't need my scsi-next tree merged to do this because
all the offending patch does is flip the default state of the above
flag).

James

