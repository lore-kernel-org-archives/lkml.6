Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDFIJB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:09:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbeDFII5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:08:57 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180406065118.GZ30522@ZenIV.linux.org.uk>
References: <20180406065118.GZ30522@ZenIV.linux.org.uk> <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk> <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] afs: Implement @sys substitution handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22232.1523002135.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Fri, 06 Apr 2018 09:08:55 +0100
Message-ID: <22233.1523002135@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> > +static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
> > +				       struct key *key)
> > +{
> 
> > +		ret = lookup_one_len(buf, parent, len);
> 
> Er...  Parent is locked only shared here and lookup_one_len() seriously
> depends upon exclusive lock.  As it is, race with lookup of the full name
> will mess the things up very badly.

How should it be done?  Do I have to use d_alloc_parallel(), analogous to
lookup_slow() without taking the rwsem again?

David

PS: Can you stick a banner comment on d_alloc_parallel() describing it?
