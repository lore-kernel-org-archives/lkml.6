Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsvkRbuf+NSbxPV9TxhIh/eRRFa4uYdTwqPtx/BA7dvlcTIwOjtUharbWCesX3FuVo/Ps9m
ARC-Seal: i=1; a=rsa-sha256; t=1520824089; cv=none;
        d=google.com; s=arc-20160816;
        b=APcsTKuQjp1nQXSqgvhoBCkBhEEYfGGGT37wYyx6Ui8M3mGlgcAaFFOvhQyPD8sCXM
         dGAih+OoLdBpNowiE0MShrRnIkVpwU1eAo6dS8bxeXkYOECDjGE1gb2Q54NgMre8Lwsq
         JLZb3rDezi1lseHG9S1sezpv3ATgPlsThZjWB9642Zs/j2PSDxTamkRZDrZN/U+Ox2un
         1kOswnnyXeC8xNs6UyLJFVyBeXgDHfuieT6qmizuzgUaPjD+0KHw4Y0AM43USyLGG05Z
         GQXe6KWFxAL8514yNYVko7zodRGfiayKY9lUb9SEUNbFDM0GAVFdQjv5KlXcmyPoOypY
         kQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=XP7agJirUPpOXB/o9z35BbCfdiTdJi1D/qe5q6LIWGA=;
        b=MYomQjpEFSj0MGQQThNxpHJ+ocM+BGVIdbztB5bw1vdD56x2wJcxTueAUimOdfGGt0
         hfXMRsRt5payKow7o8DM3l7u9I6reR3/9Vhx3w1oYuBCKKICXUnCalzKMT9BrmaYkyuB
         0C0A+GYdO58BqaPymvlt21tgcDOsBjKbR/1R6Kob97W5OHhj3wk7M+PJ4h47wuZZpZL+
         Hor0ESXuwspCMJDgVe4GbiDC4Wg2TaSQL8h8S9haQXcEqfsAdKuHt4BE5jPOS3B0elMO
         0cZ6kyTBSRBypw13Wc+L7eG7tR5Kzc7IV3La4R/HPLtKNQI7l9d39BRhkVQkzgfO9bYg
         YppA==
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
CC: akpm@linux-foundation.org, ak@linux.intel.com,
 "Kees Cook" <keescook@google.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 gnomes@lxorguk.ukuu.org.uk,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Paul Turner" <pjt@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.109439133@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 036/104] x86/alternatives: Add missing '\n' at end of
 ALTERNATIVE inline asm
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699640492077160?=
X-GMAIL-MSGID: =?utf-8?q?1594699640492077160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit b9e705ef7cfaf22db0daab91ad3cd33b0fa32eb9 upstream.

Where an ALTERNATIVE is used in the middle of an inline asm block, this
would otherwise lead to the following instruction being appended directly
to the trailing ".popsection", and a failed compile.

Fixes: 9cebed423c84 ("x86, alternative: Use .pushsection/.popsection")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: ak@linux.intel.com
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/20180104143710.8961-8-dwmw@amazon.co.uk
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -123,7 +123,7 @@ static inline int alternatives_text_rese
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
-	".popsection"
+	".popsection\n"
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
@@ -134,7 +134,7 @@ static inline int alternatives_text_rese
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
-	".popsection"
+	".popsection\n"
 
 /*
  * This must be included *after* the definition of ALTERNATIVE due to
