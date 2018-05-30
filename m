Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeE3MBf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:01:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeE3MBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:01:35 -0400
Date: Wed, 30 May 2018 05:01:33 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        broonie@kernel.org
Subject: Re: [PATCH] mm: dmapool: Check the dma pool name
Message-ID: <20180530120133.GC17450@bombadil.infradead.org>
References: <59623b15001e5a20ac32b1a393db88722be2e718.1527679621.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59623b15001e5a20ac32b1a393db88722be2e718.1527679621.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 07:28:43PM +0800, Baolin Wang wrote:
> It will be crash if we pass one NULL name when creating one dma pool,
> so we should check the passing name when copy it to dma pool.

NAK.  Crashing is the appropriate thing to do.  Fix the caller to not
pass NULL.

If you permit NULL to be passed then you're inviting crashes or just
bad reporting later when pool->name is printed.
