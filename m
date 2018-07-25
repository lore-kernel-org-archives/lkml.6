Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4EDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1E620856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="GQ6WFuhZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HWc6eVGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1E620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeGYEhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:37:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57851 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725752AbeGYEhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:37:52 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B9249219FE;
        Tue, 24 Jul 2018 23:28:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 23:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=fA19wY/Bi1lAq28NUl0ZR0o9ezUpg4WvJiOXsCGzz8Q=; b=GQ6WFuhZ
        Is9mnaRxPYiVrt4nfdUoHuDwj+9Ifbc2VGejXT8i8/Fyda7/Khsp6RxFEys7h0zy
        C7tSqmjDNSAvrY4Ufizqd5YGulU+Cv1ZE6R74svv4txcViEQu8ASi7J0LLzqGAaQ
        P8bOPjgx1wb+2ZNMYGGIsZjm96lr7eMDflF0FOOxYSlr0P4ZMbWVClU+92sClDP5
        fRvGSxXDz6O3WPaqXWk2U+6rdUvn0WdH4VYBKn8gIP5tpyCD9hDN4RnL7spDnFb3
        JrrpzShm8TN1WmDVQ8TtJ4M1eKmp4ml246XmpxaFNZO/6kCP2GIKcqya3EukYzt7
        taWFR8BCHl7L5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=fA19wY/Bi1lAq28NUl0ZR0o9ezUpg
        4WvJiOXsCGzz8Q=; b=HWc6eVGfaJwbIxuhNfztFC93HgZElt73H16Ex2VbYnCYU
        UOS8eFF2etJ2nMlTFNasYvb5gBn63zKS/U3E4/6U7ZrDZ78lcXzZmM83stNCcV0P
        YK+Eb08lZ7uNn55dKhdqHqgPL1o3VkadTQnolzREwiX1WOq0+iDjBXXQXKPN8zHN
        VICaic/61WXasik2BeawcRT3Ea9W9/D8W3pngTdGMLr2D3cFskh3Wb+N8D+LtzOo
        qGuGg+sAgV79pdUWHEwIwMY/M3TtDu7GoKWn3mimpCj73x68uQLmtpuiH95Mihdk
        Nf4vKxLGiVPXcWck9034u1JauD3Ccv67/edLhJD8A==
X-ME-Proxy: <xmx:Tu5XWyMdmqn8fJpAI-Oyiet2yIROT_eIAGn83euWqlDWqJP4Hl-Kng>
    <xmx:Tu5XW7Dk-Xvvzs2zoGMMTBh5_s1FOuE3FwofK1UBLf8ieD8uiuiV2g>
    <xmx:Tu5XW-PKxsyJkMEnTQoCUnESzm2IDCEK6UhygM-ZDlcB_qZB1DvkWw>
    <xmx:Tu5XW6c3Hig17tjXp7dTgJq65gcbI1ndvQHvjdKjyQDz-eYEL0vX5A>
    <xmx:Tu5XW36vl_jIpDqVqXvog2RiAIZN1ilxHxMvVZne8uVL1xK8B4EXmg>
    <xmx:Tu5XWyEguxmXsDY3h8rYr966u9eINDbiZ7WNoF0_i5HVAFc1X-wu7Q>
X-ME-Sender: <xms:Tu5XW48vbwEAc2-2xJbxdH_SrA_0ZM_ti6a9hb_F7ssVB9nF1NZqsA>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2F5BE4519;
        Tue, 24 Jul 2018 23:28:13 -0400 (EDT)
Date:   Wed, 25 Jul 2018 13:28:10 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] docs: net: Convert netdev-FAQ to RST
Message-ID: <20180725032810.GA6067@eros>
References: <20180725025005.14332-1-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725025005.14332-1-me@tobin.cc>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:50:03PM +1000, Tobin C. Harding wrote:

Please drop this.  I've forgotten to deal with the links from
Documentation/*.rst to Documentation/networking/netdev-FAQ.txt


Since I've already botched it can I ask for guidance here.  The problem
is updating the links means making changes that will cause merge
conflicts if they go through net-dev tree (since most references are in
Documentation/*.rst).  But we can't go through docs tree either since
that could lead to merge conflicts later as well.

My idea was to leave netdev-FAQ.txt in place but with all content
removed except

  'This file has moved to netdev-FAQ.rst. This file will be removed once
  netdev RST conversion is complete'

And then do the same for each file conversion under
Documentation/networking/.  Once all the files are converted a single
patch set updating all references into Documentation/networking/*.rst
could be posted to the docs tree.

One other idea was to leave a symlink netdev-FAQ.txt -> netdev-FAQ.rst
but I don't know how that would play with the build system (docs or
otherwise).


thanks,
Tobin.
