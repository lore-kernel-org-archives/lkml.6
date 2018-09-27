Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11161C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C584020836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C584020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeI0Nf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:35:26 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:41638 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbeI0Nf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:35:26 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 6D42813F784; Thu, 27 Sep 2018 09:18:36 +0200 (CEST)
Date:   Thu, 27 Sep 2018 09:18:36 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180927071836.GU16802@BitWizard.nl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
 <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
 <20180925223054.GH2933@thunk.org>
 <20180926191055.6fc1514f@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191055.6fc1514f@alans-desktop>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:10:55PM +0100, Alan Cox wrote:
> > And I think that's fine.  The only way we can make any guarantees is
> > if we do what Alan suggested, which is to imply that a read on a dirty
> > page *block* until the the page is successfully written back.  This
> > would destroy performance.
> 
> In almost all cases you don't care so you wouldn't use it. In those cases
> where it might matter it's almost always the case that a reader won't
> consume it before it hits the media.

Wait! Source code builds (*) nowadays are quite fast because
everything happens without hitting the disk. This means my compile has
finished linking the executable by the time the kernel starts thinking
about writing the objects to disk.

	Roger. 

(*) Of projects smaller than the Linux kernel. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
