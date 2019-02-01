Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D00EC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12FA218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="HcVwliAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j63DN7o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfBAC6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:58:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42785 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbfBAC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:58:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 524622DF3;
        Thu, 31 Jan 2019 21:58:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 31 Jan 2019 21:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=HSl4cOeylKJWGZ1gRfcpgzkKgRG
        Upcow+/PQb70GWe4=; b=HcVwliAMgEFBku4Jcy/ar1EZHhhVXBxHKogoSpDlCVo
        jz9id7tTOaY2YqB28p3BPdb1Hzo9XDtIyARJH/kwd5ZRQp7N7moYxfPuC37Oy7lS
        Up5Tfs2t7KZzqtMxNr8E4n+JEQQiJ8dSkHnqWS6IK4Dypd4p8hbs9AVLwpIiBdRF
        Yp5c6yY1HizhocF1q7CaKuchG2JcIpNVKUosvajP2bbxDKnyEHWYJ1JujUXDSNt4
        q6BoeTKDBHglSIIDvSy6RJj9pMV4lBk7UMWlTPC/4aC7LW0CY/pQUVhQrFZW4sVu
        G3TSO7oZJKlboVYxkbjhR+YVpM/4nv3jYW02gK5a6lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HSl4cO
        eylKJWGZ1gRfcpgzkKgRGUpcow+/PQb70GWe4=; b=j63DN7o0MmyWYmkAsVZJXw
        12a6yCEGIoNtkAsUPmPxnF2mOntwW6Jsiv15m5VVFYBPtJFgY9lTOGRgOEWLh70Z
        fjSITzgZ+mzUzw/llYKC9SUuEgeQG3RyjrJN6VmkSWDg6wnnIbNFq/PD4W7VtBs4
        BS/WexbMMlTrA3htZ84/+TPuHI4BDVEbfq+42s+g6lOn3/NCW8ooAhOTb6ITiDos
        trXXktVhRt12OBLT/nE66RGLfAZZQxSSW0/dV8iwubvn7QdRZOlGEAcpye/+z+oG
        14u8TAGtwy98dyhC2UflTyk6r5tmjU2fxejGia/H1RAmCgwX+9uG1Iqg8zSrWQLw
        ==
X-ME-Sender: <xms:zLVTXEFDwTR7FVROIVM-smlfRvBqyNE4HjMQ3PhwKWsHEPDJBVyBhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeejgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppe
    duvddurdeggedrvddvjedrudehjeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvseht
    ohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:zLVTXJdtepDoiYhMQbfG7Su3P_NYowRweoE4Mt9bkJEcIplJANzSfw>
    <xmx:zLVTXKTGf-kOcqWV2TroPEtU4G9NhlC8BfKLXT8eNbf23hdYkO2Gqg>
    <xmx:zLVTXKvfvNjEIT-SiWVkJiwtbTasrrL-lprwmA9HLjDfUyjztrH51w>
    <xmx:zLVTXMzFVRVxHKI_8NqEvcaG_KZXYnlrRBK6En1mDsk59T8Kx45wow>
Received: from localhost (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id E175CE412D;
        Thu, 31 Jan 2019 21:58:19 -0500 (EST)
Date:   Fri, 1 Feb 2019 13:58:13 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-ID: <20190201025813.GB29854@eros.localdomain>
References: <20190201004242.7659-1-tobin@kernel.org>
 <20190201024310.GC26359@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201024310.GC26359@bombadil.infradead.org>
X-Mailer: Mutt 1.11.2 (2019-01-07)
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:43:10PM -0800, Matthew Wilcox wrote:
> On Fri, Feb 01, 2019 at 11:42:42AM +1100, Tobin C. Harding wrote:
> > Currently when displaying /proc/slabinfo if any cache names are too long
> > then the output columns are not aligned.  We could do something fancy to
> > get the maximum length of any cache name in the system or we could just
> > increase the hardcoded width.  Currently it is 17 characters.  Monitors
> > are wide these days so lets just increase it to 30 characters.
> 
> I had a proposal some time ago to turn the slab name from being kmalloced
> to being an inline 16 bytes (with some fun hacks for cgroups).  I think
> that's a better approach than permitting such long names.  For example,
> ext4_allocation_context could be shortened to ext4_alloc_ctx without
> losing any expressivity.
> 
> Let me know if you can't find that and I'll try to dig it up.

Thanks Willy, I'll try and find it and bring it back to life.

Cheers,
Tobin.
