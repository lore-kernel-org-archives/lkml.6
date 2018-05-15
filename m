Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeEOOQJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752377AbeEOOQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:16:08 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180515134811.GB31066@lst.de>
References: <20180515134811.GB31066@lst.de> <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk> <152513043358.13808.4250608064312146536.stgit@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] proc: Add a way to make network proc files writable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3709.1526393766.1@warthog.procyon.org.uk>
Date: Tue, 15 May 2018 15:16:06 +0100
Message-ID: <3710.1526393766@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> The other option I though about would be to hide a write callback
> in struct seq_operations, as that way all the existing helpers would
> just work.

That could work too.

> Btw one of the lines above is over 80 chars.  By using normal two
> tab indents for the continuations this would become a lot more readable:
> 
> struct proc_dir_entry *proc_create_net_data_write(const char *name,
> 		umode_t mode, struct proc_dir_entry *parent,
> 		const struct seq_operations *ops, proc_write_t write,
> 		unsigned int state_size, void *data)

Actually, it's less readable because the first argument isn't left-aligned
with the rest.  I'd suggest moving the first argument onto a separate line
also:

struct proc_dir_entry *proc_create_net_data_write(
	const char *name, umode_t mode, struct proc_dir_entry *parent,
	const struct seq_operations *ops, proc_write_t write,
	unsigned int state_size, void *data)

David
