Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeCQRVM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:21:12 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35088 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeCQRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:11 -0400
Date: Sat, 17 Mar 2018 18:01:20 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de
Subject: Re: [PATCH v2 16/36] fs: add ksys_dup{,3}() helper; remove in-kernel
 calls to sys_dup{,3}()
Message-ID: <20180317170120.GC2226@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-17-linux@dominikbrodowski.net>
 <20180316084834.GE4151@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316084834.GE4151@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:48:34AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 15, 2018 at 08:05:09PM +0100, Dominik Brodowski wrote:
> > Using ksys_dup() and ksys_dup3() as helper functions allows us to
> > avoid the in-kernel calls to the sys_dup() and sys_dup3() syscalls.
> 
> do_dup/dup3 or kern_dup/dup3, please.

On the naming issue, see my other message from a few days ago. Concerning
the added complexity and the need-for-cleanup in init/do_mounts_initrd.c
and init/main.c, I have added the following comment:

	In the near future, the fs-external callers of ksys_dup{,3}() should be
	converted to call do_dup2() directly. Then, ksys_dup{,3}() can be moved
	within sys_dup{,3}() again.

Thanks,
	Dominik
