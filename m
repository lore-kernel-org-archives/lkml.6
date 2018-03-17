Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeCQRVX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:21:23 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35094 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbeCQRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:11 -0400
Date: Sat, 17 Mar 2018 17:58:08 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de
Subject: Re: [PATCH v2 15/36] fs: add ksys_umount() helper; remove in-kernel
 call to sys_umount()
Message-ID: <20180317165808.GB2226@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-16-linux@dominikbrodowski.net>
 <20180316084750.GD4151@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316084750.GD4151@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:47:50AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 15, 2018 at 08:05:08PM +0100, Dominik Brodowski wrote:
> > Using this helper allows us to avoid the in-kernel call to the sys_umount()
> > syscall.
> 
> kern_unmount, please.  And make it operate on kernel pointers please.

On the naming issue, see my other message from a few days ago. Concerning
the added complexity and the need-for-cleanup in init/do_mounts_initrd.c, I
have added the following comment:

	In the near future, the only fs-external caller of ksys_umount() should be
	converted to call do_umount() directly. Then, ksys_umount() can be moved
	within sys_umount() again.

Thanks,
	Dominik
