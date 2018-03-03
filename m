Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118457-2-5031064710452175477
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
    t=1520118456; b=Wwu2aEyuMmoL5lofK53AjOhGiW5/KD7SWPlPwp1keQWLfEB
    4ukdlnf4BAszTbOuwbVS5zxfGmIorPl6SA93FxHaKRhm8MzYBNAdLn2+9KAIAUCz
    E5SuJMdcOmZ9E1vhX1EurDZQWvHwv5L9BfIB/I+uAPqJRI6xFvEfc2KExKu5Nazf
    PEGH39eHMKmfl9sxihNL4jNzy42z1TWBeqpZoGXdyly+mcrzeLO+sMIqmSRaNCtx
    c9MX0TCKz4CTSweOFBquL4gHPJ02LJTMLLaNfHrSTyy7n8g0yyh6kcYeRDZ5e3zu
    EM2l3TGx5pFFsgYIloVVvqhpD7HZCFHz1V4jlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118456; bh=PiFfw0
    o7fw3kzSPSSvsKsUyeqpz1e9VpZM928rzlOng=; b=qpbgeG1AP5UHcUMWLpG95c
    DUScI/gmp/y64y0edx1uWbiukJuTVw/bsEeuRB427BWgXBQ1fXf0fcAUR2ExQqoa
    5IlORCAPbhg91UOB/nzkOlTXdvEfJGimx4pg4oTts8Js2rDbcdbFIF6GrWSBp8+P
    3DU98qEa6U1/i9vPvlOJN48Co5m2xIz+QcAnfMQVECp8RS7ley8ksx2acEpuFln+
    3MOUzrzD+gusNLAlSxhyAyLbgZV1ldXAV8Y56Xog3h7i6Tx33UUA3RXgSBUSSa9q
    51Hj4PS2gfbwrqLV60pghb79mKDPEEsJqjysevq6xtF3C9cuR1ZJEjcd8FdboUyg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aHgwV63Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aHgwV63Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935164AbeCCXH0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:07:26 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935157AbeCCWkH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 072/115] md/raid6: Fix anomily when recovering
 a single device in RAID6.
Thread-Topic: [PATCH AUTOSEL for 4.4 072/115] md/raid6: Fix anomily when
 recovering a single device in RAID6.
Thread-Index: AQHTsz9gKSh91ooA6Eufhr23OMq8uA==
Date: Sat, 3 Mar 2018 22:31:31 +0000
Message-ID: <20180303223010.27106-72-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:tIjqSwONQ5IpNVK/Vzm2dREmbTQ/v8vhEYLFuotwR8NTHdkIHbjtJzkQWE9rfAtsWe/TvL9g7Vfj6Z8RTrdEAq7MhqvutHm2NxaI5O/BhBn731Y8R1eZAEhiWXfEF0FyBYWAy7uL6jSEjTQjS38cCy2FQIrm/5tXbhTRmbrZKU5/n3z9pqs/1cBYDzYK4PBIH2VBat3zX4qIPhEfedlqqox9x6SL9uCgfn4BYXo/FKlOs4UfOi3JSGJEBhN6K3r7dMvJqLlGeUr8uUe+3lgotLUYawrk51WIMgwvXiQti/B3BGZorChGjw/fouPUU/I51elCyjo1nEtLtdySVflG8287WYFcDbFvUWQRmQr7Jhs3F5NGcHhnIXD75wodPPTm;5:aEv09saWEJoy6Kf61hckL2RCLYofNLaWcZJgQX1806pzasbcbRkU3R1pemt+SJhqJ7U/tIMaghlUIYwUHvrbp+33zuel6xmZVIZ6HdftaEt8KcSvtu3hFaqS50gtWlWM3jPa6vYN+QZnCe6WleAsUNJE0WPop9Zw4ViGLXfj8YA=;24:ENH7zXumcEhv05k2w5dTlK/Hy+zyXcg7TSO568QAOjpKdaJXu6sg6z8X1UqTR1H+tDJSfvtKknnWV45MbHzdq2V7YBVIsZsUWNruh7kfi/I=;7:kTW6k8JktVxlQy4M2kEdfkzybO4Y8qvEQG+F+OGJCJ48upwjS4MT/5CpvxmSmIOBOSoHB4P89q/b68VXre693GByxKaq6V7Jgf83DDMIoPFoKbQEiWeeK1KAr2+TyeGFzpfGgKO2/7pOsmjrEDC/zlYnfdBpOXPN/lEgmdWfmlRiQi7wR0REllSIYHlDCxVO9mk4Z9H+86l/ismp14m60Zi2KLEKu4XBIeNhxNXtRXox1QufeO79oEoxBAM8QC1f
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6b25e31-bf2d-4dce-3296-08d58157b16a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103358EBDD61D0E37DE8A2D9FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: n3Ez/H9FJgyD/IYgTru6RlSsg/ohapkUYJFBnT/AtHs4M8BpYuv9GJtq3PbdCbu9d99Hm26N5k6dL0oNhmSYA2OsCO/1JF48BWCQJCC9boeAa2VKR2CkBQ6yYWe9Rzw8BWdvJG7ct2CPqZwgAMzIXw7Ov0QIlXoa93d+xAHAuDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b25e31-bf2d-4dce-3296-08d58157b16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:31.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit 7471fb77ce4dc4cb81291189947fcdf621a97987 ]

When recoverying a single missing/failed device in a RAID6,
those stripes where the Q block is on the missing device are
handled a bit differently.  In these cases it is easy to
check that the P block is correct, so we do.  This results
in the P block be destroy.  Consequently the P block needs
to be read a second time in order to compute Q.  This causes
lots of seeks and hurts performance.

It shouldn't be necessary to re-read P as it can be computed
from the DATA.  But we only compute blocks on missing
devices, since c337869d9501 ("md: do not compute parity
unless it is on a failed drive").

So relax the change made in that commit to allow computing
of the P block in a RAID6 which it is the only missing that
block.

This makes RAID6 recovery run much faster as the disk just
"before" the recovering device is no longer seeking
back-and-forth.

Reported-by-tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid5.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 86ab6d14d782..ca968c3f25c7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3372,9 +3372,20 @@ static int fetch_block(struct stripe_head *sh, struc=
t stripe_head_state *s,
 		BUG_ON(test_bit(R5_Wantcompute, &dev->flags));
 		BUG_ON(test_bit(R5_Wantread, &dev->flags));
 		BUG_ON(sh->batch_head);
+
+		/*
+		 * In the raid6 case if the only non-uptodate disk is P
+		 * then we already trusted P to compute the other failed
+		 * drives. It is safe to compute rather than re-read P.
+		 * In other cases we only compute blocks from failed
+		 * devices, otherwise check/repair might fail to detect
+		 * a real inconsistency.
+		 */
+
 		if ((s->uptodate =3D=3D disks - 1) &&
+		    ((sh->qd_idx >=3D 0 && sh->pd_idx =3D=3D disk_idx) ||
 		    (s->failed && (disk_idx =3D=3D s->failed_num[0] ||
-				   disk_idx =3D=3D s->failed_num[1]))) {
+				   disk_idx =3D=3D s->failed_num[1])))) {
 			/* have disk failed, and we're requested to fetch it;
 			 * do compute it
 			 */
--=20
2.14.1
