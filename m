Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527160825-2-13189169574597987837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160825; b=VXrKyiM0aPgkS+MezUpKs0AFrKIK2Q9Ld9YdjBxk/dpPC9NwFv
    XEZ2zCdmsaoYdUjo7sqWit0v4vlZApj8O9g8g8MLX1W0R+fsFCdTgPhR0+yMX5zE
    5fMQNhG8BQH/ceBFBXu5syorV+zmtWHhRI/WJnEuW3zkA9FQT9BO9Mgby3Y/KhSJ
    SPau/kQTJS4UV2b+6aXUyOBjZ7KTwQ8eUwp+bGbePWsS5SQA9FmTTiTOyMFbFv3F
    hiywGHAz6LC+UehzLaw/zmCmPXvGlCavPL1qkXPchbrCmg3ctjOvF0AEiXssU6VW
    AQEtSm35r5OOw/ZrjH9zI02hguZdA9DfSE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160825; bh=Y44U+Q14dfEviy4SslSsuFN9DlInfC
    F3yImZVZn5jPg=; b=Eyr4IUMaSiVhMFqfJbGQRbHi0RhSF1lDAgEjzD5V7XpOYj
    t2Cb/WpzE7CaKX2huKfudZog7af9Q2g/061lPHanaLyc/ZgH02w4e3yoPsURqdF/
    yEMITfhjTnOyVGqfLFfjy+QFXaJDh1781IwfWsoo4Qb60J60pG7csl8IMlog6RJ8
    sBEozeP6mQeInJIV5rA0GuLUYVp/lXlcBh6SixIx/SlGnzDnI897UdDxcvBqpxXX
    9kKFgN8HETMgqfFaEE9PznrstY/SNE4Vsc9HhrOBkLywgdMHC+FenkUSp+y6da0h
    0+PqLY1FfyzT37GY73UoA/oKlqBF/lxAxALclq1w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xrk6gWqo x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xrk6gWqo x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMc7Wjvy7GHe7foWorPZe1vN4Cjz+htWUiFW/oEVN//E5xQv3y30qQti7Wbe0ZrHf8IYc8o3WMQb+2BeOCCyn6Wg3WMhv8vS5DtPgycUGS8PkrxORkPz
    olamnMet/eicVpUqFqy1SUJIPV9GTKAg9OvPjsMdswiib8Wv7DNcCC/M/EN7UO8IsqtdD1aQ5TLeBLDI9a7rx3jobSuAC4vfkSNQCKp6VI9jEtE9gfg+QEb6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=l5hsKEwYleRh9GI1Hl0A:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967925AbeEXLUJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967913AbeEXJwl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 032/165] hv_netvsc: Split netvsc_revoke_buf() and netvsc_teardown_gpadl()
Date: Thu, 24 May 2018 11:37:18 +0200
Message-Id: <20180524093623.275428805@linuxfoundation.org>
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

From: Mohammed Gamal <mgamal@redhat.com>

[ Commit 7992894c305eaf504d005529637ff8283d0a849d upstream. ]

Split each of the functions into two for each of send/recv buffers.
This will be needed in order to implement a fine-grained messaging
sequence to the host so that we accommodate the requirements of
different Windows versions

Fixes: 0ef58b0a05c12 ("hv_netvsc: change GPAD teardown order on older versions")
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   46 ++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -105,11 +105,11 @@ static void free_netvsc_device_rcu(struc
 	call_rcu(&nvdev->rcu, free_netvsc_device);
 }
 
-static void netvsc_revoke_buf(struct hv_device *device,
-			      struct netvsc_device *net_device)
+static void netvsc_revoke_recv_buf(struct hv_device *device,
+				   struct netvsc_device *net_device)
 {
-	struct nvsp_message *revoke_packet;
 	struct net_device *ndev = hv_get_drvdata(device);
+	struct nvsp_message *revoke_packet;
 	int ret;
 
 	/*
@@ -151,6 +151,14 @@ static void netvsc_revoke_buf(struct hv_
 		}
 		net_device->recv_section_cnt = 0;
 	}
+}
+
+static void netvsc_revoke_send_buf(struct hv_device *device,
+				   struct netvsc_device *net_device)
+{
+	struct net_device *ndev = hv_get_drvdata(device);
+	struct nvsp_message *revoke_packet;
+	int ret;
 
 	/* Deal with the send buffer we may have setup.
 	 * If we got a  send section size, it means we received a
@@ -194,8 +202,8 @@ static void netvsc_revoke_buf(struct hv_
 	}
 }
 
-static void netvsc_teardown_gpadl(struct hv_device *device,
-				  struct netvsc_device *net_device)
+static void netvsc_teardown_recv_gpadl(struct hv_device *device,
+				       struct netvsc_device *net_device)
 {
 	struct net_device *ndev = hv_get_drvdata(device);
 	int ret;
@@ -214,6 +222,13 @@ static void netvsc_teardown_gpadl(struct
 		}
 		net_device->recv_buf_gpadl_handle = 0;
 	}
+}
+
+static void netvsc_teardown_send_gpadl(struct hv_device *device,
+				       struct netvsc_device *net_device)
+{
+	struct net_device *ndev = hv_get_drvdata(device);
+	int ret;
 
 	if (net_device->send_buf_gpadl_handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
@@ -423,8 +438,10 @@ static int netvsc_init_buf(struct hv_dev
 	goto exit;
 
 cleanup:
-	netvsc_revoke_buf(device, net_device);
-	netvsc_teardown_gpadl(device, net_device);
+	netvsc_revoke_recv_buf(device, net_device);
+	netvsc_revoke_send_buf(device, net_device);
+	netvsc_teardown_recv_gpadl(device, net_device);
+	netvsc_teardown_send_gpadl(device, net_device);
 
 exit:
 	return ret;
@@ -554,7 +571,8 @@ void netvsc_device_remove(struct hv_devi
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
-	netvsc_revoke_buf(device, net_device);
+	netvsc_revoke_recv_buf(device, net_device);
+	netvsc_revoke_send_buf(device, net_device);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -569,14 +587,18 @@ void netvsc_device_remove(struct hv_devi
 	netdev_dbg(ndev, "net device safe to remove\n");
 
 	/* older versions require that buffer be revoked before close */
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_gpadl(device, net_device);
+	if (vmbus_proto_version < VERSION_WIN10) {
+		netvsc_teardown_recv_gpadl(device, net_device);
+		netvsc_teardown_send_gpadl(device, net_device);
+	}
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	if (vmbus_proto_version >= VERSION_WIN10)
-		netvsc_teardown_gpadl(device, net_device);
+	if (vmbus_proto_version >= VERSION_WIN10) {
+		netvsc_teardown_recv_gpadl(device, net_device);
+		netvsc_teardown_send_gpadl(device, net_device);
+	}
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
