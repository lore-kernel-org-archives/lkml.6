Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B78BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB081218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="WeUX5ZbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LFjKsZfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeLSAFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:05:42 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58563 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbeLSAFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:05:42 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 19E7722AB6;
        Tue, 18 Dec 2018 19:05:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 Dec 2018 19:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        +D020tyVaMEeCoY+0sUHdGR6L/LFKfsR6v269wmWEaI=; b=WeUX5ZbHSU3CI4Jy
        LPfeAfK6Mguz5UAf63qnZ7LAEzK1ou/VuuDJPH07FQGD2pHMD/3BFpFEsVWps7GY
        M5QETguTsco7/2LZaEyK5eGVS/th71+CEVZIZCkirTLMXm/mN6/ozy9ulBF+i47G
        HWbq2Hx4+7R8il1t08MZUB6Z/S/UZcM5txuuYgOumFRso70+BHt/9yGjpcTzTPIH
        eY/t87wQ/yGuZb1YOJk4ZvVPHd7sapNrvm3j2zUvxtV+OWmAODR+CbMGhG4fJdGr
        4nO79vmZsuqSYNC+vh8tgr5iE8q4Q8CGHX/jqhS4e0wAfe7Z/AcQCiTVdhC9JlXu
        OJb7xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=+D020tyVaMEeCoY+0sUHdGR6L/LFKfsR6v269wmWE
        aI=; b=LFjKsZfcbK9v46BSsd2Do41HXRg/Y5CKh3EIsx1HcyY7udT7gtrpHII+o
        Qa6mla/AjaRdIMAKZb4fHxsUZBVJMwtvbHy5lqUJ3oRAoet1YcM94WfkNYUkwLrP
        NihjAJ1SPROCQAo8DOR6HyzpDVBXZZBpUZvLj02RFitcQif3AhdFTlIKEYKKt6gN
        FcOxrs94fVQ7IrWfhWLFO8C2cPdNVjvoe63u7NJenHQzLBUdcqMiSZx8nMN5zqQy
        Y5Py2RNGlCldrZEY9QGfqil1ML1+VQoLLeyY+VDqY7qmfJctz0lrqp82RSlGniw6
        DFJsE83vgS/CY0c1boL2R6mds+giQ==
X-ME-Sender: <xms:VIsZXOmz9eLJYXrQO1F6afjRwkst0Bd8duoBg2tpOvhGOsUNrD7QaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeikedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvff
    gjfhgtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgv
    nhesthhhvghmrgifrdhnvghtqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukf
    hppeduudekrddvtdelrddukeehrddugedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehr
    rghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VIsZXP0N9r8B0LabzE0hpdd0iE7isAVUEO37fPpfZFxcg7lIKzzyYw>
    <xmx:VIsZXDTRzz94UnFzoRXuOWCUEOBI8zirtO3JExSyGwcqr5JaPJVQ4Q>
    <xmx:VIsZXAzJGLaX9O0DHYZr2Uy7dRQE66LqpKUZ8VDNNbKtznfRMdYxuA>
    <xmx:VYsZXDx6-_r4gUv4FCZ4G9DjZm9MtlwZAIKC0Eg6Hot78VUGHVbrug>
Received: from localhost (unknown [118.209.185.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id BEE0B100BA;
        Tue, 18 Dec 2018 19:05:37 -0500 (EST)
Message-ID: <941eac5115a41a0bfe8736816b7600ddfcc0371e.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        DmitryVyukov <dvyukov@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date:   Wed, 19 Dec 2018 08:05:35 +0800
In-Reply-To: <20181218130958.88ac9d638c717a1ab1db9dc3@linux-foundation.org>
References: <00000000000051e9c2057d31a563@google.com>
         <20181217072144.GQ2217@ZenIV.linux.org.uk>
         <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
         <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
         <20181218130958.88ac9d638c717a1ab1db9dc3@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 13:09 -0800, Andrew Morton wrote:
> On Tue, 18 Dec 2018 19:34:57 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > > See 
> > > 
https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> > > 
> > > I think this will fix it, I'll forward it to Andrew if you agree:
> > 
> > Actually, looking at it again the above patch is plain not needed,
> > dropping it and updating the patch which follows it in the series
> > is what needs to be done.
> > 
> > Andrew, what should I do to make this easiest for you to handle,
> > a respost with v2 in the subject of the patch affected by dropping
> > the above patch?
> 
> I dropped the patch and fixed up the fallout.

Thanks Andrew, much appreciated.

> 
> The patch wasn't true anyway.  "There is no check at all for a failure
> to allocate the root inode in autofs_fill_super(), handle it." In fact,
> d_make_root(NULL) will just return NULL and autofs_fill_super() handles
> that appropriately.

The not so funny thing is that I'm sure I looked at this some time
in the distant past and saw how d_make_root() behaved.

The lesson for me is don't try and fix other things seen while working
on something else, return later and do it properly.

> 
> However let's note that when autofs_get_inode() or d_make_root() fail,
> autofs_fill_super() will return -EINVAL.  Should have been -ENOMEM, I
> guess?
> 

That's right, but I don't think that's urgent so I'll send a patch for
it after the coming merge window.

The strictexpire option addition is urgent for me so I don't want to
upset any chance of that being merged sooner rather than later.

Ian




