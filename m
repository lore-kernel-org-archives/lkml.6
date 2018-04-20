Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbeDTM3h convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:29:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754726AbeDTM3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:29:36 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <22411.1524142823@warthog.procyon.org.uk>
References: <22411.1524142823@warthog.procyon.org.uk> <20180419124140.9309-21-hch@lst.de> <20180419124140.9309-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 20/39] afs: simplify procfs code
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22725.1524227374.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Fri, 20 Apr 2018 13:29:34 +0100
Message-ID: <22726.1524227374@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > Use remove_proc_subtree to remove the whole subtree on cleanup, and
> > unwind the registration loop into individual calls.  Switch to use
> > proc_create_seq where applicable.
> 
> Note that this is likely going to clash with my patch to net-namespace all of
> the afs proc files:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-context&id=f60c26c827c073583107ebf19d87bc5c0e71c3d2
> 
> If it helps, I should be able to disentangle this from the mount-api changes
> since the subsequent patch connects the dots to propagate the network
> namespace over automount using the new fs_context to do it.

Okay, I'll follow up this mail with a pair of patches to just use network
namespacing in AFS.  The first exports a function from core code only; the
second is the actual modifications to AFS.

Note that this doesn't actually yet permit AFS to use any other namespace.
The propagation-over-automount issue is handled by a separate patch.

David
