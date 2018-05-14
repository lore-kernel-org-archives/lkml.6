Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeENIWJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:22:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58817 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbeENIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:22:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180514082202euoutp01baaea2a78cc77650b366e7124efad5b8~udSRcXzZj1327313273euoutp01R
X-AuditID: cbfec7f5-b45ff700000028a9-cf-5af947298de4
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
From: Andrzej Hajda <a.hajda@samsung.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / core: refactor PM_OPS initializers
Date: Mon, 14 May 2018 10:21:46 +0200
Message-id: <20180514082146.4318-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djP87qa7j+jDC43WVncWneO1eLvpGPs
        FhtnrGe1mDVlL5PF5V1z2Cw+9x5htFh75C67xd1TR9kszpy+xOrA6fH71yRGj8V7XjJ5bLna
        zuLRt2UVo8eK1d/ZPT5vkgtgi+KySUnNySxLLdK3S+DKOLF+DUvBdamKIxO/sjYwXhHrYuTk
        kBAwkbh1dRlLFyMXh5DACkaJDXNfMIEkhAQ+M0rc+ycDU7R2zmRWiKJljBLb/n5lAUnwCghK
        /Jh8D8jm4GAWkJc4cikbJMwsoCmxdfd6doj6/4wSkxb2sIMk2IASfzffZANJiAgsZZS4PPUN
        2FRmgbWMEj9a9rOBVAkLWEg8/7SaDWQqi4CqxJx1RRDLzCX23VjFDnGRvMSz6fPANkgI7GGT
        mNq0mA0i4SKx7+chFghbWOLV8S1QDTISnR0HmSDsaombL5pYIJo7GCXu/26HaraWOHz8IivE
        D3wSk7ZNZwY5QkKAV6KjTQiixEOi58MORgjbUWLe/ePQ4IqV2LRgAfMERplZSAEzCxEws5AC
        ZgEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAVHH63/GvOxj3/Uk6xCjAwajEw7ti
        5Y8oIdbEsuLK3EOMEhzMSiK8u41+RgnxpiRWVqUW5ccXleakFh9ilOZgURLnjdOoixISSE8s
        Sc1OTS1ILYLJMnFwSjUwylesVT01M0rs8+W3WhyTYrymrjnMnPw+PPka45Xe+Rcm9XzqTwk7
        MsP1NnfGvcSO/3s8Xh9YY8yqk+T4Z7ZsPF8T796wxy6y1fnTrghtr1ye/zHEecvFM1siNiVs
        Nz1z89jT9uqOoHlM/L+i88snfZmVc0HwhneyjFVNsqXljcvr/k9Y+yfXV4mlOCPRUIu5qDgR
        AC5coRQRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xq7qa7j+jDH6elbK4te4cq8XfScfY
        LTbOWM9qMWvKXiaLy7vmsFl87j3CaLH2yF12i7unjrJZnDl9idWB0+P3r0mMHov3vGTy2HK1
        ncWjb8sqRo8Vq7+ze3zeJBfAFsVlk5Kak1mWWqRvl8CVcWL9GpaC61IVRyZ+ZW1gvCLWxcjJ
        ISFgIrF2zmTWLkYuDiGBJYwSv249YgNJ8AoISvyYfI+li5GDg1lAXuLIpWyQMLOAusSkeYuY
        IeobmSR+bVvKApJgE9CU+Lv5JliviMBSRoljd+VAipgF1jJKvL3TzgiSEBawkHj+aTUbyFAW
        AVWJOeuKIHaZS+y7sYod4iB5iWfT57FPYOSdheSMWQhnzEJyxgJG5lWMIqmlxbnpucWGesWJ
        ucWleel6yfm5mxiBYbvt2M/NOxgvbQw+xCjAwajEw7ti5Y8oIdbEsuLK3EOMEhzMSiK8u41+
        RgnxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5YkpqdmlqQWgSTZeLglGpgnJoffjhH
        tv9m/dQdys6HFyhOK9jSbuqxXFzC6P4BVq1tRxSP3D7Yrdyhw7A/aNKLyyWF8xbe+iW7dW7F
        7FDmCvbTbem6+43zcybI3Txzm8nl0SS2lfVJpZOE9FOjTBZMbLPV0DjlMEnSQYuH55v18vvX
        3cRXHrnx6e+bA2eV31i/8vEv8TmQpcRSnJFoqMVcVJwIAFB4w7tXAgAA
X-CMS-MailID: 20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f
X-RootMTR: 20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f
References: <CGME20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With current implementation of PM_OPS initializers users should annotate
all PM callbacks with __maybe_unused attribute to prevent compiler from
complaining in case respective option is not enabled. Using ternary
operator with IS_ENABLED(symbol) as a condition allows to avoid marking
these functions with __maybe_unused.
Solution was tested successfully with multiple versions of gcc since
4.9.4 up to 7.2.1. No functional changes has been observed and callbacks
were compiled out if not used, as before.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 include/linux/pm.h | 61 ++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d8357..59f333922c15 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -313,50 +313,37 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
 
-#ifdef CONFIG_PM_SLEEP
+#define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
+#define PM_PTR(ptr) (IS_ENABLED(CONFIG_PM) ? (ptr) : NULL)
+
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn,
-#else
-#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend = PM_SLEEP_PTR(suspend_fn), \
+	.resume = PM_SLEEP_PTR(resume_fn), \
+	.freeze = PM_SLEEP_PTR(suspend_fn), \
+	.thaw = PM_SLEEP_PTR(resume_fn), \
+	.poweroff = PM_SLEEP_PTR(suspend_fn), \
+	.restore = PM_SLEEP_PTR(resume_fn),
 
-#ifdef CONFIG_PM_SLEEP
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_late = suspend_fn, \
-	.resume_early = resume_fn, \
-	.freeze_late = suspend_fn, \
-	.thaw_early = resume_fn, \
-	.poweroff_late = suspend_fn, \
-	.restore_early = resume_fn,
-#else
-#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend_late = PM_SLEEP_PTR(suspend_fn), \
+	.resume_early = PM_SLEEP_PTR(resume_fn), \
+	.freeze_late = PM_SLEEP_PTR(suspend_fn), \
+	.thaw_early = PM_SLEEP_PTR(resume_fn), \
+	.poweroff_late = PM_SLEEP_PTR(suspend_fn), \
+	.restore_early = PM_SLEEP_PTR(resume_fn),
 
-#ifdef CONFIG_PM_SLEEP
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_noirq = suspend_fn, \
-	.resume_noirq = resume_fn, \
-	.freeze_noirq = suspend_fn, \
-	.thaw_noirq = resume_fn, \
-	.poweroff_noirq = suspend_fn, \
-	.restore_noirq = resume_fn,
-#else
-#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend_noirq = PM_SLEEP_PTR(suspend_fn), \
+	.resume_noirq = PM_SLEEP_PTR(resume_fn), \
+	.freeze_noirq = PM_SLEEP_PTR(suspend_fn), \
+	.thaw_noirq = PM_SLEEP_PTR(resume_fn), \
+	.poweroff_noirq = PM_SLEEP_PTR(suspend_fn), \
+	.restore_noirq = PM_SLEEP_PTR(resume_fn),
 
-#ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-	.runtime_suspend = suspend_fn, \
-	.runtime_resume = resume_fn, \
-	.runtime_idle = idle_fn,
-#else
-#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
-#endif
+	.runtime_suspend = PM_PTR(suspend_fn), \
+	.runtime_resume = PM_PTR(resume_fn), \
+	.runtime_idle = PM_PTR(idle_fn),
 
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
-- 
2.17.0
