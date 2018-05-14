Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeENMH7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:07:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeENMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:07:57 -0400
Date: Mon, 14 May 2018 05:07:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 12/18] kernel: add ksys_personality()
Message-ID: <20180514120756.GA11638@infradead.org>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-13-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-13-mark.rutland@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:34AM +0100, Mark Rutland wrote:
> Using this helper allows us to avoid the in-kernel call to the
> sys_personality() syscall. The ksys_ prefix denotes that this function
> is meant as a drop-in replacement for the syscall. In particular, it
> uses the same calling convention as sys_personality().
> 
> This is necessary to enable conversion of arm64's syscall handling to
> use pt_regs wrappers.

Plese just opencode the trivial sys_personality logic instead.
