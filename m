Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E6CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC59420685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC59420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeGZOZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:25:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42318 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbeGZOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:25:46 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M1eUE-1fyQOx2mjq-00tmbJ; Thu, 26 Jul 2018 15:08:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, Dave Chinner <david@fromorbit.com>,
        Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
Date:   Thu, 26 Jul 2018 15:07:52 +0200
Message-Id: <20180726130820.4174359-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:5toE5J2olpJaV8tZ8hZvsmkv7pAgQzfGT0uRkDZ/AYsBpI0nl+G
 MVV467y6QbTUQSe8Nng63vil9PKl8lvDgvqCe+iDLO8Xbc1YZp/JxEPigFNQbcDELMp6uUH
 bt1Fw/vRcdWdU3OqggZQJuK/SHGfW0t09GEbbyPCdAY4hjklVfJZNXfXPQiLDPOjG6xlXty
 ajPCYBkse1VAHAc0sPJ/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tOy3X5Oqi+g=:DVMPN97+/DbMiOBCUFjvk7
 vtsRhVzXnR+UWwMe4EjIIGFvi0ewDIwcc0rdjI/FIemE2Ft2Uazo5Xb148y/VvQK7FtvzpIkN
 MWVmTn2Wswp+33gUr6sOdiKSSwty6E4pwekQ4hLH5R8xXUtTnQic8cTJSTOnYZ95QGEQi+fMi
 XFhBhDyA1T6ga/gtJaDcsT5IRnr8Auli4xIB8T8bpA1TKOE3SFNfDB8cLoIvz0uahITV5Ap+a
 oar8RtWBTwrxNtmeolnw4oTVvjoOH0iphzW1eqNFXxtEqxBqVr+1psVHuHgnp9qnoS+erICUj
 tdNVPEIi55ivnrQ6LcsFix4P8yMFT4oIb41W6FOOqBi/bldqXMDT6ErmYPcQN/U17ZJOceVPn
 b5OcKMCGh9ewXyH7JsBgEUu7KcdUEdp6/vjw2+txoYEJQuw75qYrR8bEeOsaVPmmgnkKU99JQ
 zrqHT+PxwOogm5LvRWX3Hk9accJiYpcd2p9rqQTwcEoUyrsSqJQIB0+uAvtd8Drpd2f2bbS2t
 c4ScJ0lmxfgD53L5RIpYBXS4yxtPRuZAkAqwUtEFcVpUw6AI4lHvT7EvEJJHC6lGFX8VaIW02
 GtIMe7ZJL8ubeXi1VIJ5u1o+sHbSqt+eeNzJKz0a+mv02rAEvHz4NjsENClHRX3oBp1MSP0Dh
 UNIO+mUcoFcR3mN7e85s7bXPO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_time is the last remaining caller of current_kernel_time64(),
which is a wrapper around ktime_get_coarse_real_ts64(). This calls the
latter directly for consistency with the rest of the kernel that is
moving to the ktime_get_ family of time accessors, as now documented
in Documentation/core-api/timekeeping.rst.

An open questions is whether we may want to actually call the more
accurate ktime_get_real_ts64() for file systems that save high-resolution
timestamps in their on-disk format. This would add a small overhead to
each update of the inode stamps but lead to inode timestamps to actually
have a usable resolution better than one jiffy (1 to 10 milliseconds
normally). Experiments on a variety of hardware platforms show a typical
time of around 100 CPU cycles to read the cycle counter and calculate
the accurate time from that. On old platforms without a cycle counter,
this can be signiciantly higher, up to several microseconds to access
a hardware clock, but those have become very rare by now.

I traced the original addition of the current_kernel_time() call to set
the nanosecond fields back to linux-2.5.48, where Andi Kleen added a
patch with subject "nanosecond stat timefields". Andi explains that the
motivation was to introduce as little overhead as possible back then. At
this time, reading the clock hardware was also more expensive when most
architectures did not have a cycle counter.

One side effect of having more accurate inode timestamp would be having
to write out the inode every time that mtime/ctime/atime get touched on
most systems, whereas many file systems today only write it when the
timestamps have changed, i.e. at most once per jiffy unless something
else changes as well. That change would certainly be noticed in some
workloads, which is enough reason to not do it without a good reason,
regardless of the cost of reading the time.

One thing we could still consider however would be to round the timestamps
from current_time() to multiples of NSEC_PER_JIFFY, e.g. full milliseconds
rather than having six or seven meaningless but confusing digits at the
end of the timestamp.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
changes in v2:
* wait for Documentation to get merged first, as Dave Chinner requested
* rewrite changelog based on discussion
---
 fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 462eb50b096f..c2dbab9a7cf5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2105,7 +2105,9 @@ EXPORT_SYMBOL(timespec64_trunc);
  */
 struct timespec64 current_time(struct inode *inode)
 {
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 now;
+
+	ktime_get_coarse_real_ts64(&now);
 
 	if (unlikely(!inode->i_sb)) {
 		WARN(1, "current_time() called with uninitialized super_block in the inode");
-- 
2.18.0

