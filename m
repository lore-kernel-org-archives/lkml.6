Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1824247-1525739905-2-1006628841006621287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525739904; b=NZeiJralYs0j91KqJ15u26ukLhXrPFKaVgXqOVbLJEFF9FdcES
    vpZKZ1wVfBqYizccKW5F4X3OX2OeLI4xx3r0MhSGyeCOsSSLZtjQWPeYJZnNVlP0
    HXe3a2sXeMOZIjXWW3q7gCk3cRm1kh5JlA8ylRilvPYWWGqC+vtVGicstL+2IJ0r
    6X0xqpMq3z1QKhBXVx63XR1QUI8h0o19CggK8Z/FqKdSDX10fRJX8Q4KNMHqeHTX
    WhTkrbySEfmRJXhA2k23wV+85F0CQsdvsAbRkFaQ54dGUfmuvd/xk51GvEXbhcKi
    ydhJ+7qxSAm0WRJ1DFYpcqSxpkR4PYGp9tlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525739904; bh=id77c3dRp39m61vBZ7I0QzOKuVe8OSvQbHjb3CNypxM=; b=J
    /7R6qW6/wMhNr2qfvbpGBB9m3ZXRsXhcpGRni4E4RqJwacVFAIS3kfTXmPyt065h
    kVqx0Sm4e8Yc9U4+6z2ThFACsS9Lv/BfbL8ud/KKliyxlMyfbr4oge/BgEGAWArS
    PJdfnnEY8CYMyq8U9z7W322bDZx1VLHgR76l4i4+YjGuQF/1fS6s19kjUfx4CamK
    DLyHfcc4A6kguJTvy9dGAlXcDwZk0KMTlgkuGpUJARBy2GsJwblFCYHXzl/d+bs6
    dgYgfNikprPEi9a6vLiK+WdKSt1ZcXolTjrs3+RcxuathXp1mu1FD1WtX13CZXF1
    bVqZYovz9DeOwxfF28Vfg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=WqtMQCgA x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=GIGpYXXY;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=WqtMQCgA x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=GIGpYXXY;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKB4pdBcTW2k6/EUTEIXBLfNdYGDqgBJ0+cFhWtIsDEe8dGi6OdLSXM/sP+pp6dPGr0qG1xtSNUqOdmGyqRAo4zzKAu/2JIGAMASVS8K2J6jKFnNhira
    ad5/4qnMDwGWhn+/gwRbJEnW81CIKV41oByPV3caRM3ezm7+4tf5d7X1G7O3xYjFyRAlXmWFBhYIzi3HdXGS+S445ywCw3J5Y2qzUBJcHVewtrCMxF9xajYS
    LnvK0j/eSBY76DNA6a2Z6g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=b8aGf-dT0oUA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=16gRXMSRJVShV-DN2ekA:9
    a=-DFMFflgbjik7y-K:21 a=6jFm_8_lzUesT9d1:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqzPoYie476z+x7JB25xGwpiEnGd93kqOyVJVwc59cv7OS1UXp0w90uGx3uG7Q6o7CmnrHh3w==
From: mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, kys@microsoft.com
Subject: [PATCH char-misc 1/2] Drivers: hv: vmbus: Remove x86 MSR refs in arch
 independent code
Date: Mon,  7 May 2018 17:37:30 -0700
Message-Id: <1525739851-54919-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
References: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mikelley@microsoft.com>

In architecture independent code for manipulating Hyper-V synthetic timers
and synthetic interrupts, pass in an ordinal number identifying the timer
or interrupt, rather than an actual MSR register address.  Then in
x86/x64 specific code, map the ordinal number to the appropriate MSR.
This change facilitates the introduction of an ARM64 version of Hyper-V,
which uses the same synthetic timers and interrupts, but a different
mechanism for accessing them.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 12 ++++++++----
 drivers/hv/hv.c                 | 20 ++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b90e796..caf9035 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -75,8 +75,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
-#define hv_init_timer(timer, tick) wrmsrl(timer, tick)
-#define hv_init_timer_config(config, val) wrmsrl(config, val)
+#define hv_init_timer(timer, tick) \
+	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
+#define hv_init_timer_config(timer, val) \
+	wrmsrl(HV_X64_MSR_STIMER0_CONFIG + (2*timer), val)
 
 #define hv_get_simp(val) rdmsrl(HV_X64_MSR_SIMP, val)
 #define hv_set_simp(val) wrmsrl(HV_X64_MSR_SIMP, val)
@@ -89,8 +91,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 
 #define hv_get_vp_index(index) rdmsrl(HV_X64_MSR_VP_INDEX, index)
 
-#define hv_get_synint_state(int_num, val) rdmsrl(int_num, val)
-#define hv_set_synint_state(int_num, val) wrmsrl(int_num, val)
+#define hv_get_synint_state(int_num, val) \
+	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
+#define hv_set_synint_state(int_num, val) \
+	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
 
 void hyperv_callback_vector(void);
 void hyperv_reenlightenment_vector(void);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 9b82549..96c403a 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -127,14 +127,14 @@ static int hv_ce_set_next_event(unsigned long delta,
 
 	current_tick = hyperv_cs->read(NULL);
 	current_tick += delta;
-	hv_init_timer(HV_X64_MSR_STIMER0_COUNT, current_tick);
+	hv_init_timer(0, current_tick);
 	return 0;
 }
 
 static int hv_ce_shutdown(struct clock_event_device *evt)
 {
-	hv_init_timer(HV_X64_MSR_STIMER0_COUNT, 0);
-	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, 0);
+	hv_init_timer(0, 0);
+	hv_init_timer_config(0, 0);
 	if (direct_mode_enabled)
 		hv_disable_stimer0_percpu_irq(stimer0_irq);
 
@@ -164,7 +164,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 		timer_cfg.direct_mode = 0;
 		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
 	}
-	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
+	hv_init_timer_config(0, timer_cfg.as_uint64);
 	return 0;
 }
 
@@ -298,8 +298,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
-	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
@@ -308,8 +307,7 @@ int hv_synic_init(unsigned int cpu)
 	else
 		shared_sint.auto_eoi = true;
 
-	hv_set_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
 	hv_get_synic_state(sctrl.as_uint64);
@@ -405,15 +403,13 @@ int hv_synic_cleanup(unsigned int cpu)
 		put_cpu_ptr(hv_cpu);
 	}
 
-	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	hv_get_simp(simp.as_uint64);
 	simp.simp_enabled = 0;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
