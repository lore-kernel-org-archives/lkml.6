Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-602161-1521659992-2-11828307934883894665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521659991; b=qzMYv1kBlqdhQCx+ZJc1r1l1tXx6tP/XWtKTus1QnH8PLv3
    7d0WASFz4ezrHGbvDH0EkRubOp7JtMgBu2tXPj4sl+/Ctz1r4O9tQTqnZh+CV7lX
    kE/ztLcs6NO63a5wsmVQyrPwMjayEntOAx5korSMQO+MuowaD0uxmY9HJua3AVSX
    G98A4RGNlzM4f53o4hiLoesK6KQfe3gEKwbW2yTyycBkVGnWAgys3BLhCdjOPUVs
    N7hZfvN/b0jYpVaqXxmh0HBQy8TjsnAdQnp86SnWmtiLmt5r9c/TImpxAizjw54Q
    vbvC8TQnac8myFMHWKtROtJLstA4Bn5K8kIqNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521659991; bh=O
    BFUXYr93bEroh3Qb1wAfcv37xE8V4hXvf+yCydVU9U=; b=QVzawQn7a0ZWKYNaT
    eMZHTtV3JvCjh++9vLc7vZTjWvIr7Cyyrm1kwcrSjhC+BabtyxpXKqfHRXAWg6dP
    lwrNImSAuS0g5ukSkIKEoOlG1AlJdPyhKrnhaQyoFmwfkcqiAeqM6LrKKlouq93F
    ukFoBscKrw1Ky7RlH+tLTj/6Hx/lgR8NknzgwFtZqqWublcqmrk68kK0w7hEsd0r
    EdnbwcLZDYIK3WaC4HlCFQE8KnHFiVhs4BPU03W/dDyyaRY7aVAQFj4KpTYJgu5W
    f+RtkNPmg/iy6KWXxtCley+Ja4ukV4co0wgxTpeUYmn7QsNosd/sI1NgUfeKPxvv
    8F0/g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Aditya Shankar <aditya.shankar@microchip.com>,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: wilc1000: check for kmalloc allocation failures
Date: Wed, 21 Mar 2018 19:19:41 +0000
Message-Id: <20180321191941.4126-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

There are three kmalloc allocations that are not null checked which
potentially could lead to null pointer dereference issues. Fix this
by adding null pointer return checks.

Detected by CoverityScan, CID#1466025-27 ("Dereference null return")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wilc1000/host_interface.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index 5082ede720f0..9b9b86654958 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -944,6 +944,10 @@ static s32 handle_connect(struct wilc_vif *vif,
 
 	if (conn_attr->bssid) {
 		hif_drv->usr_conn_req.bssid = kmalloc(6, GFP_KERNEL);
+		if (!hif_drv->usr_conn_req.bssid) {
+			result = -ENOMEM;
+			goto error;
+		}
 		memcpy(hif_drv->usr_conn_req.bssid, conn_attr->bssid, 6);
 	}
 
@@ -951,6 +955,10 @@ static s32 handle_connect(struct wilc_vif *vif,
 	if (conn_attr->ssid) {
 		hif_drv->usr_conn_req.ssid = kmalloc(conn_attr->ssid_len + 1,
 						     GFP_KERNEL);
+		if (!hif_drv->usr_conn_req.ssid) {
+			result = -ENOMEM;
+			goto error;
+		}
 		memcpy(hif_drv->usr_conn_req.ssid,
 		       conn_attr->ssid,
 		       conn_attr->ssid_len);
@@ -961,6 +969,10 @@ static s32 handle_connect(struct wilc_vif *vif,
 	if (conn_attr->ies) {
 		hif_drv->usr_conn_req.ies = kmalloc(conn_attr->ies_len,
 						    GFP_KERNEL);
+		if (!hif_drv->usr_conn_req.ies) {
+			result = -ENOMEM;
+			goto error;
+		}
 		memcpy(hif_drv->usr_conn_req.ies,
 		       conn_attr->ies,
 		       conn_attr->ies_len);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
