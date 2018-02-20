Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2058923-1519112416-2-3624640341325482360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519112415; b=kk/lw/4SZB7Iw/8jHi3AS/XmfQWWA9E6BbeFDj+V9aXXsUB
    YhkNAJT75s215oK7yB+Tvazms6igmaOaFGkJexqV8Vaxv0dnR2lKYjV+atJRzYLo
    U5kcXcvqrSofJAOO3MuFWkW8/yS5Kg84UoNByBjrbZf0uqaVZePcZHlzclPc3Dh5
    cBCQfSureF4dU7p881nEsiDR6ytWfdPkh8Mxb/K93PQP5F34LTWo05zm0jk7nGRz
    sUqn9b8NksGTtf3bMq37EFYGsdtynCMB2oQkL/UzYW3laTQXCJI1KvQIH8OR4jPq
    ayQs69wX6EfxgG5pvJCRdf+99RBAKl0cckzcPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519112415; bh=C
    XJTaprPAqCcozHbg8m3styf5L5TPjhwZKr9NPRuuPQ=; b=waHmaH8BjypjZ4Nso
    oZ7T58khBqiobaHJNteKdZVo3XeQelYNY3bxGKE0mH1IW176eghsZmADIVZeY5Qm
    Px/hl4g4+B665XfhuSSLChvXW3ZpyqvDuX+ZRucS8KeH07wlGAK8Ot5J11s9fY+L
    O6uoUfmiKaZfS4GVTNFbOP71H6mSLPDQb153or8i9m+f22DE4pKx5N58qg4k7xX8
    kGtOWNR3u+jZ0cpfDSe1zgekctGwhrCt5To3CeJXlQJOjCUA7zflEaqWdCQ8ksnk
    rtEiWSnLcbeZUYP+D0KxPEOgSvkxPRfMjYuTnNIbufxb7j3RX8I0+RCBX6QAjyez
    OZ//g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.de);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=LceyhQE5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=amazon.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.de);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=LceyhQE5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=amazon.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.46,538,1511827200"; d="scan'208";a="720518547"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, x86@kernel.org
Subject: [PATCH] X86/UAPI: Use __u64 instead of u64 in hyperv.h
Date: Tue, 20 Feb 2018 08:39:51 +0100
Message-Id: <1519112391-23773-1-git-send-email-karahmed@amazon.de>
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 KarimAllah Ahmed <karahmed@amazon.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

... since u64 has a hidden header dependency that was not there before
using it (i.e. it breaks our VMM build). Also, __u64 is the right way to
expose the data type through UAPI.

Fixes: 93286261 ("x86/hyperv: Reenlightenment notifications support")
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: devel@linuxdriverproject.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/uapi/asm/hyperv.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 197c2e6..0994143 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -241,24 +241,24 @@
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
 
 struct hv_reenlightenment_control {
-	u64 vector:8;
-	u64 reserved1:8;
-	u64 enabled:1;
-	u64 reserved2:15;
-	u64 target_vp:32;
+	__u64 vector:8;
+	__u64 reserved1:8;
+	__u64 enabled:1;
+	__u64 reserved2:15;
+	__u64 target_vp:32;
 };
 
 #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
 #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
 
 struct hv_tsc_emulation_control {
-	u64 enabled:1;
-	u64 reserved:63;
+	__u64 enabled:1;
+	__u64 reserved:63;
 };
 
 struct hv_tsc_emulation_status {
-	u64 inprogress:1;
-	u64 reserved:63;
+	__u64 inprogress:1;
+	__u64 reserved:63;
 };
 
 #define HV_X64_MSR_HYPERCALL_ENABLE		0x00000001
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
