Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485384-2-13798124541946308158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485383; b=cqjK+l+1C1dvKJOvFT6Z26HnPFqH4ZYQ/cSjZ8297Gx5a9P
    tJIZX9bwFba/Z7p9Mu4i7fNEAsb08+jADk+MkMFoV+X4LK2fmKTE0N04M9AIjNxF
    Nk77YzGrQPSyMkMRspbacTthgqriULxymHOMAF1t4pYalbrvzoIKggNHk9kFGdv0
    +LZJ+0orEMUJQqY21Uba74U7VgerRdPGFKEoucfZ8H0kzbXoT1xmWpiAbPAxQtgU
    og5JHQONHOwq9NUbi673lebhLS1BKhZm76HkgcpyvKU/FR8WFuv3645BD1cnUP/w
    tutNY87Yy/vu2U2NZaMZonpgs3u/gzz0MQn2+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485383; bh=q1xcI8
    4hkY1zaKh8BySAeSQBDJ3FE4LCUo2s5Wqnhkw=; b=ni3uHUdWZxa+Aj+Y1ehVoQ
    j6Zeq8fAaOIa0bnEswUOlHQaTNdBzmr5QX/vIIRpDEY6/ldeN4Z6i491jz8sws84
    RFLHiXvK+fN3zMIRz1Pogp+aqhSXrBlnbkDQPgOzZNAkFYq2WWJqWK7pW+9/u1Yz
    k0WWJa2ijehjMF8P+np0nuvlNA4VdH6G4a6FvxzkhgkaxbfuGcsLuKcPK5yVGmw+
    r0NkkYcsq6OHRBr6YQjVveKx1ejkICqvPYNan/Zc2r3hC/RVrXUWzLfN2S3tC1mJ
    3qXlvitTva9WuETdj1ZbOHecOxepmKVUxB7JM0sHs/Z5JiK/tffT+TuhdcoHzm4g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jN7RNMiH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jN7RNMiH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965928AbeCHFC7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:59 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:54752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965687AbeCHFC5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 123/190] Bluetooth: hci_ldisc: Add protocol
 check to hci_uart_dequeue()
Thread-Topic: [PATCH AUTOSEL for 4.9 123/190] Bluetooth: hci_ldisc: Add
 protocol check to hci_uart_dequeue()
Thread-Index: AQHTtppH+FwrapGXeUC3cDLFhlL+6A==
Date: Thu, 8 Mar 2018 04:59:45 +0000
Message-ID: <20180308045810.8041-123-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:PRkrRMcdwyhR7yqT/SDwnXJSDNgq8UJaDqW2f7tAeFIgof+o8bNVKax+I7YDfvJmAEELdaJBgNgI/5Z2mD6DPlZGkHxkMoE++rRyMYz8ACx0Lrt3wo6HGh62Doge6VtfDiF7/AnMlL2GAQ3/5f6XSrz5RujJAgR7gYMiRcPwUd9ryxcYO1Em68skTWOkxyuxPhjAL2lQvxyCRW6+ISOoHegJYmGkQpFDFNfYw1VyLeolJX5poR7Hl2g2NpEKwKPR;20:6jefRBnABGg6blTYwskhQ75ftC8KDmQPDRC1zOxR7acfZxGOcvJEi0z8FT3DOa8N6441MArbPvJ6k86ZmPuFwknZWP9L6xd78nIuMxRZOsIGoSJCl/OUX6NAFrdtnplGgMnQwO3miqm3OKtjNMb3RkgU0QUF3qwfedNe8aHEhDE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aea80793-ceb6-40ec-e361-08d584b1d8f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10137A29A5C3E55531CB6C4DFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 4SRiVoNItAZ5RmA3irEaLrVwV4hLNpNNKsW3Rj2RvSe36//DhFTPs7GfLCTCkjo8UMBtHe9A5aBYplxUks2ha7D063Kp3n6xl9hJqWdaDEqgWmH1FGaIwOF/v77rmYYJCtt9jxJMNEdBfaSHk9kb+uKewYqWZCPJ+d5b5g/yTrGXAIrzUClykjo9bB5c7xBPL2QtEx7MeBtW0diCEizXVRh/sBib7ziUF457eDjI9bcjz+PLCRVy0mwIXBjpERIfJ788SP3HztdzWyTLjLEu1de7cijON6BM9YulybHIvwTHsN0+7WD9Qerap5dbIGWwN2ju5J12w6cWyxs6qMUayQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea80793-ceb6-40ec-e361-08d584b1d8f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:45.9064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dean Jenkins <Dean_Jenkins@mentor.com>

[ Upstream commit 048e1bd3a27fbeb84ccdff52e165370c1339a193 ]

Before attempting to dequeue a Data Link protocol encapsulated message,
check that the Data Link protocol is still bound to the HCI UART driver.
This makes the code consistent with the usage of the other proto
function pointers.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_dequeue()
and return NULL if the Data Link protocol is not bound.

This is needed for robustness as there is a scheduling race condition.
hci_uart_write_work() is scheduled to run via work queue hu->write_work
from hci_uart_tx_wakeup(). Therefore, there is a delay between
scheduling hci_uart_write_work() to run and hci_uart_dequeue() running
whereby the Data Link protocol layer could become unbound during the
scheduling delay. In this case, without the check, the call to the
unbound Data Link protocol layer dequeue function can crash.

It is noted that hci_uart_tty_close() has a
"cancel_work_sync(&hu->write_work)" statement but this only reduces
the window of the race condition because it is possible for a new
work-item to be added to work queue hu->write_work after the call to
cancel_work_sync(). For example, Data Link layer retransmissions can
be added to the work queue after the cancel_work_sync() has finished.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_ldisc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9497c469efd2..7ec73945351c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -113,10 +113,12 @@ static inline struct sk_buff *hci_uart_dequeue(struct=
 hci_uart *hu)
 {
 	struct sk_buff *skb =3D hu->tx_skb;
=20
-	if (!skb)
-		skb =3D hu->proto->dequeue(hu);
-	else
+	if (!skb) {
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+			skb =3D hu->proto->dequeue(hu);
+	} else {
 		hu->tx_skb =3D NULL;
+	}
=20
 	return skb;
 }
--=20
2.14.1
