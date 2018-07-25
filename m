Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6496B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="OJkhnxqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OBxg95sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6496B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeGYXpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:45:25 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45793 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731174AbeGYXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:45:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 532D12A6;
        Wed, 25 Jul 2018 18:31:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jul 2018 18:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=YSVJe6pHvZOo02PXOPyxpWSpCeK8JSyEq9/wvgIZOeg=; b=OJkhnxqN
        SqK+DX8PLgEMFFu2IcfqduRICoWbp8j6B/EpIbSsBzxki5MXJKO5S0U34O7toOQ3
        9v3v1RoRm5dwlG3bju87YnkrZmmvujXZu3dBaCiEQhQY9UaIYAVPOkXQKcWSSJ1m
        IYQVMAy7hPUCjdLeDqJG7oDy3vONO48jYDOe4SyK+g1b+G2AcVqkDQCRWNyGxZ+H
        42VPbUYAiJLJHGnrQbv1ocjvLqGCN/P2ddB+7heUPogfC8TKjCEJULaVIZ946lfN
        XG4B0tUyYCzYPpaoAHN1Sbl4ORZazlW94L5Mx+JZBdYnnRrQsHXKKxAe6QgMY5xH
        MV3m69J9QYbF7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=YSVJe6pHvZOo02PXOPyxpWSpCeK8J
        SyEq9/wvgIZOeg=; b=OBxg95sjR2d0uqrFFBb5jA9Kz6U8/0tMHn3dCcjCEXb4f
        SIrizL3q6HFBOyphH6L40azHzBaaO0r43Fe0J+LJhMX3A1leUjCsV2+DBgUXizHy
        if6nyD0uNR59ZTf//yZ1QAN4WKXufvNi1soprpY0xKd5iNNW7qvbw3HW893adRVs
        Z6nsJwBRbnTJVouuz5Fu5coNxJ+JmLxW5QwdbbIze5iQqkK7uFCfeqnFKO+grsd/
        ZnUqB934bkG+saOuHpr+h8d+kIyT2/kZpSiNu0GScJ1C8XzR9EamU9QcbU7zqqKf
        QxOf5iUXkJFmtJ7vo4n6NtyjXSmEjurY73HGyjysA==
X-ME-Proxy: <xmx:SfpYW_r8OZRngVZZgBq_DsA9LzD9PaQR8OkOfH4ZEhghBYZMOdeyfg>
    <xmx:SfpYWxm42W1oMsCEV4PVHOq3Bt5I1CWn3GRVe9QfPg4AspZZtAK_9Q>
    <xmx:SfpYWygggIN6t9uuspfz1UOPnUMZXfhpHpq3G3eHjmeTeSKiTNH9rg>
    <xmx:SfpYW7Y9XfMsBBwus7MPf97zQaBW3144fKJxI_2SXTe7KqqF6FytBQ>
    <xmx:SfpYW4sM25836KeQXIqe5DbqmJJ37Oqz-UxBRTddFnDZb7-tc5e9VA>
    <xmx:SfpYW7VSdpPxNbXLchWnNyUpwCyB8WfIvuDKbc9rlz0Lfi72KWFW9A>
X-ME-Sender: <xms:SfpYW3TOuBcox7k2Np9e4X1MnNZrapZhlGEMGElvRdQellnFH-N_QQ>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E0B010261;
        Wed, 25 Jul 2018 18:31:36 -0400 (EDT)
Date:   Thu, 26 Jul 2018 08:31:33 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] docs: net: Convert netdev-FAQ to RST
Message-ID: <20180725223133.GE6067@eros>
References: <20180725025005.14332-1-me@tobin.cc>
 <20180725032810.GA6067@eros>
 <20180725081415.373bde37@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725081415.373bde37@lwn.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:14:15AM -0600, Jonathan Corbet wrote:
> On Wed, 25 Jul 2018 13:28:10 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Since I've already botched it can I ask for guidance here.  The problem
> > is updating the links means making changes that will cause merge
> > conflicts if they go through net-dev tree (since most references are in
> > Documentation/*.rst).  But we can't go through docs tree either since
> > that could lead to merge conflicts later as well.
> 
> Merge conflicts are a way of life in Documentation/ - everybody messes
> with it.  They are usually pretty easy to resolve.
> 
> I only see a handful of references to netdev-FAQ.txt in the tree; I would
> suggest just making the change and being done with it.  There shouldn't be
> any need to do a more complicated dance than that.

Ok, I'll re-spin with all references fixed.

> And to answer your other question, yes of course it's fine (and expected)
> for this to go through Dave's tree.

And accept abuse for all merge conflicts in person at Plumbers in November :)

Thanks,
Tobin.
