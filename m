Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvEZAkxg4/4XiFq83xurt01eBz+AUGl/Sli/EoWNoQP+0bptJnp5/h0/Bx5xXVyoAnNxxwm
ARC-Seal: i=1; a=rsa-sha256; t=1520824068; cv=none;
        d=google.com; s=arc-20160816;
        b=YtinbAWk9tD/c8e+61sVTuMguoGPNOMpcF/W8N1eWngVescrstJFTDj1BXc2OcS3hv
         2j0/fOnDUQ2zTR5gqodzd7Wq7nhE3MLgACx4xIwwwX8Xd3p6/Ju74LA6CmzihhaivwDc
         wT0QS8288l8KQxoAfS/sViTtzSyWfDN8g8Ctw3ed5/ujRIjmvOs+hYYPLps2FXNFeS9a
         e3nw5zzXr8vtCvhDp9Ip9ui3+iBAu/gNf5TOC0B6vHVo/2i+TmsI8rSVa4No1I+1pU17
         9nKOkzt1OHa6BK229ZESMzF35rajhjpm3ixHfl97oBIkSw/SDUW7afBYfPhD0tOSWqzW
         SmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=X1NtCfcMglOYk8zWd0GF/L/Zd/h0Nbgu3tBQG0Qd9+g=;
        b=CvTwloKdpVA8PpGX7LvECs4UFG1cxEEClQRgV+urkNFiYogXDlPfdI4c+bOvkpTXKC
         90bJ/esXylyEFzLxGjJt+Tkvrnf635IV/6PU/r59iIF/5ONL278xUoltVjDNWRfdfE/q
         2d+wFwKQGQnq6V7LPB0D1zmYG5v1Tyyhm1b2W6lKdhGHSSmBdp+lTVN1MRAoRfAISl/Q
         uGABz080VrG8m2H5EtsEpu7QX7y6JVmYcs2M9K39IlKuQGfRIC4tSp56we5oOq4F5/hC
         eGKRVgAlRv4cLTwhJ3EB1yhKYwqCnxXkeSNgaYqZnnG8ReDCkpsdx9zN3nYy+69U3k9b
         DYVQ==
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
CC: akpm@linux-foundation.org, alan@linux.intel.com,
 "Dan Williams" <dan.j.williams@intel.com>,
 kernel-hardening@lists.openwall.com,
 "Jiri Slaby" <jslaby@suse.cz>,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 linux-arch@vger.kernel.org
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.204619237@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 089/104] x86/spectre: Report get_user mitigation for
 spectre_v1
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699618118932201?=
X-GMAIL-MSGID: =?utf-8?q?1594699618118932201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -433,7 +433,7 @@ ssize_t cpu_show_spectre_v1(struct sysde
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct sysdev_class *dev,
