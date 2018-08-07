Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B874C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E882174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="egutRjhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5zhCotR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E882174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHHBgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:36:40 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51017 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbeHHBgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:36:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 38141348;
        Tue,  7 Aug 2018 19:19:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Aug 2018 19:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xBcc6xJEgvMpBSpXYuVSDJkfix+PvF40e/TcXWWlRjg=; b=egutRjhh
        Dn8GjMT+qFeXNrYj43QLaNaWqNjfR5iC3aLFqOT5qSefvOu/EuJOSprgkZAOI59M
        TcDxrVFzHSasf071RsZHTRR4i8gfYsqFJ6G4hUqngRxtUE0Ra9Gr0Y7bzCPWDrsS
        pWwqY91WGTA+sUsBL5koSrvcDLZCk51QWymduM7liEsBAxz8ah24EQbEDPP3yO2N
        Z6svm8IV5AF0zPSLL9c3Mir2oFHoeHrb+c4Zc6z7WGedujMpR9Rqqn3IyLug8BUS
        4VdH+Q9qiLxN7JhZ6VWKwd1e11WsaNddMHv78HCU86qBHhiOPAsqXi71aHejb5uA
        FImlW5yb5QJ7lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=xBcc6xJEgvMpBSpXYuVSDJkfix+Pv
        F40e/TcXWWlRjg=; b=S5zhCotRXZp7aO9jzzmTtLxEm9s+jTIKpxJTrNrb/htpg
        GMWIZ+G8JuuXWM4twcIUXOFBSoy9GlzfJ0P1oV/G+90XrKVKeS1Z/V2Fyt3Guj22
        KHFR06s6/Jy6JOM9CwA13Y1wKmmcA2r2hWsCK1w+f+vB0Yem0CrPY2lHo02LFAWG
        SXj0yot2EOuYfsfKRO4/8dqE5+Jq5kx5CYWGvMpCAItcHlYgdHCZdPG/LnmL2Nmv
        Lizl92UTqJQ1X3UqrV1rdtLQthHgLy+SL7vCjAkwN8nVWbS9a0jrT0JAx15rWqne
        8ew0eg+OUCgwVxrnEIvEKGwMLd7XHLt98sMPbI+eg==
X-ME-Proxy: <xmx:GylqW1r8CFnELQVAUHQ-2AR_aX_OKsOSc0xsvG_6U8-SF3huqD5FNQ>
    <xmx:GylqW4N0dfqQpQJDTWreiEKuAw_18DMztkfABn4YEvtmR9ni7clUXQ>
    <xmx:GylqW7F8FoboI8QEnqc21ufft9VvA5IH9N01NjghI0N69gZeyeBhtA>
    <xmx:GylqW7FpEOWdbtSb1ftl5MKsp4HquIXc_3-6ksawQmPsNR162Gxt7w>
    <xmx:GylqW6ChesdvmpwzcukC-UDi3mXpL4LAf9lLZYFnLjOUQawmHpCCRg>
    <xmx:GylqW3FDOX6HHsuiB9oseZdiQ04GwfuPL_h0kq31JzoWL_lnqy-zpg>
X-ME-Sender: <xms:GylqWxaMXEzoRGBZ8eNosjPbVuTf70eAGUI6FPrtYoqY-Yt4OeM4ug>
Received: from localhost (ppp121-44-251-7.bras2.syd2.internode.on.net [121.44.251.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id E05B810276;
        Tue,  7 Aug 2018 19:19:54 -0400 (EDT)
Date:   Wed, 8 Aug 2018 09:19:52 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next v2 3/3] docs: Split filter.txt into separate
 documents.
Message-ID: <20180807231951.GD11191@eros>
References: <20180802223100.26236-1-me@tobin.cc>
 <20180802223100.26236-4-me@tobin.cc>
 <20180803070818.3d3e52e4@lwn.net>
 <20180807024844.GW3088@eros>
 <20180807071405.58d38277@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807071405.58d38277@lwn.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 07:14:05AM -0600, Jonathan Corbet wrote:
> On Tue, 7 Aug 2018 12:48:44 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > How about these steps:
> > 
> > 	1. start with foo.txt
> > 	2. do typo and grammar fixes (any number of patches).
> > 	3. rename to foo.rst, do whitespace changes, code snippet
> > 	   indentation, heading adornments, update references to this file.
> > 	   (single patch).
> > 	4. Fix up references in the file text to use RST (i.e :ref: blah)
> > 	5. Fix up RST markers (backticks etc). (any number of patches)
> 
> That can certainly work; just don't call it foo.rst until it actually is a
> valid RST file.
> 
> And, of course, go easy with the later steps and try to avoid the
> temptation to mark up everything; we really want to preserve the
> readability of the plain-text files.

Yeah I get over zealous sometimes, I'll keep it in mind.

What is the current view on references embedded in the text versus a
local label with the full reference at the bottom of the file.  I've
seen both and do not know which is _more_ readable?


1.	some random text referencing
	:ref:`Documentation/path/to/file.rst <label>` and more text
	

2.	some random text referencing `file`_ and more text
	...

	.. Links
	.. _file path/to/file.rst:


Although the later form is found in Documentation/ it does not seem work
for local build (since the path is relative) or am I doing something
wrong with my local build?

And for the first form I could not get the html link produced to work if
the <label> was omitted - this label seems superfluous if it is to the
top of the file (I've already added a couple of such labels).

These are minor issues, answer only if and when you have time.


thanks,
Tobin.
