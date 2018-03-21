Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeCUXam (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:30:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753980AbeCUXaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:30:39 -0400
Date: Wed, 21 Mar 2018 16:30:34 -0700
From: Darren Hart <dvhart@infradead.org>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Micha?? K??pie?? <kernel@kempniu.pl>,
        Andy Shevchenko <andy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: fujitsu-laptop: Revert UNSUPPORTED_CMD
 back to an int
Message-ID: <20180321233034.GB24138@fury>
References: <20180310204353.9584-1-kernel@kempniu.pl>
 <20180311041056.GA5432@gateway.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311041056.GA5432@gateway.atrad.com.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 02:40:56PM +1030, Jonathan Woithe wrote:
> On Sat, Mar 10, 2018 at 09:43:53PM +0100, Micha?? K??pie?? wrote:
> > UNSUPPORTED_CMD was previously 0x80000000 (int), but commit 819cddae7cfa
> > ("platform/x86: fujitsu-laptop: Clean up constants") changed it into an
> > unsigned long due to BIT() being used to define it.  As call_fext_func()
> > returns an int, 0x80000000 would get type promoted when compared to an
> > unsigned long, which on a 64-bit system would cause it to become
> > 0xffffffff80000000 due to sign extension.  This causes one logical
> > condition in fujitsu-laptop to always be true and another one to always
> > be false on 64-bit systems.  Fix this by reverting UNSUPPORTED_CMD back
> > to an int.
> > 
> > This patch fixes the following smatch warnings:
> > 
> > drivers/platform/x86/fujitsu-laptop.c:763 acpi_fujitsu_laptop_leds_register() warn: always true condition '(call_fext_func(device, ((1 << (12)) | (1 << (0))), 2, (1 << (16)), 0) != (1 << (31))) => (s32min-s32max != 2147483648)'
> > drivers/platform/x86/fujitsu-laptop.c:816 acpi_fujitsu_laptop_add() warn: impossible condition '(priv->flags_supported == (1 << (31))) => (0-2147483647,18446744071562067968-u64max == 2147483648)'
> > 
> > Fixes: 819cddae7cfa ("platform/x86: fujitsu-laptop: Clean up constants")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Micha?? K??pie?? <kernel@kempniu.pl>

Queued up, thank you.
-- 
Darren Hart
VMware Open Source Technology Center
