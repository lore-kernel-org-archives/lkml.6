Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD69124884
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmE8Za6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD69124884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbeFVUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:22:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55484 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeFVUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P/2zcIGvOya58GBqTiymPO95qTaF2o8vN2bi00SLNmY=; b=GmE8Za6PLRh1DB+G4Yysdb8LUc
        ZufcsGkzPDCNrsSaGJQqKthOScoMuxEPxQCOPfD1c9Fa+vesLYpTXJEZ5es/nrB4U+jhcfkfkm5s2
        oUr7Lz8QTzAxdL+n64vMr4GxWY/doGQzfD44FUWs/7bhPyEWCqSxp3ycS8RLBI6+4rbi3K4dMR85h
        NnQdxYOxhVzHfmD8Z48X64B7COC3K9Vz4Rz3wdm5N7Tot3p79VmPd6ZKLfasWWPBjhJ4jRI4HwOGq
        Y6XuLLw3olxQmm6hN1swzm3DYB6Sd/Ib1dbaogrlY/w9WiLXl2Tfb7QltGBKa4E4oOzAN4TBclREI
        aGQu9hQw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWSZq-0003QZ-Nh; Fri, 22 Jun 2018 20:22:39 +0000
Subject: Re: [PATCH 0/4] docs: e100[0] fix build errors
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622003708.31848-1-me@tobin.cc>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ba768d6c-dd21-3600-5cba-151b5d6185f1@infradead.org>
Date:   Fri, 22 Jun 2018 13:22:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622003708.31848-1-me@tobin.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobin,

On 06/21/2018 05:37 PM, Tobin C. Harding wrote:
> Hi Jonathan,
> 
> This patch set fixes current docs build failure on Linus' mainline
> 
> commit: (ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/kleikamp/linux-shaggy)
> 
> (FYI this is 8 commits after Linux 4.18-rc1).
> 
> And also same build errors on today's linux-next
> 
> 8439c34f07a3 (tag: next-20180621, linux-next/master, linux-next) Add linux-next specific files for 20180621
> 
> 
> I split the patches in between the two drivers to enable use of the
> 'Fixes:' tag.
> 
> Tobin C. Harding (4):
>   Documentation: e100: Use correct heading adornment
>   Documentation: e1000: Use correct heading adornment
>   Documentation: e100: Fix docs build error
>   Documentation: e1000: Fix docs build error
> 
>  Documentation/networking/e100.rst  | 112 +++++++++++++++--------------
>  Documentation/networking/e1000.rst |  76 ++++++++++----------
>  2 files changed, 96 insertions(+), 92 deletions(-)

I am still seeing a few warnings (your 4 patches applied to
linux-next-20180622):

linux-next-20180622/Documentation/networking/e100.rst:57: WARNING: Literal block expected; none found.
linux-next-20180622/Documentation/networking/e100.rst:68: WARNING: Literal block expected; none found.
linux-next-20180622/Documentation/networking/e100.rst:75: WARNING: Literal block expected; none found.
linux-next-20180622/Documentation/networking/e100.rst:84: WARNING: Literal block expected; none found.
linux-next-20180622/Documentation/networking/e100.rst:93: WARNING: Inline emphasis start-string without end-string.
linux-next-20180622/Documentation/networking/e1000.rst:83: ERROR: Unexpected indentation.
linux-next-20180622/Documentation/networking/e1000.rst:84: WARNING: Block quote ends without a blank line; unexpected unindent.
linux-next-20180622/Documentation/networking/e1000.rst:173: WARNING: Definition list ends without a blank line; unexpected unindent.
linux-next-20180622/Documentation/networking/e1000.rst:236: WARNING: Definition list ends without a blank line; unexpected unindent.


You didn't get these warnings?  or they weren't important?
or "perfect" was not your primary goal?   :)   [which is fine]

[I see around 50 similar doc formatting warnings/errors in the entire
Documentation build.]

Anyway, much better than it was.  Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
