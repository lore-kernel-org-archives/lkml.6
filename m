Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ED62085A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfAHAjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:39:02 -0500
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:51165 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbfAHAjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:39:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D05CA18224943;
        Tue,  8 Jan 2019 00:39:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk14_87efa7f585553
X-Filterd-Recvd-Size: 3023
Received: from XPS-9350 (unknown [172.56.44.85])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Jan 2019 00:38:53 +0000 (UTC)
Message-ID: <9bc80bb861899633ba93e6c81d36d2201b05936b.camel@perches.com>
Subject: Re: [PATCH v3] coding-style: Clarify the expectations around bool
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Date:   Mon, 07 Jan 2019 16:38:50 -0800
In-Reply-To: <20190107232513.GA5336@ziepe.ca>
References: <20190107211117.GA24142@ziepe.ca>
         <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
         <20190107232513.GA5336@ziepe.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 16:25 -0700, Jason Gunthorpe wrote:
> On Mon, Jan 07, 2019 at 02:10:22PM -0800, Joe Perches wrote:
> > On Mon, 2019-01-07 at 14:11 -0700, Jason Gunthorpe wrote:
> > > There has been some confusion since checkpatch started warning about bool
> > > use in structures, and people have been avoiding using it.
> > > 
> > > Many people feel there is still a legitimate place for bool in structures,
> > > so provide some guidance on bool usage derived from the entire thread that
> > > spawned the checkpatch warning.
> > 
> > Thanks Jason.
> > 
> > It'd be nice to combine this with some better checkpatch warning or
> > even a removal of that misleading warning from checkpatch
> > altogether.
> 
> Okay, do you have a preference?

Yes.
---
 scripts/checkpatch.pl | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 155fa9305166..cfe0396c9845 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6370,19 +6370,6 @@ sub process {
 			}
 		}
 
-# check for bool bitfields
-		if ($sline =~ /^.\s+bool\s*$Ident\s*:\s*\d+\s*;/) {
-			WARN("BOOL_BITFIELD",
-			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned int or u<8|16|32>\n" . $herecurr);
-		}
-
-# check for bool use in .h files
-		if ($realfile =~ /\.h$/ &&
-		    $sline =~ /^.\s+bool\s*$Ident\s*(?::\s*d+\s*)?;/) {
-			CHK("BOOL_MEMBER",
-			    "Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384\n" . $herecurr);
-		}
-
 # check for semaphores initialized locked
 		if ($line =~ /^.\s*sema_init.+,\W?0\W?\)/) {
 			WARN("CONSIDER_COMPLETION",


