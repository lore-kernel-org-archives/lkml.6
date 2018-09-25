Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39379C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C5420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuP4OZiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C5420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeIYPuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:50:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48987 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbeIYPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:50:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7821821D37;
        Tue, 25 Sep 2018 05:43:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 25 Sep 2018 05:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FJ8sJH
        IoHbTabfqHqxelMZT209fbF36DwVpGx5kZFmg=; b=QuP4OZiBSOZaIT+6cOgroU
        MagIXISD9hGzFyLvxWagMt/j79sOqQv6s4r+h3aWm6Bc2O/PisYTjMNYGr7GRc9V
        AVq0prL+knnY6lEcGlH2V8wAzlCtG27r64+iQoBTayKWgE+Vmu48052H6+Xu+RjD
        X6Rdt8hczRBlY1z0lGVXxef7UVchoDvPqYkqT77YQRID0zodQLWbakXrfD/tcb07
        /uPICjxLEpxgdGprRx34NVNcl/skGeaWjDErAsWzrCHb0oX3E82Q/M03Mn5Xs5Hg
        ZVCM7RD6kWOJW97xyyRySMYI9O6zyzvxgE9n2F+JK1/BkvPWphrVmHfdylrGtCMg
        ==
X-ME-Proxy: <xmx:NwOqW76A5EsysMEUabxsJSrNeE_CR1AbHUZKLydfAQjJ5r5xeSxGCQ>
    <xmx:NwOqW5xaXylEq-gf39dCXFohAqQW9hhrcwvuHkH2PzFA31piS6WeYw>
    <xmx:NwOqW5DnoK1yLMuzdbjUmLrosXrCGi7mv7hPEwstRG2nY2CGCdFVLA>
    <xmx:NwOqW12clTJvr1KswFK9yfj7E1_eBHJf4e0Mfhw36329gtWgy44zMw>
    <xmx:NwOqW60jkZaEOZIuO-27EAygM5QvQHomYxegx_lfxddidJDmR_4ADw>
    <xmx:OAOqW4uAB6__2ylfnQeQTRU_X3gBVwUPY5dMldZlUzk7jb6bgkf0UA>
X-ME-Sender: <xms:NwOqW8CnrdJWA3NtSvj-HaJFCwePQfxOFXJUt-HlWOPOqlWd_cJ6ug>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E0FD102DE;
        Tue, 25 Sep 2018 05:43:19 -0400 (EDT)
Date:   Tue, 25 Sep 2018 11:43:17 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20180925094317.GA12065@kroah.com>
References: <20180924.203224.1604558581746424370.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924.203224.1604558581746424370.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 08:32:24PM -0700, David Miller wrote:
> 
> 1) Fix multiqueue handling of coalesce timer in stmmac, from Jose
>    Abreu.
> 
> 2) Fix memory corruption in NFC, from Suren Baghdasaryan.
> 
> 3) Don't write reserved bits in ravb driver, from Kazuya Mizuguchi.
> 
> 4) SMC bug fixes from Karsten Graul, YueHaibing, and Ursula Braun.
> 
> 5) Fix TX done race in mvpp2, from Antoine Tenart.
> 
> 6) ipv6 metrics leak, from Wei Wang.
> 
> 7) Adjust firmware version requirements in mlxsw, from Petr Machata.
> 
> 8) Fix autonegotiation on resume in r8169, from Heiner Kallweit.
> 
> 9) Fixed missing entries when dumping /proc/net/if_inet6, from Jeff
>    Barnhill.
> 
> 10) Fix double free in devlink, from Dan Carpenter.
> 
> 11) Fix ethtool regression from UFO feature removal, from Maciej
>     Żenczykowski.
> 
> 12) Fix drivers that have a ndo_poll_controller() that captures the
>     cpu entirely on loaded hosts by trying to drain all rx and tx
>     queues, from Eric Dumazet.
> 
> 13) Fix memory corruption with jumbo frames in aquantia driver, from
>     Friedemann Gerold.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit 5211da9ca526a5adddee1ccd078e6e33a583ab36:
> 
>   Merge gitolite.kernel.org:/pub/scm/linux/kernel/git/davem/net (2018-09-18 09:31:53 +0200)
> 
> are available in the Git repository at:
> 
>   gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

Now pulled, thanks.

greg k-h
