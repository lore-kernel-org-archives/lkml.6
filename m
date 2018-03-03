Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120704-2-16513473698189287547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120703; b=TSlUKUe8QUhLieWHdfsp7yZ7cnAa1jeUmmorAyPdbTNJRIG
    cwdvrYwXshFUh9Cn6o3uYk3bmTKpHdGFarTiUaYiArwoItJKII3Nulv0HL58CUba
    CmNDj16zQzNIn6NcT/BH51qXmfw+aKdULzV8DF0ceIZr8V+rVUULk8Mo9CZzcjfW
    lX9y37E2lXy+RvsW+LkaiXdDbzrueuBeSGNnhIUsSz2adoSS06I9sLKYD6hkVWRS
    CyYEdiLkFheIBZ8QzM+A5+acPWPagXF1u2rJH+gMALD5KcuRh2YWZFJIXcUN/Hyf
    7+I70Xky/zOFt/3l3wzL+q55rAUt0HRMNMsvXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120703; bh=7/aBTC
    qIDv5Prx7aDP8jLhWwsZ6uxCFyse9HR8l38SI=; b=ia0c9JRhQuT89zKV5yCsEO
    2PTeVG0k18DfbkCdUiony7M3Pl/bzJy3gVPcy6+7SyxTEqvU7vAqcAY7vNQo8ONx
    YTHtjdgh3j8uLafRnd/HMyMRetaFjUu897780mMG+GEOEUYUEgmkKihlH9jrpGVv
    iBIQWKEILfWELfyNG7sT/Nu0w/THTpd1YrBSGUqeD81+1XkUati9NIPPx4916Sr3
    wx2U6jc4Z0zipnM49gaWajFNR4AjJDblG0X/2zOEKKKdm3bMT7YtxCLMsYSNINHR
    bJCLUa6gogkUWL5ZCavmuHSYJyNDgdTUAfVhsU7wsUoiSHq99LxbDbZwF22Ce5eg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iuQvvPZ1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iuQvvPZ1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934043AbeCCXor (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:44:47 -0500
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:51939
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934171AbeCCWeL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Easwar Hariharan <easwar.hariharan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 115/219] IB/hfi1: Check for QSFP presence
 before attempting reads
Thread-Topic: [PATCH AUTOSEL for 4.9 115/219] IB/hfi1: Check for QSFP presence
 before attempting reads
Thread-Index: AQHTsz8I8/04IEQSUEqQ/ImjU6m1gQ==
Date: Sat, 3 Mar 2018 22:29:02 +0000
Message-ID: <20180303222716.26640-115-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:uvdnDg+cKxcCk3uNsAfYsL2bOSMRV+ixcm3wrc7S50+QSmgJwAK2PaGxIobisVPeBWvmbCWzHxLGZ/Cv6oDPj6jzfSVgHBeEsjMX6ta9brcSs3WgJVXVJ7GVQ41B98d+i4V6obJM4s5f2BQJicINPap1ji7pdxTkxV+ynsnlkdumrhMfoFPm1UtGZwz0pdC3ZV5jp3p2VfgBvWhQVnA7TXEOYsvVWkrXT3I50xrkmt9oyKp5Vtwe4K2xUim2C02ImWQie6AdOrEGqDTqnNRYPk5R35R2DdgAJJXC5du7oeT76V0sjZNq6rGjFr9zq0ym06ttgv3EGnJuxeD/VToUdwfyKBtYVHExXVRolivEb+Dt8qRxFZ/ej+5/coCwzrSC;5:xXFhOK9YqZFTDTtFIKUi6beI+kMsBQ3aG0kNpQteM+dtoLq+7tsZ4Enqn+DxlMnteNUCBKUaCUS61ZbXifDGEpyWGXcy4Mh30stRjlOxu5jqym0uEahanJZO7SW95N/vFOjd1AEJFq5ceTuLC0wrVJ+VUOHBWT5qJNtlkH8PdLg=;24:MtlKwwQfH5GqiqgSwlYh6fNaJZZEeVYfkoXx03MHSraQHz/0bCxqLtOMq1avlR6jossjMNFMbGwceDshOMkWAMlIU9xqp/nJPzGh5b9yU0E=;7:7cC44J26NFw8npKgsyMh5RfK0xughPjY8s+Bvrx5RtEuamVF7vxgTohSxz9LI4mZj6ag1kwW1qmFzKSvGqFeXL/Ta8ub3ovoT23OImkU1qbjoY3lgz8I4FJySjJsDE/xzXDoCZAvzfancE7s173MUnKb0NJ76k/idSD2Ezhr/Pgv6XIAiyLpIJJiD3X3F0FPWrxSe/FSXMs78+K7dYSRmxgVZi/JljvxbkAMVvfmr9QLvqCavB1dvXBf/+gfi852
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3fd2484-b739-47d4-275c-08d58156e11a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068C376AE48131A64DA2C21FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hYoR37FwJCBU5C0MoXBMtX/SFYdIRzzc0CF+njHV4dWneQnBrUv+sbdN4xHYApcV6oYppdB0zFROapVApJb4Vka6QvTigJxqTHBjcyNHa2ee1avlZr9sghknDTiKCcNDE+CyJsRzxr2oS/MQ17mn0EnpYChJ/wcySo9St6/jPQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fd2484-b739-47d4-275c-08d58156e11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:02.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Easwar Hariharan <easwar.hariharan@intel.com>

[ Upstream commit fb897ad315643e5dc1092a115b3cec914b66df9d ]

Attempting to read the status of a QSFP cable creates noise in the logs
and misses out on setting an appropriate Offline/Disabled Reason if the
cable is not plugged in. Check for this prior to attempting the read and
attendant retries.

Fixes: 673b975f1fba ("IB/hfi1: Add QSFP sanity pre-check")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1=
/chip.c
index 4682909b021b..3be62ef154d1 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -9489,8 +9489,11 @@ static int test_qsfp_read(struct hfi1_pportdata *ppd=
)
 	int ret;
 	u8 status;
=20
-	/* report success if not a QSFP */
-	if (ppd->port_type !=3D PORT_TYPE_QSFP)
+	/*
+	 * Report success if not a QSFP or, if it is a QSFP, but the cable is
+	 * not present
+	 */
+	if (ppd->port_type !=3D PORT_TYPE_QSFP || !qsfp_mod_present(ppd))
 		return 0;
=20
 	/* read byte 2, the status byte */
--=20
2.14.1
