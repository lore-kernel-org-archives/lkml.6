Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A25C64EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB11720875
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="vUArfxnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB11720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJGKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 06:42:55 -0400
Received: from imap.thunk.org ([74.207.234.97]:44216 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJGKmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 06:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5zwO9NZgwJbTf09T6OEh+9VCoIdaGNT9FDjI2+3/4a8=; b=vUArfxnpSI0KNUOiB2cjRzn1c9
        bxXfANSBF45jFhk94G99dh7ychFFIi5u9vjK51MZG232sFyz3nOcZGQf5FD2mIKO3LtEyq41jeIe3
        8qiRFjgux5N2+ysW9y9KBKQkZxpUjEeXVEJr5//15JaP8G35A6ZHIQ/g5RObRsBZmjaQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g8zs6-0006WK-Js; Sun, 07 Oct 2018 03:36:46 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 888177A5250; Sat,  6 Oct 2018 23:36:45 -0400 (EDT)
Date:   Sat, 6 Oct 2018 23:36:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     cgxu519 <cgxu519@gmx.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.com, jaegeuk@kernel.org,
        yuchao0@huawei.com, shaggy@kernel.org, hubcap@omnibond.com,
        martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 2/5] ext4: cache NULL when both default_acl and acl
 are NULL
Message-ID: <20181007033645.GA12046@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        cgxu519 <cgxu519@gmx.com>, adilger.kernel@dilger.ca, jack@suse.com,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-2-cgxu519@gmx.com>
 <f1dd02a3-78ea-0240-72cc-135ee26f6524@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dd02a3-78ea-0240-72cc-135ee26f6524@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:04:35PM +0800, cgxu519 wrote:
> On 08/31/2018 10:33 PM, Chengguang Xu wrote:
> > default_acl and acl of newly created inode will be initiated
> > as ACL_NOT_CACHED in vfs function inode_init_always() and later
> > will be updated by calling xxx_init_acl() in specific filesystems.
> > Howerver, when default_acl and acl are NULL then they keep the value
> > of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> > in this case.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Applied, thanks.

						- Ted
