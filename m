Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517681991-2-16395733285879698330
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
    t=1517681991; b=GvkokAbCzBh+EQVPydje7L80F1Aq5crdevr6hXc5S6Kbw9+
    7oyi9ZR/jZVRfU7nwJCShkVNQg/urrMlbQi/HGdHKZu5YKiwjGyQe++OUwSt7qfX
    GrvOYxXs1Y4g1PdEGoBsP75LW4TQH93aRzQo2K8BWuqm8GcB9VuVecIMFNwZW27p
    CoNQ07dHvaWQs2+wv0oJn+TSuRMW5OVLQjPPqAaLf9Lv5pIxozmVZs+d7OSWzj6I
    cb3fngSdcxVADbm97HB/1F8Szcszs/3RWUDieMz/oBdfAdWtkDYFwplQ3W7B33ff
    Zxlxm961RpR4TsHF+LoQpywjpq/diosGA3fLg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681991; bh=Z7nMv5
    uawfKTyG5lhYxGDfdJtvN9XueixcjmhGJkda4=; b=H1zA9q+88LwLsp7oxsxFSE
    guoDdw54RfpnyzacyD9eC8ukMLq5MxNYWXwZl0RDnvilU+o6bJA7P21nc4RdkPyJ
    u0UQzBe3ASU7Y0vlhu7YVpJ7kzC/9GotqLJJKogiu5Hzhxt8TgO1SmacP/RuP40M
    fyTOAlsb1T8DJlMktc8+0rIUbI+2sn7LPY0uTlUUslqwAb64S/99fPOAUyc0n70n
    mQSbG9bsGtrWCXVFTp7fWkZVU2s0bmdQNuMxGjfl+ewWxfEU/wT0S3I7e94bDc3f
    EbzBceTTeEMrrHRvBc5Txj3YmifBD3YIbDvKyhCm2cg5kOGv7AYz6cQfAdatlNlA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kELdYUNd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kELdYUNd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeBCSTt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:19:49 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:42587
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753491AbeBCSGt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 25/32] bnxt_en: Fix the 'Invalid VF' id check
 in bnxt_vf_ndo_prep routine.
Thread-Topic: [PATCH AUTOSEL for 4.4 25/32] bnxt_en: Fix the 'Invalid VF' id
 check in bnxt_vf_ndo_prep routine.
Thread-Index: AQHTnRl0gXN4xYWxGUmefC865E2nEA==
Date: Sat, 3 Feb 2018 18:04:37 +0000
Message-ID: <20180203180413.7438-25-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:xT/dhEuhATB0m9gVPxfuz6PcreMIN5btG39pCcIvflXKWGGsDrMJlDzivxxTSoSzcZDSCdhTxURpqxS0vgxrDK9BOjLMG7P4BYDNahXKqiRc98xV8ACJUxF7M/pAlzCE4ua8QlD0yD7het/UcoQv0vz95gZV2XxtEpK7WYlJ7QEbQ9nlN/OlaCL4bFll7ojSe52pn8IQX6BTwGmYUVZgpdkdMxXj4SZcn0gXQo+aOOZTn31wu+RGuABFEiWWFBj8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b24d0869-4205-46ac-87a3-08d56b30c6d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009237E0F2A1D75A4B99EF6FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 1KHZWP7NXzh3/FL5dBJZLQJW1PQ9lRsTEZ4b998usvcJResY+LWHaIzHGD/J3X8G2+xwLvC6qlZnBbztoiPC6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d0869-4205-46ac-87a3-08d56b30c6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:37.7839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index ea044bbcd384..3eebb57975e3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -29,7 +29,7 @@ static int bnxt_vf_ndo_prep(struct bnxt *bp, int vf_id)
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
