Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B0320869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="iDCEb4dF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fibNY5iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfBAA6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:58:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48301 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbfBAA6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:58:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BCCFB2D89;
        Thu, 31 Jan 2019 19:58:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 31 Jan 2019 19:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZT9ljo+ZXcqCXfaIqDIpaOjNxLT
        /0pY68f+LJGHdi4k=; b=iDCEb4dFuYjMdR3BFwDxpIsj7iEA4rdl0j/fbIO0Y5L
        35DrJX85pmr21SOxKR6GxySOe4BLEL14YQLyv4m0a/1bW7PzauyF1XthMpmMfB/E
        j2FKOlqwHwCCN82dGYIu7woyWkCejKzPix4eiTCbgUQZ1oIMjlEfHHEUQqZFM9IG
        fU/T0IBDuMdedE1+RikHRLLYju1nKNyiyvobmHD5VlNFFm+AjZtmABUJic/w+ChB
        4u3Ft+OVb7qWvokQC2IyXCzzOxI/mJbucvUsvdi1M4oKbv69lnEjLgSLKr9eNidI
        9VRG874qsh7vM3GfYTgnJPANIRDMJTC8oNtGm5RwzuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZT9ljo
        +ZXcqCXfaIqDIpaOjNxLT/0pY68f+LJGHdi4k=; b=fibNY5iGO8VOO2bhZPWGPy
        bDwNE5qDQWg5jnmBkNFSmvWLWjwXxj85cmCtJn/Oi+uOI49IrLmkTe2SqGMkRyD6
        s389zPYAuRzA00XZDLYdBtuzFQIyASWkISLtxjBaLHjmY9klzFTjHuEEsa8P1MBu
        Qjhf7E/r/RmcZs9QUO0y+kwt7T9xYZpfH1CkxlK00UH4sRGCTO6PMP+0yclnM8Lj
        hSjNg9U6H8ITqXSDKToQNC2qo8EBILAOILd+yce3pilcd9htO6QgGfA7HQX830m2
        Wbxi56V9SQFKiRABFp8RaqL/N6NtG8MYiNoN68UC6j6ljlxlbCEEs6/s9tQi8b8A
        ==
X-ME-Sender: <xms:xJlTXHgLxnfFBkh-2exrnCdSBSqdun8dywhXZ72ipMq6Ish-TjaONQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppe
    duvddurdeggedrvddvjedrudehjeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvseht
    ohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xZlTXISnZTH-dSVzJifEISez-n8sraP3H8sA95JoinTp6UfZ4AJhGw>
    <xmx:xZlTXCHYIwQEVgt-UX_snwAgthTWTH7umcJ9KVkGDCJ4y0BWg9f0BA>
    <xmx:xZlTXIm12-JnnhRbEwSbSeGRa3KVJK4UPVZ0bLSuF9dHRylViHt-WQ>
    <xmx:xplTXFKEqjwBvTOgwxOEEPbNZpXCAPA3nAX5kux4VqRN8wUQgAAVbQ>
Received: from localhost (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id 414C31031B;
        Thu, 31 Jan 2019 19:58:43 -0500 (EST)
Date:   Fri, 1 Feb 2019 11:58:38 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-ID: <20190201005838.GA8082@eros.localdomain>
References: <20190201004242.7659-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201004242.7659-1-tobin@kernel.org>
X-Mailer: Mutt 1.11.2 (2019-01-07)
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:42:42AM +1100, Tobin C. Harding wrote:
[snip]

This applies on top of Linus' tree

	commit e74c98ca2d6a ('gfs2: Revert "Fix loop in gfs2_rbm_find"')

For this patch I doubt very much that it matters but for the record I
can't find mention in MAINTAINERS which tree to base work on for slab
patches.  Are mm patches usually based of an mm tree or do you guys work
off linux-next?

thanks,
Tobin.
