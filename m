Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-422771-1518026275-2-10447726871652869872
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518026275; b=NMHmRQuN+SXuhnFu0F1xR5Iz41pFk4mDO+HUL5ae3a6gwXy
    WGvLbXaQq/Ne+kbPnYUPUEsh5Xd3+hUwGUwsyefpKRB3ultosXXfwqejqgnP6k/u
    2+sLkZ6bSS5XwK80iPC7XGzK0Jl0jsBaO1YOdeddHh/qEiQ9QSYaJYIKpiYZfULO
    UO1S3LkaAED78CAVBCJDAQbQd4YSrr917/w7qEIAOiM1MoOSSv/sKmLcY6cBn7HX
    edgmOFcOcAiIQhGs6AZUpTcnrrt6WyxRuikV+jLeiP20fPIHYIbSdFcvV/mvnVDB
    K2eczgIDBOlKcBQfqMwRnxyUX5LvQhX3oTmgGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518026275; bh=r
    EoKHDSiO7hFDBIU/nGr669xVyuiTbCdxwvzwW1qVSU=; b=GEWHPOWFLEWs2eCTe
    oCPFRywxqBzk8mtW25q4Z2LSkwzTrA4dR0JtYAXT6CMHyubU5WE1cbUHK+mjHv9Q
    rmb08yEtyNgolciJNne3CPiTStksYMDnonN4ccoJ0S6JIFtGWw9kunC0cXohqomM
    MSFDtyHuVGwxTHH4NNvcC6JtdH5fe+sPYQDYQ2XBQc0zYs/Ia/di4G2u+CEzhpAm
    D5YrX1GqIWMowdM25cZ3YOURbe0xMnohD9q2Pc4JX+6KtiZgy/VyoUKSV+JHo2Pf
    w6FvuaBfigZvQF3NAEL+wPDYwDT6f4TKm8yiSgp3+QI8uyrP+gW2Iaibp9T5uQte
    PzRbA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: devel@linuxdriverproject.org
Subject: [PATCH RESEND 1/4] hv_balloon: fix printk loglevel
Date: Wed,  7 Feb 2018 18:50:00 +0100
Message-Id: <20180207175003.28859-2-vkuznets@redhat.com>
In-Reply-To: <20180207175003.28859-1-vkuznets@redhat.com>
References: <20180207175003.28859-1-vkuznets@redhat.com>
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
Cc: Eduardo Otubo <otubo@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Alex Ng <alexng@microsoft.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We have a mix of different ideas of which loglevel should be used. Unify
on the following:
- pr_info() for normal operation
- pr_warn() for 'strange' host behavior
- pr_err() for all errors.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv_balloon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index db0e6652d7ef..1aece72da9ba 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -691,7 +691,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				(HA_CHUNK << PAGE_SHIFT));
 
 		if (ret) {
-			pr_warn("hot_add memory failed error is %d\n", ret);
+			pr_err("hot_add memory failed error is %d\n", ret);
 			if (ret == -EEXIST) {
 				/*
 				 * This error indicates that the error
@@ -1014,7 +1014,7 @@ static void hot_add_req(struct work_struct *dummy)
 		resp.result = 0;
 
 	if (!do_hot_add || (resp.page_count == 0))
-		pr_info("Memory hot add failed\n");
+		pr_err("Memory hot add failed\n");
 
 	dm->state = DM_INITIALIZED;
 	resp.hdr.trans_id = atomic_inc_return(&trans_id);
@@ -1041,7 +1041,7 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
 
 		break;
 	default:
-		pr_info("Received Unknown type: %d\n", info_hdr->type);
+		pr_warn("Received Unknown type: %d\n", info_hdr->type);
 	}
 }
 
@@ -1290,7 +1290,7 @@ static void balloon_up(struct work_struct *dummy)
 			/*
 			 * Free up the memory we allocatted.
 			 */
-			pr_info("Balloon response failed\n");
+			pr_err("Balloon response failed\n");
 
 			for (i = 0; i < bl_resp->range_count; i++)
 				free_balloon_pages(&dm_device,
@@ -1421,7 +1421,7 @@ static void cap_resp(struct hv_dynmem_device *dm,
 			struct dm_capabilities_resp_msg *cap_resp)
 {
 	if (!cap_resp->is_accepted) {
-		pr_info("Capabilities not accepted by host\n");
+		pr_err("Capabilities not accepted by host\n");
 		dm->state = DM_INIT_ERROR;
 	}
 	complete(&dm->host_event);
@@ -1508,7 +1508,7 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		default:
-			pr_err("Unhandled message: type: %d\n", dm_hdr->type);
+			pr_warn("Unhandled message: type: %d\n", dm_hdr->type);
 
 		}
 	}
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
