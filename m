Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C1BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5F9205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5F9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbeGXJYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:24:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388461AbeGXJYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:24:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76697AD5E;
        Tue, 24 Jul 2018 08:19:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 333A4DACF7; Tue, 24 Jul 2018 10:19:04 +0200 (CEST)
Date:   Tue, 24 Jul 2018 10:19:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix size_t format string
Message-ID: <20180724081903.GR26141@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717135236.3673195-1-arnd@arndb.de>
 <20180717150400.GA3126@twin.jikos.cz>
 <544184a7-25ae-55a6-3e81-0e1fa1e5cd1d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544184a7-25ae-55a6-3e81-0e1fa1e5cd1d@infradead.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:07:42AM -0700, Randy Dunlap wrote:
> On 07/17/2018 08:04 AM, David Sterba wrote:
> > On Tue, Jul 17, 2018 at 03:52:27PM +0200, Arnd Bergmann wrote:
> >> The newly added check_block_group_item() function causes a build warning
> >> on 32-bit architectures:
> >>
> >> fs/btrfs/tree-checker.c: In function 'check_block_group_item':
> >> fs/btrfs/tree-checker.c:404:41: error: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werror=format=]
> >>
> >> The type of a sizeof() expression is size_t, which is correctly printed
> >> using the %zu format string.
> >>
> >> Fixes: 9dc16aad5660 ("btrfs: tree-checker: Verify block_group_item")
> > 
> > Folded to the commit, thanks.
> > 
> 
> Hi David,
> Where did this patch end up?  linux-next-20180723 is still showing this
> format warning.

It's still in a local branch, I haven't pushed for-next for a few days
but will do today.
