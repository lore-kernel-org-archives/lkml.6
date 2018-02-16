Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeBPJpb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:45:31 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51536 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeBPJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:45:28 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180216094526epoutp02695374cc7eaa68523753bfe40320dc74~TxTQYICUz0556605566epoutp027
X-AuditID: b6c32a49-00dff70000001122-d0-5a86a83532c5
From: t.vivek@samsung.com
To: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com, Vivek Trivedi <t.vivek@samsung.com>,
        Kunal Shubham <k.shubham@samsung.com>
Subject: [PATCH] fanotify: allow freeze on suspend when waiting for response
 from userspace
Date: Fri, 16 Feb 2018 15:14:40 +0530
Message-Id: <1518774280-38090-1-git-send-email-t.vivek@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmuq7pirYog/WPzS0urFvNaDF7ejOT
        xcFlM5kt9uw9yWJxedccNot7b7YyWbzs28jmwO6xc9Zddo++LasYPc4sOMLu8XmTXABLVKpN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpWhDQyM9QwNzPSMjIz0T01grI1OgkoTUjO8L9jAWvBaq
        OHn4P2sD4waBLkZODgkBE4lF8y4zdjFycQgJ7GaU2LX9LxuE84lR4uTdH1CZb4wST++tYYRp
        mf6lgwkisZdRYs7f50wgCSGBL4wS70FsDg42AUmJO7cVQMIiAskSl65/ZwGxmQXSJH6cmQI2
        R1ggVuLjjGOsIDaLgKrEw/872EBsXgFniZsvv7FA7JKTOHlsMivILgmBv6wS+649ZIJIuEic
        ftjBDmELS7w6vgXKlpL4/G4vG0TDZEaJiZM+sEM46xklll59wAxRZS/x4MZRdpBLmQU0Jdbv
        0gcxJQRsJQ70SEMcyifR+/sJE0SYV6KjTQiiUVFi4d4prBBhcYmepUEQpodE66NUiApHifbH
        EN8KAX34qucM0wRGuVkImxYwMq5ilEwtKM5NTy02LTDMSy3XK07MLS7NS9dLzs/dxAhOW1qe
        OxhnnfM5xCjAwajEw7uhtzVKiDWxrLgy9xCjBAezkgjvreltUUK8KYmVValF+fFFpTmpxYcY
        TYFBOZFZSjQ5H5hS80riDU0sDUzMzMwNDQwsTZTEeR0DXaKEBNITS1KzU1MLUotg+pg4OKUa
        GPmqNs/+kJTZu9M7KGaCWOR55eVv558zFX60+MckwdCc3H/Rz5qXSB3YbzQrcmvejTtKpsv/
        OMauvPxA1mBL34XpX3msOx4fe7E2PS6Z+R7Xv49tW31522b59qyuu7XZMe3BN/cNlkc/Z/pG
        xDIqzdIos/5S9NFQYfknwxXiSd+Ew4On2q552KHEUpyRaKjFXFScCADl68kYcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LZdlhJTtd0RVuUwZ9+EYsL61YzWsye3sxk
        cXDZTGaLPXtPslhc3jWHzeLem61MFi/7NrI5sHvsnHWX3aNvyypGjzMLjrB7fN4kF8ASxWWT
        kpqTWZZapG+XwJXxfcEexoLXQhUnD/9nbWDcINDFyMkhIWAiMf1LB1MXIxeHkMBuRonrhzcy
        QyTEJe7OvsgOYQtLrPz3nB2i6BOjxPm/C9m6GDk42AQkJe7cVgCpERFIlzhyuw0szCyQIbF0
        cyKIKSwQLXHzQzBIBYuAqsTD/zvYQGxeAWeJmy+/sUBMl5M4eWwy6wRGngWMDKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYLDRktzB+PlJfGHGAU4GJV4eDf0tkYJsSaWFVfmHmKU
        4GBWEuG9Nb0tSog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5O
        qQZGqeZ1P1cb6j35tH9SiQu/9pVLUxj6xMRLO35IdKefnV/lbxb6qqxq4Xzz/++KfzUqWAr2
        /17n0FtX21N06VR+7Ppzuq1Zq+4/3G32Y8rLsF1pByUYK/p1PLy2dD/VNpynPcHx39sZmdYL
        50rt65h0tGtxwROfFI6enfffTBGLuTFXR3naUe4eJZbijERDLeai4kQASUIsAhcCAAA=
X-CMS-MailID: 20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae
X-RootMTR: 20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae
References: <CGME20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Trivedi <t.vivek@samsung.com>

If fanotify userspace response server thread is frozen first,
it may fail to send response from userspace to kernel space listener.
In this scenario, fanotify response listener will never get response
from userepace and fail to suspend.

Use freeze-friendly wait API to handle this issue.

Same problem was reported here:
https://bbs.archlinux.org/viewtopic.php?id=232270

Freezing of tasks failed after 20.005 seconds
(1 tasks refusing to freeze, wq_busy=0)

Backtrace:
[<c0582f80>] (__schedule) from [<c05835d0>] (schedule+0x4c/0xa4)
[<c0583584>] (schedule) from [<c01cb648>] (fanotify_handle_event+0x1c8/0x218)
[<c01cb480>] (fanotify_handle_event) from [<c01c8238>] (fsnotify+0x17c/0x38c)
[<c01c80bc>] (fsnotify) from [<c02676dc>] (security_file_open+0x88/0x8c)
[<c0267654>] (security_file_open) from [<c01854b0>] (do_dentry_open+0xc0/0x338)
[<c01853f0>] (do_dentry_open) from [<c0185a38>] (vfs_open+0x54/0x58)
[<c01859e4>] (vfs_open) from [<c0195480>] (do_last.isra.10+0x45c/0xcf8)
[<c0195024>] (do_last.isra.10) from [<c0196140>] (path_openat+0x424/0x600)
[<c0195d1c>] (path_openat) from [<c0197498>] (do_filp_open+0x3c/0x98)
[<c019745c>] (do_filp_open) from [<c0186b44>] (do_sys_open+0x120/0x1e4)
[<c0186a24>] (do_sys_open) from [<c0186c30>] (SyS_open+0x28/0x2c)
[<c0186c08>] (SyS_open) from [<c0010200>] (__sys_trace_return+0x0/0x20)

Signed-off-by: Kunal Shubham <k.shubham@samsung.com>
Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
---
 fs/notify/fanotify/fanotify.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6702a6a..1d65899 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/audit.h>
+#include <linux/freezer.h>
 
 #include "fanotify.h"
 
@@ -63,7 +64,9 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
-	wait_event(group->fanotify_data.access_waitq, event->response);
+	while (!event->response)
+		wait_event_freezable(group->fanotify_data.access_waitq,
+				     event->response);
 
 	/* userspace responded, convert to something usable */
 	switch (event->response & ~FAN_AUDIT) {
-- 
1.9.1
