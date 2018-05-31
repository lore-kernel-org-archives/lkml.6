Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeEaXL5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 19:11:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53056 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEaXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 19:11:54 -0400
Date: Fri, 1 Jun 2018 00:11:52 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/32] VFS: Introduce the basic header for the new mount
 API's filesystem context [ver #8]
Message-ID: <20180531231152.GL30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720674345.9073.7664682296580266598.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720674345.9073.7664682296580266598.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:05:43AM +0100, David Howells wrote:
> +	bool			drop_sb:1;	/* T if need to drop an SB reference */

IMO that should be simply fc->root != NULL - if you keep a dentry, you'd better
make sure that its superblock has an active reference, so deactivate_super()
is needed anyway.
