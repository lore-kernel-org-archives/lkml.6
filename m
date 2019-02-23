Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEF8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB17206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMyyGwOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfBWRwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:52:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfBWRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SvIs3KMR6R0VwkH2komtPThA4rCm0M8LMtCNxL8Gguw=; b=JMyyGwOrp//VFSro14bzCZ+IK
        qWnQAW56blFOsXt6FJyOgxoYi85m2WV2VLzPsjCv/OHq/rRYBCx0av6Q8Vs9aUQ3B7X1xCgaW1C+0
        iNRVacFbLRdeHz2y/CEjNF/wK5PzGX8e+v2kbL6cFbycDqt+VGZNhf+t5LV2XMcLOnUul7Abk+vAa
        8uPR3mEDXmFCLJ0lfx8c193+tajrFrETJvbrbKLPH0RDx5oDpbwVwk7zsIN7G65wOMElQpbzaVk7U
        jgCsH8E90rcE0kkuaHEdKS4sqeOVp0djZUZASnNDwWa3lIfohAZT+19wLfRuauDBRiZ5EBjOKaVc6
        Xe63rPVow==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxbT7-0001Hj-Ih; Sat, 23 Feb 2019 17:52:09 +0000
Date:   Sat, 23 Feb 2019 09:52:07 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20190223175207.GC4722@wrath>
References: <20190224011925.6db87446@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224011925.6db87446@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 01:19:25AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   9bfe33ba29d0 ("x86/CPU: Add Icelake model number")
> 
> is missing a Signed-off-by from its committer.
> 

Hi Stephen,

Apologies if I've asked you this before... I didn't find it after some
searching.

We should be catching errors like this before they hit next. First,
there is no reason we can't catch them - unlike the integration failures
only next can catch. Second, once they are in next, there is no "right"
way to fix them.  Either rebase or send the bad patch to mainline - both
are bad. Don't get me wrong, I'm glad next catches them.... but I'd like
to get to the point where it doesn't trigger on our subsystem :-)

Are your patch mechanics tests available for us to integrate into our
commit and prepublication checks?

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
