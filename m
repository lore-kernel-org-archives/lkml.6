Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785EEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AD920675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="GBREfe+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT3HKVRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfBMBN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:13:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35425 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729726AbfBMBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:13:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D38021D07;
        Tue, 12 Feb 2019 20:13:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Feb 2019 20:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/vsni0qI4nIlP2MtRM9/uEjnMvw
        ObGlkgdfO3PfJISo=; b=GBREfe+IaNu9MN4ysUkKzXc3q741zVmIMyvcTElSMab
        qaOnWrhH5L9k/zSktZt0FD4MuXuZ4f7CXUDokMK3myFif9Co5FytGYVnTt6pafv1
        cbM/bLrhOGpkyspnYUj1jugnmDQD8OySP/olkAOiX0nKRR4wY8WxLWS3llHsul17
        dpVDirkVEllNcBhQqviXah2SkimT6Q9KICjczpbTSgBh9AVos7MKtZVOULptdnQG
        QaLbteNgo1RNUuXwqS54vBXANYBse7Io5pLmvKefI/y44ChDU5NS0n5laA893IEv
        CF/QbagS3F0xUc7NEmpslh4rJ9w0vVXaz9Y5vqTgwGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/vsni0
        qI4nIlP2MtRM9/uEjnMvwObGlkgdfO3PfJISo=; b=UT3HKVRBITRkJypVgGFLED
        qv18xzFsnV5L6iem9iX3/ckmxTmJU5ClGacny9G/5hnU5YiZw9Jjddx1E3WTBQqC
        gMVHdp+0IQ2mdIjI0q+xYEo/Ul3EDc/Ke6HdmspWzADm/BEPe1dFD04LrVyOAaXz
        qMvABH6fg+VdzFTsXabpmauexRDf2hM4kr29GDH+RQe439f/bK2WaGx2M1eWk8GX
        pkY/hoIC+dNbuOTzGWtAnrixRkbokCANGhyK04INmyvuqGNx32Q4aG0UCsbXr/tS
        IYayXARX0qPcGKuHIwnMdc8AMRfGyE0M22aHjzoMD/IDl3KXe7KRZ9Eq4rQvUMeg
        ==
X-ME-Sender: <xms:UG9jXLmnFeAqt6cNu6cMmyXeEKut8cF5NeMZ6QF8_DTOq8y5OjgBig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecufghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfse
    httdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehm
    vgesthhosghinhdrtggtqeenucfkphepuddukedrvdduuddrudelledruddtgeenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:UG9jXD0KircKN0WWwwHH9TeuIcQ0DYE-iuTiLS4bGuEtmEZJosdoOg>
    <xmx:UG9jXJh3C75OBfdlmyqsEpeQVw-WwrDUj69r4Trg4-TRFTXFBJ7rjw>
    <xmx:UG9jXBbQd9WObKl93wsTU6MdPGQmP-qWhbf04KxgubPYDFaYTT33oA>
    <xmx:UW9jXGF4GohBPaUia8NzuDe6dJ5CvmAxMEIB_of7GZpRGjyHajE9Jg>
Received: from localhost (ppp118-211-199-104.bras1.syd2.internode.on.net [118.211.199.104])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B255E4693;
        Tue, 12 Feb 2019 20:13:51 -0500 (EST)
Date:   Wed, 13 Feb 2019 12:13:40 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190213011340.GA29295@eros.localdomain>
References: <20190212072958.17373-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212072958.17373-1-tobin@kernel.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:29:58PM +1100, Tobin C. Harding wrote:
> The XArray is, in a way, a replacement data structure for linked lists,
> as such, on first use developers may wonder if it is safe to remove
> items while iterating over the array.
> 
> For example, this is fine:
> 
> 	DEFINE_XARRAY(things);
> 
> 	void cleanup()
> 	{
> 		struct thing *thing;
> 		unsigned long index;
> 
> 		xa_for_each(&things, index, thing)
> 			xa_erase(&things, index);
> 	}
> 
> Document this feature explicitly in the docs and also for the macro
> definition.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> Hi Willy,
> 
> I had my first go using the XArray today and during that I wondered if
> it was safe to remove items during iteration.  Conceptually it seems
> fine and it seemed to work just fine in code - is this something people
> should not be doing for any reason?  Is this the best way to traverse
> the tree and get every thing just to erase it?  Are we even supposed to
> be thinking this is a tree or should we just be thinking it is an array?
> 
> (As you might have guessed I _still_ don't know exactly how a radix tree
> works :)
> 
> Oh, and FTR the XArray is hot - good effort man.
> 
> thanks,
> Tobin.
> 
> 
>  Documentation/core-api/xarray.rst | 3 ++-
>  include/linux/xarray.h            | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 5d54b27c6eba..2578e0bdaa17 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -97,7 +97,8 @@ You can copy entries out of the XArray into a plain array by calling
>  :c:func:`xa_extract`.  Or you can iterate over the present entries in
>  the XArray by calling :c:func:`xa_for_each`.  You may prefer to use
>  :c:func:`xa_find` or :c:func:`xa_find_after` to move to the next present
> -entry in the XArray.
> +entry in the XArray.  It is safe to call :c:func:`xa_release` on entries
> +as you iterate over the array using :c:func:`xa_for_each`.

Re-reading documentation this line may be in the wrong place .

Perhaps it would be better added at the end of the 'Normal API' section?

	Finally, you can remove all entries from an XArray by calling
	:c:func:`xa_destroy`.  If the XArray entries are pointers, you may wish
	to free the entries first.  You can do this by iterating over all present
	entries in the XArray using the :c:func:`xa_for_each` iterator.  It is safe
	to call :c:func:`xa_erase` while iterating the array.

I'm a bit lazy when I read docs and soon as I find an answer I stop
reading (bad Tobin) so it might be nice to tie the first mention of
xa_for_each with the comment on xa_erase _and_ the section on
xa_destroy.  Man, writing docs is never as easy as it first appears.

Oh and I sent v2 already but it hasn't shown up in my inbox so replying
here on v1.

thanks,
Tobin.
