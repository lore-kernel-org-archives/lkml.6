Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8446220BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8446220BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeGLLkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:40:21 -0400
Received: from nautica.notk.org ([91.121.71.147]:59199 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbeGLLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:40:21 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id ABCF4C009; Thu, 12 Jul 2018 13:31:11 +0200 (CEST)
Date:   Thu, 12 Jul 2018 13:30:56 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180712113056.GA23286@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-4-willy@infradead.org>
 <20180712111726.GA17774@nautica>
 <20180712112333.GA15277@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712112333.GA15277@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Thu, Jul 12, 2018:
> > Ah, I had missed that you didn't update this memset as you said in reply
> > to comment on v1.
> 
> Rather than update the memset, I ... 
> 
> > Could you resend just this patch and either initialize fid->fid or use
> > kzalloc for the fid allocation?
> > 
> > > +	fid->fid = 0;
> 
> Did that instead ;-)
> 
> If I were going to initialise the entire structure to 0, I'd replace
> the kmalloc with kzalloc and drop the memset altogether.

Oh, I'm blind, sorry! :)

> > If you do resend, alignment here was wrong.
> 
> I think this warning from checkpatch is complete bullshit.  It's
> really none of checkpatch's business how I choose to align function
> arguments.
> 
> That said, if you want it to be aligned some particular way, feel free
> to adjust the whitespace.  I don't care.

I would tend to agree that sometimes checkpatch is overzealous, but
having worked on projects where code style is all over the place it
really feels much more comfortable to have a consistent style
everywhere.

Thanks for the permission, I'll adjust it (assuming this does end up
getting pulled from my branch, but nobody yelled so far)

-- 
Dominique Martinet
