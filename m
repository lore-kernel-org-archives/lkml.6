Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F4E20936
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FQBJpKVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F4E20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeHVXiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:38:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHVXiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iy4pCo0jjKiK2mMp2nL0qVptJxhyWtPHzfDVGkaYI0g=; b=FQBJpKVkYS+I240lpedLaw4uf
        39w2zlJgY+0WA8Vb60iitpFxZWSL9a2XwJWU1aAeV9gq1QAxwfybvjAPaKmCj7362JmiztxSPFtGN
        QVISgKwvNCHTqaPfuNxKpHcXo/3dzdhseL69c1soBzl7y7nyl/P2TVJydOu1nqb1/zZNTqvSBPZbA
        xM15mjqFlwE58cp/NBHhVXUhAuVkQkuai+XyFqvTlgOfPzxGB9rWiCQYyvN/p2f7nDUf54VaeV3f+
        GMsCv38RM0+Qc3MInd6H8KEodFH/XenPBbRY859kmO62TnlPMAOxecFFqNcCVQzHJacKKohnf5EIl
        wo3R3amag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsZU1-00054s-VY; Wed, 22 Aug 2018 20:12:01 +0000
Date:   Wed, 22 Aug 2018 13:12:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V2] license-rules.rst and LICENSES: Use only spdx version
 3 with -only and -or-later
Message-ID: <20180822201201.GC19458@bombadil.infradead.org>
References: <9f90ed3678d32bdde88d63e877880dcb08a97e15.1534519501.git.joe@perches.com>
 <7275a821f20ba080b6a262089ceeaf8fa94d4bab.camel@perches.com>
 <CA+55aFyd5D9Rj2Wm+rP9QnZg2Jd_LKqPTKTmPv+doYN=JXra=w@mail.gmail.com>
 <alpine.DEB.2.21.1808222115050.1652@nanos.tec.linutronix.de>
 <d0d292a4d9637c1a94eb40abd8a4ee2dd1f0d823.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d292a4d9637c1a94eb40abd8a4ee2dd1f0d823.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:47:57PM -0700, Joe Perches wrote:
> Perhaps it's better to stick to a single SPDX version style for
> all kernel files.
> 
> Right now, there are already several -only and -or-later uses.
> 
> $ git grep -P 'SPDX-License-Identifier.*(?:-or-later|-only)'| wc -l
> 144
> 
> So perhaps a patch and a tool to do the reverse conversion:

No.  Any tool which does anything useful just has to understand both
2.0 and 3.0 naming.  They're aliases for each other, that's all.
