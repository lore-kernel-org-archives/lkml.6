Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDFINH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:13:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751344AbeDFINF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:13:05 -0400
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
Content-ID: <22388.1523002383.1@warthog.procyon.org.uk>
Date: Fri, 06 Apr 2018 09:13:03 +0100
Message-ID: <22389.1523002383@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> lookup_one_len() seriously depends upon exclusive lock

In the code it says:

	WARN_ON_ONCE(!inode_is_locked(base->d_inode));

which checks i_rwsem, but in the banner comment it says:

	* The caller must hold base->i_mutex.

is one of these wrong?

David
