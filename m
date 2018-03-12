Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtu7mmPG12osvp2YMj9GNdVo6GeazSA+xfoPXjP2wpdjm0FPdQwC6JPiDprFvH+KCZanZsJ
ARC-Seal: i=1; a=rsa-sha256; t=1520824060; cv=none;
        d=google.com; s=arc-20160816;
        b=QBNI3jtbBOYeJWJTHbwQBcfTWLiUfAt5YMyTypPVOslQhuRsgxioI3J2DInmdO/jLQ
         AUCvyXwYQQfFq6RXcMPiOGB7jvM7gYqLiKwDeZMpqOpiX4hzRyc3SzOUfyZcNZxLAHL8
         Q7gVvr0ATU4OIWx4I6qJCGjrdrHI8aZ/iQE25ZexN5zOORhuWJerx4yy8u3X/7Mtpslg
         nd9jP35Zbj0GupYGc/d91oq67cMAwFNqP/pcgCgOPYmSOcOwFfw8/RLl0Ru9WwyDp7Fz
         jXjsrko32jWCninbOrpTvS+8pSRLtiO1ekSF+JSRKvMFgajxr1xqc3n+azQ2k44yk0xn
         tv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=38+3gxKdpbgxeeHWXYaGx/JR2iNUnGAo5EqJEWyy1O8=;
        b=cnQccgxA4bQc6KPRwqCAQVY3M442YLnCmeIEYCkhMbcQm6B7QWs6vLzOYGg3YHqf2y
         00jFPaikMmlc58LSQBKmifxylzLvcLNsGwMIxSrkI6VVGGoVzCetYpanfJIR/7uk6omh
         CCbjWmVyQOc9ZibYTfGG4Ae3QawxTL6gfOuD/TKBjkHJ3NfQQBq0jf9q66/aBIiSFtRx
         6Mt1q13GcEarFbpdiIevzWI8W/cnYAcUacxM+ZxnRf4NqMSG5qYvRdZ2z9yeP8/lL6Fs
         wM1vLG5de3pWIeL8sRDeZv51WUs1DxoW/MuBiWdDV0iS5Xpf/ihaWmAxt/weZ91Lwtgk
         Y2Ig==
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
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Ingo Molnar" <mingo@kernel.org>,
 kernel-janitors@vger.kernel.org,
 "Dan Carpenter" <dan.carpenter@oracle.com>,
 "Borislav Petkov" <bp@suse.de>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "KarimAllah Ahmed" <karahmed@amazon.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.143503038@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 097/104] x86/spectre: Fix an error message
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699610185199725?=
X-GMAIL-MSGID: =?utf-8?q?1594699610185199725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -317,8 +317,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
