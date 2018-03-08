Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935996AbeCHRXR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:23:17 -0500
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:56198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932091AbeCHRXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:23:16 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7576:7903:9025:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12109:12438:12555:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:14777:21060:21080:21326:21365:21433:21627:30022:30046:30054:30060:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: hand17_738620811400e
X-Filterd-Recvd-Size: 2661
Message-ID: <1520529792.11634.12.camel@perches.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
From: Joe Perches <joe@perches.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Whitcroft <apw@canonical.com>, Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Date: Thu, 08 Mar 2018 09:23:12 -0800
In-Reply-To: <20180308170317.GE6773@mellanox.com>
References: <20180308164058.2ad5a158@canb.auug.org.au>
         <20180308161845.GC6773@mellanox.com> <1520527178.11634.9.camel@perches.com>
         <20180308170317.GE6773@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 10:03 -0700, Jason Gunthorpe wrote:
> On Thu, Mar 08, 2018 at 08:39:38AM -0800, Joe Perches wrote:
> > On Thu, 2018-03-08 at 09:18 -0700, Jason Gunthorpe wrote:
> > > On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Commit
> > > > 
> > > >   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> > > > 
> > > > is missing a Signed-off-by from its author.
> > > 
> > > Thanks Stephen,
> > > 
> > > May I suggest to the checkpatch maintainers that checkpack should look
> > > for this too?
> > 
> > No such commit in current -hext
> > $ git status HEAD
> > HEAD detached at next-20180308
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=aa0de36a40f446f5a21a7c1e677b98206e242edb
> 
> > checkpatch doesn't try to match email sender to sign-off
> > as the email sender doesn't have to sign-off on a patch.
> > 
> > It currently does:
> > 
> > 	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
> > 		ERROR("MISSING_SIGN_OFF",
> > 		      "Missing Signed-off-by: line(s)\n");
> > 	}
> 
> If I were to suggest an exact check it would be that the commit git
> author and commit git commiter both have signed-off-by lines,

The git commit committer can't be known by checkpatch.

It just looks at patches.

The original author of any patch can't be known either.

There is a mechanism to add a "From:" line that is
supposed to represent the sender of the patch, but that
person may not be the original author.
