Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981444-2-14413470837764569789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981442; b=C7u033tn9oLMlMg+sQwt1q2FCviPJ1NpRKjacEH4ynwmmtNbY5
    k+E9kS8Mv1OdshlrKLcmr5NdAtpq4K3U7/G7HGGTVhrn/2JojkX7VdjfCQIWVThu
    Ys3pHSDq8rc7avMlIkLKqMdJewBPuAQAL9uLmxsT1izQcqzk6vNGlM1oF4WsyH0n
    f87X4TgzEX4XJx2HZXn678Z7ON15vrRGg/hPJKqWgMRiW2G7pleIDbdPf65QND/u
    t3YMfPZvTizNFJOHO8OQWewI8e6zybTjJsdHSeWggjvaHjACwu2nRHMurJjzt38L
    Vu5Y6f9eBTb04ONKye7QeL7BsT8QmwG8ciSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981442; bh=nbRIvVl9cFa/5071xZWTC+I4fAXEko
    Skzaf21OyJduQ=; b=RPfahEzmlfYHwfxcwAsqVeDaFJ5AaHJpqQMo52Rx2eLEhh
    MvLAVfnEwiiwIDIfJrzZ/kIo0aLM8dBvT+BbU7O6vYXDFwhpN2pK0UhPIttjkjoB
    EDDLfxdc2qJEEHSZGmKI1n2vCq2UI5+HoWXYOumhLbfoRc1F4OGaawOLTMI7DaIj
    OqrEhSayXul8mCD9EaLh5a4Sbht0nPh1e8EgA3qbFX8C+AygXuXqXvZN6uiXocL+
    x3rJZqdlQervloVdN1KmcnDOswGDGhM+uC8fcU+V+f8iGmGsRBldTEa2CoNhPso0
    Y+Tvz8/SJlL1WknWMZtrfpi1QByTIaQbfoCWZiBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKcXLqqjfV702Un9W3u3cPXcpgLZzX6/xI3vr4m0z1aaXnYaHD6uKRLRCOFjheU6OLKsABQChYfMyuNsr6yOuKqN/VA9MJ4iYyaGLPjUpW66dDbhmTmi
    sppFEk28/+xyFXwkTGagSu6xiDt3q4mQTjF6ra6LTLBBzvvaZzzekswfwH5RartA9TnInmnIpjWSP8ACpquVzILe2IAaErb5E8AIrlPHtf/CucxLC76MHnX9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Dei6p5SHAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=tYXb87LlyGDwczk5ohYA:9
    a=yxJzA0BjidGEYW1_:21 a=j5obsVEdtrHTNXun:21 a=oOYMpWVXTzOFAxEF:21
    a=QEXdDO2ut3YA:10 a=M-Yerj1wOn-OpK7r_3ei:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755858AbeDQQKe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:10:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbeDQQK3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:10:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Szymon Janc <szymon.janc@codecoup.pl>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 59/66] Bluetooth: Fix connection if directed advertising and privacy is used
Date: Tue, 17 Apr 2018 17:59:32 +0200
Message-Id: <20180417155648.435000598@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Szymon Janc <szymon.janc@codecoup.pl>

commit 082f2300cfa1a3d9d5221c38c5eba85d4ab98bd8 upstream.

Local random address needs to be updated before creating connection if
RPA from LE Direct Advertising Report was resolved in host. Otherwise
remote device might ignore connection request due to address mismatch.

This was affecting following qualification test cases:
GAP/CONN/SCEP/BV-03-C, GAP/CONN/GCEP/BV-05-C, GAP/CONN/DCEP/BV-05-C

Before patch:
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6          #11350 [hci0] 84680.231216
        Address: 56:BC:E8:24:11:68 (Resolvable)
          Identity type: Random (0x01)
          Identity: F2:F1:06:3D:9C:42 (Static)
> HCI Event: Command Complete (0x0e) plen 4                        #11351 [hci0] 84680.246022
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7         #11352 [hci0] 84680.246417
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement, inc. directed unresolved RPA (0x02)
> HCI Event: Command Complete (0x0e) plen 4                        #11353 [hci0] 84680.248854
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2             #11354 [hci0] 84680.249466
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                        #11355 [hci0] 84680.253222
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 18                          #11356 [hci0] 84680.458387
      LE Direct Advertising Report (0x0b)
        Num reports: 1
        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
        Address type: Random (0x01)
        Address: 53:38:DA:46:8C:45 (Resolvable)
          Identity type: Public (0x00)
          Identity: 11:22:33:44:55:66 (OUI 11-22-33)
        Direct address type: Random (0x01)
        Direct address: 7C:D6:76:8C:DF:82 (Resolvable)
          Identity type: Random (0x01)
          Identity: F2:F1:06:3D:9C:42 (Static)
        RSSI: -74 dBm (0xb6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2             #11357 [hci0] 84680.458737
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                        #11358 [hci0] 84680.469982
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25          #11359 [hci0] 84680.470444
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: 53:38:DA:46:8C:45 (Resolvable)
          Identity type: Public (0x00)
          Identity: 11:22:33:44:55:66 (OUI 11-22-33)
        Own address type: Random (0x01)
        Min connection interval: 30.00 msec (0x0018)
        Max connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                          #11360 [hci0] 84680.474971
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0    #11361 [hci0] 84682.545385
> HCI Event: Command Complete (0x0e) plen 4                        #11362 [hci0] 84682.551014
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                          #11363 [hci0] 84682.551074
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 0
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Connection interval: 0.00 msec (0x0000)
        Connection latency: 0 (0x0000)
        Supervision timeout: 0 msec (0x0000)
        Master clock accuracy: 0x00

After patch:
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7    #210 [hci0] 667.152459
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement, inc. directed unresolved RPA (0x02)
> HCI Event: Command Complete (0x0e) plen 4                   #211 [hci0] 667.153613
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        #212 [hci0] 667.153704
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   #213 [hci0] 667.154584
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 18                     #214 [hci0] 667.182619
      LE Direct Advertising Report (0x0b)
        Num reports: 1
        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
        Address type: Random (0x01)
        Address: 50:52:D9:A6:48:A0 (Resolvable)
          Identity type: Public (0x00)
          Identity: 11:22:33:44:55:66 (OUI 11-22-33)
        Direct address type: Random (0x01)
        Direct address: 7C:C1:57:A5:B7:A8 (Resolvable)
          Identity type: Random (0x01)
          Identity: F4:28:73:5D:38:B0 (Static)
        RSSI: -70 dBm (0xba)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2       #215 [hci0] 667.182704
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                  #216 [hci0] 667.183599
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6    #217 [hci0] 667.183645
        Address: 7C:C1:57:A5:B7:A8 (Resolvable)
          Identity type: Random (0x01)
          Identity: F4:28:73:5D:38:B0 (Static)
> HCI Event: Command Complete (0x0e) plen 4                  #218 [hci0] 667.184590
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25    #219 [hci0] 667.184613
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: 50:52:D9:A6:48:A0 (Resolvable)
          Identity type: Public (0x00)
          Identity: 11:22:33:44:55:66 (OUI 11-22-33)
        Own address type: Random (0x01)
        Min connection interval: 30.00 msec (0x0018)
        Max connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                    #220 [hci0] 667.186558
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                    #221 [hci0] 667.485824
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 0
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: 50:52:D9:A6:48:A0 (Resolvable)
          Identity type: Public (0x00)
          Identity: 11:22:33:44:55:66 (OUI 11-22-33)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x07
@ MGMT Event: Device Connected (0x000b) plen 13          {0x0002} [hci0] 667.485996
        LE Address: 11:22:33:44:55:66 (OUI 11-22-33)
        Flags: 0x00000000
        Data length: 0

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |   29 +++++++++++++++++++++--------
 net/bluetooth/hci_event.c        |   15 +++++++++++----
 net/bluetooth/l2cap_core.c       |    2 +-
 4 files changed, 34 insertions(+), 14 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -893,7 +893,7 @@ struct hci_conn *hci_connect_le_scan(str
 				     u16 conn_timeout);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role);
+				u8 role, bdaddr_t *direct_rpa);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -749,18 +749,31 @@ static bool conn_use_rpa(struct hci_conn
 }
 
 static void hci_req_add_le_create_conn(struct hci_request *req,
-				       struct hci_conn *conn)
+				       struct hci_conn *conn,
+				       bdaddr_t *direct_rpa)
 {
 	struct hci_cp_le_create_conn cp;
 	struct hci_dev *hdev = conn->hdev;
 	u8 own_addr_type;
 
-	/* Update random address, but set require_privacy to false so
-	 * that we never connect with an non-resolvable address.
+	/* If direct address was provided we use it instead of current
+	 * address.
 	 */
-	if (hci_update_random_address(req, false, conn_use_rpa(conn),
-				      &own_addr_type))
-		return;
+	if (direct_rpa) {
+		if (bacmp(&req->hdev->random_addr, direct_rpa))
+			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+								direct_rpa);
+
+		/* direct address is always RPA */
+		own_addr_type = ADDR_LE_DEV_RANDOM;
+	} else {
+		/* Update random address, but set require_privacy to false so
+		 * that we never connect with an non-resolvable address.
+		 */
+		if (hci_update_random_address(req, false, conn_use_rpa(conn),
+					      &own_addr_type))
+			return;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 
@@ -825,7 +838,7 @@ static void hci_req_directed_advertising
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role)
+				u8 role, bdaddr_t *direct_rpa)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -940,7 +953,7 @@ struct hci_conn *hci_connect_le(struct h
 		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
 	}
 
-	hci_req_add_le_create_conn(&req, conn);
+	hci_req_add_le_create_conn(&req, conn, direct_rpa);
 
 create_conn:
 	err = hci_req_run(&req, create_le_conn_complete);
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4646,7 +4646,8 @@ static void hci_le_conn_update_complete_
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 					      bdaddr_t *addr,
-					      u8 addr_type, u8 adv_type)
+					      u8 addr_type, u8 adv_type,
+					      bdaddr_t *direct_rpa)
 {
 	struct hci_conn *conn;
 	struct hci_conn_params *params;
@@ -4697,7 +4698,8 @@ static struct hci_conn *check_pending_le
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
+			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER,
+			      direct_rpa);
 	if (!IS_ERR(conn)) {
 		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
 		 * by higher layer that tried to connect, if no then
@@ -4807,8 +4809,13 @@ static void process_adv_report(struct hc
 		bdaddr_type = irk->addr_type;
 	}
 
-	/* Check if we have been requested to connect to this device */
-	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
+	/* Check if we have been requested to connect to this device.
+	 *
+	 * direct_addr is set only for directed advertising reports (it is NULL
+	 * for advertising reports) and is already verified to be RPA above.
+	 */
+	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, type,
+								direct_addr);
 	if (conn && type == LE_ADV_IND) {
 		/* Store report for later inclusion by
 		 * mgmt_device_connected
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7148,7 +7148,7 @@ int l2cap_chan_connect(struct l2cap_chan
 			hcon = hci_connect_le(hdev, dst, dst_type,
 					      chan->sec_level,
 					      HCI_LE_CONN_TIMEOUT,
-					      HCI_ROLE_SLAVE);
+					      HCI_ROLE_SLAVE, NULL);
 		else
 			hcon = hci_connect_le_scan(hdev, dst, dst_type,
 						   chan->sec_level,
