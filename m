Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeCPItq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:49:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeCPItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:49:43 -0400
Date: Fri, 16 Mar 2018 01:49:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 17/36] fs: add ksys_chroot() helper; remove-in kernel
 calls to sys_chroot()
Message-ID: <20180316084941.GF4151@infradead.org>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-18-linux@dominikbrodowski.net>
 <CAK8P3a2s2YsttKSjZfc8xW+kjv8M1hFDCg1E9nHPjq_KRvik2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2s2YsttKSjZfc8xW+kjv8M1hFDCg1E9nHPjq_KRvik2Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +       ksys_chroot(".");
> >         complete(&setup_done);
> >         while (1) {
> >                 spin_lock(&req_lock);
> 
> Could this be done using kern_path()/set_fs_root() instead so we
> avoid the __user pointer?

Agreed.  Especially as we don't need any of the permission checks here.
