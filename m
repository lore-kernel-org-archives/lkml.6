Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116559-2-3469681706385199230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116559; b=vVqzjV9kM+ETGjDvJR3s+b2TrTJ4ZdL3+cC/rwInfWZADqJ
    wKqE+ZJM9fgAMj0Z2ubU75z1vVlqgkSzo4HlSIWrCG11qVu2nRMTL1Zxm2JTfzEL
    O8iXkRGQ21mgBaivbcqQNRcvnjplo/yXSR1yi7NX82mRpnI0BdjA0tgXQ4xZMhNg
    yyXvT3CGmmWrDozY7z5sJS5eiSG+NeP0koJOVlB9X+a3wQW4ibecrCYIPfImAB3t
    lv32Uy6gj0W1VhPKgi/x1uq/dcDkDe1lMVn3gVTHOtH2U7W0Sgo4UbfXIRqdr/7n
    vitX2CjRpkqaCNTSKZG2v4J/hUkDVhROKDpTrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116559; bh=1Neaod
    Q2EFK2O4hRejBsvxJyZZciQUpOCHcsHdAx5iQ=; b=dynbvkb3G2KcZCIDclZOlF
    YeRiSuqnLNs0yLj+afvz+2vqAIsGeYlYRGvI0gVApgqFS6uADBgRciTNCkMa1rP1
    eDa/3xaQNBzoeB/+untUHchBl2CLqdLfiHYyH2qwEUYlDuAoMDwVtpNLO1aC6ioM
    GttB1V3tx/Vlnd2SUVoQqS10/DhJkjq2yR9iL1uuJ9Uku+GbuM8CveVxEofU1+XG
    B6e++Z86HgQyE5Mcz0JizsUXwt6xD/Mjflxnz4xBNY8andHT+J/CVbAO5WM0hW19
    lC0rLwJJOIWht3Dj+TVy2jaLA1nxUX4Re0m38YBf0Boq1CLc9ZslizyahLHRK9rQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GN6pDd2D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GN6pDd2D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934235AbeCCWeg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:36 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:59936
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934190AbeCCWeO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Phil Turnbull <phil.turnbull@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 118/219] fm10k: correctly check if interface
 is removed
Thread-Topic: [PATCH AUTOSEL for 4.9 118/219] fm10k: correctly check if
 interface is removed
Thread-Index: AQHTsz8JKsDCcyfKFE6clcX4f/+JRQ==
Date: Sat, 3 Mar 2018 22:29:04 +0000
Message-ID: <20180303222716.26640-118-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:z/CZKVSvnn701/AEW/Aya/en1jZiirCVIIIZArFEUSjP6/DypPgh9oon0uXGCz4VRqdClbgSExH8CPYPB2d/rraCbEo8IE+Zc385JyFoqxEC0GTmJj2vvNA/RT/bTURsa9W0aiIeZUieTu8FbO0U4nklg06V1O+FPSklhMPszBoY/2h3hSUN8JpkwHSnqH5X4Q4hvgn4wIwqUhLXaWCrwg85p5oOH92uMBR3q8FvxB4uGZynfUE5dTAALfjxPb5gTJrP3gJ3WtSwsBqxjfIQ03L100YMH5udbv1JxrjHPRJsKOnKvlIo/E55n/pzPH8+eU6NhNO/mZg5HaeJ14/lq7m46zFERlfEPjZTfgrz0jcoyjO1z3027BjnUfeafnkE;5:D+mj3enXHE3diQgWHrYIo9jO3kS1TE+gmFWLOa/pNMOlh2esD/Z7MVmItsok732igwDZIkqKS+AhMUsblLID28r97pPkSk/tSxAVpH9DGWoX4SK6c7tEQSrQc6oZkA3CoV/TfYwK6RkAKJSou15rrPGUN4TdWLtSc06Yx6shwgU=;24:7AD7aGtpWFu9zq2CWam4nyPl1PdT9n7KvnZYws5V3aji+jZ2HHfMjN3dxJHTVmSlFqFfTqVkaFKk7zJQH0GBbY40IhOyjAO6GLkx2facUKs=;7:aiZXkLJlYUW3CDNOKZpTnvuwapUNJ9gUUQ2rBko63kTGrNkHLm0Q2kaqLYZ8MvA+jOtVNEddTZMdfYTvu8SHsOKMJTClJG2FnBeTbPex9mQu93f6EG0/YqIy2pjn0O9JMRTWXXNAjwDRPD52xggIp+F8msN2u5aKM2G3qd0wJd/d/Hj/s0CAXR1RO5yyjhg6bn7I49OCuvUcyt4IuWbcSG8FS3h8J2clAfiyLd9TKWGVxaOGH46rhVuawDkQNMTc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6ffcfe3-7f01-4337-e4e0-08d58156e1d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10680EAED7309E891CA0D71BFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LyzSjlLrrfvYshu9tP37P7cM2jz4TUc/ATSVXWH52JkQlqpPd9UueMZiwUr3jTCB/ssE2SMxZpUZqI50zfQU+p48D4zja0i1jL3LPkhZRx0ovRvAp4cYlsnaCYkDnSLhRxhO3jy7ckhqmGg05fx3SX2M4oL6NehqdQchpkukGi0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ffcfe3-7f01-4337-e4e0-08d58156e1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:04.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phil Turnbull <phil.turnbull@oracle.com>

[ Upstream commit 540fca35e38d15777b310f450f63f056e63039f5 ]

FM10K_REMOVED expects a hardware address, not a 'struct fm10k_hw'.

Fixes: 5cb8db4a4cbc ("fm10k: Add support for VF")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net=
/ethernet/intel/fm10k/fm10k_ethtool.c
index 5241e0873397..7041d83d48bf 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -942,7 +942,7 @@ static void fm10k_self_test(struct net_device *dev,
=20
 	memset(data, 0, sizeof(*data) * FM10K_TEST_LEN);
=20
-	if (FM10K_REMOVED(hw)) {
+	if (FM10K_REMOVED(hw->hw_addr)) {
 		netif_err(interface, drv, dev,
 			  "Interface removed - test blocked\n");
 		eth_test->flags |=3D ETH_TEST_FL_FAILED;
--=20
2.14.1
