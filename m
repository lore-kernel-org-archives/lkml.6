Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65920C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E4325370
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Dgcisf/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLYFh0Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E4325370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeFXXln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 19:41:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39773 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751965AbeFXXll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 19:41:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AFBF215F2;
        Sun, 24 Jun 2018 19:41:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Jun 2018 19:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=W6uR+qNMvQobCppSwLAXhy27OjbPDKywgdajfoxXNuQ=; b=Dgcisf/Y
        9IdqeLYyPXtlsrom4HEnuuvkAw0xGISNcVaJxotp8IfBvjfvJ7ILuWIcY6YZ4POz
        P/9j3hGvQ1DNMSouVkDMaw0ZVlHDbWXKzbtyPTJm3tZwGCQ1cJlaL+4au9TXw/ll
        +btQFPPlyhUVAJyuOCMjnsu/q1nwqj+WY2G4DtrNpORj+FiDZ9oAzbt15fGT9/ml
        RrBlffskFPtwE6ZBkRgFytE3OqO4Y/LAoj+dnyrDIBV4aMQTBRGj6JZOTY2JgK/G
        owdEjPg5dPz3XlxKSfy/mA7HEOClPqJ0eRDZF9AxT9ucaFgXLkM2BhLtVgGM8df2
        0e3854ByHO4p7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=W6uR+qNMvQobCppSwLAXhy27OjbPD
        KywgdajfoxXNuQ=; b=uLYFh0Smh14wLzF28tKnzPJtJ5076mKHtWzEj0+bhlHt4
        +Vnsg6XMhvIA9fbjM3d/FJXwfYFoBiDrRu4w/HbrXE3Ly03UtdgrENtOBEIyYnfv
        A34jmX6HRI2jukGAvaqioa4jqUfsVcZyiqvcuEtELkSOcNdP3+XsQJ9aD6mk/Bim
        JEmubZZui83tStNwCurgiF151sZ5NobjlBhz538NMPjey0i9svAB0hbJ/Yl0SDBw
        ijOQGMnSREYv1pRXHF/LkRe37Cz+YgS/wznRPgRip9gC6/q+RtMf6izuspgy77zy
        sS4JO7EG8Sm273CjDCo+OJOLuUXSFtdKzN10l36bw==
X-ME-Proxy: <xmx:NCwwW_E7FBku6rzoTXUuefSqC_nkFblHUG8_a3TP96XpCVqTj0i-eg>
    <xmx:NCwwW6IZxPTNSxUzNhvGlZ0IQGtwH_4D7rUu7Pu-3XtCrswPGJp3sw>
    <xmx:NCwwW7mrHzHb395jm2jVG1m9qjThE4wUWSp77ZbMB6ZfHB1OwcK5xA>
    <xmx:NCwwW6Sh5mmkkq_WM0Vcsdh-vJvDKtpyjOn04VSUNn_8nxaS9TyBhg>
    <xmx:NCwwW1I-hw-gTVR5UGwLHexOb5Y1ntehdi5blT_-A3BwWtRMUNu4-Q>
    <xmx:NCwwW2BIS-CHxXb5txxvSE1hB2bmR01Q7BOGIZfI3No7I4PHKRpzQA>
X-ME-Sender: <xms:NCwwW_C-2IXPPuKYqNBDC0Fg_tN--KHC5PzwEvBUTcQNx0eLZbnXCg>
Received: from localhost (ppp121-44-217-101.bras1.syd2.internode.on.net [121.44.217.101])
        by mail.messagingengine.com (Postfix) with ESMTPA id 986D1E4648;
        Sun, 24 Jun 2018 19:41:39 -0400 (EDT)
Date:   Mon, 25 Jun 2018 09:41:35 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] docs: e100[0] fix build errors
Message-ID: <20180624234135.GE3006@eros>
References: <20180622003708.31848-1-me@tobin.cc>
 <ba768d6c-dd21-3600-5cba-151b5d6185f1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba768d6c-dd21-3600-5cba-151b5d6185f1@infradead.org>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:22:37PM -0700, Randy Dunlap wrote:
> Hi Tobin,
> 
> On 06/21/2018 05:37 PM, Tobin C. Harding wrote:
> > Hi Jonathan,
> > 
> > This patch set fixes current docs build failure on Linus' mainline
> > 
> > commit: (ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/kleikamp/linux-shaggy)
> > 
> > (FYI this is 8 commits after Linux 4.18-rc1).
> > 
> > And also same build errors on today's linux-next
> > 
> > 8439c34f07a3 (tag: next-20180621, linux-next/master, linux-next) Add linux-next specific files for 20180621
> > 
> > 
> > I split the patches in between the two drivers to enable use of the
> > 'Fixes:' tag.
> > 
> > Tobin C. Harding (4):
> >   Documentation: e100: Use correct heading adornment
> >   Documentation: e1000: Use correct heading adornment
> >   Documentation: e100: Fix docs build error
> >   Documentation: e1000: Fix docs build error
> > 
> >  Documentation/networking/e100.rst  | 112 +++++++++++++++--------------
> >  Documentation/networking/e1000.rst |  76 ++++++++++----------
> >  2 files changed, 96 insertions(+), 92 deletions(-)
> 
> I am still seeing a few warnings (your 4 patches applied to
> linux-next-20180622):
> 
> linux-next-20180622/Documentation/networking/e100.rst:57: WARNING: Literal block expected; none found.
> linux-next-20180622/Documentation/networking/e100.rst:68: WARNING: Literal block expected; none found.
> linux-next-20180622/Documentation/networking/e100.rst:75: WARNING: Literal block expected; none found.
> linux-next-20180622/Documentation/networking/e100.rst:84: WARNING: Literal block expected; none found.
> linux-next-20180622/Documentation/networking/e100.rst:93: WARNING: Inline emphasis start-string without end-string.
> linux-next-20180622/Documentation/networking/e1000.rst:83: ERROR: Unexpected indentation.
> linux-next-20180622/Documentation/networking/e1000.rst:84: WARNING: Block quote ends without a blank line; unexpected unindent.
> linux-next-20180622/Documentation/networking/e1000.rst:173: WARNING: Definition list ends without a blank line; unexpected unindent.
> linux-next-20180622/Documentation/networking/e1000.rst:236: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> 
> You didn't get these warnings?  or they weren't important?
> or "perfect" was not your primary goal?   :)   [which is fine]
>
> [I see around 50 similar doc formatting warnings/errors in the entire
> Documentation build.]

Thanks for testing this Randy.  You are right there are a bunch of
warnings, I did not think to grep for warnings on these files - sloppy
work by me.  The series has been applied already but I'll add clearing
these warnings to my TODO list.

> Anyway, much better than it was.  Thanks.
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks again,
Tobin.
