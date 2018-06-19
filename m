Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65791C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C2A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/B6cI0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C2A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030273AbeFSR1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:27:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vXnN97+IkJ5WZv0RfUrd/xjNQZ8L/UTHY0kBNocozlM=; b=q/B6cI0yG9VR37nu1ERFYbhQU
        YmXMK+dmyGKQVnBX7IY9QTUAMsoTYiAxnfxt7R2sFO5ef3GrKlimauiG2eA2ugxgzY/OulwpdtXNE
        l0E0YI7kLsXrhZEz0AYX7y0iaobi/dKs8l6kRRG+18rZU+eHx4uXUumQDu5OehUuyd8ocnGpn8ugI
        RvXxn0LQEZ4eyhrbb8/ptd3UaP4uFLSeaKSjB92ntw4LVPbIwU1ZSkihiweumjWs10PelUDg1m+io
        p3C6kEfwlH71nHGqUTFu5Jl5h496XFZe1EVVIm2uErmPGcDPpGCG4sW3i7rGxGayBePhy8KRvjfeq
        cfsB4oRUA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVKPI-0000SP-K2; Tue, 19 Jun 2018 17:27:04 +0000
Subject: Re: [RFC v7 0/1] mconf: global i-search in menu prompts
To:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20180617121534.4809-1-dirk@gouders.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <87d68443-ad2c-50e0-ef10-f6a9f349c050@infradead.org>
Date:   Tue, 19 Jun 2018 10:27:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617121534.4809-1-dirk@gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2018 05:15 AM, Dirk Gouders wrote:
> Hello,
> 
> Most noticeable changes are that the exact starting position before
> doing i-search is now remebered and i-search stays on the current item
> if a character was added and the new string also matches this item.

Nice.

> Also, compiler warnings were eliminated and A_UNDERLINE was replaced
> with A_STANDOUT to mark active menu items when the focus is on the
> buttons, because I tested mconf on a tty where underlines were not
> visible.  For a complete list of changes see below.

This highlight/standout is good, helpful.

> Dirk
> 
> Changes in v7:
> 
> 
> * Rework i-search instructions text

For the (old) menu_instructions[] string:  that has a hard time fitting in
80x25 or 80x30 console.  I.e., it is being truncated.  I had to resize the
console to 90x30 to see all of it.  Oh well.

> * Remember exact starting position in menu
> 
> * Stay on menu item if it matches pattern with a character added
> 
> * Fix print_autowrap for short texts
> 
> * Focus on buttons: use A_STANDOUT for current menu item

:)

[snip]


I like it.

thanks,
-- 
~Randy
