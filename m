Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E76C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B9E208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B9E208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeG0ONA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:13:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32788 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbeG0ONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:13:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 53D2627E1C;
        Fri, 27 Jul 2018 08:51:11 -0400 (EDT)
Date:   Fri, 27 Jul 2018 22:51:21 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
In-Reply-To: <87in513wbt.fsf@igel.home>
Message-ID: <alpine.LNX.2.21.1807272229020.65@nippy.intranet>
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>        <878t66idai.fsf@igel.home>        <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>        <alpine.LNX.2.21.1807241423000.8@nippy.intranet>        <761399f0-0b10-716c-1e80-cfb19c06e455@infradead.org>
        <alpine.LNX.2.21.1807271428300.65@nippy.intranet> <87in513wbt.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018, Andreas Schwab wrote:

> On Jul 27 2018, Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > Why doesn't gcc convert strncmp to __builtin_strcmp?
> 
> It does.  In fact, it first converts strncmp to __builtin_strncmp, then 
> optimizes it to __builtin_strcmp. Finally, __bultin_strcmp is expanded 
> to a call to strcmp.
> 

So either the static inline strcmp routine has to be dropped from 
arch/m68k/include/asm/string.h (along with #define __HAVE_ARCH_STRCMP), or 
else a static inline strncmp has to be added (along with #define 
__HAVE_ARCH_STRNCMP)?

-- 

> Andreas.
> 
> 
