Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1886210-1522228501-2-11522927945970723437
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522228500; b=gdp0gYx+AKlRsH2gVu3o2dhDq6H2e5eDcYvf00PuNcBstOY
    E1Bgx8r+1BAm6/CD/TccN9FJ2XJfkA487ZnsLw37KrAZQNLQt3Nz/H6EdIi0XllW
    +oOv3PZp6z+DgJGdUDNJ75F/oZV+KnCWFABr+bOMCyXrH3o/oi3B+RAh03uM8DIC
    Dq8pfjK8CMCJ1jKHJwKOEL8nqVYDd4pGLLkWvF67i4B4uxqDuUx+uLA3srDPDE9x
    rRegfHSsgzlF5JtW7WKV2ddpblNBffDr8tk0VHwduVCcHrraUdEmz8icJfhdlMmh
    +1uVA8kDcV3h+IDqB7C1qc1ejKQbWnDBgihNuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522228500; bh=T
    YISrXTFv8aa3Epon5Zz0Ronh3+ny+USVlyCnZepFUU=; b=Wd3/Rf8eYbWCBL0qe
    FifNeBgaBb1VRy/NW/kdCd52NVJTZqa1n2+3XbzvdiW50Uj2egGlCG2/pgpUTFib
    2TaxYylE1bfI1HY1gErTPo7boWOtQ2quwqb58hSQ0OqS39BTLETHB45WoSrV/9i3
    3CufdCta1Me5zkaPldGO0hQjlR7h6wRaiFz+gsYd6xjvs0BbYzojAiNKTLIbnCWn
    48Csr8Vn1D9nw3PPJwQ1vPvRH2sMI726qdrC7oZAbQjWcnNuxQW/Yj8mdf//JS+1
    MyUHWWkm8rzd0kByaDGp2dlpCc5x34vtlD3PR73sNV6yWMLaAZ6/IR94p10cKqG+
    jGNLw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=SiZcGSN7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iIPP5d/F;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=SiZcGSN7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iIPP5d/F;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGkz4M/NU5/briJt7PsJfUQdmkREcsfgRpUM7JVQDpnLSJcVRyUK5+M6EoJWDjGHeSH9DfsajZj6GIKtaG2bNZaeF5UaqjZj5PGCuksdx3NJBViHqEwS
    LNx+WMd19dp70qc8kXVRpI8yKtxxtLY4yqi3NLMvuSKv9TgaR0/d/QlzrKVnz93EV+QnrT1J2Tr7YHecxKdb1zKJ0b+NtjoqaZAbdvr15BQicFybsy53PTeB
    f74dT+xfhkLuFyjSB7Qg2Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hSkVLCK3AAAA:8 a=n8i27M1mAAAA:8
    a=DDOyTI_5AAAA:8 a=3PkXPK8BYj74Kj1dNy4A:9 a=CjuIK1q_8ugA:10
    a=cQPPKAXgyycSBL8etih5:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+a9k0c9vU2SkuzhImI/MFGfaPtynjiHAfu3DTCQQZQFQd2mcE3x4HRij45MpHARL6bKrUpLQ==
From: Martijn Coenen <maco@android.com>
To: gregkh@linuxfoundation.org, john.stultz@linaro.org, tkjos@google.com,
 arve@android.com, amit.pundir@linaro.org
Subject: [PATCH v2] ANDROID: binder: prevent transactions into own process.
Date: Wed, 28 Mar 2018 11:14:50 +0200
Message-Id: <20180328091450.85073-1-maco@android.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
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
Cc: devel@driverdev.osuosl.org, maco@google.com,
 Martijn Coenen <maco@android.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This can't happen with normal nodes (because you can't get a ref
to a node you own), but it could happen with the context manager;
to make the behavior consistent with regular nodes, reject
transactions into the context manager by the process owning it.

Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/android/binder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 764b63a5aade..e578eee31589 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2839,6 +2839,14 @@ static void binder_transaction(struct binder_proc *proc,
 			else
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
+			if (target_node && target_proc == proc) {
+				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
+						  proc->pid, thread->pid);
+				return_error = BR_FAILED_REPLY;
+				return_error_param = -EINVAL;
+				return_error_line = __LINE__;
+				goto err_invalid_target_handle;
+			}
 		}
 		if (!target_node) {
 			/*
-- 
2.17.0.rc1.321.gba9d0f2565-goog

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
