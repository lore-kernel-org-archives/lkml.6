Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523474033-2-7494552513860588246
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474033; b=lcNYiuh0a5EJ+g4H0Q78zQ15T6JAkNhdzGUc7Edkx079844m82
    nO6XEJ4p7Jc4qgIaCd520aShogGfeipbkYKdE0ntX+OdyMjQC1eFz+6M3egbe5vZ
    9BseXzcm0eXx1sRJoFCj+F/8AHKgG5YT6BKvUrlKpzmZxOh4e9+K+P/YQu74rCUT
    tRszxV26zsGsQGfCyvJu4BlucN1sJDhItWjJSlLma6BG5WrhVbqASoYlXHLCNvSE
    vQo6z8XxZP0W2suWFqbn2Sxw4MgdRzy6yy8Jo9EFXvSEwkqD4q4m+BDgTiBGKC47
    8t1/vCBd4jfYf4OnHJz9SPmaivjou6I8aqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523474033; bh=U2Utl5fT6mU+Va5Xpwo5K7AOz/zKXd
    HvSD/+r9dlf6g=; b=SxiIp1fl8Ikmv8krkRqm4SqMhfKmb2i/RqIenHMjcjSVqk
    HqjIgIU1iU/SQwFC/C6hOWGEqqcubQ8pUkjaNVp1CRXc2mfPWTLIpU0husJSltzg
    VF6+ZIUPP8zDv1dAwgEX81ZkBxgq3WQx1CvvIg48J6okEewXN2tTYqiAiYoU2Ks3
    h59g9FsES6r+45hAkE9fyhpOBxB/T3/AsglmORgZkjbgqVOEu/Wrne9LTHoedlTt
    QWeLomo23LEHU9lN/ELL/UHKqJ6OiPVkziyKc9NgYkiq5pp+JhREBZBn0PxOgxnr
    KDpB0tsE+OiQkrQ2udLPB4T4z8S+v4mQRe0sIIoQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfIvASi658WVxzooq5/MvtLjcChOZOX45PBSwSEOqsU+MSqmeBe7ae7qfpiTn9qALGgJzISciZ5vlj0Klj0NtiFPVYE/IrQg4kqndpVC6j/dbm8oWlE2x
    Z2GsSztfCzmHC1IMBSwO1zvOTO1o+kV9pV0kb8/sI0iAEr4fw3h5VTSebhtHd5TD8+P3OJaKK5AAg9n8K+adYBuOuldtZkKGxbR6TvpKAERf7Z08hKuDrgFJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=hEsfW16Z3biFOAOLPU8A:9 a=QEXdDO2ut3YA:10 a=M-Yerj1wOn-OpK7r_3ei:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756662AbeDKTNg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:13:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935115AbeDKTFy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Szymon Janc <szymon.janc@codecoup.pl>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 247/310] Bluetooth: Send HCI Set Event Mask Page 2 command only when needed
Date: Wed, 11 Apr 2018 20:36:26 +0200
Message-Id: <20180411183633.083674352@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Marcel Holtmann <marcel@holtmann.org>


[ Upstream commit 313f6888c8fbb1bc8b36c9012ce4e1de848df696 ]

The Broadcom BCM20702 Bluetooth controller in ThinkPad-T530 devices
report support for the Set Event Mask Page 2 command, but actually do
return an error when trying to use it.

  < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
  > HCI Event: Command Complete (0x0e) plen 68
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Success (0x00)
         Commands: 162 entries
           ...
           Set Event Mask Page 2 (Octet 22 - Bit 2)
           ...

  < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
         Mask: 0x0000000000000000
  > HCI Event: Command Complete (0x0e) plen 4
       Set Event Mask Page 2 (0x03|0x0063) ncmd 1
         Status: Unknown HCI Command (0x01)

Since these controllers do not support any feature that would require
the event mask page 2 to be modified, it is safe to not send this
command at all. The default value is all bits set to zero.

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  9 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21e6 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=F82FA8E8CFC0
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_core.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -548,6 +548,7 @@ static void hci_set_event_mask_page_2(st
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 events[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	bool changed = false;
 
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
@@ -557,6 +558,7 @@ static void hci_set_event_mask_page_2(st
 		events[1] |= 0x80;	/* Synchronization Train Complete */
 		events[2] |= 0x10;	/* Slave Page Response Timeout */
 		events[2] |= 0x20;	/* CSB Channel Map Change */
+		changed = true;
 	}
 
 	/* If Connectionless Slave Broadcast slave role is supported
@@ -567,13 +569,24 @@ static void hci_set_event_mask_page_2(st
 		events[2] |= 0x02;	/* CSB Receive */
 		events[2] |= 0x04;	/* CSB Timeout */
 		events[2] |= 0x08;	/* Truncated Page Complete */
+		changed = true;
 	}
 
 	/* Enable Authenticated Payload Timeout Expired event if supported */
-	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING)
+	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING) {
 		events[2] |= 0x80;
+		changed = true;
+	}
 
-	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
+	/* Some Broadcom based controllers indicate support for Set Event
+	 * Mask Page 2 command, but then actually do not support it. Since
+	 * the default value is all bits set to zero, the command is only
+	 * required if the event mask has to be changed. In case no change
+	 * to the event mask is needed, skip this command.
+	 */
+	if (changed)
+		hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2,
+			    sizeof(events), events);
 }
 
 static int hci_init3_req(struct hci_request *req, unsigned long opt)
