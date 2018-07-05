Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D655BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847E624171
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847E624171
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeGEHGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:06:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:44408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753021AbeGEHGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:06:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BF1CADFC;
        Thu,  5 Jul 2018 07:06:42 +0000 (UTC)
Date:   Thu, 5 Jul 2018 09:06:41 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com,
        syzbot <syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in rds_ib_get_mr
Message-ID: <20180705070641.ske6jjvk4zp5kg2f@linux-x5ow.site>
References: <089e082ce58896ad350567ee4825@google.com>
 <20180513211058.GE677@sol.localdomain>
 <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
 <20180704213506.GH725@sol.localdomain>
 <04c882dc-332e-92d6-fe76-b1dd3bedd71c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04c882dc-332e-92d6-fe76-b1dd3bedd71c@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 05:32:20PM -0700, santosh.shilimkar@oracle.com wrote:
> On 7/4/18 2:35 PM, Eric Biggers wrote:
> > On Sun, May 13, 2018 at 10:46:37PM -0700, santosh.shilimkar@oracle.com wrote:
> > > On 5/13/18 2:10 PM, Eric Biggers wrote:
> > > > On Wed, Mar 21, 2018 at 09:00:01AM -0700, syzbot wrote:
> > > 
> > > [...]
> > > 
> > > 
> > > > Still reproducible on Linus' tree (commit 66e1c94db3cd4) and linux-next
> > > > (next-20180511).  Here's a simplified reproducer:
> > > > 
> > > Thanks for the test case !!
> > > 
> 
> [...]
> 
> > 
> > Ping; this RDS bug is still unfixed.  The same reproducer I gave earlier still
> > works, even when run as a non-root user.  I tested upstream commit
> > fc36def997cfd6 (v4.18-rc3-113-gfc36def997cfd), and linux-next commit
> > bce40927669338 (next-20180704).
> > 
> Yeah I haven't sent a fix for this yet. Downstream we have refactored
> MR code and I wanted to get that upstream. With that this bug will
> also get addressed. I was hoping to get that series but since some
> optimisation is still pending investigations its getting delayed.
> 
> Will find out if I can fix this panic in meantime with smaller change.
> Thanks for reminder.

Oh please sent bug fixes _before_ refactoring in that area. Otherwise
it's a pain for everybody backporting the fix to a stable kernel.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
