Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D96C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA99020878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pg2429G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA99020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeGIOlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:41:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55993 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754517AbeGIOlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BL81swADh6dn6OzdR4M1bko01GEs9sV7XdzdR7vAUqo=;
        b=Pg2429G/hnQ8IrDuiVWpvjt1cUQkmKgbVr0ueWdSTVN4OYPVcEA+zPcpRaf5Nxm13r0NLLELn689q/sJX6iMy4jY0Me0X29hGEZYFJ8XaHpasw2NyfkqzCIl0N7rAA1D4Cj8wBLjKLZs+jx44FJUeG7nnNEgqP90NbsdNnYSzWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fcXLe-0005gB-9C; Mon, 09 Jul 2018 16:41:06 +0200
Date:   Mon, 9 Jul 2018 16:41:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Masahiko KIMOTO <masahiko.kimoto@cybertrust.co.jp>
Cc:     f.fainelli@gmail.com, fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hiraku.toyooka@cybertrust.co.jp
Subject: Re: [RFC PATCH 0/1] net: phy: skip autoneg of ethernet(fec) on
 network boot
Message-ID: <20180709144106.GJ10376@lunn.ch>
References: <1530857230-31124-1-git-send-email-masahiko.kimoto@cybertrust.co.jp>
 <8a437ead-5ded-57c4-c44f-95986442d626@gmail.com>
 <20180709.182902.1637265651643155858.kimoto@cybertrust.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709.182902.1637265651643155858.kimoto@cybertrust.co.jp>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 06:29:02PM +0900, Masahiko KIMOTO wrote:
> Hello Florian,
> 
>   > I completely acknowledge and support the use case, but your
>   > implementation is definitively not the way to go. In my experience the
>   > problem is usually that there may be a disagreement on the
>   > Pause/Asym_Pause advertisement bits and that alone is responsible for
>   > triggering a re-negotiation. Can yo check if that is the case here?
> 
> Thank you for your support.
> 
> Concening the problem about PAUSE/Asym_PAUSE advertisement you pointed out,
> I could not understand your consideration.
> 
> Would you tell me more detail about it?

Hi Masahiko

You said that the PHY is being configured 3 times, and might be doing
auto-neg three times. Often a phy will not actually perform auto-neg,
or do it much faster, if the advertised bits do not change with each
re-configuration.

So check how u-boot is configuring what is advertised, and look at
what Linux is configuring. In particularly, look at the pause
configuration. If pause is configured different in u-boot and Linux,
try to make it the same. Things might go faster than.

    Andrew
