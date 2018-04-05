Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3551175-1522955387-2-11684771393990259079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522955386; b=sljfMPJTfzEwcj2Vfs7jAHqcTKTuQePAlM/RykiCc5gA/z1TFO
    AEFEJ5CyePIEfPD/hXrF3d2Z3b9LCwB4KcsWFhFXZ73/qPlkHI4eKteOMzfmUnHC
    M1Sw0BZL7U7IEkzLnz2t4Fi6xANBunxjDbMEbzaMjYJ59N3joTh2IJAI7ink/2nq
    0nDpbhtcKkMmEooOz/iQpQS3QcUpPfIvgNen6PU1Tf4fNG6J87W/ko97q3CsHF9I
    AGO8MdcdLYOWAP+oyLjg5xKLaCNk4xi/7fI77fiUvoDlpchyyqIFYs+lvf9e/S+h
    4I6W5MfRHR6ONKS7uYsLwWKIhe3u7fyYJwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522955386; bh=opjvT
    SYlDiWmBxYGY4mp8sIluDaI36whQcT+coNP1/M=; b=SHU6jVrZ6YDWaVb5yO31D
    QalVpWGXKmglTmKt39ewbMrii4UF5+yDzLpPMhaOxuZqfvWPxzdPo2yIqiDfEj4G
    w04a6m3IQioBJmAI+Fuus2FgVyg18PJ9ONr2ZauKZ8wAEa6kPWQB39/wEGfqpTWG
    +QwUETdP/FVmzgWRjOGaOWhW1WDzqgkwyAJTb9hjkvPIQ3RfG+LdluRpYYkLIBQV
    oZ1H1euOhiUg1DRLYImWYGg1fOxLKKl0+HPAPu7KY81XkPXHYsdjc5SkhUpOBwGn
    OzPoRN9vOa5Vcnw8eSnk4DG7jF1Uld+xlARBJEsrHg/BKqPDpTJ1YprYh6PNelF9
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2PlVAPDFlAS+EcEAoEUh0l6iYJ95vvRV5X5dAV1PfCYb9J8dPm6/u3yYpdC+28cN//vQjrpLw+xkWaSrn4wk1Mg5OMJCLg+BEtHPTiBCj33xInKUvU
    43tQrb62pZwbeJcW+bB6p73bQAGgzm3At65cIVf3jAU5ODhXYrCMitqnTSO/m4/6jbLRmYngEw1SLTBSpOY1MMkpB0CLiMXB7+3vqieVU5Bqdj1Eu1aipxnD
    90bwBD3Nj/vuonvxk49bFQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=DIVliQd-wq7dlOAR0N0A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org,
	sthemmin@microsoft.com
Subject: [PATCH 4/4] hv_netvsc: Pass net_device parameter to revoke and
 teardown functions
Date: Thu,  5 Apr 2018 21:09:21 +0200
Message-Id: <1522955361-14704-5-git-send-email-mgamal@redhat.com>
In-Reply-To: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
References: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
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
Cc: otubo@redhat.com, Mohammed Gamal <mgamal@redhat.com>,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The callers to netvsc_revoke_*_buf() and netvsc_teardown_*_gpadl()
already have their net_device instances. Pass them as a paramaeter to
the function instead of obtaining them from netvsc_device struct
everytime

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/netvsc.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index df92c2f..04f611e 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -110,9 +110,9 @@ static void free_netvsc_device_rcu(struct netvsc_device *nvdev)
 }
 
 static void netvsc_revoke_recv_buf(struct hv_device *device,
-				   struct netvsc_device *net_device)
+				   struct netvsc_device *net_device,
+				   struct net_device *ndev)
 {
-	struct net_device *ndev = hv_get_drvdata(device);
 	struct nvsp_message *revoke_packet;
 	int ret;
 
@@ -160,9 +160,9 @@ static void netvsc_revoke_recv_buf(struct hv_device *device,
 }
 
 static void netvsc_revoke_send_buf(struct hv_device *device,
-				   struct netvsc_device *net_device)
+				   struct netvsc_device *net_device,
+				   struct net_device *ndev)
 {
-	struct net_device *ndev = hv_get_drvdata(device);
 	struct nvsp_message *revoke_packet;
 	int ret;
 
@@ -211,9 +211,9 @@ static void netvsc_revoke_send_buf(struct hv_device *device,
 }
 
 static void netvsc_teardown_recv_gpadl(struct hv_device *device,
-				       struct netvsc_device *net_device)
+				       struct netvsc_device *net_device,
+				       struct net_device *ndev)
 {
-	struct net_device *ndev = hv_get_drvdata(device);
 	int ret;
 
 	if (net_device->recv_buf_gpadl_handle) {
@@ -233,9 +233,9 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 }
 
 static void netvsc_teardown_send_gpadl(struct hv_device *device,
-				       struct netvsc_device *net_device)
+				       struct netvsc_device *net_device,
+				       struct net_device *ndev)
 {
-	struct net_device *ndev = hv_get_drvdata(device);
 	int ret;
 
 	if (net_device->send_buf_gpadl_handle) {
@@ -452,10 +452,10 @@ static int netvsc_init_buf(struct hv_device *device,
 	goto exit;
 
 cleanup:
-	netvsc_revoke_recv_buf(device, net_device);
-	netvsc_revoke_send_buf(device, net_device);
-	netvsc_teardown_recv_gpadl(device, net_device);
-	netvsc_teardown_send_gpadl(device, net_device);
+	netvsc_revoke_recv_buf(device, net_device, ndev);
+	netvsc_revoke_send_buf(device, net_device, ndev);
+	netvsc_teardown_recv_gpadl(device, net_device, ndev);
+	netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 exit:
 	return ret;
@@ -474,7 +474,6 @@ static int negotiate_nvsp_ver(struct hv_device *device,
 	init_packet->hdr.msg_type = NVSP_MSG_TYPE_INIT;
 	init_packet->msg.init_msg.init.min_protocol_ver = nvsp_ver;
 	init_packet->msg.init_msg.init.max_protocol_ver = nvsp_ver;
-
 	trace_nvsp_send(ndev, init_packet);
 
 	/* Send the init request */
@@ -596,13 +595,13 @@ void netvsc_device_remove(struct hv_device *device)
 	 * Revoke receive buffer. If host is pre-Win2016 then tear down
 	 * receive buffer GPADL. Do the same for send buffer.
 	 */
-	netvsc_revoke_recv_buf(device, net_device);
+	netvsc_revoke_recv_buf(device, net_device, ndev);
 	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_recv_gpadl(device, net_device);
+		netvsc_teardown_recv_gpadl(device, net_device, ndev);
 
-	netvsc_revoke_send_buf(device, net_device);
+	netvsc_revoke_send_buf(device, net_device, ndev);
 	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_send_gpadl(device, net_device);
+		netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -624,8 +623,8 @@ void netvsc_device_remove(struct hv_device *device)
 	 * here after VMBus is closed.
 	*/
 	if (vmbus_proto_version >= VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device);
-		netvsc_teardown_send_gpadl(device, net_device);
+		netvsc_teardown_recv_gpadl(device, net_device, ndev);
+		netvsc_teardown_send_gpadl(device, net_device, ndev);
 	}
 
 	/* Release all resources */
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
