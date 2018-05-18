Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeEROKC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:10:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeEROJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:09:58 -0400
Date: Fri, 18 May 2018 07:09:57 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org
Subject: seq_putc is preferable to seq_puts
Message-ID: <20180518140957.GB6361@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Joe,

A nice checkpatch addition would be to look for seq_puts(x, "s")
and recommend the author use seq_putc(x, 's') instead.  The primary
offender is seq_puts(x, "\n") (a hundred or so, scattered throughout
the kernel), but seq_puts(x, " ") has its adherents too.
