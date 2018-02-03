Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517681892-2-12202425722373073007
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
    t=1517681891; b=haMbr6Xo0I64VBgRX4QDu2yJQL7MJ7riMjpRPgBQkn01bS6
    X0sFhVgUq0P4xald8/dKGkQHUzRqTEeszUN55a/f4jzCuak50jeC9EhsuxXyJhhm
    HBgwslMFIKlppVM5BksMa2pMGJEkJzpl+sLNJqdn5lO6lKlfw513xY0Upw6rsIIk
    0AUulIBeyHtiKTxNtk3VWWCOS6K+Ki9zWkV0KZ5VcFSHUPZOhtiSn8HvOM3WlSom
    9p42GHlL5bGp+wAUWAt6WY93BhVYnmJx1lPovS/P4+bnGQV6hapbRhclnpUMKeZb
    xYVYkPmTdJfUYZXDqv0jbwJer3eOfV2yThIHGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681891; bh=DC/3c0
    6TW0EV1dBMZ5vv59QfQxFPVqBfMM1uTTICae0=; b=OabXtueB4X0uzqyY1qmJUa
    rD5lr5dRVjfcfvpvgVcW0pIPbS911fWStKWr8Zk4aSwa1RWU+6hC3V2Har0WGjxI
    TUB0g8AqeDMNKRX1uxTjEalluQstWn930LEK/eFVYZpXR3rUpC8lgpPwJxRUAwP7
    bKFRNai1lYu/4L/xKWJqwTFQZRkVqOHEy78DislUsVrLLWzyTxUoeYsQDMe+VgvI
    lk0d48fkvl/BVQHF0/rYZmNvx+hNbKDJudgDCt3I46aMKT5A7PCNgfNDYviatOAo
    MZ78gDuzE4cxIeN11zgENz2DX3YHescDmu0QyllBF0r+BjkIouR/TXYiaBFuSw1w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JECPSv9a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JECPSv9a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeBCSSH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:18:07 -0500
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:50832
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752976AbeBCSGx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 45/52] bnxt_en: Fix the 'Invalid VF' id check
 in bnxt_vf_ndo_prep routine.
Thread-Topic: [PATCH AUTOSEL for 4.9 45/52] bnxt_en: Fix the 'Invalid VF' id
 check in bnxt_vf_ndo_prep routine.
Thread-Index: AQHTnRlcXY51t4rF/k+LsgScWVs72w==
Date: Sat, 3 Feb 2018 18:03:58 +0000
Message-ID: <20180203180303.8490-45-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:U4naRLgBmW9idiDL153gerBbp9ZHl6x4ADznnNMu9iONcmtWh7AkeW5e1I4zZ5rJX/8U9Wn7xi3jIPVlHaQ+m32pF+a3Z6L2u6uj35BdOsuQtlJvtQHLJHppu8mlP7e6AHL75uuzBbD4TNSi6Kmljh7SMJhnxNoO5V9G9L2zW5id1kitjZstfbm25utCyEsT73PYFMOvWMuyDZM2M9ICQr8/t7rYO3+qHXb6UNRXF5CpM3UxjSl9jE0yr0yzj5lC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ef865a2-25ab-4724-7360-08d56b30a202
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB10127CE6A7E5AB7E337C11D5FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: x/Hr7J8q4KY9bAiSDQGAXXMgwHqrTYf6H2xf5MEReZH6UkZYM3a6tJp1PED5YA1B7LmmT+xovEn4dtC18Oc8iQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef865a2-25ab-4724-7360-08d56b30a202
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:58.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>

[ Upstream commit 78f300049335ae81a5cc6b4b232481dc5e1f9d41 ]

In bnxt_vf_ndo_prep (which is called by bnxt_get_vf_config ndo), there is a
check for "Invalid VF id". Currently, the check is done against max_vfs.
However, the user doesn't always create max_vfs. So, the check should be
against the created number of VFs. The number of bnxt_vf_info structures
that are allocated in bnxt_alloc_vf_resources routine is the "number of
requested VFs". So, if an "invalid VF id" falls between the requested
number of VFs and the max_vfs, the driver will be dereferencing an invalid
pointer.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Venkat Devvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_sriov.c
index 60e2af8678bd..393cce3bf2fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -68,7 +68,7 @@ static int bnxt_vf_ndo_prep(struct bnxt *bp, int vf_id)
 		netdev_err(bp->dev, "vf ndo called though sriov is disabled\n");
 		return -EINVAL;
 	}
-	if (vf_id >=3D bp->pf.max_vfs) {
+	if (vf_id >=3D bp->pf.active_vfs) {
 		netdev_err(bp->dev, "Invalid VF id %d\n", vf_id);
 		return -EINVAL;
 	}
--=20
2.11.0
