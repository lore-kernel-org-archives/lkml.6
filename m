Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3DEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E3521A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WEnoNv1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNfoS1se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E3521A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeHGFAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:00:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44903 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbeHGFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:00:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0503D21DF2;
        Mon,  6 Aug 2018 22:48:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 06 Aug 2018 22:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZDQtrhoqeBKbPd6CM2BKLbUDJhNwYwDyV2YZUZHwQMk=; b=WEnoNv1u
        SWKsgsNvzZsYh4k9GxdnVQZ/LN7FzG85+Pxq0CpNrHxVnddmp+bggKSdPdNcWu7w
        eDAahexdZbXim09tLpB69uiPkaz9ZkgTr8QJZrkpF/sjODv/wlbi0yHiidwcBkam
        AXcjZj8xqwA5bPeDVeR/0c7vT+KlC3sni+tSgbhzrcBHHmMfuFZFd+wP6CKH/KUT
        quWue1HT5uGlqo98ffmkVbYlQptaHuLTu7BNQfMHdf0gfiE+cM9pgqk1+Z+SEXUt
        EFt5nhcTKzc+9MG1vRTK/bHsuBXwiiVrH4ii/KhbjXgnZC8qozOKXDCrBBpQjDNI
        y81fDwn3EOkPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=ZDQtrhoqeBKbPd6CM2BKLbUDJhNwY
        wDyV2YZUZHwQMk=; b=VNfoS1sehY0s8/UW2BYNyq47Q2UfuJs0ezZBSrNtjtc50
        gjCJOl/WDkOf9x7ZmlhN02i5LIIBxsg4jIEtJ4ZP1EBs60v4n5YLBSexAbDzVQ4Y
        3lNlToY/QHCGvLeHeDDq82+FJNVSpfFrWLLRqXz8BAJpdcN6mNOS10csCEN+dQCS
        MXH8aAtrVSwSVr1Hkd1a7jo3nfPj4wSEGYRMPJUw3eB3MrPF90e5ESVEtW34XHrM
        y8Wtex4HpGQiXQAnb5Z51KQqf3iFhyvCms8Ptd49hnxlLrCCgl0ZwDoHKoztEfX1
        v7JWvmSCZtj3cS8448Q8ooDRJlzgeBfNPG2etYfQw==
X-ME-Proxy: <xmx:kAhpW5UVgVv7L02PNnmzuw0_l-Im_-NQPO19tvx-y4LVhMtqLcVCoQ>
    <xmx:kAhpW3hXkDImM6uvMSom7_ZDCDTFCEh0AVYxmk64-DiuON2GH5qN7g>
    <xmx:kAhpW8-LcdIjXiBjbvlKm6azVQdPDVDWXKuv5ha5Eu2c_utl7zS1cw>
    <xmx:kAhpW5BsYKCHFqX44in21ElXMk348-0uAnfgBSOl-Mpzeoi6lQTv4A>
    <xmx:kAhpWxJM7LqOQeThX0dnww0dY9IALC_HIMNL-o7jqpXOPUOzaccZ3g>
    <xmx:kAhpW-m4h3i1H9-hwnY1CIa1FM2y-jx2XSHlvwQVzpjXKPdnMPdxXw>
X-ME-Sender: <xms:kAhpW8W3VO44ypw_qqb3bztNCx0eUfCwPs1ZbgELljsro_IYxYhhXQ>
Received: from localhost (ppp121-44-251-7.bras2.syd2.internode.on.net [121.44.251.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC9861026B;
        Mon,  6 Aug 2018 22:48:47 -0400 (EDT)
Date:   Tue, 7 Aug 2018 12:48:44 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next v2 3/3] docs: Split filter.txt into separate
 documents.
Message-ID: <20180807024844.GW3088@eros>
References: <20180802223100.26236-1-me@tobin.cc>
 <20180802223100.26236-4-me@tobin.cc>
 <20180803070818.3d3e52e4@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803070818.3d3e52e4@lwn.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:08:18AM -0600, Jonathan Corbet wrote:
> On Fri,  3 Aug 2018 08:31:00 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > In preparation for conversion of Documentation/networking/filter.txt it
> > was noticed that the document contains a lot of information.  The
> > document may be more accessible if it was split up.  Some parts pertain
> > to everyone, let's put these bits in core-api/.  The more hard core bits
> > about eBPF internals could be put with the other BPF docs in
> > Documentation/bpf/.  There is a small bit of information on testing and
> > miscellaneous matters that are useful for everyone (everyone does
> > testing, right) so lets keep that info at the bottom of both new
> > documents.  (This includes the original authors.)
> > 
> > Split Documentation/networking/filter.txt into
> > Documentation/bpf/eBPF.rst and Documentation/core-api/bpf.rst
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  .../{networking/filter.txt => bpf/eBPF.rst}   | 590 +----------------
> >  Documentation/core-api/bpf.rst                | 599 ++++++++++++++++++
> 
> Some overall thoughts...
> 
>  - A good step in the right direction, and worthwhile work.  Thanks for
>    doing this!

Thanks for you thoughts Jon.

>  - The new eBPF.rst file is not actually an RST file.  Giving it that
>    extension while not converting the contents will confuse Sphinx.  I'd
>    call it .txt at this point.

I'm a bit stumped as the best way to structure a patch set that does

	foo.txt -> foo.rst

conversion.  FTR the conditions I'm trying to meet are:

1. Each patch should be discreet and leave the kernel in a _correct_
   state.
2. One thing per patch.
3. Maintainers should be able to take the first 'n' patches without
   taking the whole set.

How about these steps:

	1. start with foo.txt
	2. do typo and grammar fixes (any number of patches).
	3. rename to foo.rst, do whitespace changes, code snippet
	   indentation, heading adornments, update references to this file.
	   (single patch).
	4. Fix up references in the file text to use RST (i.e :ref: blah)
	5. Fix up RST markers (backticks etc). (any number of patches)

Any better ideas or further suggestions?  I like 4 and 5 separate since
they can be done in multiple ways so may be controversial.

>  - The document now known as core-api/bpf.rst is still covering two
>    separate things.  One is the socket-filter API, while the other is
>    classic BPF.  Since cBPF is still used elsewhere (seccomp), it's of
>    wider interest.  Also, this is user-space API stuff, not kernel API
>    stuff, so I think that Documentation/userspace-api/ is the right place
>    for it.
> 
> I'm kind of thinking this through as I type it, but I guess I'm arguing
> for the creation of three files, all in Documentation/userspace-api/:
> 
>  - socket-filter.rst on how to write socket filters
>  - cBPF.rst describing classic BPF and its tools
>  - eBPF.rst describing extended BPF
> 
> Tying cBPF.rst into seccomp_filter.rst could also be helpful for our
> readers.
> 
> Does this make sense?

Yep, that all makes sense.  Patch set to come.

thanks,
Tobin.
