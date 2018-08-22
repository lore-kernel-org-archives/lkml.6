Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E85C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3487521486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3487521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHVTnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:43:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbeHVTnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:43:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F362BAF6C;
        Wed, 22 Aug 2018 16:17:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA3CE1E361C; Wed, 22 Aug 2018 18:17:41 +0200 (CEST)
Date:   Wed, 22 Aug 2018 18:17:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 1/2] fs/quota: Replace XQM_MAXQUOTAS usage with MAXQUOTAS
Message-ID: <20180822161741.GA2559@quack2.suse.cz>
References: <20180731013731.1987-1-jcline@redhat.com>
 <20180731013731.1987-2-jcline@redhat.com>
 <20180822160551.GE23037@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822160551.GE23037@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-08-18 18:05:51, Jan Kara wrote:
> On Tue 31-07-18 01:37:30, Jeremy Cline wrote:
> > XQM_MAXQUOTAS and MAXQUOTAS are, it appears, equivalent. Replace all
> > usage of XQM_MAXQUOTAS and remove it along with the unused XQM_*QUOTA
> > definitions.
> > 
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> 
> Thanks for the cleanup. The patch looks good, just one small nit:
> 
> > diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> > index 03d890b80ebc..a5846cde8272 100644
> > --- a/include/uapi/linux/dqblk_xfs.h
> > +++ b/include/uapi/linux/dqblk_xfs.h
> > @@ -27,11 +27,6 @@
> >  #define XQM_CMD(x)	(('X'<<8)+(x))	/* note: forms first QCMD argument */
> >  #define XQM_COMMAND(x)	(((x) & (0xff<<8)) == ('X'<<8))	/* test if for XFS */
> 
> You can delete XQM_COMMAND() as well here.
> 
> > -#define XQM_USRQUOTA	0	/* system call user quota type */
> > -#define XQM_GRPQUOTA	1	/* system call group quota type */
> > -#define XQM_PRJQUOTA	2	/* system call project quota type */
> > -#define XQM_MAXQUOTAS	3
> > -

Oh, now I've realized that these are actually from uapi header. I don't
think it's worth to break existing userspace sources just for a sake of
this small cleanup. So I'll just remove this hunk from the patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
