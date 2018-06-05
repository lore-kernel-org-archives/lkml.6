Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeFEUj3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:39:29 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:49478
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752110AbeFEUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:01 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/8] x86/hyperv: Add interrupt handler annotations
Date: Tue,  5 Jun 2018 13:37:50 -0700
Message-Id: <20180605203756.29809-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203756.29809-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
 <20180605203756.29809-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfBmPPXvR3AC73sWWSmoXjypNo3+5mZlASFGBmTxJXdkYZ46NrqUmluAu0+sbeDEibEfhlF7ezv7JJVuWqRU5QMs1li0vZBLLo8Kj5YZljCjiUM1yiTi0
 +Ldd/VwBSuEyx3T0Rf3eUubo6qvqZDUmmCB8IxMyy7JNpQW9LjpKE6S1gPtn6wX/gMrcrcqTziMlmeQsTuxSG5EpzvW07yUXxFIRjYwwz2ilVYAqJAnRnV2C
 lv8oZTOEHARzjR6wQXirv1e1C9xU7LNdTUp5c1aUzZR9IH9gNP9wermhQZYjoQfJZfyp7g/V14hMar3VW9Zh6RzQ69Vu4mNQ78KlhU+zdFHLxbINNwUSInej
 hD3HbW5xrbG/bxFak4EMkTTQ4MgQ0zQPFxElaRukzCp6qOujN6o9Kqa9EbaO43grgeqsVeJ1P2l+H9b9rI4tAYw80XeME1eo5AVj+nMxnNkGpbGvOIjt4vEd
 v3fcSi+7cikrdpUdxhBMujQSSHmtu+jxiHUBh4tQO/RXxBS08Elh5ypxl0hWl0P4ILPZHmGZD1M3Dr8QyzxCtJYEUwnl6WpAyHszyg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Add standard interrupt handler annotations to
hyperv_vector_handler(). This does not fix any observed
bug, but avoids potential removal of the code by link
time optimization and makes it consistent with
hv_stimer0_vector_handler in the same source file.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 031082c96db8..8a49b7ef7b76 100644
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
2.17.1
