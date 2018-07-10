Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A001A20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IJAtsCCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A001A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933534AbeGJO0s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:26:48 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42656 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933280AbeGJO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:26:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CFB688EE409;
        Tue, 10 Jul 2018 07:26:46 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bx3SJSQFHqLb; Tue, 10 Jul 2018 07:26:46 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 43B628EE055;
        Tue, 10 Jul 2018 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1531232806;
        bh=WzSB94h0OHQ5da2/P6RX9GqsBTSFYxyd/0ztpYrye5Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IJAtsCCfJNo8hMLnBAUkgOjSqkHWLoUe3L0L+kshpqL2r8JjezWdZ+9KHFNj4IzgG
         SRpN7VO2kSccplneIaCOR1LwLUBhEaUOszRI5hIWfO+taWydst00IfBwrAGMxaS3mv
         ZxatVVRphhk6arqlfJeBYl1dTAozjaO2jgY6+bU8=
Message-ID: <1531232805.4963.11.camel@HansenPartnership.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>
Date:   Tue, 10 Jul 2018 07:26:45 -0700
In-Reply-To: <3f0359a5-6733-f9d3-a616-d27ce430c904@kernel.dk>
References: <20180620132911.5f6ab464@canb.auug.org.au>
         <20180710173114.17ee69ad@canb.auug.org.au>
         <280ebbdf-fafb-1744-f517-815a30e682bb@kernel.dk>
         <1531232063.4963.8.camel@HansenPartnership.com>
         <3f0359a5-6733-f9d3-a616-d27ce430c904@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 08:22 -0600, Jens Axboe wrote:
> On 7/10/18 8:14 AM, James Bottomley wrote:
> > On Tue, 2018-07-10 at 08:09 -0600, Jens Axboe wrote:
> > > On 7/10/18 1:31 AM, Stephen Rothwell wrote:
> > 
> > [...]
> > > > I am still seeing these warnings ...
> > > 
> > > Martin queued up the forward declaration patch for this one, not
> > > sure
> > > why it isn't showing up in the scsi tree yet.
> > 
> > All the trees are fully up to date ... which commit is it?
> 
> It's a patch from Arnd, I don't know what commit id it is. But
> Martin replied a few days ago that it was applied. I don't have
> the email handy, though.

You mean

Message-Id:	<20180706201920.2185565-1-arnd@arndb.de>
Subject:	[PATCH] [v2] sbitmap, scsi/target: add seq_file forward declaration

?

Martin didn't reply and it's not yet in his tree, although I'm sure it
will be soon.

James

