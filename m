Return-Path: <mhkelley58@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523468102; cv=none;
        d=google.com; s=arc-20160816;
        b=wPkgOtCDXUQcttq6x7aGGxSGIQVZgfL8cGUbRfY+C23h1puQW4pAaOIxKLh3oGiSjm
         0mhL7pfpz8hN6wutwPhMKLjVcwAtIfEb+6elv15zrUX8aDZEuvlWCl/pTjIu3XBeso8U
         b9LFKekux+r4M7T/Hn0h/xl1R7u8QiakdjvksZT4VkVzLF0nrj/zMTUBSKm6btXd+eMu
         uf9kD+OppNJ8K1XcOKFZ4mct9zBHwneOdtYcYTgrXQ5pfe3nG2uZ6dufgU97Y7bDY4u6
         6p6MxxbA/Xjrg3kNm6E9DcPRsGhG1+xjHImeeVmyMIHRqSAkgxoGi7Ja0Yw+6NOcnXjv
         6MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=xpGSHAfp6YTlblkuWPcoahilYnvACzbNvWwV4hDY9Ss=;
        b=N1Irsfs68H5ORZoIcqIVCnOlmVW1a3qHKjcYDs3ffNhBNItTfn8KYNJsuB8o0FZBfn
         JlA6Pjj16EqMnd7q+5d3+tPqv3+TnsZqGm22xOFf8t0F/Co2oaUa8hGciiiklZgoliqb
         l9iYofcUmZZi8wZoRDdYl2Hf+xH6W2fNpRSfhmBxxQb2n9+innOJcRJCt76D/7eeUkcS
         BrKcAQcgZmYsnqswaNxAKxztpTWghOY0ftLQtN6J9pxNYjqNvi8y4xD9epLIwltxktxd
         CNRQDzdAAVqedu3mTANoZ0mqv9q03npDbWc83BXQfA3zCKmBUJvB4zbcUhzq2aTGc6ye
         u8Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nh1QGkRw;
       spf=pass (google.com: domain of mhkelley58@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mhkelley58@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nh1QGkRw;
       spf=pass (google.com: domain of mhkelley58@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mhkelley58@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/mGgZvrfXxmmq8Fn8YkJ+MBeedISGbvbGOzFpuqmjVXZjfKVEYY9lP9UkIFxCJLe9MScNp5Q==
From: mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com,
	kys@microsoft.com
Subject: [PATCH v3 char-misc 1/1] x86/hyperv: Add interrupt handler annotations
Date: Wed, 11 Apr 2018 10:34:35 -0700
Message-Id: <1523468075-12713-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 2.7.4
Reply-To: mikelley@microsoft.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597472089339155035?=
X-GMAIL-MSGID: =?utf-8?q?1597472089339155035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mikelley@microsoft.com>

Add standard interrupt handler annotations to
hyperv_vector_handler(). This does not fix any observed
bug, but avoids potential removal of the code by link
time optimization and makes it consistent with
hv_stimer0_vector_handler in the same source file.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
Changes in v2:
* Fixed From: line [GregKH]
Changes in v3:
* Added more explanation in commit message and the
  Suggested-by line [GregKH]
---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4488cf0..20f6849 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,7 +41,7 @@ static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
-void hyperv_vector_handler(struct pt_regs *regs)
+__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-- 
2.7.4
