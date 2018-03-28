Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1645646-1522222168-2-3127478790303811715
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
    t=1522222167; b=ptkr1B+wo1h4rz+SBEQ4WHOanDB/L+0gjywYm5a5EuR9LvM
    QhqAApgDhECGWkbONxmhp8Y9U7696P/Yr5gV+dg2TFvBiVEHLGag9ZHDdHVJsWAt
    tF4SxJBUT/deCdSl+1v1j2P5z31CdnTTX9GLml10lrSO3FzAvwS40ZIGYpdc/mrG
    JJFrw0BcnnP+I1ORHMVbdtYAQDtC1nnbw5xD44LJJxKjLqdVnhFnfKfdWqIwn0MU
    oArdfwQ7QUqwsomUaFaQVzsTlN/aysTsFPYApeQnSqZ4ILcwX59UWV4hLYYM0dwa
    W8GoinJJmxtjhDWeusPGkkHYkYlOuFHhqE05cig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522222167; bh=2
    bY58pgK1gs0zlcStHisA7HfKVErXdudYAgIu7nu/NE=; b=ZkGHu9pBs3uIrzVzE
    QxpQv4+AMlKleMqQuW1dQsGOgvKi3wsCEMjxjlcQezqSMGGrSzupNtJeih0niLDD
    RPIfktgV4FMiGb6lwjDYPGkH2qMIOP1iDX7KMDSaLWR6BcRcmM4OlYO5UHIHUIbM
    zID60qVe7nB5P/9bLblrgmX5qx094AdSfm8M2LHu5AJsm+c8OXJmg1vRAakcnq2B
    RpwcNFpo9iZH900V8yNexGgVvBpplYKhD63Ae7y1PqlHH3Qy8lpEqcoGiugk8lTh
    MGPUFadFe5QYPMN6MwdatEnE9HW1OITI+npBS6Le7D6s80oclq8tPm0Xmt9hCsQS
    ulXGw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=MICc1P7T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=c9hke76O;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=MICc1P7T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=c9hke76O;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMvng8DiIkAovO4Nvjpil4RWnvw8f+LDfTQKwRlyq3CAP08SovQzAXDJ9u5PC8BZM2S5AIi/XbcRLVnS9uy6Dfz3FkPJBSzOBXDQgN1foElAu5cmErg4
    5loDac8cM0RwDFvJYhHXej6Fr33KHAE+QcCu41V2ixJ2aAH9fNOuWSy8w1y509mnnVXlfpX36L8t84kX9xU/JZwzqOxPBR8ZH5xigUylk3/IsWoULeO6XD8j
    X1eC1DcdlnYiCKhC90CGtw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hSkVLCK3AAAA:8 a=n8i27M1mAAAA:8
    a=DDOyTI_5AAAA:8 a=3PkXPK8BYj74Kj1dNy4A:9 a=CjuIK1q_8ugA:10
    a=cQPPKAXgyycSBL8etih5:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+hhsF8OFeXXuB1swNR6dBLgaoEbyXSp0mp3MG9CPcmBLWrp2R2Da8l5vCOx9Q/FjLUXOd+nA==
From: Martijn Coenen <maco@android.com>
To: gregkh@linuxfoundation.org, john.stultz@linaro.org, tkjos@google.com,
 arve@android.com, amit.pundir@linaro.org
Subject: [PATCH] ANDROID: binder: prevent transactions into own process.
Date: Wed, 28 Mar 2018 09:29:03 +0200
Message-Id: <20180328072903.155938-1-maco@android.com>
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
---
 drivers/android/binder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e7e4560e4c6e..57d4ba926ed0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3001,6 +3001,14 @@ static void binder_transaction(struct binder_proc *proc,
 			else
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
+			if (target_node && target_node->proc == proc) {
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
2.17.0.rc0.231.g781580f067-goog

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
