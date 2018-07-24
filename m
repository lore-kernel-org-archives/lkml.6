Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA0C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B1620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQZG9Z0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B1620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbeGXUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:49:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40025 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388537AbeGXUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:49:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so3594817pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0W9ZC2HFTC7PA906uICGXyq508S2gLkFEMAC034oqao=;
        b=XQZG9Z0DIzRukLxD/IY0PSvLCBrbUDhqKnD5avqRFIuX6aWm+SLI/MnMrteOz95IaA
         eaDXhxzqpjsiKzOtFmooL1qpvTgH/yu789t4fUry123NAfuPjQWydo4dQvBHBB2TXDnY
         VQ4I1qTrr/+FDo8xhzllReglVUsVcpH3c7keJeIK5pSJ1R9a1ALCarZfDaFJOdurCTUf
         taucRoc4Pl6DyIcFkB5152xKuVaW5xKwkB43q8Ds+/VFam6O+o537g8l0+F/qKrcMlpW
         w3iMzvCWxsdWUFhJJlYIqmAymTUB/y4cRxZhnWorNAPauF0jRiHV/C0e17VPxBkQIeua
         7Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0W9ZC2HFTC7PA906uICGXyq508S2gLkFEMAC034oqao=;
        b=bBeRA9PSxhlYV1hq/EDHLaNuSxEWYJ3a3E/W2ki6RTTrCbxVnWlEqlKClXHlHJItZJ
         ws5tMprgyxYA0Mjqqc4LCoJftEI5u4RX6O8olP1RzU5XS3pasca3ZdLRqf8m3QPrOMTl
         oJWC7cYuNGHTAkk9LbGKjznQkAbr/fd3Z8pKaZyvTw5Iz7aZdE3kgINZkRMPnUN6VdiV
         oeEzm95iRCCs+xoZS6LA2KqeDDPTqeL/4OeeDR/LwNFtMCB9n2fPZAtZqGF1ZbO3otb8
         xaqvDbRap2asFAnoMsZZas1Jzht4deEwqChjI4jr2LQRBxQOYsLWtbAIPm0qlTXDjf1H
         YyyA==
X-Gm-Message-State: AOUpUlHtqS+xp1ityqXt5d/03xVPIZeKGj9zBX/aIldNge1SKGTRL1Cm
        9Vicl9ls8ZRdPqlQ5k9/76c=
X-Google-Smtp-Source: AAOMgpdTcAc8atbzTH69wOIqklSmEXmuyOlk1ceeAzp24KyyenBL81UNEytl1VEf8rm/AvPzqevl7g==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr18988193pfi.147.1532461274161;
        Tue, 24 Jul 2018 12:41:14 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id n26-v6sm8555382pgv.78.2018.07.24.12.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:41:12 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:41:10 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when
 exiting
Message-ID: <20180724194110.GA190016@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com>
 <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
 <20180723181350.GA58212@ban.mtv.corp.google.com>
 <20180723221002.736e0830@bbrezillon>
 <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com>
 <87in55po3a.fsf@notabene.neil.brown.name>
 <20180724012226.307f578d@bbrezillon>
 <87fu09pfii.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu09pfii.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 11:51:49AM +1000, NeilBrown wrote:
> On Tue, Jul 24 2018, Boris Brezillon wrote:
> > On Tue, 24 Jul 2018 08:46:33 +1000
> > NeilBrown <neilb@suse.com> wrote:
> >> One possibility that occurred to me when I was exploring this issue is
> >> to revert to 3-byte mode whenever 4-byte was not actively in use.
> >> So any access beyond 16Meg is:
> >>  switch-to-4-byte ; perform IO ; switch to 3-byte
> >> or similar.  On my hardware it would be more efficient to
> >> use the 4-byte opcode to perform the IO, then reset the cached
> >> 4th address byte that the NOR chip transparently remembered.

Do these chips cache the last 4th-byte used? I don't recall reading
that, but that would be interesting. It also sounds like that would make
things even more difficult to do robustly.

> >> This adds a little overhead, but should be fairly robust.
> >> It doesn't help if something goes terribly wrong while IO is happening,
> >> but I don't think any other software solution does either.
> >> 
> >> How would you see that approach?
> >
> > I think the problem stands: people that have proper HW mitigation for
> > this problem (NOR chip is reset when the Processor is reset) don't want
> > to pay the overhead. So, even if we go for this approach, we probably
> > want to only do that for broken HW.

If it actually saves bytes on the wire to stay in 3-byte mode more
often, then that could be helpful to all systems. But otherwise, yes, it
doesn't really belong on a properly-designed system.

> I agree that a "my-hardware-is-suboptimal" flag is appropriate.
> I was addressing the suggestion that the current approach doesn't handle
> all corner cases and was suggesting a different approach that might
> handle more corner-cases.  I should have been more explicit about that.

If you want to talk about optimizing the broken-hardware hack, then
fine. That's not my interest at all.

Brian
