Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527161051-2-16306069846113603562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161050; b=NMCXcy36/AqU1KmFDKQEN7l/Tds8xwICf0jd9xcEfqVM2F9dI4
    oeqMHmSitmbMBWGIT+OYHXz3Ky4HFpqIJ/G8kfiSfZ87GO6Y0UrTfAGGfECbP54Y
    JwO9Ltuq1z7lFavmTqSr6QTID72rzYs5f6Lm1WoZO9bO4kQF8a9ThghGobB3v4mk
    2KI5x4l4TXuZFpN9/7lUulnLkIJNZfdGd3nrsvZlij13udsVSWWDe7nd0Qo7Vq7o
    LkXCq11a2lXM8rEZb7Wx8pntaV+HRk10k38RXp+RyWWGtaoT98ICAFHUGL//nl/h
    bOFbde25SYBPE4Wz0D7OsTYhxOW2CWCxI9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161050; bh=ZS5CbUj0fMVvkY3MiD9nrpCrAi7qEe
    8pMW+DB5GLRwo=; b=BTDQIuYCwREl2DE+/1EtuPzdRvVAxETJOJEA0f8sab81Rg
    mrp4shIRv18NWS1rN3PVCa2BQb+nxruE3+uLXdpoNaWyDUfsidjQ22D7zs1Sokzw
    +OPt8BiT78BUIyo3WwckHHCqSDMza5XO6rR2ji0XHR5u5Ba8XCP6dBL4JFLwzNQB
    WtTjgs2+5bccLwjMSK49M6Z4hOloYFRqG9jzyPiL9GWFjqqh2sqNEPRZSmd11pyq
    oFoWiBSHpeK+8B0fuuCHjGEAnBuXtIPZCeKA5GAzVmNH2MpkS4BVA709gvcpFtgg
    cBni1iRs5Jmu5Z43jJm1ANx3gQrFO+Z/jKIZXG+g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cWHObIqf x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cWHObIqf x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrUPSjZZ9+VRrbbxabtR109Ct2ITOcj+snBp+lUhQBuAAxNtg3nRYpONYedItIjWlk+6RxpMVe3cWPhYKQGlWiXXUe0APY4HFdF4wHJ7hg+gzmPm45y
    30TgH6bwBpSuzJA80WIbo4g3zbrKHMmoAxmpKv20lN5ckEN2UJUvj+BO2K3O7e5ql5TJTLBj54jZZv4hNYr8zgYv6Salfgd0DMc/TOUaQ88WL8cMaSna8VY3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=YoBW9JiR1WO_XMdwIYUA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967275AbeEXJv5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967380AbeEXJvz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 017/165] hv_netvsc: netvsc_teardown_gpadl() split
Date: Thu, 24 May 2018 11:37:03 +0200
Message-Id: <20180524093622.678940144@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Commit 0cf737808ae7cb25e952be619db46b9147a92f46 upstream. ]

It was found that in some cases host refuses to teardown GPADL for send/
receive buffers (probably when some work with these buffere is scheduled or
ongoing). Change the teardown logic to be:
1) Send NVSP_MSG1_TYPE_REVOKE_* messages
2) Close the channel
3) Teardown GPADLs.
This seems to work reliably.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   69 ++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -100,12 +100,11 @@ static void free_netvsc_device_rcu(struc
 	call_rcu(&nvdev->rcu, free_netvsc_device);
 }
 
-static void netvsc_destroy_buf(struct hv_device *device)
+static void netvsc_revoke_buf(struct hv_device *device,
+			      struct netvsc_device *net_device)
 {
 	struct nvsp_message *revoke_packet;
 	struct net_device *ndev = hv_get_drvdata(device);
-	struct net_device_context *ndc = netdev_priv(ndev);
-	struct netvsc_device *net_device = rtnl_dereference(ndc->nvdev);
 	int ret;
 
 	/*
@@ -148,28 +147,6 @@ static void netvsc_destroy_buf(struct hv
 		net_device->recv_section_cnt = 0;
 	}
 
-	/* Teardown the gpadl on the vsp end */
-	if (net_device->recv_buf_gpadl_handle) {
-		ret = vmbus_teardown_gpadl(device->channel,
-					   net_device->recv_buf_gpadl_handle);
-
-		/* If we failed here, we might as well return and have a leak
-		 * rather than continue and a bugchk
-		 */
-		if (ret != 0) {
-			netdev_err(ndev,
-				   "unable to teardown receive buffer's gpadl\n");
-			return;
-		}
-		net_device->recv_buf_gpadl_handle = 0;
-	}
-
-	if (net_device->recv_buf) {
-		/* Free up the receive buffer */
-		vfree(net_device->recv_buf);
-		net_device->recv_buf = NULL;
-	}
-
 	/* Deal with the send buffer we may have setup.
 	 * If we got a  send section size, it means we received a
 	 * NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE msg (ie sent
@@ -210,7 +187,35 @@ static void netvsc_destroy_buf(struct hv
 		}
 		net_device->send_section_cnt = 0;
 	}
-	/* Teardown the gpadl on the vsp end */
+}
+
+static void netvsc_teardown_gpadl(struct hv_device *device,
+				  struct netvsc_device *net_device)
+{
+	struct net_device *ndev = hv_get_drvdata(device);
+	int ret;
+
+	if (net_device->recv_buf_gpadl_handle) {
+		ret = vmbus_teardown_gpadl(device->channel,
+					   net_device->recv_buf_gpadl_handle);
+
+		/* If we failed here, we might as well return and have a leak
+		 * rather than continue and a bugchk
+		 */
+		if (ret != 0) {
+			netdev_err(ndev,
+				   "unable to teardown receive buffer's gpadl\n");
+			return;
+		}
+		net_device->recv_buf_gpadl_handle = 0;
+	}
+
+	if (net_device->recv_buf) {
+		/* Free up the receive buffer */
+		vfree(net_device->recv_buf);
+		net_device->recv_buf = NULL;
+	}
+
 	if (net_device->send_buf_gpadl_handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
 					   net_device->send_buf_gpadl_handle);
@@ -425,7 +430,8 @@ static int netvsc_init_buf(struct hv_dev
 	goto exit;
 
 cleanup:
-	netvsc_destroy_buf(device);
+	netvsc_revoke_buf(device, net_device);
+	netvsc_teardown_gpadl(device, net_device);
 
 exit:
 	return ret;
@@ -544,11 +550,6 @@ cleanup:
 	return ret;
 }
 
-static void netvsc_disconnect_vsp(struct hv_device *device)
-{
-	netvsc_destroy_buf(device);
-}
-
 /*
  * netvsc_device_remove - Callback when the root bus device is removed
  */
@@ -562,7 +563,7 @@ void netvsc_device_remove(struct hv_devi
 
 	cancel_work_sync(&net_device->subchan_work);
 
-	netvsc_disconnect_vsp(device);
+	netvsc_revoke_buf(device, net_device);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -575,6 +576,8 @@ void netvsc_device_remove(struct hv_devi
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
+	netvsc_teardown_gpadl(device, net_device);
+
 	/* And dissassociate NAPI context from device */
 	for (i = 0; i < net_device->num_chn; i++)
 		netif_napi_del(&net_device->chan_table[i].napi);
