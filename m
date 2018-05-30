Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964780AbeE3Hlo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:41:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbeE3Hlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:41:31 -0400
Date: Wed, 30 May 2018 00:41:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
Message-ID: <20180530074130.GA6927@infradead.org>
References: <20180530075920.1f73275a@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530075920.1f73275a@mschwideX1>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	req->completion_data = cqr;
> +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> +

Please don't play such tricks.  In general your driver structure
should have struct request embedded.  If for some reason
struct dasd_ccw_req has a different life time please create a new
structure instead of these hacks.

In either way this really doesn't look like a post-rc7 change.
