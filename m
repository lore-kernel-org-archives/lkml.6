Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADE32148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WT60Z28H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nB8Cb9lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfBUFZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:25:13 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52149 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:25:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6E9DC31D3;
        Thu, 21 Feb 2019 00:25:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Feb 2019 00:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=p/pdBzhJoGFstigVk45paamlvV3
        /M/4q6oBZea5EIy4=; b=WT60Z28H4ibMiQZc3a6HxbjX47+qGhCv8zDJpTba1JN
        Cfvy931ghbxHQRxKJSHD2EJNyno+HdClsH+5VaBw4+sSWjASLM0I8M4Bx0gURF+l
        OeUQW5KR+j4KOzFXxPiRz7gC0oONFSGLBcfHR7/PX6IhafV2wEJc9h8pqUMzErlT
        4VqR3rQsNlLru3wus7Qri+miCIGWy1k1GvGGDq5f38bPMQruzNMf+lS522NzbeS6
        y9TrBXic+UDsqJiXIHvhnA0hUllZy2upLDSb5nXJNgz/miVGcTn3UbKJlwHK1Y2v
        xmpPqWgUzNIJCzxyaiUjmdanVHElTwLRFKQT2CdXN7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=p/pdBz
        hJoGFstigVk45paamlvV3/M/4q6oBZea5EIy4=; b=nB8Cb9lpzX30kZkILN563J
        W4CWEnE2Hk0CtINV5Rtp2uGUIJwdQHG9dIG34lLnzny+ECXCrQreBPibVM9ohnNW
        xF2X6LKApZ0borC9K8TMbmeViYugh23AJyWDCMdhbkk8D2cMegEpl0umKL/lX0Ki
        ard4EZ5Ca1pHl2CIbL140JJWbLLZJughFpYUos6lA/OrpP8LW2z9aVrfKkK/eena
        BnreJ4t7nrIvwk34InjLZsxgHizRPnKipiYIqwuqDkwv/obAumapscxU5hv6i5TM
        KLCWAhDWQkY4ObaL4cPUgeNEMvtbCAegOqr/6kpZtyoX3IWLcA+/Enexc3nBFmYg
        ==
X-ME-Sender: <xms:NTZuXDhO_kYFuTzhtVxlxR77Y5_S8Mtfd-Vk31xXwGHibrsw1Gt60g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdekfeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdefledrudeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NTZuXMvp120Fkm_vD_s3UxkhCfHcoApQvmlOokm5OkbF-0pCBsvoWw>
    <xmx:NTZuXG_QDMzjy7cJNNx5X0zTrC1YVeGcpb7MUdBq_KIwi826VWQZTg>
    <xmx:NTZuXKZs0mope-Wu1UZyje4uTkAxa8VOuS_5pZjR6MaErseRJA3_hg>
    <xmx:NzZuXBb7Nd1lh4xTzgxz7RDax33WZrXVExxTQ42m5Gdzc4eEBwW3Pw>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18879E4597;
        Thu, 21 Feb 2019 00:25:08 -0500 (EST)
Date:   Thu, 21 Feb 2019 16:24:35 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
Message-ID: <20190221052435.GF11758@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:05:10PM -0800, Kees Cook wrote:
> On Mon, Feb 18, 2019 at 4:52 PM Jann Horn <jannh@google.com> wrote:
> > AFAICS the byte_at_a_time loop exits when max==0 is reached, and then
> > if `res >= count` (in other words, if we've copied as many bytes as
> > requested, haven't encountered a null byte so far, and haven't reached
> > the end of the address space), we return `res`, which is the same as
> > `count`. Are you sure?
> 
> Oh, whew, there is only 1 arch-specific implementation of this. I
> thought you meant there was multiple implementations.
> 
> So, generally speaking, I'd love to split all strncpy* uses into
> strscpy_zero() (when expecting to do str->str copies), and some new
> function, named like mempadstr() or str2mem() that copies a str to a
> __nonstring char array, with trailing padding, if there is space. Then
> there is no more mixing the two cases and botching things.

Oh cool, treewide changes, I'm down with that.  So to v2 I'll add
str2mem() and then attack the tree as suggested.  What could possibly go
wrong :)?

	Tobin
