Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826580-2-7065157879158560344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826580; b=QVQufwMx9yVTYdcKhvdJJhKOQnglZboIXShyCuO07epDCuC
    BJ6Tsy36r0fO4WuJwpnfZphO5+d8J+DgRQUTUAB5YHVdbE0dhuk2vZHw4kFaqAwZ
    k8V2YlC8sLExfAHP/JenSvnTUhWg4NKKKGjWX3S6581AK/oGoJLycAeCdz5qRTPz
    91otHzGVmNRiOCf4rGXCeA072JxqUGPfooJYXgPzypiRuVomil23EBAi0dK+SIbZ
    vayzCEyP2Xcdml2d0T65IEUrvAAKeVIpT+TC7TFLESSpG3CfUWHYttkFSHaHTxJf
    TuZhnsxTO5UbAfupPIKp8xMfJJea88muV1L84zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520826580; bh=2
    8vK9yXxPhDgzJ0vZxP8iEHl5qomTPFT5tSqoEqRum0=; b=Crgau6cIYYuHOfLvz
    INMg43vWgUdjs4d24CcOMCgczDVBSxQQb6fHSQqUYQMF8jcH+6mGhiccByAi61qy
    ELjSuuf900Cp4vFKBfM0EOHbjHYlha16aNSkV3qyGOZaCNaNcEOPjBpVEGBofgjn
    amwFhwsBz+TNzM05ml1xhCJbyN6hvQd6kwfZw7RdzXr6ATulZ5b49T//l9rL16Db
    fcRkKi6famvBMZE9NIuHV3RNiHUA16NnD+eWbJVj7TLXWTVRMJlTh2JLMe2FqHSL
    qqCUaYH+umvsIjar0FIQuNN7P/zyO0HfrrKhe9DHgm36F/P36x55yB7jcBtPSON+
    T4eFQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YfVei7uN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KOC2Vki5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YfVei7uN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KOC2Vki5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtZh0AFi6MXhm7oOOeSHvP0e7FuwyyVmjXM2wwKVTL9vwyKm0XUkm8UkveWVEGlG87FEK1uTw==
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, kys@microsoft.com
Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Date: Sun, 11 Mar 2018 20:49:02 -0700
Message-Id: <1520826542-2095-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: mikelley@microsoft.com
Cc: mikelley@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V.  They are being added as staging for upcoming code for
Linux guests on Hyper-V on ARM64.  The x86/x64 implementation
is null because VMbus interrupts on x86/x64 don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index e73c4d0..b73b839 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -168,6 +168,10 @@ void hyperv_vector_handler(struct pt_regs *regs);
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
 
+/* On x86/x64, there isn't a real IRQ to be enabled/disabled */
+static inline void hv_enable_vmbus_irq(void) {}
+static inline void hv_disable_vmbus_irq(void) {}
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b1f6793..6a3ea4e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -299,6 +299,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 			    shared_sint.as_uint64);
 
@@ -433,6 +434,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
+	hv_disable_vmbus_irq();
 
 	return 0;
 }
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
