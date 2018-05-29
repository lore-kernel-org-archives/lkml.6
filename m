Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbeE2GLc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:11:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeE2GLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:11:31 -0400
Date: Mon, 28 May 2018 23:11:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Albert Ou <albert@sifive.com>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Subject: Re: [PATCH] riscv: pass machine size to sparse
Message-ID: <20180529061127.GA20005@infradead.org>
References: <20180528163505.15698-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528163505.15698-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 06:35:05PM +0200, Luc Van Oostenryck wrote:
> By default, sparse assumes a 64bit machine when compiled on x86-64
> and 32bit when compiled on anything else.
> 
> This can of course create all sort of problems when this doesn't
> correspond to the target's machine size, like issuing false
> warnings like: 'shift too big (32) for type unsigned long' or
> is 64bit while sparse was compiled on a 32bit machine, or worse,
> to not emit legitimate warnings.
> 
> Fix this by passing the appropriate -m32/-m64 flag to sparse.

Can we please move this to the common Kbuild code using the
CONFIG_64BIT syombol?  This really should not need boiler plate in
every architecture.
