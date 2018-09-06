Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB447C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7920844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC7920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeIFUo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:44:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeIFUo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:44:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33435ADFE;
        Thu,  6 Sep 2018 16:08:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 560A3DAD85; Thu,  6 Sep 2018 18:08:27 +0200 (CEST)
Date:   Thu, 6 Sep 2018 18:08:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused pointer 'tree'
Message-ID: <20180906160827.GE24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Colin King <colin.king@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180828132101.9559-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828132101.9559-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:21:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'tree' is being assigned but is never used hence it is
> redundant and can be removed.

For patches removing dead code it's good to do a bit of research what
was the reason for that. In most cases it's a simple leftover after some
other cleanup or rework, ie. harmless, but this needs to be reviewed
anyway and the reference in changelog helps.

In this case it's after my commit 00032d38eaa89c76de7, I'll update the
changelog. And the previous patch removing inode in relink_file_extents
was udpated too.
> 
> Cleans up clang warning:
> warning: variable 'tree' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: David Sterba <dsterba@suse.com>
