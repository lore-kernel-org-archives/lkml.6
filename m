Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeFAFQb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 01:16:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60326 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFAFQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 01:16:28 -0400
Date: Fri, 1 Jun 2018 06:16:26 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/32] vfs: Make close() unmount the attached mount if so
 flagged [ver #8]
Message-ID: <20180601051625.GR30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720685405.9073.17445116582570028610.stgit@warthog.procyon.org.uk>
 <20180531191955.GG30522@ZenIV.linux.org.uk>
 <20180601015255.GP30522@ZenIV.linux.org.uk>
 <20180601031829.GQ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601031829.GQ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 04:18:29AM +0100, Al Viro wrote:

> +void umount_on_fput(struct vfsmount *mnt)
>  {

.... which needs to do mntput() in case if it's attached.
