Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237495-2-13850489527188351253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237494; b=jSqwj1gMDBTKA6yPtEuW0iE8p6Z4wyfczTP8ftGMwegwUeNv2N
    NqVkzeTyFe72zDcW1Ojulr1tlCIFaOMqmOzEAwHCn5AkzOdVXfj3+X8yAaDowRnW
    +gmrg9useic2bjz95RC8l8x7N8caaUAwp0CyddjIAZJr2vhsx+K0W5tUUI+/de3X
    0VEcwjOaKpch7n5z4JhEHorVGwqwwqeo7ncsqELJq5U/v6/bewozi3WtjAiJTW8h
    wGqfdLV5vcGP9mRc0XuvArc+UW2EttrWpog9o6AlKORfMjDYRQl5EifXIMNoOQf1
    ldOp5KF3BLMhpcCFCYNNaF9wrL0zA/0v+ybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237494; bh=KPvitYgRTf
    DxRC4c00daEa2K24NPjCM+ZbvYM5vEb5o=; b=S25Jw8b6nAhEX9Fqilv8ACTfP0
    3jGmuBhcn/uUQ8yGONOuylMhBp3c0Fc/3hRGujDrBPldDX65x+yxeRxjUJXYtid2
    FAuPVNmgct93aqFFcc0SaUUf8qlNdx7BeiVHAqgkukih6yRERNtOMJSvYF8J77IM
    1Cu8UmTaoTfgbJBK4W0z/s0fHFMWiZ5pa/Kf24GWuHT6W8C7iVEaeUV6A/dRl861
    QP0L8dt3QTyGqO8YsXgtNcJDt+/X3Y3NPLj3CPZArsJt8D8r4PViocGApBkwbw5F
    BKLAY6Sq4ilFbFrM5Wd3HuLu7ClCQB9qdHecd26DbEYXruoXlK/3IepCVmdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AyrCbytQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AyrCbytQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGAfiX9r0IXfAFkn/kRsE6rwv8bY/ocOMbNIR/K1XIS/Jkn5+T/qqSAOCqKih3XAUo70Owt3CT3Mx1QILUFeS5i9LV5Ifnwwgu47iZRtCMboJSmq2SXi
    5Nkmc8ycaZ2uQr7UpkUcBHud03p/Cu+ftZRkyg6WLUaPv5iE7Sc4DjG3N69PhpbgyJCcfIRU/9P7chd94o9sbyw+B43oUe2OT8mMZsdVrZoDNDVHSLRTK9go
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=A7XncKjpAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=z3f_M_gtP8hYPzda5ocA:9
    a=9clCeZIcQEAr2j8t:21 a=wundv0GXn1DO6M88:21 a=wPNLvfGTeEIA:10
    a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756609AbeDIAfw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:52 -0400
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com ([104.47.36.132]:23728
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756582AbeDIAfu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: WANG Cong <xiyou.wangcong@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 037/162] net_sched: move tcf_lock down after
 gen_replace_estimator()
Thread-Topic: [PATCH AUTOSEL for 4.4 037/162] net_sched: move tcf_lock down
 after gen_replace_estimator()
Thread-Index: AQHTz5miuaCuWeEJn0uVCVgg++Kt7w==
Date: Mon, 9 Apr 2018 00:28:09 +0000
Message-ID: <20180409002738.163941-37-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:4r4ud/I0LJN2PRnyLZRCipejXYA+40Suni7uotL51RgxPg9bvdxzxWIco+wqlL/gEEWvME/IgcEsh8gjwOqJd5puguBmZ3uGhF2z97fipGSwWslHteak5xngs0MnOPtvvF0DjOS7yX3PIUmjxIsjFPKjFIKcVGrtR2UNFqwByTS4BY1uSEKVLJKIQLLTcgbHof3itGVmRiIKHBbiECm2j36W+mu/Xh0IuDgvcQWwdfIwFp2UfFxjvXpnyv8abQnt;20:3Sdxwe+jfkYboHllrg0f5YAbrVo7NOE2BUMP3bb7LyNH5lA5wCVFkMNH62VqYel7/8J5/YOP1XWOOWlzYVqfbuIhSD7ILw1JrkOZTGAdr8NyLq0buV1J6sEZ45oPOMCzcGwa8/EpDipwI3IE1CN0UDmg62dUIGOYYGGBw8yYEOE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b7f32a2-4131-407c-e8af-08d59db1d635
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725E252EAA7E1F068AA6045FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(39060400002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gkJbZ1J8aZaRNuRtY0cVIEbA8hkUdfXrDWA28u4FXOLzFGOc6WdlvazIx5tr/lzuJ7vtKKoAp5W8lJ9siu9lc/w9/1k/ymy01d+U39G/Il3/PX28ZdpCn61G9+cucH/6WZhWaXEyxFsl9yr7pH7cdhCgGG1ejorLlNgcf2rDQU9KeLGwr5Zf6bgIw1KCopPizCBQmBckwQm/ZpdDlHl55fRwPjkm2GQM3TKOdFl4VasDQYSiO6ReQ+cAzVTbJrQt6LedASmsAknv7vBnXfouz11f03smtTJU4wWgmpBRoLlA93o4SipI9F56uoy6+wsBYiC8oVvceaaK6hDQDxzZgTUIvipX2Bkt83jY9YS9uZzauSYov9JtiqihGceNCicEpuDZ98svOsgrq6fzHkp+7F6HToqk7pyiwuSWY99xR7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7f32a2-4131-407c-e8af-08d59db1d635
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:09.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: WANG Cong <xiyou.wangcong@gmail.com>

[ Upstream commit 74030603dfd9f76c0f279f19f1dd1ee3028fee7a ]

Laura reported a sleep-in-atomic kernel warning inside
tcf_act_police_init() which calls gen_replace_estimator() with
spinlock protection.

It is not necessary in this case, we already have RTNL lock here
so it is enough to protect concurrent writers. For the reader,
i.e. tcf_act_police(), it needs to make decision based on this
rate estimator, in the worst case we drop more/less packets than
necessary while changing the rate in parallel, it is still acceptable.

Reported-by: Laura Abbott <labbott@redhat.com>
Reported-by: Nick Huber <nicholashuber@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sched/act_police.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 9a1c42a43f92..c5d5650fd14b 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -176,21 +176,21 @@ override:
 		}
 	}
=20
-	spin_lock_bh(&police->tcf_lock);
 	if (est) {
 		err =3D gen_replace_estimator(&police->tcf_bstats, NULL,
 					    &police->tcf_rate_est,
 					    &police->tcf_lock, est);
 		if (err)
-			goto failure_unlock;
+			goto failure;
 	} else if (tb[TCA_POLICE_AVRATE] &&
 		   (ret =3D=3D ACT_P_CREATED ||
 		    !gen_estimator_active(&police->tcf_bstats,
 					  &police->tcf_rate_est))) {
 		err =3D -EINVAL;
-		goto failure_unlock;
+		goto failure;
 	}
=20
+	spin_lock_bh(&police->tcf_lock);
 	/* No failure allowed after this point */
 	police->tcfp_mtu =3D parm->mtu;
 	if (police->tcfp_mtu =3D=3D 0) {
@@ -242,8 +242,6 @@ override:
 	a->priv =3D police;
 	return ret;
=20
-failure_unlock:
-	spin_unlock_bh(&police->tcf_lock);
 failure:
 	qdisc_put_rtab(P_tab);
 	qdisc_put_rtab(R_tab);
--=20
2.15.1
