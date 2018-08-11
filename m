Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F07C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E8321A00
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bsWTLQac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E8321A00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeHKXXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:23:47 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52468 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHKXXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:23:46 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8CBEE5C1AD6;
        Sat, 11 Aug 2018 20:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534011593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zs8qZTuntC5YS4h07070AcZG9kuelqBEqxXybYZI3gE=;
        b=bsWTLQacrqqLh3dKpDw/r7TWY8RytUYhqEMBYppwfak1FzgFEbF6RwGSd9qVFWs4q0gO8/
        hJVnnwVJ5Zsd6xfsigFk/kwGEtFoKxjv21R0tCB9yiISl1eGVM781mFTiLPQosCsBJeYv8
        9PDdY64LQ03kTv2LeI7x8GpiYrT1HiY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 Aug 2018 20:19:52 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     catalin.marinas@arm.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: drop experimental mark for ARM stack unwinding
In-Reply-To: <20180811165728.GS30658@n2100.armlinux.org.uk>
References: <20180811103127.21485-1-stefan@agner.ch>
 <20180811165728.GS30658@n2100.armlinux.org.uk>
Message-ID: <9c1b118342fa64f208f66d9bf651f0e8@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2018 18:57, Russell King - ARM Linux wrote:
> On Sat, Aug 11, 2018 at 12:31:27PM +0200, Stefan Agner wrote:
>> ARM stack unwinding is upstream since 2009 and has been proven
>> working well. At this time it is the preferred stack unwinding
>> support since it also supports Thumb 2. Do not scare people
>> and drop the EXPERIMENTAL mark.
> 
> Actually, there are still cases where we're missing the annotations -
> I've seen them in various oops dumps, but I forget where they are.
> What I do remember is that they didn't seem trivial to fix at the
> time, so it's still recommended that frame pointers are used if you
> want to guarantee getting a debuggable oops dump.

Ok, but does that warrants the experimental mark?

Experimental sounds rather harsh to me. People might disable it because
of that... I'd rather have a >90% chance of having a good stack trace
than none at all.

--
Stefan
