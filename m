Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA1C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="UIBwfGDQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjHecy1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB0B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeJWFmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:42:35 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:46831 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729444AbeJWFmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:42:35 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 01:42:34 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 3830CA4A;
        Mon, 22 Oct 2018 17:13:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Oct 2018 17:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=FIqaQsHGINwO438/mscUzkrIs1T
        N2tGydpUe2mDeT6Q=; b=UIBwfGDQV99U1th/qx44GhKGGv+X7wBRYp9djCgsiUU
        h2Fd4q1h2e7XiZ5SdpTVnhaiI4p6XTirtbq6KeoTxuBIy6j9mN8DAZtsJ4AhKoAE
        RsO0sfSw49PJLlbKJDvg+HxfUtEvom2OJmqYa7YarjcdMg+xF6wn//qDtJHVwygq
        QmTTC7TX3WuxaaV1zu8khSl9q1OY3eiqQ0U6FZFmHKhsOQuJkKoU0+pJ4XJSSSWi
        VLyCvtkwmm/sDTUh9mRXlIbqOpFCD1mGwf4Rm1L96B7PG+bRNaklgxZRUaSXAE/8
        iu94bgyrsS0k1MxrgUMdikZlgmH9xgs0S66jyW0CjMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FIqaQs
        HGINwO438/mscUzkrIs1TN2tGydpUe2mDeT6Q=; b=QjHecy1uthj5ByZcBHgJVI
        Uyy7GIQVDLto72Bj+oKaPp6XnM4F+CFGLv5yhzguNRp3UckL5AC3CyQP9UesLmPe
        YEdQTRZl4JBlBe1aHxt05K9b5ynh/NJfWUwRYTK4D9ykdXUA/2G26a8r8an+cxvD
        KDVJozvgLeYeAhPEOTKV9NyWSH7TL6RaKvFQ06v9E2Y55Sx1e4+Z0APHpcIkGgGk
        W6Z75vq39s0OoG1xi27nX7FdLayPa0v6SbhStcAnk50W14y+zTGUpJxdwhPmB9ys
        XYiIenOLoyaGE06TVEIYqFRdDid28VG9VDlJDVoq6vQJ1/gH9of382WcX0u4uNyQ
        ==
X-ME-Sender: <xms:hD3OWzpWsHhSSw9BXPd6d6eT7K1bu1cZAJfcVFD6Qhdxqcxs0jXYaQ>
X-ME-Proxy: <xmx:hD3OW5LtXLo2Q0OK5st6OqYdxk1Vkc03EeJkDmKu6qqQ7Fzog_GmEg>
    <xmx:hD3OW4Fxm4U50qyjjWMkbWaX0iWoCPilLJz7bMf4C0MljV722ZpHcw>
    <xmx:hD3OW56O3Wi0mN605tBOp2sQOYHmi7elbrtR-rt9KQVhGKUgmE4FKQ>
    <xmx:hD3OW5NRGc8dwsD8wn2j-0p-yrBEpSrIf7yaNi5aeyWnu5nU_nF38Q>
    <xmx:hD3OW_IqabcexA4JdBmvaWfNbCAojQGFPT-oerpR7sssrNQGlhkYrw>
    <xmx:hD3OW9etl_okUZS0prV2rUzmuDJq3AbPq_iSR4A5uaPWbnRnGb1q6hIrW64>
Received: from localhost (unknown [167.98.65.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B831102EC;
        Mon, 22 Oct 2018 17:13:39 -0400 (EDT)
Date:   Mon, 22 Oct 2018 22:10:25 +0100
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [GIT PULL] code of conduct fixes for 4.19-rc8
Message-ID: <20181022211025.GA8911@kroah.com>
References: <1540066514.3464.22.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540066514.3464.22.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 01:15:14PM -0700, James Bottomley wrote:
> This is the series of patches which has been discussed on both ksummit-
> discuss and linux-kernel for the past few weeks.  As Shuah said when
> kicking off the process, it's designed as a starting point for the next
> phase of the discussion, not as the end point, so it's only really a
> set of minor updates to further that goal.
> 
> The merger of the three patches to show the combined effect is attached
> below.  However, Greg recently posted the next phase of the discussion,
> so people will be asking what the merger of the series looks like. 
> Ignoring the non-CoC documents, I think it looks like this

Sorry for not responding sooner for this, travel and the meeting today
took up my time.

Anyway, as we discussed today in the Maintainers summit, let's leave the
Code of Conduct text alone for now.  It matches what "upstream" has with
the exception of removing that one paragraph.  If you have issues with
the wording in it, please work with upstream to fix the issues there as
hundreds of other projects will benefit with your changes if they are
really needed.

For now, let's let things settle down and not worry about hypothetical
situations that might possibly happen in some way or another as we can
debate that type of thing endlessly (it's a good skill we have which
makes us great kernel developers, but it not always transferrable to
other environments).

If real issues do come up in the future, we will address them then, as
we always have the option to change and revisit things as needed.

thanks,

greg k-h
