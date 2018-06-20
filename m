Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F230C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AE820836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AE820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeFTOiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:38:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:59911 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753619AbeFTOiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:38:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3D44AE2A;
        Wed, 20 Jun 2018 14:38:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1D1CA1E04AE; Wed, 20 Jun 2018 16:38:05 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:38:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, y2038@lists.linaro.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] [v2] reiserfs: remove obsolete print_time function
Message-ID: <20180620143805.2pfhuy4tm5lc66tr@quack2.suse.cz>
References: <20180620142522.27639-1-arnd@arndb.de>
 <20180620142522.27639-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620142522.27639-3-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 16:25:04, Arnd Bergmann wrote:
> Before linux-2.4.6, print_time() was used to pretty-print an inode
> time when running reiserfs in user space, after that it has become
> obsolete and is still a bit incorrect: It behaves differently on 32-bit
> and 64-bit machines, and uses a static buffer to hold a string, which
> could lead to undefined behavior if we ever called this from multiple
> places simultaneously.
> 
> Since we always want to treat the timestamps as 'unsigned' anyway,
> simply printing them as an integer is both simpler and safer while
> avoiding the deprecated time_t type.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: after a second look, I decided to remove it instead of fixing it.

Yes, that's a good idea. The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
