Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124CA21755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="BE7oN3SW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZCSlmSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124CA21755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeHNBwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:52:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38629 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730203AbeHNBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:52:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 080FB21B84;
        Mon, 13 Aug 2018 19:08:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 Aug 2018 19:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=mGJgpSjBO2eTL7yUDfrzvIwnETyoggSXoVxz8hRn/mc=; b=BE7oN3SW
        LhutBMcz4K5i84NUMxnuBM18OF6p2W7l3YdNM2keuuCGtr9/GBu0M5g74ezJXeeW
        MEoRlePPvQEJL4iIl86fEmjiPMLnxFyolt2rqfj4EXbPPr8UrThIszpsbTFzYIBP
        mZwPOp2AVPMrjJkiEkLUHRnlHivl3ASNDiVCXheaEb/A/5QCWswet3zMIQJWxzHO
        +upPvaBQrDROkFMIUkM2ZEyaXdEVfIKZ2o/HRjPsEzq7fQBBJYNAl8oEimXvw5yb
        5obSH4lZGIf/WfwA/9rkVwy0ZfAMfJ9FbPZpT7vngRjUN12Mk4r3YBrPDrrFPS2O
        uAwJ3Zqb7O8swQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=mGJgpSjBO2eTL7yUDfrzvIwnETyog
        gSXoVxz8hRn/mc=; b=ZZCSlmScWH1Qv4VOQ6u4vq+2dbLqhtMw/A8VI/5L8+uYd
        ouPMSlh/R38AEr7RdeR/+SRbCTCpN0DqiAye9bCYbOubu1NnM5EGz1W+DZ8PaZWr
        ygL40XWqHiZuGhPp+ggZq0m2kWU5B1ugoiNrfb2G0E1TnHWe0ET8Zp8QdA2DDzuP
        4mezkc/8TUDKQ3hOhmYZER6Ud0Vc0vaE4TvUSMb+uNrLDZXDuszmFSNqFGPZbWCN
        HXlw5t4juL2pOpWkq39EU++2YGrQMiZxAfYBTC5X8C6V6YbhnWwn/WgUFRdSdaGg
        Jzzz8umQvHl6k3x6qgklcQWVAt760ellIv1LcyXuA==
X-ME-Proxy: <xmx:UA9yW1DnUh7oKpHhs0wqRSx13n-dGBy8KsSRP-oU0lLok97u6OF7mA>
    <xmx:UA9yWztTJzdJRoyANx9POMUb9_8y8S4YPvn2hLjpC3pVXgEIpGYF_Q>
    <xmx:UA9yWya7w9xrAVtZXKs5onZNdLY1jQkrkvbhaIlQjE7uwI9xaOZOqw>
    <xmx:UA9yW-VQST5rXCWQw5Q8A6E_ZFLoymqezWi7mz2li3qA1c947Sy5EA>
    <xmx:UA9yW-4amSr_2DDelkNH8SXh9WSCwFNh09OS1RdSK5Uskq0gIvjxjQ>
    <xmx:UA9yW4m0qIRraHtqEUoKRwvnIxvWL4St31rIA-B2CQhsjX1joyLGRA>
X-ME-Sender: <xms:UA9yW7vAIE2_K52SF1J_pp1HbiGxchVxwcAvEaC9JEQ4utKlQXDbEA>
Received: from localhost (ppp121-44-255-31.bras2.syd2.internode.on.net [121.44.255.31])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98A2CE4439;
        Mon, 13 Aug 2018 19:07:59 -0400 (EDT)
Date:   Tue, 14 Aug 2018 09:07:55 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: Convert tcp.txt to RST format
Message-ID: <20180813230755.GP32374@eros>
References: <20180813072048.15064-1-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813072048.15064-1-me@tobin.cc>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 05:20:48PM +1000, Tobin C. Harding wrote:

Please drop, I didn't notice the merge window had opened.  Sorry for the
noise.

thanks,
Tobin.
