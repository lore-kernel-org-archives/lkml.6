Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F73C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA062088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="rGl9wcAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+aPZl/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA062088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeGYD7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:59:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41243 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbeGYD7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:59:45 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 21521218CA;
        Tue, 24 Jul 2018 22:50:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 22:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=rSsM0Wyvgy6epKWbaJlNDiaIDJ5fikoMb2MRaHRNl
        3E=; b=rGl9wcAelo1DP8fZKPDWcLgQZV+v38nhLP76Ap2QgUVMuV17gowIqwS8G
        S9pTWIHp82YoaV5KPpOswatUydbXwsT0sHDjedLIBPD8b93RX0TN6wrs/h/5yU6W
        tz56WW/fkMOE9b6kLvDukOivvkyMxUhS6n3zevjD6qfXZxBHHie8b6JBtFWpw/JS
        q5M9msbHPam+bK0aj/HfT+Pkp4+zHdC8TOTHSVGXaX5QXwb7Ke2zR0KE34gEvrpV
        omHL0YYpPAVoT4c++tsu9cQYxR3fm47dLJ6lC+Nce2JVL17JmKvHGt8D/bKaSgyw
        aoWTLQUvZH4RnCJgsSYbxgUB4O25g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rSsM0Wyvgy6epKWba
        JlNDiaIDJ5fikoMb2MRaHRNl3E=; b=I+aPZl/JjksAC3xBh2dXywTi/KicFfzeB
        ZQuXwz61lPP/nh5tWB/78m0qhpXm7pB2MbnzWRbUGbaqFaeTQPLH4kyGJkypwyeN
        CYPNppTFFP4Q13YGn92dwFtrOm4mQve/y30GlotjxT+G8LOzPbIbTH75wFVvy9Cm
        eoolJJZ5fkg2G6dRMOECilUakwRwhLQBDIgXGIKnPrOaiyg5HplMbbkh3PTlvsSy
        Bw20XlEPCMG4KTic2Xl9s0EJkhS28mmpzehwAHAk2biePgpXVxYN4x3mUXB80fzu
        4r+syqfDO16wT1AKjMURAHo0bY3AZovsvvyk+UgDI7VRr3rdrKxMg==
X-ME-Proxy: <xmx:ZuVXW0_YRxj4pqaXl7GK7mzlvUlCCFIFU_GO5ZToFDbNLTfU2YgF9Q>
    <xmx:ZuVXW84JCwJsBwC7Rjkt54h6T1C_cloBNBfXTLJNff20rr7KXvNXLA>
    <xmx:ZuVXW72JRJ9SrK4bXl15vB5XkGQ_IBYxVmJOL3BuYQyR6CpfH-b4_Q>
    <xmx:ZuVXWzDx8C23A2oYCr5stJB-dS1aohX7kvnInHtXn7QjuQNtAGcyaw>
    <xmx:ZuVXW928H54UnGwLqkgKkIO6oAwkS6bJT2fZ-CRsnE3F9_2S13U1pQ>
    <xmx:Z-VXW91mr_83UpJ9peu9zDWPlIscjNhXaO8KeWzCKLHvZe_DOXOgZg>
X-ME-Sender: <xms:ZuVXW8ovFJJDLI-L74WOji4F5foYZD0Z_zII04xKHMj7sEQAAmZJTw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7486E4445;
        Tue, 24 Jul 2018 22:50:13 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] docs: net: Convert netdev-FAQ to RST
Date:   Wed, 25 Jul 2018 12:50:03 +1000
Message-Id: <20180725025005.14332-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

Is it ok for this to go through Dave's tree?  Patch one touches a
line in Documentation/networking/index.rst  Patch two depends on patch
one so it needs to go through the same tree please.


Dave (and Jon),

Kernel docs are prefer restructured text (RST) format.  In doing the
conversion I tried a bunch of different ways to break it up to ease
review.  Nothing I tried worked since so many of the changes touch so
many lines.  In the end I did the whole conversion as a single patch and
listed in the patch commit log each type of change that was made.

Also, with these conversions I'm finding it difficult to split the
changes into separate patches and still keep the tree sane after each
patch.

In an effort to catch mistakes I did the conversion over three days -
there is only so many times you can read a docs file in one day without
your eyes starting to bleed.

Any tips and/or suggestions on making this and future conversions easier
to review much appreciated.  If changes are not widespread it seems to
be better to split the file rename into a separate patch then make the
changes after that.  (For this one it didn't help.)


thanks,
Tobin.

Tobin C. Harding (2):
  docs: Add rest label the_canonical_path_format
  docs: net: Convert netdev-FAQ to restructured text

 Documentation/networking/index.rst           |   1 +
 Documentation/networking/netdev-FAQ.rst      | 259 +++++++++++++++++++
 Documentation/networking/netdev-FAQ.txt      | 244 -----------------
 Documentation/process/submitting-patches.rst |   1 +
 4 files changed, 261 insertions(+), 244 deletions(-)
 create mode 100644 Documentation/networking/netdev-FAQ.rst
 delete mode 100644 Documentation/networking/netdev-FAQ.txt

-- 
2.17.1

