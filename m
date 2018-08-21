Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C71C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED021735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXbIsBMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ED021735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHUJdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:33:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+6mg4P+MOb9+SHS/evbOP0DuPZ4Vgqdm2kEH1dkv000=; b=RXbIsBMI/dedUMWrOEnynvgVx
        FHfqBG//pB7a+r3p466JBD2Esb+8sC5/IhsJfkqzD8pNZ1124B1mMOvcNGt39obMpZagIIDcFGLP/
        dTgA+XOoVXxjgfzWkycAK3Zsmyg7d2+pdPXf7aLSaDoh10x589EZfXbB9VYsAAitfuSol0A24ziJq
        l2NZsy3kUGr9LqXvyhvCBxne76is01aiyh/KwLnepMoMYkF2CHLG7g4syGIKGFgARWl1PdFXao/KD
        G7pcKuf6dsuqYTVzHFNER1gZYp20xtukJPwR//U7Xfotyl0N1vTmHXROJDEyP0Y4tN8HUbGReEX29
        PZvLqvwkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frzwJ-0001sf-Hx; Tue, 21 Aug 2018 06:14:51 +0000
Date:   Mon, 20 Aug 2018 23:14:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
Message-ID: <20180821061451.GB481@infradead.org>
References: <20180817102645.3839621-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> Hi Bjorn and others,
> 
> Triggered by Christoph's patches, I had another go at converting
> all of the remaining pci host bridge implementations to be based
> on pci_alloc_host_bridge and a separate registration function.

I really like the idea behind this series.

> I'm adding a bit of duplication into the less maintained code
> here, but it makes everything more consistent, and gives an
> easy place to hook up callback functions etc.

I wonder if there is a way to avoid some of that by adding a few
more helpers, but even without the helpers that approach looks
ok to me.

Do you have a git tree somewhere to play around with the changes?
