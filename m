Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754428AbeEaKWu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:22:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33963 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754268AbeEaKWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:22:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180531102247epoutp037addc1d956fa04fa775bed1f43bfab31~zs5jI5jgH2308723087epoutp03i
X-AuditID: b6c32a4b-989ff70000001138-06-5b0fccf6b737
From: Maninder Singh <maninder1.s@samsung.com>
To: pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 2/2] printk: make sure to print log on console.
Date: Thu, 31 May 2018 15:49:11 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTYRTm3e62qzS7Ta1Xkxg3DJU2t9XsFppKViOlBv4IHGIX96Livtrd
        lkY/FspYI81KCUXJwJaJZYlpqSlNUwwpzSSLPiQVKq3ltxlU267Rr/Oc8zzPOYfDwbmiV7xI
        vMBgQWYDrSP5wVh7X2ysZGV4s0b2eXwXNdqFqLHOWj7Vd92BUR/mHnCoP1PLPKrHOcmh7ixO
        CSjPUB1IwVWPat4LVKU9bwWq8rYmoGppG8dUi6071LwslJiPaC0yi5Eh16gtMOQlkemZOYdy
        lAkyuUS+n9pHig20HiWRaRlqyZECnW8VUmyjdVZfSU0zDBl/MNFstFqQON/IWJJIjVyukMpl
        +6QKhS8qsw8olD7JKZR/s6mSY7qxs2i65D5mB41RLhCEQ2Iv/Ohu5LpAMC4iugDsL1/B2GQB
        wNrJnwI2WQHwyeOL2D/LbMc0jyUeA9gxcI/DJksALrRV8fwqPiGFTZ3dAUcYcRQurP7g+0Vc
        4gqAqx+bA0QokQznyuwCP8aIaPj9xRSfHbEDDg1cDYyAhJMPa53uACEkbPDDXS+HFaXBBc/g
        hiEUfh1sE7A4En655NjADHR5zwO2USmA35Y+cVkiGU5OPPWJcN9KsbClM95f5hIhsOzXNMdf
        hoQQOh0iVh0NS9/c47F4O1ycn984hQpOnB8NrCAismHd3XpQAaJq/jetB6AJRCATo89DjNK0
        x4DOSBlaz1gNedJco74VBD4qLv0haH2e4QEEDshNQrw5RCPi0TamWO8BEOeSYcJK22aNSKil
        i88iszHHbNUhxgOUvqNd5kaG5xp9/2mw5MiVioQE2X6Zcg+VICe3CVf2/s4SEXm0BRUiZELm
        fz4OHhRpBzEj4WGd1qjUC2Pr7UkxgslrURW9Dc8k9tuh0w0uh0ZX5V0TZ2+fDVaPpL7sHtvd
        UtRPR9TFqUYPy5aP//GmVJds6VX0vlPHnFjbitkr4xzVqlJp2uoxU2+qzjPzZv2WbR0wgjVt
        4cnuTPe7mghlydpsqnP5dezMsDnRfa7rNIkx+bQ8jmtm6L/jc74UZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTvfbGf5oA06Li7tTLS7vmsNmcXh+
        G4vFvTdbmSz+P/7KarGv4wGTxdrPj9ktDp2cy+jA4bFz1l12j5Z9t9g9+rasYvRYv+Uqi8fn
        TXIBrFFcNimpOZllqUX6dglcGUtXTWEqWKhc8aR5I0sD4wqZLkZODgkBE4nX25+wdjFycQgJ
        7GaU+PDpKyNEQlri57/3LBC2sMTKf8/ZIYo+MUqs3PQTrIhNQE9i1a49YEUiAt4SU6//YgQp
        YhaYBjTp+TF2kISwgL3Em94GMJtFQFXi3fnHbCA2r4C7xMdDR9khNshJnDw2mXUCI88CRoZV
        jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBwaSltYPxxIn4Q4wCHIxKPLwca/iihVgT
        y4orcw8xSnAwK4nwTinjjxbiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUg
        tQgmy8TBKdXAqDm/7XCmU7J2sjqjuZTDU+s/8mu23lv4l/GcgO6Eu9oFovomS36+iJe8vrNt
        xuY4z8v/BIUXMn3ozZ0tb1YR+cl/woTb0/xP7XkacMV/ktyN+S1cdit55ZmdqpuT9XrZPftK
        89fMX7vi7Tf31286igr+O3Omrc2QkNX5sjfrwmWTJzwL5K5eVmIpzkg01GIuKk4EAK91bhQi
        AgAA
Message-Id: <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
X-CMS-MailID: 20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch make sure printing of log if loglevel at time of storing
log is greater than current console loglevel.

@why
In case of async printk, printk thread can miss logs because it checks
current log level at time of console_unlock.

func()
{
....
....
	console_verbose();  // user wants to have all the logs on console.
	pr_alert();
	pr_info();
	dump_backtrace(); // prints with default loglevel.
	pr_info();
	pr_emerg();
	pr_info();
	...
	...
	...
	pr_info();
	console_silent(); // stop all logs from printing on console.
}

Now if printk thread is scheduled after setting console loglevel
to silent, then user's requirement will be in waste, because it will not
print logs on console at time of printk thread scheduling.

@how
use one bit of flags field to store whether its console print
or not(console_print) by checking current console loglevel with 
message's level at time of log.
At time of print check this flag for printing message on console.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 kernel/printk/printk.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ab15903..4e0be66e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -360,8 +360,16 @@ struct printk_log {
 	u16 text_len;		/* length of text buffer */
 	u16 dict_len;		/* length of dictionary buffer */
 	u8 facility;		/* syslog facility */
-	u8 flags:5;		/* internal record flags */
+	u8 flags:4;		/* internal record flags */
 	u8 level:3;		/* syslog level */
+	/*
+	 * whether to print this msg on console or not?
+	 * due to async printk, printk thread can miss
+	 * prints at the time of console_flush because of
+	 * change in print level afterwards.
+	 */
+	u8 console_print:1;
+
 }
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 __packed __aligned(4)
@@ -623,7 +631,12 @@ static int log_store(int facility, int level,
 	msg->dict_len = dict_len;
 	msg->facility = facility;
 	msg->level = level & 7;
-	msg->flags = flags & 0x1f;
+	if (msg->level >= console_loglevel)
+		msg->console_print = 0;
+	else
+		msg->console_print = 1;
+
+	msg->flags = flags & 0xf;
 	if (ts_nsec > 0)
 		msg->ts_nsec = ts_nsec;
 	else
@@ -1144,9 +1157,9 @@ static int __init ignore_loglevel_setup(char *str)
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+static bool suppress_message_printing(int console_print)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	return (!console_print && !ignore_loglevel);
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
@@ -1172,13 +1185,13 @@ static int __init boot_delay_setup(char *str)
 }
 early_param("boot_delay", boot_delay_setup);
 
-static void boot_delay_msec(int level)
+static void boot_delay_msec(int console_print)
 {
 	unsigned long long k;
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+		|| suppress_message_printing(console_print)) {
 		return;
 	}
 
@@ -1199,7 +1212,7 @@ static void boot_delay_msec(int level)
 	}
 }
 #else
-static inline void boot_delay_msec(int level)
+static inline void boot_delay_msec(int console_print)
 {
 }
 #endif
@@ -1840,7 +1853,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		in_sched = true;
 	}
 
-	boot_delay_msec(level);
+	boot_delay_msec(level < console_loglevel);
 	printk_delay();
 
 	/* This stops the holder of console_sem just where we want him */
@@ -2011,7 +2024,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg,
 			     bool syslog, char *buf, size_t size) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
+static bool suppress_message_printing(int console_print) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2354,7 +2367,7 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if (suppress_message_printing(msg->console_print)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
-- 
1.9.1
