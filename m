Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELv38dDqj4Lrp9i3Pc00uau3V2KjR/AR7bAzYt0D4o9JU3GWDpRI+qHUuzxnKPMce9YgFwVg
ARC-Seal: i=1; a=rsa-sha256; t=1520824071; cv=none;
        d=google.com; s=arc-20160816;
        b=kb3Rxrbbdm9yXiHLqKP9Its694TfaRPSOku72XQLQMKcGIyb5ZO6BzwXVdNHaHzYPM
         befnnUbW09mpR14DkZCzikKofkH/yg/3M3PFh180Rp4euoBiKjlivtMKnRnAlIyfzm0/
         wybFZ0WrOQemB3zW9oEslgbmaKdqJlxSf04wqTxlCVCrWsTdCZlKU7axLwFRNtcmVp9t
         npL2Y9dc56Mt7AWNKOceJMmx3Xe9dRjFNmxo/sM1NyhpEqxESXO9bzXf5OY7tJ6EwvpZ
         gZ1madrU9obdgeHcbCfw2f7VBfRou7BmLpYt/+KHdpIgANO7AqknkVJ7qsWmXGjP+PL+
         JwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ldReD5xrAoiTm91DloStiUWwHsfznnHZZ1wWcmvNS3M=;
        b=uJOTXhduKV0wdjTt3OdkkjcmrsG7cD1ykerLy2yJnQFaJfc+6oN5KDeZFrF89yg1BO
         bkcYhhVVFd52OoBXvGT4k93zr6gNwRMSt4WDWDSeqTE8DcxQu0sRB04CQigotS3UW/KM
         3wbruuGf9pyQ3VhzImV3dsdcUDDjM7/5C90BJc/mzGc3nx9UKD5k9NvEMiku8BPjVtOv
         IFRIMnULz3WJ39mx7oUCoWRelbEVjHTmMJEg5EZHQds7r8YbdS/7dSo5vWxfQKUz0ibe
         x+jscSBvBBxXs4igdtzMB0r2joacGBcsJvKnVVmHUzhLzfxrrBsHmqnmzXBpi8HUygXv
         vCyA==
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
CC: akpm@linux-foundation.org, linux-arch@vger.kernel.org,
 gregkh@linuxfoundation.org,
 "Dan Williams" <dan.j.williams@intel.com>,
 alan@linux.intel.com,
 "Thomas Gleixner" <tglx@linutronix.de>,
 torvalds@linux-foundation.org,
 "Jiri Slaby" <jslaby@suse.cz>,
 kernel-hardening@lists.openwall.com
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.995550615@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 59/76] x86/spectre: Report get_user mitigation for
 spectre_v1
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699618118932201?=
X-GMAIL-MSGID: =?utf-8?q?1594699621418418242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit edfbae53dab8348fca778531be9f4855d2ca0360 upstream.

Reflect the presence of get_user(), __get_user(), and 'syscall' protections
in sysfs. The expectation is that new and better tooling will allow the
kernel to grow more usages of array_index_nospec(), for now, only claim
mitigation for __user pointer de-references.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -353,7 +353,7 @@ ssize_t cpu_show_spectre_v1(struct devic
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev,
