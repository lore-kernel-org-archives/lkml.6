Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C66BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A65720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHjK8aXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A65720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeGXVAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:00:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34982 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeGXVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:00:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so3611593pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPAd1sp+UuG7JBscgilTU+f5/Y/VMPkc7LXxVNCkEz0=;
        b=MHjK8aXOVijjxBCCfVmoaEEEYhNQQsxWN/U8tSzCyOugMF8ybTeCB/eivfsthchEtA
         /rBRpKZUSX2WJ1s8xAVmo05NAgQLPnHyVMcbUEI2cSxzj+bCG98jOALjcBCOsVXChvH0
         wQWrWIxxRLDu1rTcR9qvjJpKGMsJTIohCMJrug8S/+dHrtDOkoJpYjskeqrB0Y8GPYvJ
         YFX55O3jTgn5Ic+gmL1BI1lV9JX/+VobQhPblItTtHdJiLSLbxLqta/29zxdeWIUpMlv
         Bj8NLDqYdsh4fsdIY+7D3SboEWAAZUMzqbUu1AOm7b5jRXq8txmAWZk5KlW5dAREZ0Hr
         JG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPAd1sp+UuG7JBscgilTU+f5/Y/VMPkc7LXxVNCkEz0=;
        b=bB655eGsaBq/6UH5z7bEdLVsWM0W06stFoznj92keo8vOpgkQHI58YH9QLwSwCNEmt
         bOXbq4V1bVNPBniAnS89MXqfoglbPZSqYMVS8ngl5lzSuCuavIGU59nA/9MegjPBDA9M
         rREZMFsJGCyHqK+ViiUzRZ+f+0kTm/N5UY/ApzNGekayTLJRWrzwBVfl5aBODugKTZtV
         zo2QCGSnUNrkQu9jQnsoukQdUg7+v9pKFHLsXUq7Sqrl2ASOR5qpn7Z4u1M2kUOCtQAo
         vYnepLylnSFMJFH08lf++tLJORQwc8m01aFoKsN+5Ui01CLkB/9CYRXqfm+r3U0fe/42
         7Y6g==
X-Gm-Message-State: AOUpUlE2k1fjn9PIhR4chtFhw2/ifJzrcYTTTL2gy0yt5KS8p2Ikc/ba
        Gmb6Loc+LYMWWM/fArdCNDY=
X-Google-Smtp-Source: AAOMgpf8uyrYqWeew7uTaDpJFYcDrZbCEpyJHGmREtzxroizOGXOHMRsfJl5+/dpak16K+CowMFAGQ==
X-Received: by 2002:a62:a018:: with SMTP id r24-v6mr19117461pfe.144.1532461925746;
        Tue, 24 Jul 2018 12:52:05 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id r23-v6sm16573058pfj.5.2018.07.24.12.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:52:04 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:52:02 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        NeilBrown <neil@brown.name>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when
 exiting
Message-ID: <20180724195202.GB190016@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com>
 <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
 <20180723181350.GA58212@ban.mtv.corp.google.com>
 <20180723221002.736e0830@bbrezillon>
 <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com>
 <20180724011811.40165a35@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724011811.40165a35@bbrezillon>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Jul 24, 2018 at 01:18:11AM +0200, Boris Brezillon wrote:
> On Mon, 23 Jul 2018 15:06:43 -0700
> Brian Norris <computersforpeace@gmail.com> wrote:
> > On Mon, Jul 23, 2018 at 1:10 PM, Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > > but it still seems to improve things. Of course, that means the
> > > user should try to re-route all HW reset sources to SW ones (RESET input
> > > pin muxed to the GPIO controller, watchdog generating an interrupt
> > > instead of directly asserting the RESET output pin), which is not always
> > > possible, but even when it's not, isn't it better to have a setup that
> > > works fine 99% of the time instead of 50% of the time?  
> > 
> > Perhaps, but not at the expense of future development. And
> > realistically, no one is doing that if they have this hack. Most
> > people won't even know that this hack is protecting them at all (so
> > again, they won't try to mitigate the problem any further).
> 
> Unless we add a huge backtrace at probe time which forces them to look
> closer at what they did wrong (like you seem to suggest below).

Sure, if we can force a huge backtrace, then maybe that's an acceptable
situation. I just predict that someday, somebody will argue that the
warning should be downgraded, since there's nothing the average user can
do about it. (Well, except not buying from that manufacturer in the
future.)

> > Or even better: put this hack behind a DT flag, so that one has to
> > admit that their board design is broken before it will even do
> > anything. Proposal: "linux,badly-designed-flash-reset".
> 
> I think we can remove the "linux," prefix. If it's badly designed, it
> applies to all OSes, don't you think?

Sure.

Shall I send a patch?

Brian
