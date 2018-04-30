Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeD3OhN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:37:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753683AbeD3OhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:37:12 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180424141248.GA26136@lst.de>
References: <20180424141248.GA26136@lst.de> <22411.1524142823@warthog.procyon.org.uk> <20180419124140.9309-21-hch@lst.de> <20180419124140.9309-1-hch@lst.de> <22726.1524227374@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-afs@lists.infradead.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 20/39] afs: simplify procfs code
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19808.1525099030.1@warthog.procyon.org.uk>
Date: Mon, 30 Apr 2018 15:37:10 +0100
Message-ID: <19809.1525099030@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> I don't think you should need any of these.  seq_file_net or
> seq_file_single_net will return you the net_ns based on a struct
> seq_file.  And even from your write routines you can reach the
> seq_file in file->private pretty easily.

You've taken away things like single_open/release_net() which means I can't
supply my own fops and use the proc_net stuff.  I wonder if I should add a
write op to struct proc_dir_entry.

David
