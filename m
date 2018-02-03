Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683147-2-10237988163656898637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683146; b=lhDjEmVBUHQ+9X23SqK9efF1MTFHleL1xvgL25mKmfu2tSV
    b0g0Y33VIlx6JUsEjlLZbjctilGymHjdtgrbsCnfD933j94G5tzGo0WEe6fLTKr2
    RH1GVLXhDXpEgbUz7VO6kJxPDyj2UPrvAv+Fi/9keVKU31d/lOSFrHaqYoK8INdM
    uUK9UNBj/YJdYr+a1My1kohqVNwnZz75188E6yW67Pr6fdr0Sa84YWI/aNOr+3XV
    m/rg1n+cX/P0LkKCu27kWfLx52WN0tViCHbSYzDpAVFsnyT3mxt95C4Q5nwDDl/O
    WOXH1x9hptvnjyaZlPAiecdU+05yYZGhqvcigMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683146; bh=WBh3YD
    IL+jhNSGFyqD7keCK93aighNiej90SxJGdq3o=; b=IUJhyVIjJ9y/D0e3rhTDsW
    q7zP/Xqoe/M2dYS2X5k7SQuyj/KQRO4vECk/WoC0xIOOiKHEnBuxvwO80Z7FdSR6
    apYg8eram9BiHRpnOA0ZzR2gax3AkFRFPb7pPR+lVWjE0cdNAG1//UKq9bsxmEBd
    Lk58HMBxGFNfcADYbNumS017JiI6NVRWbnZ07TsoYZ2+uOhyDl8OV/BylW9YFKZb
    PskqGUfNZOTpx00CBXiSqxakvidx9uXBa/yHmaZrX4qujQGZNUAm8UfwqXiAQPR0
    TGWMh+z106GveC73N1QOBvDeoITOXnkwmerDxXOhHXnQGdWktc6euUzOSMg4/9kA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aCrPUhps x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aCrPUhps x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeBCSjB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:39:01 -0500
Received: from mail-bl2nam02on0109.outbound.protection.outlook.com ([104.47.38.109]:45293
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752802AbeBCSDi (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 086/110] net: ena: unmask MSI-X only after
 device initialization is completed
Thread-Topic: [PATCH AUTOSEL for 4.14 086/110] net: ena: unmask MSI-X only
 after device initialization is completed
Thread-Index: AQHTnRkAfapAp5r/bkq/8NzfXEU4Vg==
Date: Sat, 3 Feb 2018 18:01:24 +0000
Message-ID: <20180203180015.29073-86-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:pwE6asl7LIrlFeQVWYjL/kGzLUaiX1yaPEoYiPo8P/YOj2qpPD5ul1udtlZEOnNEjbKXz7R1fhiRMu4Y/FuDtZWk2WKBQoF2kXy/TzMdMn8Hg0nqdo3kzBAoyIH3YtpADcAkq19SDlLv6eQF05FG1EbW7PGbVqz/Clubtxvk1/eLYwpFVngbofJgvznnaPM3iVRTLhx8fjUYMoS0x0WgQTCIRxeI0+1BdKP+4oKLgI0d2VFowPdcp/Ybo4KoQBoQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b790b33a-902b-4030-958e-08d56b304162
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041E43943BA071D7C437D41FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: jHVvej+0Unw7xDIxqL6VcJ+iAPzFOYDnWy7WjlKkIkgxBhMYGB09DOyDxJEy48u039Rm9zjlPFJcsjwiWLj77A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b790b33a-902b-4030-958e-08d56b304162
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:24.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 7853b49ce8e0ef6364d24512b287463841d71bd3 ]

Under certain conditions MSI-X interrupt might arrive right after it
was unmasked in ena_up(). There is a chance it would be processed by
the driver before device ENA_FLAG_DEV_UP flag is set. In such a case
the interrupt is ignored.
ENA device operates in auto-masked mode, therefore ignoring
interrupt leaves it masked for good.
Moving unmask of interrupt to be the last step in ena_up().

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 26 +++++++++++++-----------=
--
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index c6bd5e24005d..67df5053dc30 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1565,7 +1565,7 @@ static int ena_rss_configure(struct ena_adapter *adap=
ter)
=20
 static int ena_up_complete(struct ena_adapter *adapter)
 {
-	int rc, i;
+	int rc;
=20
 	rc =3D ena_rss_configure(adapter);
 	if (rc)
@@ -1584,17 +1584,6 @@ static int ena_up_complete(struct ena_adapter *adapt=
er)
=20
 	ena_napi_enable_all(adapter);
=20
-	/* Enable completion queues interrupt */
-	for (i =3D 0; i < adapter->num_queues; i++)
-		ena_unmask_interrupt(&adapter->tx_ring[i],
-				     &adapter->rx_ring[i]);
-
-	/* schedule napi in case we had pending packets
-	 * from the last time we disable napi
-	 */
-	for (i =3D 0; i < adapter->num_queues; i++)
-		napi_schedule(&adapter->ena_napi[i].napi);
-
 	return 0;
 }
=20
@@ -1731,7 +1720,7 @@ create_err:
=20
 static int ena_up(struct ena_adapter *adapter)
 {
-	int rc;
+	int rc, i;
=20
 	netdev_dbg(adapter->netdev, "%s\n", __func__);
=20
@@ -1774,6 +1763,17 @@ static int ena_up(struct ena_adapter *adapter)
=20
 	set_bit(ENA_FLAG_DEV_UP, &adapter->flags);
=20
+	/* Enable completion queues interrupt */
+	for (i =3D 0; i < adapter->num_queues; i++)
+		ena_unmask_interrupt(&adapter->tx_ring[i],
+				     &adapter->rx_ring[i]);
+
+	/* schedule napi in case we had pending packets
+	 * from the last time we disable napi
+	 */
+	for (i =3D 0; i < adapter->num_queues; i++)
+		napi_schedule(&adapter->ena_napi[i].napi);
+
 	return rc;
=20
 err_up:
--=20
2.11.0
