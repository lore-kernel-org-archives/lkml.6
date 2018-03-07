Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1520386626-3-11959288890400160942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520386626; b=Q+jat3bc5WvCjqgQ3M8IkLMGVfEjzyzZOPjnu598jVj0qMp
    i0TBSc9Da/LJIcg6OpLzcSCK+AKRcEFRsa8a9LNcyIfY/zquzlX0x3eDTXwLV87d
    F7qx1ytln9CA/k872FeVvZz/Jbp8iuCyx5kQG/yqzpC25775uunf5YnjeexfHznB
    zzO7l4+Czrr2TyhzboEsOywdH8mFFBan1CoftAb5pMtI03h5G3lEEpHef1eD/UZg
    OntBYxz9goM0DwKJkPXgcnnFCpOC7mwoWfgctAJ69UWatFzdRXCPjorCN5oHwihX
    3AC+RBAPdoHLn1081nZTyUyZ7A8nbkBvakpSxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520386626; bh=I
    voN8gWXwXhhwDYIaw5alc3xBvV9x/BpZUE94HelNhU=; b=etarF0r2EgRRCdyb9
    4boCstw6H/HDZST+HaMjwnxEhz8eDSSFXtEiqxEuhUvEd4Mt5x8ex7dvHqojlTTo
    9rY9AjDo9euE1CNW9zpu8zHZy1nbA2oM6YajkpaPgg1irf5xy9gJyjzlW3Qt1l1G
    rqoOtjFCLd+DmvDZ2g3ODgURzFPkIKZxsRqDVSz/me3s9k4/y1vbOohcmyyoSmE3
    3VfM4JhVPWz84TfRZ2XNC+jXAFWCN0M4KVFWgO2hztC3VKVqABTkfCAcBpOOi/C5
    N4Jnj0OSRbVCxao0048wSfBOOFlIDKQ9mnDs8UX5h9DgHqFy0TUWPwWqm2MU5mqh
    DmVOg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	dan.carpenter@oracle.com
Subject: [PATCH] staging: most: Remove unnecessary usage of BUG_ON().
Date: Tue,  6 Mar 2018 17:31:41 -0800
Message-Id: <20180307013141.23080-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306094728.xbhamhpwdphv6kju@mwanda>
References: <20180306094728.xbhamhpwdphv6kju@mwanda>
X-Provags-ID: V03:K0:39Kz14lGS74Wmuq3BFwedmoVXbzoTHCapm0F5DxMi2erOnGybyx
 k5Tq2IyxHpw7/zJ/TwhassuZG8QjM/wOxnYYxGuct039OoxZBoiJBwE6tkvUBT16SKYqnZs
 t+vl0l/jp2bA0mHxosZ8iVSL4Lb46QFzGvkybdMu65zRNfky/Hs9K7uzxt0WISHRDk35m9R
 47Yyt2Ba82EzwelF3XIdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fpbJ13R4rmc=:RXCjOwRiTWaFANABFqkG3v
 IvMvhEIV9gbXYgsmBMcFwDiLYqUvG7lyxsjeOpp76oa8S++Rw8F4m9Mb0bxDNrEu08Mljknqy
 MGPOqC+I7Gyhfl9rbYCTgpsJK+UrSVnXR2NYeG5KdoVMJh84WPwwb8tgUhW5O/Kw0+sF0dK6L
 AQQR/uW7Z9zicX6sNXrO1ieAnxk73sHrAdi0/tuIaF8S8x+c/0j9IIqebUkYQzFnE08fWAB7i
 Cp7/pTW/zaWoh4onG7hmVYmp+6JQRRh+yE1LbCiGZpo57Woy0blO2JRz5KP0J4HJls/hF3Nvr
 E72m3mn27F4ZdNXS7AT2SMJ2B2UlO39Gs/Ofdtx0ku9nN+1/kgMJqCUse8mkaafpQ/kCXxwee
 cq6dv5Jk6xbNau0xyJgZ2XcFkFI5SFDgDPYlQ1B+/ApfxtR+gAXm6gamgk1uxF/5WIkaj3zIM
 uZvdzeSRgHgQPLXTfsLYuaupbbGykYcZi8ljKNmKJDx7NN7c56FJr7asi54RyQoVy7kRBvjs4
 DXde9/qiq526d3q+3DavQ8dY6pomFk9J8DeUH59Pyb8sFMojr4XgtA0LJBEfu/81bCiPGycTk
 dZzHzB5mNIxhCzQRtYZ4Y9gXLbs+qt5CaD4Zvio3iVNhna6xnyANNBx7AQCKgDvX+9+ty/gCh
 dyBGWmkmXyBEcwXAvHmrJ4SU47zcjKE/lOUPfFLhgOr5B8hW12ZLFqQd4NUkGKJ8TdVg8YlXX
 ixpUIdKdFJCYtJU50IpojEJNFupYbF9KQPvHsQ==
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
Cc: devel@driverdev.osuosl.org, chris@engineersdelight.de,
 linux-kernel@vger.kernel.org, Michael.Fabry@microchip.com,
 christian.gromm@microchip.com, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no need for the calls to BUG_ON() in this driver, which are
used to check if mbo or mbo->context are NULL; mbo is never NULL, and
if mbo->context is NULL it would have already been dereferenced and
oopsed before reaching the BUG_ON().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Acked-by: Christian Gromm <christian.gromm@microchip.com>
---
 drivers/staging/most/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 0ab2de5ecf18..3afc25a61643 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -915,7 +915,6 @@ static void arm_mbo(struct mbo *mbo)
 	unsigned long flags;
 	struct most_channel *c;
 
-	BUG_ON((!mbo) || (!mbo->context));
 	c = mbo->context;
 
 	if (c->is_poisoned) {
@@ -1018,8 +1017,6 @@ static void most_write_completion(struct mbo *mbo)
 {
 	struct most_channel *c;
 
-	BUG_ON((!mbo) || (!mbo->context));
-
 	c = mbo->context;
 	if (mbo->status == MBO_E_INVAL)
 		pr_info("WARN: Tx MBO status: invalid\n");
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
