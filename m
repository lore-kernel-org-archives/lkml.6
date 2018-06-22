Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3CAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E25F2496B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="cJrS7WlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E25F2496B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933938AbeFVWdm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:33:42 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:49205 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbeFVWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=160drf+B7jT6BEooEkusqVguTDR3RdBDfnLOHw6kRxA=; b=cJrS7WlFwgUb+0C+gT72KjPNmX
        mO7goiX7T6sX931slqjpoMk1JfEVX9js0dziNlfvp6czJfEd+GNwVp9vRFJn0lWwpEX97USGgSe0M
        dx6dCVuVgU8uPuzsG4hBEBKrsL3Z9RqRDUk91f7xAryxIJTxIlQoHJS85W4Suozmqq0zhi2CWvoKp
        z+6Ll6HtwpGpcCcKYx6bIPN0NN9X3dCG911KuPRMTfFxLmYiqPTiStmVPoZwt+baXAJrAkekojHLv
        /fbfwTLYjjU+GX5YqCgxODzhl9Doy5d+ehUHVsX29xrBCAJCh5i0j7ZKzHVKdrkCQ0QVE/FVm6c3K
        xv/jscow==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44970 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fWUca-00Elg4-TR; Fri, 22 Jun 2018 22:33:37 +0000
Date:   Fri, 22 Jun 2018 15:33:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
Message-ID: <20180622223335.GA12581@roeck-us.net>
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622210519.GA18630@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:05:19PM -0700, Matthew Wilcox wrote:
> On Fri, Jun 22, 2018 at 11:42:46AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > a few days ago, m68k boot tests in linux-next started to crash.
> > I bisected the problem to commit 'xarray: Replace exceptional entries'.
> > Bisect and crash logs are attached below.
> 
> Thank you!  I was afraid something like this might happen.  
> 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
> 
> Line 42 is:
> 
>         if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
>                 return -EINVAL;
> 
> The pointer passed in to idr_alloc() is not 4-byte aligned; it's aligned
> to a 2 byte boundary.  I'm having a little trouble seeing who it is that's
> passing in what pointer ...
> 
> > Call Trace: [<000180d6>] __warn+0xc0/0xc2
> >  [<000020e8>] do_one_initcall+0x0/0x140
> >  [<0001816a>] warn_slowpath_null+0x26/0x2c
> >  [<002b50e4>] idr_alloc_u32+0x44/0xe8
> >  [<002b50e4>] idr_alloc_u32+0x44/0xe8
> >  [<002b51e4>] idr_alloc+0x5c/0x76
> >  [<00247160>] genl_register_family+0x14c/0x54c
> 
> It makes sense to here (other than idr_alloc being listed twice)
> 
> >  [<000020e8>] do_one_initcall+0x0/0x140
> >  [<003f0f02>] genl_init+0x0/0x34
> 
> Assuming this is right, that would imply that genl_ctrl is not 4-byte
> aligned.  Is that true?  I'm not familiar with the m68k alignment rules,
> but it has a lot of 4-byte sized quantities in the struct, so I would
> assume it's 4-byte aligned.
> 
> >  [<003f0ce6>] bpf_lwt_init+0x10/0x14
> 
> I don't think this is the caller.
> 

Here is the culprit:

genl_register_family(0x36dd7a) registering VFS_DQUOT
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8

It may be odd that fs/quota/netlink.c:quota_genl_family is not word
aligned, but on the other side I don't think there is a rule that
the function parameter to genl_register_family() - or the second
parameter of idr_alloc() - must be word aligned. Am I missing
something ? After all, it could be a pointer to the nth element
of a string, or the caller could on purpose allocate IDRs for
(ptr), (ptr + 1), and so on.

Thanks,
Guenter
