Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NkBpHq+7HFvFVwAAmS7hNA
	; Sun, 10 Jun 2018 05:49:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9D6E60795; Sun, 10 Jun 2018 05:49:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0836602FC;
	Sun, 10 Jun 2018 05:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0836602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeFJFtx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:49:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54432 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeFJFtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:49:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRtDy-00047R-RL; Sun, 10 Jun 2018 05:49:17 +0000
Date: Sun, 10 Jun 2018 06:49:10 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs: factor out inode_insert5()
Message-ID: <20180610054902.GQ30522@ZenIV.linux.org.uk>
References: <20180529144143.16378-1-mszeredi@redhat.com>
 <20180529144143.16378-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144143.16378-10-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:41:41PM +0200, Miklos Szeredi wrote:
> From: Miklos Szeredi <miklos@szeredi.hu>
> 
> Split out common helper for race free insertion of an already allocated
> inode into the cache.  Use this from iget5_locked() and
> insert_inode_locked4().  Make iget5_locked() use new_inode()/iput() instead
> of alloc_inode()/destroy_inode() directly.

... thus hitting the sucker with ->evict_inode(), in condition that is quite
likely to be unfit to be seen by that.

NAK.
