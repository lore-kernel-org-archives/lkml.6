Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241598-2-4516985311908386795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241597; b=u35SBxa5IcAB4HQQSFzKslOoznnFGoyVLBhtT9QK7RXDssFCmN
    5n/BsVgFv1wnk+VdsfFpCctXtAm2NiXk6dNny1JjRSHNl9XeH/lsmTei4f3VUmsl
    yXvQykGRav9PbA1NOxpuFQWDD8sdB+Q/qTp5ZZqw2QEkXYwpFr2/zhs9RSj+WWsa
    50mXxWYXMQ8L+aTmuZLF2nsuXTWpUYDnOdO6ZkgpxZiHfb8/thMnq7Igvzmg53Gj
    ambYb/8I0CxwLV4z5rFt+xuH1tVIIsLa5hfXVZVw/GygQLTlkQzmwWKjN52WB5/S
    h3WsfGppnT7uc9xhQXyevXpq0HeDzjIN9fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241597; bh=ICx+GXyAVJ
    cMXkguJWGeaXv2uN3V1dc1Z14U3l3Q06k=; b=vBCBjYO1ieQ+ZGuUIY6pYHF6Kf
    VQyfflYzsvYIdsq5LTDQcwDbHJhMepVrx4sA83eRHSyNthi7ikopbwjTE9ZkjBH4
    TceP6VkoHdh7od0TmJM8/cu9mM8e3zhUY42AqB8iIh6ciIzokhV6iEAig+3c/INq
    R+YOhgHuj4dqMcmeFcN7u9QvrhpQDYOvVRVAFCGiuvovXigCk9cLiwqw6ntgQo4k
    OUrRWcb3+Ghs1Yxs0Z/PDkUqDzbhBAjOaspB4GX9eXvb6BN4wnbGoGBgJxvYyhlJ
    WHbWqfq2RcbFkqNN/VJaREmg4iDVHFuKjA1QHJiKo0pGhddEkQHVKMyCE9xw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQrIAnCA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQrIAnCA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfORuEdWkutgK03hWFbpJ86ccCW6qiA5mE3NB8kLkZ+2mGQLxWG7EKvRj5iP5JtzzVPmw5n+0ah8rj6Tw78MT6YlBRCLbk153b8OWNIgL2PpduAFue6rn
    OrR0CUtaMgvtWijduBEdA+ZiurEtTXZpv1cG82pV1sjfj2LHaolHWcnR/JSU3FDx7eunT5wsQEzr4LWQMycHPwS8FCch4ORaHn202rq8BsNJ9QIVWBbzu74e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=rTRWisClx3kO2Y1GW4kA:9 a=wPNLvfGTeEIA:10 a=M-Yerj1wOn-OpK7r_3ei:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755682AbeDICjw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:39:52 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755561AbeDIA10 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Szymon Janc <szymon.janc@codecoup.pl>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 038/293] Bluetooth: Send HCI Set Event Mask
 Page 2 command only when needed
Thread-Topic: [PATCH AUTOSEL for 4.9 038/293] Bluetooth: Send HCI Set Event
 Mask Page 2 command only when needed
Thread-Index: AQHTz5j25TxXBdaOQkWMi0rvJBf+AQ==
Date: Mon, 9 Apr 2018 00:23:19 +0000
Message-ID: <20180409002239.163177-38-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:yF+7cZwexJxhJqOXUYbM5OFuUOJoo/L/I4vJHifTlt6TGuxvMbGtDWwDKUH2+Cl8+NdxT+MjHjAYeMPi9kDJKBu6L5GcZtVslVeGDyG3DKujjhoajTjQqLnd41krj/f8fFh1l07PoG8TJGXeK1RMCeIyCXeBhbJkTqAWzQNJGbY2wnqrJoU4T2yXQhQm2y7nqD16G1GufDKlhC1NMrJbMDX50mPpSUCsqDr3/+wtUPHfBqG6DV1IW+Qfjsinz0p/;20:qEdxiDuU2cXsM2cboX69Syy9ZDvCIK33BKxHjSCkga5NQk+fkrlDajJG0ubZHFNgm8w0o7UGyRvNqewzowJL27vI7A7hsBjVwSa0pHMq6oosjqV094kQGgmTbyXjKhWdOETvcAu4hZvTSaNkpHl8qYHfGITDuh17NhUoSnwnKhs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a514c59-e7d5-49c8-7760-08d59db0a8f7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103102A8669DC19E74A87EA6FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yJK/H8OE1ozHhlxSLr1QPZjEkiY08kX+815uXQWjvnRCVSKPkWs9Os4f3+GL7DAQHpu6dsEViXNu4S4rfvpzCuOgiYBCVe/ZwTT8IyyqE0bS/DnVdM8tpSs7BjipmzhdBXxUrBO1SBhkhjRHnAqLizg1cxDjgVYsbTWyK2rS/9GC5rJIIVNZ4gPRjqy0dQ+yMksFXidWLU7y21uE9Wc2lglpcTB6Jb/9292P6tetBvqMXn60GMAI1ocXXwwV7rxtfMbvWd67D4ZaJR5+PFME7K3/PFtAETdewWflIa+T2GZC1o7P0rJ5RiAv+KjkmMoloD+XAzqFCEdFSZh/KHwwZmn9hln6xZloMUCJ7aNxEaLuinA4kNibSMmhPo3Yyrk9oVqqw/n4/vs4Qh4LnO4pr1nKmMtRA0U+LO9uSnb1x4M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a514c59-e7d5-49c8-7760-08d59db0a8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:19.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D03 Dev#=3D  9 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a5c ProdID=3D21e6 Rev=3D 1.12
S:  Manufacturer=3DBroadcom Corp
S:  Product=3DBCM20702A0
S:  SerialNumber=3DF82FA8E8CFC0
C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dbtusb
E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bluetooth/hci_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3ac89e9ace71..4bd72d2fe415 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -548,6 +548,7 @@ static void hci_set_event_mask_page_2(struct hci_reques=
t *req)
 {
 	struct hci_dev *hdev =3D req->hdev;
 	u8 events[8] =3D { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	bool changed =3D false;
=20
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
@@ -557,6 +558,7 @@ static void hci_set_event_mask_page_2(struct hci_reques=
t *req)
 		events[1] |=3D 0x80;	/* Synchronization Train Complete */
 		events[2] |=3D 0x10;	/* Slave Page Response Timeout */
 		events[2] |=3D 0x20;	/* CSB Channel Map Change */
+		changed =3D true;
 	}
=20
 	/* If Connectionless Slave Broadcast slave role is supported
@@ -567,13 +569,24 @@ static void hci_set_event_mask_page_2(struct hci_requ=
est *req)
 		events[2] |=3D 0x02;	/* CSB Receive */
 		events[2] |=3D 0x04;	/* CSB Timeout */
 		events[2] |=3D 0x08;	/* Truncated Page Complete */
+		changed =3D true;
 	}
=20
 	/* Enable Authenticated Payload Timeout Expired event if supported */
-	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING)
+	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING) {
 		events[2] |=3D 0x80;
+		changed =3D true;
+	}
=20
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
=20
 static int hci_init3_req(struct hci_request *req, unsigned long opt)
--=20
2.15.1
