Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB718C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456DC253C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WbEfyqNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jb/jn8Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456DC253C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeFYCGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:06:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58603 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751834AbeFYCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:06:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EA6220E46;
        Sun, 24 Jun 2018 22:06:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Jun 2018 22:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=/MJze+aeqNjRd2fQuCZo/c2tzuQyi
        kPXjwxzxaNssSQ=; b=WbEfyqNQte1MBp6J2ts2Ytxkxz0S24wu4TnAlKvCiriSe
        W5By+zu/Sp5Il8CAzmGnXEib5bu52psv2XWqK3ZwpZqL+XiAH5gUER9ulz9bKv7b
        LXn4rzx7bChhvtmCQTO/jvgkppw7JzkN+Q1YDMd2IErlHUkWPUbYSuB9FiahI9mK
        0PYTMuD60/v1HL4csX2WGKzYTXq0Y2ZGPFzi39WAd+PdvsLi5UAiUVtZ9MnvZAq5
        fl9Fz/s0FFVnvDs9T0YhCOYBd8NPvaTAJFoNwL+rK05Z1pd1YIeSLxRKMM1seEtZ
        k8nW1Sn1y1i1bGvytvCsQxyUvkTmizOtrz38/AmYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/MJze+
        aeqNjRd2fQuCZo/c2tzuQyikPXjwxzxaNssSQ=; b=Jb/jn8IpIZJV8Gw/M3GH9a
        6IvRU8xyLNvtHV8I2+HS2WxXmqg3fCmt9vSa1P6Uf7zOB+v3oTJnJ65IpFDNqHcy
        4eKFd4Em8Tj5G3N2ZybNVO5hRWUi5mVxUORBP+tlXutkQqHLANEHV2iD7XqLSVR7
        IJCCmisKte0U+8lGaPYGROaaI3v24CCgXBKNXXn/8Pz6n4r3dIBSN2UWbMoAElyb
        YFWypBQ2ZJsbdhV4dOuYp/JBBckQdzBgQYZyP49X6B2tGf9QgXIjq4+QsocpOgqj
        lg1G4IMx8P2iHK6GLBZKo67ubd0Qfm7XYotXSmZ7N34FJRPITzUXP5CCMy5C3vsA
        ==
X-ME-Proxy: <xmx:I04wWyJkoBW9Jr4vbFRjF8zb5bkwxE6xrR4p1EWRsfZXkob9_nyO5g>
    <xmx:I04wW6Uk4k5RWH85hP8aIRUdXvQP3w3SkfPWZhwvxJLghOZwvoFSjQ>
    <xmx:I04wW0ghLMmJflTjSKAAwKTz1KuI5p8GaLtYzUnSUsOLcpka0DMtcQ>
    <xmx:I04wW19Z11U7cMFZ-70cdpEjeFJciFVgKEQxzDmvzTswCiWX0nP3jA>
    <xmx:I04wW-BSKGrYmCOiCLg0IBn7O-rC1QQc_BLclaKJMPkYfRCaRdeafQ>
    <xmx:I04wWxkeW4GVMrH6Qx78HZ3lti05FOdm3vPjZIkvvVC6_ovXdD3hAA>
X-ME-Sender: <xms:I04wW230c64mc-nMfhVz3kSv3KB36qTWRoA97eLN-xfIF8tgRmrr8Q>
Received: from localhost (ppp121-44-217-101.bras1.syd2.internode.on.net [121.44.217.101])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9060FE40A3;
        Sun, 24 Jun 2018 22:06:26 -0400 (EDT)
Date:   Mon, 25 Jun 2018 12:06:23 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] docs: e100[0] fix build errors
Message-ID: <20180625020623.GJ3006@eros>
References: <20180622003708.31848-1-me@tobin.cc>
 <ba768d6c-dd21-3600-5cba-151b5d6185f1@infradead.org>
 <20180624234135.GE3006@eros>
 <91A1572C-63A6-4420-B01B-A0DD5F84200A@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91A1572C-63A6-4420-B01B-A0DD5F84200A@intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 01:11:33AM +0000, Kirsher, Jeffrey T wrote:
> 
> 
> > On Jun 24, 2018, at 16:41, Tobin C. Harding <me@tobin.cc> wrote:
> > 
> >> On Fri, Jun 22, 2018 at 01:22:37PM -0700, Randy Dunlap wrote:
> >> Hi Tobin,
> >> 
> >>> On 06/21/2018 05:37 PM, Tobin C. Harding wrote:
> >>> Hi Jonathan,
> >>> 
> >>> This patch set fixes current docs build failure on Linus' mainline
> >>> 
> >>> commit: (ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/kleikamp/linux-shaggy)
> >>> 
> >>> (FYI this is 8 commits after Linux 4.18-rc1).
> >>> 
> >>> And also same build errors on today's linux-next
> >>> 
> >>> 8439c34f07a3 (tag: next-20180621, linux-next/master, linux-next) Add linux-next specific files for 20180621
> >>> 
> >>> 
> >>> I split the patches in between the two drivers to enable use of the
> >>> 'Fixes:' tag.
> >>> 
> >>> Tobin C. Harding (4):
> >>>  Documentation: e100: Use correct heading adornment
> >>>  Documentation: e1000: Use correct heading adornment
> >>>  Documentation: e100: Fix docs build error
> >>>  Documentation: e1000: Fix docs build error
> >>> 
> >>> Documentation/networking/e100.rst  | 112 +++++++++++++++--------------
> >>> Documentation/networking/e1000.rst |  76 ++++++++++----------
> >>> 2 files changed, 96 insertions(+), 92 deletions(-)
> >> 
> >> I am still seeing a few warnings (your 4 patches applied to
> >> linux-next-20180622):
> >> 
> >> linux-next-20180622/Documentation/networking/e100.rst:57: WARNING: Literal block expected; none found.
> >> linux-next-20180622/Documentation/networking/e100.rst:68: WARNING: Literal block expected; none found.
> >> linux-next-20180622/Documentation/networking/e100.rst:75: WARNING: Literal block expected; none found.
> >> linux-next-20180622/Documentation/networking/e100.rst:84: WARNING: Literal block expected; none found.
> >> linux-next-20180622/Documentation/networking/e100.rst:93: WARNING: Inline emphasis start-string without end-string.
> >> linux-next-20180622/Documentation/networking/e1000.rst:83: ERROR: Unexpected indentation.
> >> linux-next-20180622/Documentation/networking/e1000.rst:84: WARNING: Block quote ends without a blank line; unexpected unindent.
> >> linux-next-20180622/Documentation/networking/e1000.rst:173: WARNING: Definition list ends without a blank line; unexpected unindent.
> >> linux-next-20180622/Documentation/networking/e1000.rst:236: WARNING: Definition list ends without a blank line; unexpected unindent.
> >> 
> >> 
> >> You didn't get these warnings?  or they weren't important?
> >> or "perfect" was not your primary goal?   :)   [which is fine]
> >> 
> >> [I see around 50 similar doc formatting warnings/errors in the entire
> >> Documentation build.]
> > 
> > Thanks for testing this Randy.  You are right there are a bunch of
> > warnings, I did not think to grep for warnings on these files - sloppy
> > work by me.  The series has been applied already but I'll add clearing
> > these warnings to my TODO list.
> 
> Thanks, already on it.  I have a set of patches that I will push once Dave open’s up his net-next tree.

Oh cool, even better.

thanks,
Tobin.
