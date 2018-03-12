Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtyu1ob+HmMacQ+LD5TzJoIxZN8DlEKSaiYt2endlnkud+53vLkU5KiZ+69Ep4LySgOB8NR
ARC-Seal: i=1; a=rsa-sha256; t=1520824078; cv=none;
        d=google.com; s=arc-20160816;
        b=UuwaquwpZ47IYMXzCZ+iXNaD8qYUyzi84efUaYSICJBFVe34pl4lPqhSMN+xdQ96U/
         eB448fs1Q2uFEnWCtdCBdsVvrwqT8/3UZ+w8noCOBn6eTZT/d4gVD85oMvhC8JXKITjw
         eFe0SDQ5rW4rzihnuXWW/FJdxAf9X8qWNSAia7lX3eZcILW757Z78ctAECqJp4DF5ce3
         d5l39JDRhPxORZLeHXSqlMsNuxctZ6E46MAfIokm+XsclPEqUyx+lDoJoJhm3mspKgFt
         yxfvwRXFjRCHCvjhxuRbKq2SDn7ytLm/5oHu0SYbn7rKjhEQhtuwlHwzsnGVXypnws4U
         XyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=dg2YfSJRM3aoxY7QV60vHFbqBiJc/HVrBhKfB1e6okI=;
        b=bH5cOg8wIIE4O2V/NAHsFyBpzDnQbHCeYNzd6bBYXHt0wIPoHldcwxci8TJJI3xZSc
         XlFt18MCuS6w4xEb5O+j+EbvmulcV8ll238dsyjGGQyUzytSscrjCtqBLhhVW4S3YXWE
         RNl1bHKI+mK3WI4o9ldrUrp/zKV07UNIj0/7BhjhHEL++uSJ0tCJYENtscpxzZ/o001c
         54pWGBQljlFDvGPiO0DRMs/g79VHs+ztl6WIOwnxx6OoK5ptvCNgu7dpbOeR9FfsCz4x
         T7IxT0VOKcqPD/7Z+z2VwDoD2x/p3qemPvpOCmiTOBddvtGFwdi02l+Wi1rN9tb2LTFr
         mn8g==
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
CC: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
 ak@linux.intel.com, torvalds@linux-foundation.org, dave.hansen@intel.com,
 keescook@google.com, luto@amacapital.net,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Borislav Petkov" <bp@suse.de>,
 pjt@google.com, jikos@kernel.org, riel@redhat.com, peterz@infradead.org,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.405904313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 48/76] x86/bugs: Drop one "mitigation" from dmesg
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699616853113589?=
X-GMAIL-MSGID: =?utf-8?q?1594699629180361785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 55fa19d3e51f33d9cd4056d25836d93abf9438db upstream.

Make

[    0.031118] Spectre V2 mitigation: Mitigation: Full generic retpoline

into

[    0.031118] Spectre V2: Mitigation: Full generic retpoline

to reduce the mitigation mitigations strings.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-5-bp@alien8.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -153,7 +153,7 @@ static const char *spectre_v2_strings[]
 };
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 static bool spectre_v2_bad_module;
