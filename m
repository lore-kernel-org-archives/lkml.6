Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120885-2-10729449751367817769
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
    t=1520120884; b=RC9SoJlJVqZkHVXqDNYHwObIdpbQuFADrS1w0jTn9fNgWW7
    RCEBF11Imf7srbiEZdIuk5m6i0/y0eq2EqAFRZ/yOjue88ECVe/Cf3vHXzHs50t7
    MUKG+RhsMUa6nDbEFYOY7GHy+YzfuGvN9Jk+SKBFSs2EegzT9JvmEv/9afWpGezV
    d7aCuNorpIPpW4yc4qvJTeSGm7tWZgr+TBxs3g8ktoWm6Ry9tmhTwUmfpAotB+2s
    6Fc7b4+iNzkMhPG2wEhLKrnSS6rnJIQMgYJ1HcUZMWgXM2YGIEpVpyYPbbpY6gSk
    TN1MG3bS6NCGuPyDmK18XDUuiqga0lcPBJEeP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120884; bh=OenLXc
    GcacL8VfFHStGZFFsnRp4AOG8OlEh8o8QaMVc=; b=Eer/ArwMkEEJb3PvfJ2g3O
    676hyfmPBjKU+eBEcEFaKgrsuGsOYs6EhYARbQu2CYD4OA9QjISsGDHdSUBOf3+u
    E87Xn/vdBuou2Z21aINAf9iPrCSN5EbRQ7PmqBE0lHW3VK6x4wwp6r3o6ND2b6/S
    FPCIcksfRFfRbTEG0MF8J47jgrRQPoBG/xdd+9zBYr/VQjUlI77LcLv9BUWGiQqA
    UcoS1yhEuzF7RGc8Wa71frd0V3+Qq7cYzLrNf47Cd7wLfHz+Y2g5gu9THDTWx/YH
    n6AkTQwK6pGMCQeP1RjTVQuCtKXxM+lwIHlX0tPvmRhNNAwR3dKgsraxoaJFSyuQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CTw3oCUk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CTw3oCUk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbeCCXsD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:48:03 -0500
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:3173
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934099AbeCCWeB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michal Kalderon <Michal.Kalderon@cavium.com>,
        Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 103/219] qed: Fix TM block ILT allocation
Thread-Topic: [PATCH AUTOSEL for 4.9 103/219] qed: Fix TM block ILT allocation
Thread-Index: AQHTsz8DR5ASA27e5E+1JlNKkiXTWQ==
Date: Sat, 3 Mar 2018 22:28:55 +0000
Message-ID: <20180303222716.26640-103-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:f+BmKKT17W2JWUFVLupze25yvgTZxpZYwZwv1HnbJpQu/LjcnZ1VbG1uCckhPUGQJlEZMZQAAWq/ll6RKjznZ30tKaFKb1vtPuTs+mOJhogo56Iho3UFi1VFk+x+kM2aUg+e9ZkjEPXe5FGZsrRdeo0yFyRv6SrJLF1KAJYpNDyqVPfQFGdVvLFgEuSID1RYQ3fvwDeDrAOHTUOLWISSZLMP4GA/+4CMXm7AOFNMvS0Q87gGxaxvFWrew0urHzBl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 739d1534-148d-474d-0893-08d58156da50
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106527DB31639000997003AEFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0C1oTNVk19SP04OgTLQlaVOjgJ+/c0cegSrPKS9Tuz5oF4cNFaB9rZrFW3zfF6rrxOJzD63SnMR/5wQwyL5xcx/tXB6WHiyTbIBHfmQbWGcGEB7M4asnP8zs4gc+qDH6RxfpdRq+9uSHLTvslczcDqUFUJIzxKR0X1UpcvW9Q34=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739d1534-148d-474d-0893-08d58156da50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:55.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit 44531ba45dbf3c23cc7ae0934ec9b33ef340ac56 ]

When configuring the HW timers block we should set the number of CIDs
up until the last CID that require timers, instead of only those CIDs
whose protocol needs timers support.

Today, the protocols that require HW timers' support have their CIDs
before any other protocol, but that would change in future [when we
add iWARP support].

Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 32 ++++++++++++++++++++++++---=
----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethern=
et/qlogic/qed/qed_cxt.c
index ed014bdbbabd..457e30427535 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -271,16 +271,34 @@ struct qed_tm_iids {
 	u32 per_vf_tids;
 };
=20
-static void qed_cxt_tm_iids(struct qed_cxt_mngr *p_mngr,
+static void qed_cxt_tm_iids(struct qed_hwfn *p_hwfn,
+			    struct qed_cxt_mngr *p_mngr,
 			    struct qed_tm_iids *iids)
 {
-	u32 i, j;
-
-	for (i =3D 0; i < MAX_CONN_TYPES; i++) {
+	bool tm_vf_required =3D false;
+	bool tm_required =3D false;
+	int i, j;
+
+	/* Timers is a special case -> we don't count how many cids require
+	 * timers but what's the max cid that will be used by the timer block.
+	 * therefore we traverse in reverse order, and once we hit a protocol
+	 * that requires the timers memory, we'll sum all the protocols up
+	 * to that one.
+	 */
+	for (i =3D MAX_CONN_TYPES - 1; i >=3D 0; i--) {
 		struct qed_conn_type_cfg *p_cfg =3D &p_mngr->conn_cfg[i];
=20
-		if (tm_cid_proto(i)) {
+		if (tm_cid_proto(i) || tm_required) {
+			if (p_cfg->cid_count)
+				tm_required =3D true;
+
 			iids->pf_cids +=3D p_cfg->cid_count;
+		}
+
+		if (tm_cid_proto(i) || tm_vf_required) {
+			if (p_cfg->cids_per_vf)
+				tm_vf_required =3D true;
+
 			iids->per_vf_cids +=3D p_cfg->cids_per_vf;
 		}
 	}
@@ -696,7 +714,7 @@ int qed_cxt_cfg_ilt_compute(struct qed_hwfn *p_hwfn)
=20
 	/* TM PF */
 	p_cli =3D &p_mngr->clients[ILT_CLI_TM];
-	qed_cxt_tm_iids(p_mngr, &tm_iids);
+	qed_cxt_tm_iids(p_hwfn, p_mngr, &tm_iids);
 	total =3D tm_iids.pf_cids + tm_iids.pf_tids_total;
 	if (total) {
 		p_blk =3D &p_cli->pf_blks[0];
@@ -1591,7 +1609,7 @@ static void qed_tm_init_pf(struct qed_hwfn *p_hwfn)
 	u8 i;
=20
 	memset(&tm_iids, 0, sizeof(tm_iids));
-	qed_cxt_tm_iids(p_mngr, &tm_iids);
+	qed_cxt_tm_iids(p_hwfn, p_mngr, &tm_iids);
=20
 	/* @@@TBD No pre-scan for now */
=20
--=20
2.14.1
