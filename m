Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC8C20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC8C20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbeGJOsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:48:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50004 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:48:29 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MGJlf-1fprxW1JnL-00FAsR; Tue, 10 Jul 2018 16:48:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Chinner <david@fromorbit.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] Documentation: document ktime_get_*() APIs
Date:   Tue, 10 Jul 2018 16:46:41 +0200
Message-Id: <20180710144737.1136856-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sgtWyMyvf2MpatRMDWbIGFJKsHlC+g8XU2pZLl7xHbz6qxmI/Uk
 XcTmBDx6F83YWCpYb7qvljDxEqBsybrTg1BMy1WvfSKZAF/qqX6zSUMQPhKKvUeoX4uwvkk
 4ivviQhrmXnAO6lJSyiSJvOypepjKT7g9yHAqQN+csJqQM3ovMqU7AQux+RXXL5/1++losd
 4YCbfdhJbt6Jx3fb5XU1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mstS1CWmnV4=:7X6IUN7f2SEl0MFNktIrVI
 61F0SHV1pcoJbnqBtAvdXgoBXQPSCnyjVXUaKtN4gyQEP5TFoWNnxMvmDF5WoSqLBYlvMNTWP
 Q7KyBANvgR92uAV4tQ83DNFMxzCyhao+RNx5LB9vEKhvapTqLufpW82HmnC0sBHtQnYUBF6y0
 N8pLKPext7sqgMCHqTIEekxhtQk5o1+RpqsHEJP7/Qyg2I3XuOeCAWvxJRYfVfxBP8zt4xLl/
 icl2ecPeVYglYypJD55/uTHInupzgzewyry+pF+G671JoztEcKBK+iFv8lRmgncpR9oEzwVAT
 xnA4JJviHmWEttx4G2TmojpIKRiXQb7n2Hl4R/xENeoxkHLHJsSplG99ULhGzfUYb6QITfOU8
 BGwJiDBp9Tmmpxnc23AfxJUcydCz1tqQy4wT5ovz8NZujwRFckMVAAlJBLPfmXjOTPTKldXYf
 ThVHuIiCC6CiAweOwMphT/Z3BON+h4b0L8WipXuWKgWAun8QntVMqQmDHMFb0uu1U7rH69xFz
 YBASO9lJ37j1BXGNiUck5ODtejsr++/BpOgRSfmZ3IWYngWQyVj912jTqNRIsqV5i3rGFEK/w
 6oC79n2khIAMJLqrXfjnRVQjSvtzvGqgUIgMDms/3QWy/iymwkM7kqbpUrFrNXFiKEuCwlWs2
 jR7G0Z6DhnMe8SgBAHV9fcE5aqVOrN5Uqa1PbU0Ugbsh6mzORGf9Ho0dGBmBh+qhF8pA=
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dave Chinner points out, we don't have a proper documentation for the
ktime_get() family of interfaces, making it rather unclear which of the
over 30 (!) interfaces one should actually use in a driver or elsewhere
in the kernel.

I wrote up an explanation from how I personally see the interfaces,
documenting what each of the functions do and hopefully making it a bit
clearer which should be used where.

This is the first time I tried writing .rst format documentation, so
in addition to any mistakes in the content, I probably also introduce
nonstandard formatting ;-)

I first tried to add an extra section to
Documentation/timers/timekeeping.txt, but this is currently not included
in the generated API, and it seems useful to have the API docs as part
of what gets generated in
https://www.kernel.org/doc/html/latest/core-api/index.html#core-utilities
instead, so I started a new file there.

I also considered adding the documentation inline in the
include/linux/timekeeping.h header, but couldn't figure out how to do
that in a way that would result both in helpful inline comments as
well as readable html output, so I settled for the latter, with
a small note pointing to it from the header.

Cc: Dave Chinner <david@fromorbit.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: minor changes suggested by Randy
---
 Documentation/core-api/index.rst       |   1 +
 Documentation/core-api/timekeeping.rst | 185 +++++++++++++++++++++++++++++++++
 include/linux/timekeeping.h            |  15 +++
 3 files changed, 201 insertions(+)
 create mode 100644 Documentation/core-api/timekeeping.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index e821cf78be3b..11b54e2bbce2 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -29,6 +29,7 @@ Core utilities
    printk-formats
    circular-buffers
    gfp_mask-from-fs-io
+   timekeeping
 
 Interfaces for kernel debugging
 ===============================
diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
new file mode 100644
index 000000000000..93cbeb9daec0
--- /dev/null
+++ b/Documentation/core-api/timekeeping.rst
@@ -0,0 +1,185 @@
+ktime accessors
+===============
+
+Device drivers can read the current time using ktime_get() and the many
+related functions declared in linux/timekeeping.h. As a rule of thumb,
+using an accessor with a shorter name is preferred over one with a longer
+name if both are equally fit for a particular use case.
+
+Basic ktime_t based interfaces
+------------------------------
+
+The recommended simplest form returns an opaque ktime_t, with variants
+that return time for different clock references:
+
+
+.. c:function:: ktime_t ktime_get( void )
+
+	CLOCK_MONOTONIC
+
+	Useful for reliable timestamps and measuring short time intervals
+	accurately. Starts at system boot time but stops during suspend.
+
+.. c:function:: ktime_t ktime_get_boottime( void )
+
+	CLOCK_BOOTTIME
+
+	Like ktime_get(), but does not stop when suspended. This can be
+	used e.g. for key expiration times that need to be synchronized
+	with other machines across a suspend operation.
+
+.. c:function:: ktime_t ktime_get_real( void )
+
+	CLOCK_REALTIME
+
+	Returns the time in relative to the UNIX epoch starting in 1970
+	using the Coordinated Universal Time (UTC), same as gettimeofday()
+	user space. This is used for all timestamps that need to
+	persist across a reboot, like inode times, but should be avoided
+	for internal uses, since it can jump backwards due to a leap
+	second update, NTP adjustment settimeofday() operation from user
+	space.
+
+.. c:function:: ktime_t ktime_get_clocktai( void )
+
+	 CLOCK_TAI
+
+	Like ktime_get_real(), but uses the International Atomic Time (TAI)
+	reference instead of UTC to avoid jumping on leap second updates.
+	This is rarely useful in the kernel.
+
+.. c:function:: ktime_t ktime_get_raw( void )
+
+	CLOCK_MONOTONIC_RAW
+
+	Like ktime_get(), but runs at the same rate as the hardware
+	clocksource without (NTP) adjustments for clock drift. This is
+	also rarely needed in the kernel.
+
+nanosecond, timespec64, and second output
+-----------------------------------------
+
+For all of the above, there are variants that return the time in a
+different format depending on what is required by the user:
+
+.. c:function:: u64 ktime_get_ns( void )
+		u64 ktime_get_boottime_ns( void )
+		u64 ktime_get_real_ns( void )
+		u64 ktime_get_tai_ns( void )
+		u64 ktime_get_raw_ns( void )
+
+	Same as the plain ktime_get functions, but returning a u64 number
+	of nanoseconds in the respective time reference, which may be
+	more convenient for some callers.
+
+.. c:function:: void ktime_get_ts64( struct timespec64 * )
+		void ktime_get_boottime_ts64( struct timespec64 * )
+		void ktime_get_real_ts64( struct timespec64 * )
+		void ktime_get_clocktai_ts64( struct timespec64 * )
+		void ktime_get_raw_ts64( struct timespec64 * )
+
+	Same above, but returns the time in a 'struct timespec64', split
+	into seconds and nanoseconds. This can avoid an extra division
+	when printing the time, or when passing it into an external
+	interface that expects a 'timespec' or 'timeval' structure.
+
+.. c:function:: time64_t ktime_get_seconds( void )
+		time64_t ktime_get_boottime_seconds( void )
+		time64_t ktime_get_real_seconds( void )
+		time64_t ktime_get_clocktai_seconds( void )
+		time64_t ktime_get_raw_seconds( void )
+
+	Return a coarse-grained version of the time as a scalar
+	time64_t. This avoids accessing the clock hardware and rounds
+	down the seconds to the full seconds of the last timer tick
+	using the respective reference.
+
+Coarse and fast_ns access
+-------------------------
+
+Some additional variants exist for more specialized cases:
+
+.. c:function:: ktime_t ktime_get_coarse_boottime( void )
+		ktime_t ktime_get_coarse_real( void )
+		ktime_t ktime_get_coarse_clocktai( void )
+		ktime_t ktime_get_coarse_raw( void )
+
+.. c:function:: void ktime_get_coarse_ts64( struct timespec64 * )
+		void ktime_get_coarse_boottime_ts64( struct timespec64 * )
+		void ktime_get_coarse_real_ts64( struct timespec64 * )
+		void ktime_get_coarse_clocktai_ts64( struct timespec64 * )
+		void ktime_get_coarse_raw_ts64( struct timespec64 * )
+
+	These are quicker than the non-coarse versions, but less accurate,
+	corresponding to CLOCK_MONONOTNIC_COARSE and CLOCK_REALTIME_COARSE
+	in user space, along with the equivalent boottime/tai/raw
+	timebase not available in user space.
+
+	The time returned here corresponds to the last timer tick, which
+	may be as much as 10ms in the past (for CONFIG_HZ=100), same as
+	reading the 'jiffies' variable.  These are only useful when called
+	in a fast path and one still expects better than second accuracy,
+	but can't easily use 'jiffies', e.g. for inode timestamps.
+	Skipping the hardware clock access saves around 100 CPU cycles
+	on most modern machines with a reliable cycle counter, but
+	up to several microseconds on older hardware with an external
+	clocksource.
+
+.. c:function:: u64 ktime_get_mono_fast_ns( void )
+		u64 ktime_get_raw_fast_ns( void )
+		u64 ktime_get_boot_fast_ns( void )
+		u64 ktime_get_real_fast_ns( void )
+
+	These variants are safe to call from any context, including from
+	a non-maskable interrupt (NMI) during a timekeeper update, and
+	while we are entering suspend with the clocksource powered down.
+	This is useful in some tracing or debugging code as well as
+	machine check reporting, but most drivers should never call them,
+	since the time is allowed to jump under certain conditions.
+
+Deprecated time interfaces
+--------------------------
+
+Older kernels used some other interfaces that are now being phased out
+but may appear in third-party drivers being ported here. In particular,
+all interfaces returning a 'struct timeval' or 'struct timespec' have
+been replaced because the tv_sec member overflows in year 2038 on 32-bit
+architectures. These are the recommended replacements:
+
+.. c:function:: void ktime_get_ts( struct timespec * )
+
+	Use ktime_get() or ktime_get_ts64() instead.
+
+.. c:function:: struct timeval do_gettimeofday( void )
+		struct timespec getnstimeofday( void )
+		struct timespec64 getnstimeofday64( void )
+		void ktime_get_real_ts( struct timespec * )
+
+	ktime_get_real_ts64() is a direct replacement, but consider using
+	monotonic time (ktime_get_ts64()) and/or a ktime_t based interface
+	(ktime_get()/ktime_get_real()).
+
+.. c:function:: struct timespec current_kernel_time( void )
+		struct timespec64 current_kernel_time64( void )
+		struct timespec get_monotonic_coarse( void )
+		struct timespec64 get_monotonic_coarse64( void )
+
+	These are replaced by ktime_get_coarse_real_ts64() and
+	ktime_get_coarse_ts64(). However, A lot of code that wants
+	coarse-grained times can use the simple 'jiffies' instead, while
+	some drivers may actually want the higher resolution accessors
+	these days.
+
+.. c:function:: struct timespec getrawmonotonic( void )
+		struct timespec64 getrawmonotonic64( void )
+		struct timespec timekeeping_clocktai( void )
+		struct timespec64 timekeeping_clocktai64( void )
+		struct timespec get_monotonic_boottime( void )
+		struct timespec64 get_monotonic_boottime64( void )
+
+	These are replaced by ktime_get_raw()/ktime_get_raw_ts64(),
+	ktime_get_clocktai()/ktime_get_clocktai_ts64() as well
+	as ktime_get_boottime()/ktime_get_boottime_ts64().
+	However, if the particular choice of clock source is not
+	important for the user, consider converting to
+	ktime_get()/ktime_get_ts64() instead for consistency.
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 86bc2026efce..947b1b8d2d01 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -21,6 +21,21 @@ extern int do_sys_settimeofday64(const struct timespec64 *tv,
 				 const struct timezone *tz);
 
 /*
+ * ktime_get() family: read the current time in a multitude of ways,
+ *
+ * The default time reference is CLOCK_MONOTONIC, starting at
+ * boot time but not counting the time spent in suspend.
+ * For other references, use the functions with "real", "clocktai",
+ * "boottime" and "raw" suffixes.
+ *
+ * To get the time in a different format, use the ones wit
+ * "ns", "ts64" and "seconds" suffix.
+ *
+ * See Documentation/core-api/timekeeping.rst for more details.
+ */
+
+
+/*
  * timespec64 based interfaces
  */
 extern void ktime_get_raw_ts64(struct timespec64 *ts);
-- 
2.9.0

