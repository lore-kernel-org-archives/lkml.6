Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233718-2-10718465133356925816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233717; b=RPs0Qxs8fmf732WMUhnPhzo1c4XwNqm3rX9E9qEpm+76x6HcrQ
    4tq3/bdvX1M6O1iCEyFBc4D4b/kJZC7WNlfS6j8gUmwKLZ5Vyuj8IVRcI6/n1GQM
    90YGDhSaGIHyoz3+UeDICDpqYCtfOUgwxu/+FZMbghDUyuXqRpl2R6/BdrmWGc4G
    OVgh1nyZzRRY9ayjG0ImPOmdnm4LR7RzflBz2CxaQeN+6cNqrwUDFxx0E8C7euyX
    e3Vktv8PCGDNPu5uj1Ve6+SwMSfS99w9ZMJrJ/BeXmIwxVrYoGH5FMwjzrmql5I7
    7JJ8tAzPDRkHXEIpxKFCI3ef0u0kaPYrxzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233717; bh=IQ8HoETNxV
    G1yw+ePtUCXtzJNNkTh3dkiyBt0d54kXI=; b=r3jexXZeQg0O9VNvgiGt+l/vXa
    /gPp9PdKc9yAzhgKldYPPmTRpzBpxvB8mF2LL9E2B0fbbQlRXf9xXEFcyhFKFRvQ
    5G5MefxIsVm6JtL/vX4OzzwzUvHBh8w1QjObPc5jM8RxMrWHUx8bfCpe6E1EALi9
    rF774SqsKOka9qDhz0U4eJGp1eX+y6ESSe1/JwPUgNLiYb1ywD5HMTKp8eBVQtt4
    y7d/3r8Pk26BJ50c7Hjbgh0/zP6yBevdwSdS278OafFWTEt7a0M5S3LBOWW/I7JA
    6nrZVPSkSaN/Ys2CSH4HOiyyzgW3kb/12gQp0bpFqlwBFIbsoHfU8u6C/XyQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k4rmkTZU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k4rmkTZU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC/KKZ+9kyUAwCNVBN84ZveCUVmLNN2qs88mNwQ0gpkVuwjn3PaQ99p9UxCuzGVPtJTs/8tUIlWioxtxSQI6WiN4Jnpf3coJinrFx5sdlFUHOmmT59pL
    shDGOpbtvWcfVCldSfEIymwnXgqq6dmonS7mky6pZ3/b1NfNccg6wD5ERx4USm+oIFvm8/43AGy3Je5f7kgS/I6eN8plvLNbGOkvQox5k1dDG50hkPEk6O+Z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=A7XncKjpAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=dlZJRZMykRr5UMNJ7lEA:9
    a=a_uV3PB7bDQM4cAx:21 a=rRzT_d6aB79yKkMd:21 a=wPNLvfGTeEIA:10
    a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeDIA2f (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:35 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755812AbeDIA23 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: WANG Cong <xiyou.wangcong@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 073/293] net_sched: move tcf_lock down after
 gen_replace_estimator()
Thread-Topic: [PATCH AUTOSEL for 4.9 073/293] net_sched: move tcf_lock down
 after gen_replace_estimator()
Thread-Index: AQHTz5kI5bHtrvQjqUOFH/ek0xZDHw==
Date: Mon, 9 Apr 2018 00:23:51 +0000
Message-ID: <20180409002239.163177-73-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:D/tRZAlVNf8bonJJUqS6Df88p/5NtM66rOAIkNjfWx+3V9LyYPIQcVUXs04tfJv8fhjCk8KJLC9H6vecbUlK8sGhGrJQ3DgpkFbDBvcwpISgufWTDWQI5/EfMyjMhqM/87UyCo/NzSHosDnmfGbyeiDNeGKeS3KqHtfR1YoEJqfIcetwu3U413aOYDDOuYuI4KWxmC2bNNOeWfobgAsFsxZniW0TpXUVcZyicsV2x8PIk1FQQPjGLkI/dahAUku6;20:v52Rklh3Zu5KqyLumW/aXHJ2vbtwVkSXRYocE9tw90SAygjs0+S0vI/uICowYgQL4K2EQ6XAj45N3ODLesSuETHiuRPRHkBrzYRI9FYlUCDlCLF/RhSZYvFTI+yBa62BvnukaqykPNS95gP2M15QOizXVeWWVCAyoUIHK8Zu2rQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7edc1f60-dadf-4714-fd6f-08d59db0d00d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08074DFE9E76A7FDD729F403FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +TYQNrUg+AmFvtSiCwxnDgrcUfD14O3zp7Kqk+N5qsxPdVtwsdtGzLQFWHTAj8sll05dcbnyM7mAnxpnumfWOdlmG7gcm4C7m2QOuT8Khjfr6KKkPtRWD56gdU1Q7J5DhPdyq+b8bMnzU2pFNewR6rppJgLll8TdE0u7CHRBUep4WFdINOXFi2rUEeIl2s8xRBQ5klbHa+hRB8DYrtTMBp5q5SPsJN3oI+9sfDzTBdmpjWygyeLaqzv2YWE+wGY4JSPn/pX1QUNKxpSSOcZNIUmL8cyv0OBFQcJsMQKtFSGJg7mVu2YUDyCDV4jQKXtgmU3NS1zLHXgFFZJBXgq3SeKeLF+MHvsQJ/xNb6LIKKYocKtOh+M/eJaUCxA02akFHOdDUahQg6FUG5p9yZa7Pao+2k0KHwj8pFy4oExvJgQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edc1f60-dadf-4714-fd6f-08d59db0d00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:51.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index d1bd248fe146..ca30796290aa 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -132,22 +132,22 @@ static int tcf_act_police_init(struct net *net, struc=
t nlattr *nla,
 		}
 	}
=20
-	spin_lock_bh(&police->tcf_lock);
 	if (est) {
 		err =3D gen_replace_estimator(&police->tcf_bstats, NULL,
 					    &police->tcf_rate_est,
 					    &police->tcf_lock,
 					    NULL, est);
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
@@ -193,8 +193,6 @@ static int tcf_act_police_init(struct net *net, struct =
nlattr *nla,
=20
 	return ret;
=20
-failure_unlock:
-	spin_unlock_bh(&police->tcf_lock);
 failure:
 	qdisc_put_rtab(P_tab);
 	qdisc_put_rtab(R_tab);
--=20
2.15.1
