Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235528-2-1143557806558560469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235527; b=sIjRv8h6oNqwOCUUgwCEaqjZkex2Ru4YHi144pOq73bHuPKqB8
    hg/Uy+eVjIhg/LqrpxlaYV2xdX9xL0kOtbbmmLcpEJhRLGt3CIIUoE+5kmO/hQke
    vyrRaLE0vchcxgSjU1ow0ONXVvuloparPTPK4PDTZ7h9IdhRW9xCheeNQkBXLxN6
    M/SqGezzZbsRMa5U4TS7XordML19mkpJtRf9xhRdB5/mPR5cVelZGBgqoFmiY0nd
    J4GvYI3fLHE7vaL3PUkpRqDnFHCAAsNbmgrdBDGyclVPUXnxpDB4nLRvBgN2jcxM
    zeocOsEdQEgInNsm8/E5PkUzgSYMFv9TiG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235527; bh=f6GqWJMRF0
    xisDlyX4PaU2h8wnKyjBFQ0QCFyR2r0vw=; b=oiu5Kzh/wut77a2mRXjSqfO+tU
    ywGQbyI11ZOMRj4Dos+tFIKLMebRuQDVQSDajrEdpx1L4kEYrpxoGDW1XJZPv+RI
    LjGwe3ajlKFUxPpxdCgbKf3OfWxxf0U68q7vGk7hVEBre9a8XVDLHAmM8lxFJple
    EatuvCcKLzLz2GRTxthWs2ZImt1/BZ9pghyDXyzIU8yXjo+h7wl5jnoyWj2qQPK1
    63pSO/oqfhaAZLoHlqG+ZO6Q6bYHaVagh5QbC4UB/EhVYFLwxh153Hx6ormlJIix
    W8UydNJwlOGObSORLL3TItMaJHDG3mciI5FT9XM7yOcsibjtaTgMohvbvylw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ED0OiIPW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ED0OiIPW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGl2rE4+xjuKO/D5RqGw6pV3k9v1fNBwumzlTsnr0n43xVUUV2G0qGoDP676bn89s3s+E7EuAKscQDDuoHYjWIR/vlonrrV1+7mtUqo8zV1U8Lums2/t
    naS3VauUq/tbxwRhZXaIY32E0kVIqdY70IriJHoqADL38DGNZ2c6WBDHLUvMNNOAP9shH0kT5EfWGkWEr7GPGmIU49siBw0QH5sbKsZTsij3Zn9wpJWyraMS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=A7XncKjpAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=z3f_M_gtP8hYPzda5ocA:9
    a=9clCeZIcQEAr2j8t:21 a=wundv0GXn1DO6M88:21 a=wPNLvfGTeEIA:10
    a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeDIA6m (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:58:42 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933114AbeDIAjq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: WANG Cong <xiyou.wangcong@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 030/101] net_sched: move tcf_lock down after
 gen_replace_estimator()
Thread-Topic: [PATCH AUTOSEL for 3.18 030/101] net_sched: move tcf_lock down
 after gen_replace_estimator()
Thread-Index: AQHTz5qvHUZUEoOSLUuE6GzrVx027Q==
Date: Mon, 9 Apr 2018 00:35:39 +0000
Message-ID: <20180409003505.164715-30-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:Y1ETqQw2f9TtqRMcNomXBFwhNDCuCoU4zaGwC07vye1YyAcCpl1lqyiBJqKfg4Dna1Z8z3sO/si9U837R+8hNAZVpkD0jAMjnd6jlF7ZC/jBtn1FIyxjQ07cPwBhLrUT647MAUe+JRIVlB+wiaRMzAOi1xJMrNIPWAC/SudIfGDhtrzFWYkBSnMNjV/wh0zIOKtH/WGx6AJ1MJUMtUn56/1Xgqj7bOZFKx0LqRFuLPIWdPHMieW7al+Jfj3Jm7Oh;20:8Ol/i/+bQR+avR8IKxLvKkcIlfH3EJQkqxzKoLACGrJtVCVW66peJghIAcJVrFvUXJQBC+hO/aJ8ICx0P7wI7+udXnDphZsU78MMjVpYHmsD+pxhjrXpIbJNu3wDAHq0+06fGlo8fhsWk0Gutd+RPrmM0dPo3PMLPqiQYhhbFqI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29f61235-0510-4262-841f-08d59db26355
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966180DDC6B6C1FF588DA56FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: k1bGF2YS0jKrNptFrgkDjGDJU3KTXHEhMynTFH+eYfrNwNmJi1niN6k9av25MW3T/PnloltJ10LT1EzEjWbIrTI3GOIwTYcpuvdKwKsK1g/EvvlsVgasRxndJImiLfMK5u4AzQlOnIbpVbkFzltRyrGY5F1B/WISOXu6qqU69njCrfSLW0IO1gewgi67fkjG/lC+r8/ffd9cIMe3ZnwVVNeRrc+CGvjRoz7zyDL95dlH4Ygdd2HCqS9BsMAegCuwCbZceyHGiEcq7hPpMgkhCzfLVBhct8ndMaJOod4GIinPqVp4hsWu14prIU1H7OMy6RzDikyBiWeumtE6nQMAVo13Ko3Znel2veXdFoVygjCdj5YsBcqvN0ruWjvt3eshrVZcBOMEBbrOqeKtgMLzb98X2LdAQaL2z4E4+JHBdAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f61235-0510-4262-841f-08d59db26355
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:39.3454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 69791ca77a05..1a25d25b9a56 100644
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
