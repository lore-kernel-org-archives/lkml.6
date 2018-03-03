Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121577-2-14773411172091764208
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
    t=1520121576; b=RT+2SN5T6X8Ry+v2qZQWdd85odxkiApwwSUBs1ag4M9Fx2v
    tgTy6utg0eUgbGH8Wyj1Yxi3eKfx4EPR8UWAl1VRORy/UwQZ6JPZ+3PMelRRIwCH
    u6iWQojuf9XUNeJYCbJh9ACQ1zARhsv253KvG/6S9GVpSG6SRW5Kise475iJLcKa
    o/bCpg3W00xzzVAzUOhf2Fe4WZlqY+NQPmR/GPMxeTQHP/1wBvZMUeZ5+H/MHFcp
    6R9sFRnejvSzlfmGAAifTF3sQAKMMzZk1KTcDvfJh7f7P3zH4lft6837i57nE5Vf
    s4AVMXDsFaQjRzqJbwScl+FyorviadSryMxNSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121576; bh=FjsNv9
    YhBzwZyAwOmb7UPAbobp0C/yueQLtt7adn6Pk=; b=VJVr5kclhSSxgF6RbfU1JB
    nsTM1Fqzjvqe3ycCRFRzrwIdKNSGvsw9YMvFJwZmkVXfwppZtVGpIUnXq7mxqzp0
    /rT3FL4iuX25el9Z6kyB7iHEOVjydsswg0K1Ko97mZxlXia5H9wEzGuqbC/id5Mc
    uoRFzToyZC/tM6zWShaNneBDYXa4RZ4W4ES/DrhofUo9Icv2pYkGXsgT2gf5k8ib
    +vMGKv1gqJOHLK4XtPhNZFc0OTeuvZ/sKGu4qX45C669KWyV3AjZv4cDS35v1AAJ
    s6PR/BNPC8L4WrveZWbGeM3t8UJitSD94qdeGOuMzmFv8GAL55vj0Pr47Uiah2mw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kbc8wQ38 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kbc8wQ38 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCCX7H (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:59:07 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933264AbeCCWcN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 048/219] qed: Always publish VF link from
 leading hwfn
Thread-Topic: [PATCH AUTOSEL for 4.9 048/219] qed: Always publish VF link from
 leading hwfn
Thread-Index: AQHTsz7xTxUqMr6B/kC9VkIhaB9ZpQ==
Date: Sat, 3 Mar 2018 22:28:23 +0000
Message-ID: <20180303222716.26640-48-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:PnL3YDVhf6ISCuqCfRnUkNbzqpjwMQwQpQ1zEv4SO/2Wu0KS3fgSoLRNsu5z+8RopiVAvPsO7NGpzPXnZDFwHyOKrCoAuyQjTtCI9APpib0Z/4sTm0ttbXNyPXMOicyuXPbtDCh9MHakIeaBaBM43TpXSZmdjvda8VrUq5k4pHeTpFaSTd9sIO4EF1s7IR+dCTqgBaIukwUQK381lz1FvnkRHVtD1bvM05JU2QL5LgSIbkPzQf4s62uAaIIvbihu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eac11b64-1b73-4b24-f7fe-08d581569bad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036C69657B32BB34AE209A1FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GWg4n4GYDtdoxecM/ZsWWWODrQ0XfS5jQE7WOcBHBJUzfz2xvBE9723Tw+crUqxalNO3MGnkMARit2U7lyxkE6R2COFVH82jK3JD5iOzdqJbMqpM4CuVRMzUINPnJlpoQ+CfSscpk6jqYpGRsWvh/RKtHAtERiPynbjx/PGLCnY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac11b64-1b73-4b24-f7fe-08d581569bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:23.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

[ Upstream commit e50728effe1126eae39445ba144078b1305b7047 ]

The link information exists only on the leading hwfn,
but some of its derivatives [e.g., min/max rate] need to
be configured for each hwfn.
When re-basing the VF link view, use the leading hwfn
information as basis for all existing hwfns to allow
said configurations to stick.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethe=
rnet/qlogic/qed/qed_sriov.c
index d2d6621fe0e5..48bc5c151336 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -3573,6 +3573,7 @@ static int qed_get_vf_config(struct qed_dev *cdev,
=20
 void qed_inform_vf_link_state(struct qed_hwfn *hwfn)
 {
+	struct qed_hwfn *lead_hwfn =3D QED_LEADING_HWFN(hwfn->cdev);
 	struct qed_mcp_link_capabilities caps;
 	struct qed_mcp_link_params params;
 	struct qed_mcp_link_state link;
@@ -3589,9 +3590,15 @@ void qed_inform_vf_link_state(struct qed_hwfn *hwfn)
 		if (!vf_info)
 			continue;
=20
-		memcpy(&params, qed_mcp_get_link_params(hwfn), sizeof(params));
-		memcpy(&link, qed_mcp_get_link_state(hwfn), sizeof(link));
-		memcpy(&caps, qed_mcp_get_link_capabilities(hwfn),
+		/* Only hwfn0 is actually interested in the link speed.
+		 * But since only it would receive an MFW indication of link,
+		 * need to take configuration from it - otherwise things like
+		 * rate limiting for hwfn1 VF would not work.
+		 */
+		memcpy(&params, qed_mcp_get_link_params(lead_hwfn),
+		       sizeof(params));
+		memcpy(&link, qed_mcp_get_link_state(lead_hwfn), sizeof(link));
+		memcpy(&caps, qed_mcp_get_link_capabilities(lead_hwfn),
 		       sizeof(caps));
=20
 		/* Modify link according to the VF's configured link state */
--=20
2.14.1
