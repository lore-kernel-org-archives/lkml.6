Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123007-2-9682641992809771268
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
    t=1520123006; b=shnXHZF/+IBboKPtUFJulYCpDQxGqzkhcFVAidf6A29Ovhc
    2LfrUD57Se9oVcTqC82YhgB1M8OrEizOcnQxgYRtbS++MCd0J8R/IUFFMO5Qlm4W
    Cxe2VWhub5CAGB+hKcfP2cKOQGoyTtQBthQJJmUAylK55tu+MYQ6fDiO8qQx60wS
    2TDt9IAAj+z5pGhhg73jsLtyKhDwSvsskssKr/d1IAVYn8xwMjT9IwcNOlUf9YGf
    Fr0m23rKNGUibCrjob1nlSZSP19Gsig7H3yo7c6Xxk925p2NwRiZST8f9tHbE4l+
    l4cspiX0Pr+/JlyM2YdfAJ0eKoGLhCGfkaS2kow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123006; bh=hJ3QjW
    G88PV0iUrLldMvjgQzKsP53FKPAxiF4B+W+O0=; b=IdcjrnZ3Qv9jMDoFeAHmSi
    FXVwFCNBzaqQ8zO+a7fvmdsBN6XNzzMpKeNqnwWgLNI/nMZnnZDThjGS03ttIgX5
    B9wOaZkNFcs+M4cNQssPzCAKTPogN/fgpvTy3nJ9xEobJhTwASUf0edP3ofrIUlA
    907b8eyNxkG+aCrFyb4fZ1xX5uCI6AVjivxs6RQw6YVjjNCHEs7QfGFvqvMAaWlf
    kQP/xO5Z19urkbBT6C7pd1rb3fZDd/ei5IvEevGJRYZUTOX7RUS3EsZYvcNIz8pL
    9zPButLOZdjocvoaFEg2EzFVzU5VsypZJPr6MbEiG6k7mFSAoXKxmO4NxBo0SXwA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XEf4bkPQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XEf4bkPQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeCCW2X (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:23 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933049AbeCCW2V (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sunil Goutham <sgoutham@cavium.com>,
        cjacob <cjacob@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 24/84] net: thunderx: Set max queue count
 taking XDP_TX into account
Thread-Topic: [PATCH AUTOSEL for 4.14 24/84] net: thunderx: Set max queue
 count taking XDP_TX into account
Thread-Index: AQHTsz6jJvEjBI86RE2/f4vwnUgg2Q==
Date: Sat, 3 Mar 2018 22:26:13 +0000
Message-ID: <20180303222518.26271-24-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:RjmlM/95VoMJOlWn7JNyDVuJ+LcY1rthpzAsTTdqMPdz+c1HKm0Xby+8TjiiB597wrOYIk4GRjTKP7JXimjCiNxPA4Vfop3YZtGEML2Iu5jHBFdgxXEo8Wu+tzUbzdcuT0BIf1lH443iKPA5LnF/gIsXv6bLSKQm+qRFnIUELS0isUfCcyZ2M0P5bHZgb0iWa+v3gBn0MMBsl49y63qX1wAHHjyHLG5/PW02L4ftKWM6wxcfrhagkXLdlyiYSDO0BLWtmGrs8fyi8VcxigN0dpxtJW/nSzMDQMMWPxx6PylZZxvonHr/CIOmqZzN+85Il3jTqhCwOfZfUuAkkUHKqQDH3NOeW7I8CVsM+WKQT1bpLPOGpqmw28Uqe76QDyey;5:bG8CKQlo5veZeXBfgb+kBKBoi+dCa9E9pnC4DwxzAKAZ3hyttvOEv2OVTx8tTSetifU3JhwCcRzkLNRjUFcj2i6YOAoQLRtTswJ5aX3uepNUe+6FXxUGp4mr8mmzjjyeqZqCs1DWQ2KO0GUyPTbiGtm3Ms1RUfED9ygVkt+BQo8=;24:IyGqY3QmPxSRF+Xd3n5uPzsGzBcl3lz5ErrYCnDdFRn51+l8EJ9AONtR5Y7wNEBH3yHa2r2FICuqg/t+zq4jgfQaTS/K/riY+6tuWS3iL/k=;7:SaiQJr0OYX85tOCJeJiQFDWM44y4uccneYpimjG5J6TrzZ8xuhXA6uJiLNfuNM7/qoryIRvZYe1YMTZa9811M3k+4bL8M8phcL8JaNg2Q53uUYLowgLLf/w/8XKh+6dcQ8hP7cK+KW/KTQAU6lMDlYytM/yV4zQpBmsAzYRDn2jsHermQDPkw+bUjt7M9quI9mBgS+fQA8KAf3cc5iITpBxENS7njLO/ThURDuLrUFWezFjHzeyE4ImGbr6r/7Ws
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f03cf48-3b55-4431-b3f2-08d58156109a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115A607CFB7489D0900FA2AFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: t4djfIg3BQ60LcNCkbiXHQwFt6C+sS7jiULoN0dXxo1Uctb11HMvRnYDeTtvVJT++AQkaJnhWZMUp0LSiMJMmHQ12tSz9azVh3/tEk0akQBzkMaNMXDnZJ1+GPyNfUqVTgexalBQvX2wBaf0ypliqzPXnL8i7QNoie6EmspQtFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f03cf48-3b55-4431-b3f2-08d58156109a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:13.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sunil Goutham <sgoutham@cavium.com>

[ Upstream commit 87de083857aa269fb171ef0b39696b2888361c58 ]

on T81 there are only 4 cores, hence setting max queue count to 4
would leave nothing for XDP_TX. This patch fixes this by doubling
max queue count in above scenarios.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: cjacob <cjacob@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index 805ab45e9b5a..2237ef8e4344 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1832,6 +1832,11 @@ static int nicvf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	nic->pdev =3D pdev;
 	nic->pnicvf =3D nic;
 	nic->max_queues =3D qcount;
+	/* If no of CPUs are too low, there won't be any queues left
+	 * for XDP_TX, hence double it.
+	 */
+	if (!nic->t88)
+		nic->max_queues *=3D 2;
=20
 	/* MAP VF's configuration registers */
 	nic->reg_base =3D pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
--=20
2.14.1
