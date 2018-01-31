Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeAaVzL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:55:11 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:56027 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbeAaVzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:55:10 -0500
Date: Wed, 31 Jan 2018 13:55:09 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH] Rename make inode_cmp_iversion{+raw} to
 inode_eq_iversion{+raw}
Message-ID: <20180131215509.GD28275@bombadil.infradead.org>
References: <20180131204309.32474-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131204309.32474-1-kreijack@libero.it>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 09:43:09PM +0100, Goffredo Baroncelli wrote:
> The function inode_cmp_iversion{+raw} is counter-intuitive, because it
> returns true when the counters are different and false when these are equal.
> 
> Rename it to inode_eq_iversion{+raw}, which will returns true when
> the counters are equal and false otherwise.

A lot of places use !inode_eq_iversion().  I think we should have both
inode_eq_iversion() and inode_ne_iversion().

Also, we have 'inode' in the name, why keep the 'i'?  inode_eq_version()
and inode_ne_version() are shorter.  We could even go so far as
iversion_eq() and iversion_ne() if keeping 'iversion' in the string
is important.
