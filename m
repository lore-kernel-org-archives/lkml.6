Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELu7dyMYyjAJWsaJYsOPbzKu0l+xZAxa8tIVTJiVF0PsGXvKIOaEKxmeIuCvvWul8gSjX0mg
ARC-Seal: i=1; a=rsa-sha256; t=1520824075; cv=none;
        d=google.com; s=arc-20160816;
        b=LlY7AbyYFZsUxgSzMVQ+BdzOBVFMK97iKWOk2oD/UjtttA933BrwqEzLD5Qv43WL0S
         vcSf6xAxjfgJLfLqSV7a8OFHYe9lriMaC97Sm/Fum3h5+wk0sJ4mVUZYd1XTbXTUMS/7
         PC8DYQlBlavzT1Lz0T1qd+DFafj90s0Epgs9VlFhFjhCkknHBh98/2bZlbpwfUKHzF/V
         1qHwgRNu7TuoHRJRVE54NYkEhgYzzd6fwdOapUKqc8uYaxpfoz1BV29QnNC98H4Lg5Lp
         61e5c4FCgcvYdykUSH0RKK+dCYy7o5ryMhp2BqxI+YlzV+EMjKC9olwut1TS8wtARuhI
         B98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=QNAp12WdbOTak4s/squw/sGI0r75dXiJBAj9LGEy0jw=;
        b=FyMA9IyoCL/Ln/CUw3duihgm5xPeiB5mQHxzwuP8n3dV2eogl0Ld/oTkltAQ5VzJyD
         KEL/Dnr6Agi+3ezVhOVbTVJnXYMaNGd/31uBxLM4AKfMPmDxCpCytI6bn+JG/FowQgFv
         Jr91p1h3ShE4pAuMJWnTjZmoxOqZcWgGn3hyYDCNimcqdY/T3bJ9Wm39BKX0NyTC8C5p
         aYBPKUI0IYDzQg1rI/Kang6hU9CNZKYs3jT0nDfELT3D6cR41GjUAcPu6FCI853k7K7F
         Fhx+5/WZofz7RzNVb3Knrp2joQ9l7nEp1JTeRoZ6LQ0B+dMFtqRQaN9npu6ontporVE6
         KAvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Ingo Molnar" <mingo@kernel.org>,
 "Dan Carpenter" <dan.carpenter@oracle.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Borislav Petkov" <bp@suse.de>,
 "KarimAllah Ahmed" <karahmed@amazon.de>,
 kernel-janitors@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.583952513@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 67/76] x86/spectre: Fix an error message
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699610185199725?=
X-GMAIL-MSGID: =?utf-8?q?1594699626416744851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 9de29eac8d2189424d81c0d840cd0469aa3d41c8 upstream.

If i == ARRAY_SIZE(mitigation_options) then we accidentally print
garbage from one space beyond the end of the mitigation_options[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
Link: http://lkml.kernel.org/r/20180214071416.GA26677@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -237,8 +237,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
