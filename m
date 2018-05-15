Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeEOO2a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:28:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752348AbeEOO22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:28:28 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180515135333.GA31296@lst.de>
References: <20180515135333.GA31296@lst.de> <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk> <152513043985.13808.14819147732435024607.stgit@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: 'Adding' a writable proc file under /proc/net/afs/ [was [PATCH 3/3] afs: Implement namespacing]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3981.1526394505.1@warthog.procyon.org.uk>
Date: Tue, 15 May 2018 15:28:25 +0100
Message-ID: <3982.1526394505@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> So the real question here is why afs needs a write callback as the first
> user of /proc/net ever in a day and time were we've deprecated adding
> new proc files.  This is a discussion that should be had with linux-fsdevel
> and netdev in Cc.

/proc/fs/afs/cells and /proc/fs/afs/rootcell are not new proc files, nor is
the ability to configure the in-kernel afs filesystem by writing to them new.
The cells file has been there since 2002 and the rootcell file before the
start of the git history in 2005 - it's just that they've been in
/proc/fs/afs/ not /proc/net/afs/.

However, the afs procfiles need to be somewhere under /proc/net/ for the
network namespacing, so I moved the directory over and emplaced a symlink at
/proc/fs/afs.

David
