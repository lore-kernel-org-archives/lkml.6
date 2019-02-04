Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4312C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849A22083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="RevxtlRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCqVuHJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBDFzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:55:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46269 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfBDFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:55:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A28B521AB8;
        Mon,  4 Feb 2019 00:55:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Feb 2019 00:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Cnv3ii0vTX6c//dFrqytCvGGSFf
        VQGMLpdqPG0BQ0I8=; b=RevxtlRi+0lFihLOIh9TssVLxk6EOb+KRrleA+y4H/m
        DSlQlOy8U730z2ydsvU6zAxKwN5fx9wPTKPVcQjOj+8XcMeeSCu3vg182C2ZoVbB
        Dt400bkItxzpZUfoKGnf+A/QNworbQA9xyqkkBqM12s7MkT1wGgHIorQX3aQ/+YV
        FxOWr/5dwG3xvJzpLt+dO25OO/5PXsfyy+bMgRgQDnmIGLEdVmrqzG4cZTlupPiZ
        G9TEo2mKoavIx8G0MVuZM2eFt5b28YXkk+bxtKzj0jp5qpeVVARO9kYsDaAB9N5h
        jA5k7aVU8+/u6LqZVl7jjkmWvbCdemV7gHve84BoAbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Cnv3ii
        0vTX6c//dFrqytCvGGSFfVQGMLpdqPG0BQ0I8=; b=KCqVuHJVaIhmIuKIpb5RYm
        +uyMTTrHzKrarBqn0lw61zbBe/knvFOq+k2eBZwge+fSc9SxoEymXKvQqpgtzwXn
        6gEu3e8J6lEcjwB9eVa/DUErE5XqxmKQuCQWjz9pSEfm6usEi6TJYjz+b9vX4gZh
        En8gOEC/+B64IjsWRE8T1NVb8rIC6GEt6gHnXHYHl7VakMhfTNzAm1HgbGbN4iSy
        55B8zdBaem+o4UeOPnD8RbNiiIso+Awcu8tvg9Tdd7Jce1fyr1vuiqTYL5QSfEGx
        sOVbZBE0exAfojCsNhBNlSolCmx3FJKS72J4hBa/aj/EGQ69AoctS/sC3fafqTLA
        ==
X-ME-Sender: <xms:1tNXXFAGUviouBUVA1T7fOkXugaMjfsWK6WlCOoHqBW0D_Q4ZFACmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppe
    duvddurdeggedrvddvjedrudehjeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvseht
    ohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:1tNXXJgv7Hbhx1jO8holvgIVYG5DoAJ8qeflgDR-d8ynU2H1KOxE4w>
    <xmx:1tNXXOPJu7nwsa3nNmqD2I06-_wWE_m9qWjK-kyqJ3x2RMwvunai8g>
    <xmx:1tNXXK4wdesBM13bOCGa7vYtkw7ld_cZya7mNiD_mY04_ECapeJM4Q>
    <xmx:2NNXXOI6LWHp3eo1nJjtZwrE8yDwJzEF5TLV2pzditwb45JJAMbwbg>
Received: from localhost (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7021E4543;
        Mon,  4 Feb 2019 00:55:33 -0500 (EST)
Date:   Mon, 4 Feb 2019 16:55:26 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-ID: <20190204055526.GA14242@eros.localdomain>
References: <20190201004242.7659-1-tobin@kernel.org>
 <20190201024310.GC26359@bombadil.infradead.org>
 <20190201140346.fdcd6c4b663fbe3b5d93820d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201140346.fdcd6c4b663fbe3b5d93820d@linux-foundation.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:03:46PM -0800, Andrew Morton wrote:
> On Thu, 31 Jan 2019 18:43:10 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Feb 01, 2019 at 11:42:42AM +1100, Tobin C. Harding wrote:
> > > Currently when displaying /proc/slabinfo if any cache names are too long
> > > then the output columns are not aligned.  We could do something fancy to
> > > get the maximum length of any cache name in the system or we could just
> > > increase the hardcoded width.  Currently it is 17 characters.  Monitors
> > > are wide these days so lets just increase it to 30 characters.
> > 
> > I had a proposal some time ago to turn the slab name from being kmalloced
> > to being an inline 16 bytes (with some fun hacks for cgroups).  I think
> > that's a better approach than permitting such long names.  For example,
> > ext4_allocation_context could be shortened to ext4_alloc_ctx without
> > losing any expressivity.
> > 
> 
> There are some back-compatibility concerns here.

I'm don't understand sorry what back-compatibility concerns (please see
sentiment at end of email :)

> And truncating long names might result in duplicates.

So I thought I had a good idea - add a pr_warn() if cache name > 16 and
patch all current intree calls to kmem_cache_create() called as such.

This process very kindly lead me to the fact that this does *not* work
because of the macro KMEM_CACHE (which uses the struct name as the cache
name).

So, back to the drawing board.  I'm concerned that this may be a waste
of peoples time, if so please say so and I'll move on to something else.

thanks,
Tobin.
