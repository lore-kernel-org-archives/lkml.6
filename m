Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488920-2-13259568781166318616
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
    t=1520488919; b=qIBo/XZxlADcingLZbW44Bvv8n+L3NWBGsAF+qThR35TXs1
    Usrqi/Fn/fJIYEurr9Veo0Xzz8xoS5dp8XACB24I+CCXTzUkMgW6Lnq/u2Z/lPXu
    iiry1aB2rdcJrdEtRxGE6pEwb5UrNdHqI9sQlB7u+s4TzsWLmRSI23FRr8ukBz7L
    68sjL57Oh4LUHxVuMI8RE0UNSs0HAf+iiC4iP26Ivm1lILnPvN00zca+ZbguinjM
    0VMCLMahexkh2Hch13laGCySEa+ujDVlilSoyMW0i5mVqA1wEjGJtJKtPsZqo8P7
    lhYtF8gCpqFGWlymqRxchKPi7TT6k4BIHAQU/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488919; bh=ghYC8I
    9jstGs5we12+srcmlk0KrUOpaPR/CrJKEtmZs=; b=FC0duCEnMN5khFdLjhjDhl
    flbB41+PW9y7mrVno503b8or6zhGShr1x0DinNbV6T9ZG3Q5S77KM4qWfq87fQIs
    S8/W4Musj5TttURbxvDJhu7rcCXU0ooh41qFc2dUriu1iNn7Bl0OgoKZbU25NqFi
    vi6bbtalhVtdeNb8fQzTDU5JgkfqJaHQtsOo/8LV1wOIMU2xZr+OLSfIT2TMOOy4
    wbo3Ovu0cYTcGcFVfQg/gS7ap4bPesJqlKwrtKe2Oj4kJ7GJGGW+uOfkjTZoMFQ6
    xzTL1mjAC2uIX9GZxoq8QbrIH+D9hy1RweEy/NRovq6oRsQ19yWptgT8DHEna4og
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IGTTnc+y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IGTTnc+y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeCHGBn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:01:43 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:54752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965904AbeCHFC6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 124/190] Bluetooth: hci_ldisc: Add protocol
 check to hci_uart_tx_wakeup()
Thread-Topic: [PATCH AUTOSEL for 4.9 124/190] Bluetooth: hci_ldisc: Add
 protocol check to hci_uart_tx_wakeup()
Thread-Index: AQHTtppH81A3FcZObkS3K9pRFqOkSQ==
Date: Thu, 8 Mar 2018 04:59:46 +0000
Message-ID: <20180308045810.8041-124-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:GcqqaIi8BC8xqyswy21zEYXj5Nx5sUQ7vr0a+ShCFOIUNB3m6U8bJ39AlIL6gxHc/04urYjnB36hpbn13fyAkgdgibhA6vx12BusNNF8P8fQ7Vu0rcpTpdefOOPtbRs69ZJpdYV3fWuZ1xnvgTZmTL2FPgYpILHIhmWCuhAWyG63RUFIV+MtjEmDSbMAOCKktX/l/VrbAVT1gsPz7quljuGD8ZrgUGN97n0D2wPGG4BlbbzDC9KcboQ4g4IOt6FU;20:M6dHHrazpl4ki+oXZvowwlBupSA8tFsFoRjRhxCX183MdL8l9+d+nwDXNagcesTYNbcN7HKQ9bro2hkrQfGX3Uvo/Thvwe+t5iBg+qDpV2pMyq5GNR7QAamURBDxfO1/YctcbIG346tuOrv40Yx88eHp5gfidoqmmSc7Vbvh7fg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ac33d9f-8edd-445f-f165-08d584b1db38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013779CE03C408C841AB53AFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HXpCAQJx+BvIrjdb3d8eZveMFglvD9PwzdBn2ltjqqbI4dFdUtMvDArwwtOrvDhT35zP0MHzixcq/ULP+fxq17o/Dx89gN9AERzwHT+btpEL5tdUxlxTFQvitZyJeOIw3tsLJDAY8TqRIrSln3v+ZnWb0tKOFvo+eqvZyhcCofhUHAKMUL+pF9uvOCm1VW675K6rjBZ+lNyIs0kjR1sfMNdZs/bpJtH3wuf5CeIWpkl+qnMBsopLQX5D49RIccEfTTIbyBbiJ1/iwaliKswIPfihhQ50/4Qh7prYFDhfuK1D4iR95eJ3NuGjbf8vJ+88A+AjCVcZNF3zvakHTN2Mog==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac33d9f-8edd-445f-f165-08d584b1db38
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:46.3337
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

[ Upstream commit 2d6f1da168e1d62c47f7d50135ac4cbd8411dcb1 ]

Before attempting to schedule a work-item onto hu->write_work in
hci_uart_tx_wakeup(), check that the Data Link protocol layer is
still bound to the HCI UART driver.

Failure to perform this protocol check causes a race condition between
the work queue hu->write_work running hci_uart_write_work() and the
Data Link protocol layer being unbound (closed) in hci_uart_tty_close().

Note hci_uart_tty_close() does have a "cancel_work_sync(&hu->write_work)"
but it is ineffective because it cannot prevent work-items being added
to hu->write_work after cancel_work_sync() has run.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_tx_wakeup()
which prevents scheduling of the work queue when HCI_UART_PROTO_READY
is in the clear state. However, note a small race condition remains
because the hci_uart_tx_wakeup() thread can run in parallel with the
hci_uart_tty_close() thread so it is possible that a schedule of
hu->write_work can occur when HCI_UART_PROTO_READY is cleared. A complete
solution needs locking of the threads which is implemented in a future
commit.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 7ec73945351c..2230f9368c21 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -125,6 +125,9 @@ static inline struct sk_buff *hci_uart_dequeue(struct h=
ci_uart *hu)
=20
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		return 0;
+
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
 		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
 		return 0;
--=20
2.14.1
