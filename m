Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227130-2-7846148179233344824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227130; b=LKo1E7l8uEF4GjU1Z5XTjfYHIAfwbqgEoYDLDfn+mZ+gWTR
    HERDc3IH50lPakJB03M7ecWZ4sjYAIiFhHvBnHY+Ddab7dBHwnC1ngKcS1FOjmPu
    w0CXr7PBhCJMs9c0o+65TGaItXy5Mb9qEfLs/gHeMZInoCRYDPmZA1BzVIFUvrkW
    DCs3NuxdSnNODW34r1Ybxz5IbOijjddcnqHsHr0NnKxa4jVGRQHULpxa4CtzXuCM
    Z2q6thKfVVo4WFxk/zAyweR/tcr2TqNhglVhIuxBdL+1kYY6MI8v1exp0zxWeULi
    tFNMSPo9+gUkUwh2MJbk3xFKoSvW2BDHsA2DGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227130; bh=mO6C+HpZ1HT58tGG5Q2kfMc8ZTQ9CwEOG9iujxDSW5M=; b=I
    6WO4o/qojpACgMghi64rgMQfC8keMY3pqQdJHvARPy0Rb/kjGFcUe1qJhaIKmIoh
    jb//ol3WswxVBFxjlrR6IUdlrrpf7ulOO6g9Ga8pA3G1KSTg8g1hrrR5shhgj/Zc
    Fhq1RfphgggdOaFH+t3wJU2PFdIrECRlCOhK9OPV6eqbE4hqrZ0sem4WtN7vFlsI
    IIDcI071CObbI9OiagW+4DKUHqN9vNlESShwIohh1sKIuLjJgY+MNBm5KFkaTebs
    HzJYc4ipYaQpByvR6Q5ifUooEzFFfNyNCW04jomS/0WheV0+C3aXUmY/m7e4uGjk
    4tZREGIMswucvmLU+CHtg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 09/12] hv_balloon: fix printk loglevel
Date: Sun,  4 Mar 2018 22:17:19 -0700
Message-Id: <20180305051722.19157-9-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfOOgjQbpPLEUACaNnRs532IZZhW10v2/CAvkpP8QMK38D5DC67IgtyT/OHtKlK+5mjKbPeFz3UPXZqLwpfv11xvUugHnytD+cR0gP9X27wKzA7mhHGrQ
 m6ZNpALEhnzk8IWiK6gUhQ85SB4/jTxJfXfTqqRqeVw9Mf0F2JjLGaW62shtHaoUsf/7QpjU4hbXvpvUk/sGj1uWwUqB5BwmOtTOLKSyfS9F7rgRhbtfgQCF
 /Gu6eFqmBcTFsWdqbZ999PL8V1PMVgWVkOBkOH8G6vs6Hq0l1PfLNZEgXW2jjIhZ3KE6Z2/PcM9vctkxsicLpTgf8aeyCjmra8E2YF5s8jOYeQ//AiMgyhy9
 UjBRuIfhqIH49PJ9hzuqPFJ/mBzKYGT3qvat2Pe6ZQ/bSMo9tivDeAL3qE3mGmJJ60GKOsisjT0X/91AdQWXzGvK473JGzqn/mq0/IU0iyh4tqEuRnbRfsia
 uqUP5amIMifaisIKT5N2hEuA9cam7Oi8UEC8dXk4FDkgKTDHUC6UPqbnCs0Njka/Y+3jGJ9kQcQWIKllOqhWuJ6NRT7dVo43fBVvZw==
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

We have a mix of different ideas of which loglevel should be used. Unify
on the following:
- pr_info() for normal operation
- pr_warn() for 'strange' host behavior
- pr_err() for all errors.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
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
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
