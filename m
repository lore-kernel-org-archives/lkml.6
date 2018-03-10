Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2413098-1520668055-2-12727203611021090487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520668055; b=NKX+TeCyfa4s6cEL7qsjSSaIecCBXlnB/qSaVWBkV2hHawL
    pDE1i052YhaxDX+PomJISyig8bD2gOmAX9TaM4tygn2zTsEA9d3P1tLPELDAGKRU
    V0u1i2HJEDy6ZEHCCnjPd4NWd0Z7d/XTvVRxl3aV2GUVwZZQmQbF3X+IxKQWIqI6
    2qKL2aDl59w3E0kLKzAm79M2zpyA8qwoJlu16vHFQ7yEl8XgKtAZcArHKxnLbkgn
    RY8wigGdtbHbiYbkU1LGlprNAGhG573pOLvUldYrDF+fwycpfTbT+JMVWUKKSizB
    RqnjzChE3fJHm+FQUYibMtFPQxHRMtRG66ZzwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520668055; bh=Y
    yhidoE50DUZFk/LLxhB2Z6pNWGjosXh3pyWcIO/yfU=; b=foquR+5QCfzCY4PlV
    kMXSO2OZv8QbshDnNC3/72nhpSx/yUFnXzhj27bnoGsbBkxxHmxOG37wUwykdbSF
    JdrgFFjD/tqSiobIxN2FN5CQgGNXEN4Bq2WFx3YpQGiQQsqFa2Inexkz7HT3Enzt
    zdCU5RqANeaSbs+uHURZrVkNA1Qqi8NBhB6GR/+RMpFwXsvF+kgBZa+TBF1IAKQR
    0Q2SAUQi5h/nuRERotgSCt8PC/gWJDX3adHQhHc4fW3hmxgyLFbCIYFNAkQ+cRFs
    HivYGOJCcHXN/chcDRYf8rfjtO2usvpS9IpqhNYlsNV+Abq4IMJfVK2p5TweVz0h
    lbYfg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cztaWdFK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p3wEbku9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cztaWdFK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p3wEbku9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuhUIg2T6lbuiISV9i6TXJgegCFvcHE18lKrfKCiMNgH7bTzTMoYypA0Y8SyO1ovN0F6DCz8Q==
From: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com
Subject: [PATCH 2/2] drivers: android: binder: fixed a brace coding style issue
Date: Sat, 10 Mar 2018 13:16:58 +0530
Message-Id: <20180310074658.1961-1-vaibhavmurkute88@gmail.com>
X-Mailer: git-send-email 2.15.1
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 Vaibhav Murkute <vaibhavmurkute88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed a coding style issue.

Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
---
 drivers/android/binder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 764b63a5aade..2729bb75ca19 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2641,11 +2641,11 @@ static bool binder_proc_transaction(struct binder_transaction *t,
 	binder_node_lock(node);
 	if (oneway) {
 		BUG_ON(thread);
-		if (node->has_async_transaction) {
+		if (node->has_async_transaction)
 			pending_async = true;
-		} else {
+		else
 			node->has_async_transaction = true;
-		}
+
 	}
 
 	binder_inner_proc_lock(proc);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
