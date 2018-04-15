Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeDOMGj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:06:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeDOMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:06:38 -0400
Date: Sun, 15 Apr 2018 05:06:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Thelen <gthelen@google.com>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tarick Bedeir <tarick@google.com>
Subject: Re: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
Message-ID: <20180415120636.GA10759@infradead.org>
References: <20180413070644.11974-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413070644.11974-1-gthelen@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 12:06:44AM -0700, Greg Thelen wrote:
> Allow INFINIBAND without INFINIBAND_ADDR_TRANS.

Why?  We are pushing everyone heavily to use RDMA/CM, so making it
optional seems rather counter-intuitive.

You'll also have to fix tons of ULPs to explicitly depend on
INFINIBAND_ADDR_TRANS, or make code conditional on it.
