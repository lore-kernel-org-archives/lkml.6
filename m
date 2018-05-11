Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeEKABd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:01:33 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53912 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:01:32 -0400
Date: Thu, 10 May 2018 20:01:28 -0400
From: Rich Felker <dalias@libc.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: early alloc change broke sh
Message-ID: <20180511000128.GA23149@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0fa1c579349fdd90173381712ad78aa99c09d38b (of/fdt: use
memblock_virt_alloc for early alloc), attempting to boot on sh (j2,
nommu) fails with OOM:

[    0.000000] bootmem alloc of 7836 bytes failed!
[    0.000000] Kernel panic - not syncing: Out of memory

I suspect there are significant differences in memblock_virt_alloc and
memblock_alloc (perhaps specific to nommu?). It looks like microblaze
was also affected:

http://lkml.iu.edu/hypermail/linux/kernel/1801.1/02200.html

I'll continue looking for a solution but I wanted to let you know
right away in case you might know what's wrong and have a fix. It
would be nice if we could get a fix for this regression in 4.17 since
multiple archs are broken.

Rich
