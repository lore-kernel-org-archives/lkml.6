Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeFAJAh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:00:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16381 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeFAJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:00:32 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180601090030epoutp01527694586da788e0f2557268a89863f8~z-a-2cILf2066620666epoutp01_
X-AuditID: b6c32a4a-aa5ff70000001139-35-5b110b2d9aa8
From: Maninder Singh <maninder1.s@samsung.com>
To: pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v2] printk: make sure to print log on console.
Date: Fri,  1 Jun 2018 14:26:42 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmlq4ut2C0wYE9FhYXd6daXN41h83i
        8Pw2Fot7b7YyWfx//JXVYl/HAyaLtZ8fs1scOjmX0YHDY+esu+weLftusXv0bVnF6LF+y1UW
        j8+b5AJYo1JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZAWnTWCsjU6CShNSM
        5rVGBeeEK17fX8/SwLibv4uRk0NCwESi7fZ55i5GLg4hgd2MEmcPzmOBcD4xSnTuOc4EUiUk
        8I1R4mF7OUzH7g3/2SHiexklTv/zg2j4wijRs2gRWIJNQE9i1a49LCC2iIC7xKfvH9hAipgF
        JjFKfL+/BiwhLGAnMXPiJDCbRUBVYt3ayywQG+QkTh6bzArSICHQwSZxf8oCNpAEr0CZxI2e
        X0wQRS4Sv/b9YIawhSVeHd/CDmFLSXx+t5cNwi6W6HrfyAgxqIVR4u2XR1AN9hIPbhwFauAA
        OklTYv0ufZAwswCfRO/vJ0wgYQkBXomONiGIalWJlpsbWCFsaYnPHz9C3ekhcfb7SxZISMRK
        7N5/lmUCo8wshKELGBlXMUqmFhTnpqcWmxYY5aWW6xUn5haX5qXrJefnbmIEJyctrx2My875
        HGIU4GBU4uHV+MIfLcSaWFZcmXuIUYKDWUmEd0oZUIg3JbGyKrUoP76oNCe1+BCjKTDQJjJL
        iSbnAxNnXkm8oamRmZmBpYGpsYWZoZI474/rAtFCAumJJanZqakFqUUwfUwcnFINjPOvX3ur
        cZ79+jmPxNnlv2asqHkkxiNvedXh8CudLja1TV/1L/vv3ZiSFfRcq2pZtVZz6AbXi1cm1r6o
        SVhaw8Lt/2T9nuoFfqof7dXeNGbKNO+NXihVGR2kPUHSsTVojaXI0edVySYfrqZI6IknPr5e
        v2tW2z0J0flbbRqDirO6WNhKbc48UmIpzkg01GIuKk4EAHcwQMxkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSnK4ut2C0QctlQYuLu1MtLu+aw2Zx
        eH4bi8W9N1uZLP4//spqsa/jAZPF2s+P2S0OnZzL6MDhsXPWXXaPln232D36tqxi9Fi/5SqL
        x+dNcgGsUVw2Kak5mWWpRfp2CVwZzWuNCs4JV7y+v56lgXE3fxcjJ4eEgInE7g3/2bsYuTiE
        BHYzSjxdNIEZIiEt8fPfexYIW1hi5b/nUEWfGCX6p0xmAkmwCehJrNq1B6xIRMBbYur1X4wg
        RcwC0xglPjw/xg6SEBawk5g5cRJYEYuAqsS6tZfBbF4Bd4kzT/+xQ2yQkzh5bDLrBEaeBYwM
        qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgsNJS2sH44kT8YcYBTgYlXh4Nb7wRwux
        JpYVV+YeYpTgYFYS4Z1SBhTiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUg
        tQgmy8TBKdXA6PAj//A9RsvKGkV+y3L58G3HmU99i74U9DeY2cfP79wEg+rUnd+OOc77KStc
        9ujfrJ2s5ZsOKh2et0NZtnVGnqUY4ynfZR/nqb91nHhkzYkXSn0PT5ek28q/ez77iMVvw5i8
        pfxZP0xvxLebTzfK0D5t+mPL5k9HPcRv9jTN/ufhtOjqb4PDd5RYijMSDbWYi4oTASeS8YYj
        AgAA
Message-Id: <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
X-CMS-MailID: 20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch make sure printing of log on console if loglevel
at time of storing log is less than current console loglevel.

@why
In SMP printk can work asynchronously, logs can be missed on console
because it checks current log level at time of console_unlock,
not at time of storing logs.

func()
{
....
....
        console_verbose();  // user wants to have all the logs on console.
        pr_alert();
	dump_backtrace(); //prints with default loglevel.
        ...
        console_silent(); // stop all logs from printing on console.
}

Now if console_lock was owned by another process, the messages might
be handled after the consoles were silenced.

reused flag LOG_NOCONS as its usage is gone long back.
(5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb)

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1 -> v2: make changes simpler as suggested by Petr Mladek.
	  use flag rather than changing structure of printk.

 kernel/printk/printk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af21..4b059fe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -349,7 +349,7 @@ enum con_msg_format_flags {
  */
 
 enum log_flags {
-	LOG_NOCONS	= 1,	/* already flushed, do not print to console */
+	LOG_NOCONS	= 1,	/* suppress print, do not print to console */
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_PREFIX	= 4,	/* text started with a prefix */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
@@ -1886,6 +1886,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
+	if (suppress_message_printing(level))
+		lflags |= LOG_NOCONS;
+
 	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
 
 	logbuf_unlock_irqrestore(flags);
@@ -2355,11 +2358,10 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if (msg->flags & LOG_NOCONS) {
 			/*
-			 * Skip record we have buffered and already printed
-			 * directly to the console when we received it, and
-			 * record that has level above the console loglevel.
+			 * Skip record if !ignore_loglevel, and
+			 * record has level above the console loglevel.
 			 */
 			console_idx = log_next(console_idx);
 			console_seq++;
-- 
1.9.1
