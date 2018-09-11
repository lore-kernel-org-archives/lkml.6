Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC34C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3763D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5kNSoFfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3763D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeILC5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:57:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59473 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeILC5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=B6YeQnveHNafZdHz6a8g6lcpiJENPNVZGCmMjS8k27M=;
        b=5kNSoFfC4A3n5Q+7A7lrbXLUKkNwhRA0kccFy981o3dBPTnIxjPdB/vIcDG1C8HJEy0WZwbJsG87ubTZHeRNj8SJwPTi02BIrqOueoKU2usGbzP2oVaeO4QQ8j7uepHGorYiJITt7Ii5jRY1vt76HIye18xKCMbalJmlOUE6Gdk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzqdI-0002bD-1Y; Tue, 11 Sep 2018 23:55:40 +0200
Date:   Tue, 11 Sep 2018 23:55:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 17/17] net: WireGuard secure network tunnel
Message-ID: <20180911215540.GC32007@lunn.ch>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-19-Jason@zx2c4.com>
 <20180911133017.GJ30395@lunn.ch>
 <CAHmME9pwVSeE=4aUD6RKLjE+DrHY1=3OtBS7sAvdR66gaNhNtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pwVSeE=4aUD6RKLjE+DrHY1=3OtBS7sAvdR66gaNhNtA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Most uses of inline are this way after checking the compiler output on
> several platforms. (Generally my build-run-test cycle is actually
> build-IDAPro-run-test.) If you feel that's been done too liberally,
> I'm happy to spend time rechecking each use case.

Hi Jason

I really expect DaveM is going to come along and tell you to remove
them all.

You need a strong argument that they are needed, since this goes
against the general consensus in the kernel, that the compiler is
better at this than humans.

       Andrew
