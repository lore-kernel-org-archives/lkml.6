Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeELDni (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 23:43:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40758 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELDnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 23:43:37 -0400
To: LKML <linux-kernel@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: nios2 build: empty_zero_page ?
Message-ID: <768a2f8d-23f6-1b28-e299-10a788b309ff@infradead.org>
Date: Fri, 11 May 2018 20:43:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I bet this has come up before, but my search foo didn't find anything.

When (cross) building nios2 allmodconfig, I am seeing this build error:

ERROR: "empty_zero_page" [net/ceph/libceph.ko] undefined!
ERROR: "empty_zero_page" [fs/exofs/exofs.ko] undefined!
ERROR: "empty_zero_page" [fs/crypto/fscrypto.ko] undefined!
ERROR: "empty_zero_page" [fs/cramfs/cramfs.ko] undefined!
ERROR: "empty_zero_page" [drivers/usb/wusbcore/wusbcore.ko] undefined!
ERROR: "flush_icache_range" [drivers/misc/lkdtm/lkdtm.ko] undefined!
ERROR: "empty_zero_page" [drivers/md/dm-mod.ko] undefined!

and arch/nios2/mm/init.c references empty_zero_page, but I don't see
anywhere that it is defined.

Help?

There are plenty of other build issues also, but they all are about arithmetic
that is sometimes provided by libc functions, e.g.:

ERROR: "__ucmpdi2" [drivers/media/i2c/adv7842.ko] undefined!
ERROR: "__ashrdi3" [drivers/mtd/nand/onenand/onenand.ko] undefined!
ERROR: "__ashldi3" [fs/btrfs/btrfs.ko] undefined!
ERROR: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] undefined!

thanks,
-- 
~Randy
