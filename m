Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeAaQET (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:04:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:61479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbeAaQER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:04:17 -0500
Message-ID: <1517414633.10864.6.camel@gmx.de>
Subject: Re: crash binary for latest unreleased kernel
From: Mike Galbraith <efault@gmx.de>
To: Joe Smith <codesoldier1@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date: Wed, 31 Jan 2018 17:03:53 +0100
In-Reply-To: <1517370670.7130.2.camel@gmx.de>
References: <CABGNecyRGfSrrTH99Jps7KaDO3G3GuRErUDGixt4fueX467UBQ@mail.gmail.com>
         <1517027565.10239.61.camel@gmx.de>
         <b7b94e75-8052-738d-cc18-5aa1d0b4afde@infradead.org>
         <1517028522.10239.66.camel@gmx.de>
         <CABGNecydtsBT070SoVNRGbnmBdGNHAkEaAzJdoHd_ogyUn=ayw@mail.gmail.com>
         <1517131246.6669.11.camel@gmx.de> <1517133624.6669.22.camel@gmx.de>
         <CABGNeczUC8nt3PYSjSRUr-j_sxEA=k9cbwBaygA=WPwq-3jLFQ@mail.gmail.com>
         <1517370670.7130.2.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:maDsEPoH+hkzgY05ixpGuq+ZH8I5XAn/PQu780LZiGCvTzuE9xe
 HVV2qc6mfiH2RJ6sK9mJ7VQmQh7FSgcS0JsAbClXT3AiAs2NLmTfTZWUQNwRo+R5JsiKZAN
 o9Dzo379ZDSE93iiQtFUIgVle+x2wcViVQTeU7jdWbkJIKQ+RdVkOei7NMOVCFwffmj+pIY
 HRv4d3UDLJdSHlLly0MNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B3Km2m/EWGM=:DfoBSHej5Zv8K5dXXWLBmY
 f76fqmSROgJRaDlbiOetYzjfQyRhcWgQOvmB8N66kjDcEkGzofg25rrLt2tP0JynKOdYAIF6S
 g0OoxqJ2sm4Zau3Mbq490SMR30grAq6uRGstYM+2oE6cUSdD+6r7Gaaiw/6gcp6bohpzkszA4
 RAfeLU2Fzt3zgu3xDBQb8m4YAFgsbfbUH7QIziXTN8JxjrNp0sJxp3gz4Jxj5oCvkfLOD/dPL
 zzgo4nJdc4R7S97JN8dNdEvBKwVEf2zJYEEPGwFAfMgFj2l4HrYlkawOFnbEtcLmIhEvVsnF9
 3rJakw3dAy7uTAq15nVIyQeTi8TQ1pnluByidXvg3fIJp3Qm4cwmK/mroIBY6GK19QzfTTwXC
 uE5LkNb852vVaZqBUFJAksFcRNM/ooB0QvwqVABfaSx72Meicth1Q6Oy2eGBhI4XBh1hZAKwr
 lBBZb/FY3q1H56Nyxof8/lOweygu7f2RfGCplj0vS++KgjhRtMHmxEg+0Wa0PfUmJnkfODkRa
 XL01qLM5PZxNvxM0RQK70cpjODoIAJ3LQF5lTzs0pzjJ0UOiq7xln2KXuswLuYzcuRQyEDAsF
 NpWnlqtLs7VTqrdSSjORN0u87PTc0CdSWe04wEdBHbXngISCwox09XYjUehVqVyG7rGDZnlft
 wrf28/uNhuWJxM7LDrBHbTNJ7TRdC/hF7mejC/4G8FM7kIfoZOTEgpdZTEvicCMK6e+4agw0H
 oJsq0EWlTEYfa0t9Zrqu8/J3ajdOv/0vYqc6RDBO8acjChRCt1gb2+wVWWouQuE6G1rK+OJJN
 hQKj3aRPuuz47+w7QWo/ODfsJSnBGJhcoXsdpAQ+LNMOLH5RysDTTRjkL2gkaTQ7SYe/bKns/
 mbuXRhesVkFN5u1t11ClbGY4akPd8AW8ChGAuXuzzOsZ6DwKw6nnOVl5FbckzD
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 04:51 +0100, Mike Galbraith wrote:
> On Sun, 2018-01-28 at 12:19 -0800, Joe Smith wrote:
> > Thanks a lot, Mike. Following your suggestions worked !!!!
> 
> Until Monday happened :)

And during a rare non-lazy-sod moment...

---
 task.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/task.c
+++ b/task.c
@@ -438,8 +438,21 @@ task_init(void)
 			len = SIZE(task_union));
 		machdep->stacksize = len;
 	} else if (VALID_SIZE(thread_union) && 
-	    	((len = SIZE(thread_union)) != STACKSIZE())) 
+		   ((len = SIZE(thread_union)) != STACKSIZE())) {
 		machdep->stacksize = len;
+	} else {
+		/*
+		 * Post kernel commit 0500871f21b2, init_thread_union size
+		 * became zero.  Use __end_init_task - __start_init_task.
+		 */
+		if (kernel_symbol_exists("__start_init_task") &&
+		    kernel_symbol_exists("__end_init_task")) {
+			len = symbol_value("__end_init_task");
+			len -= symbol_value("__start_init_task");
+			ASSIGN_SIZE(thread_union) = len;
+			machdep->stacksize = len;
+		}
+	}
 
 	MEMBER_OFFSET_INIT(pid_namespace_idr, "pid_namespace", "idr");
 	MEMBER_OFFSET_INIT(idr_idr_rt, "idr", "idr_rt");
