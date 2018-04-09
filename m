Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238064-2-18433467494501922963
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
    1523238063; b=gcLEQ9zLuKII6zBtSgbAax1KQSMPFWMkw8ZJvXAxZwjmiUYBIC
    IulSNrGQjgFAlTwYGlpj58pDJ8qjXhjQMEMGYIs+anBcgBS39Ouu3WnkHWcK6AKl
    p0MLvmjtgBLDvV9NwzrfToA2iZrbuxkZv1UAf7Zu1o/KIoVtsw1A2ZNJhqbf9Ta0
    2s6GG80xCLjPWSXjBT9ogEVzGPcGPpKJfMXvvLABWVUue6+H8UcVmsyIGMqkZdmQ
    npL4ZJYVObg2UCSGlKV7RLhsaXoFBMqsN3YcPzQkUk4FZFomHiX/dDQ2NNhC+l2d
    rb9PGiQgbO8wMXnbK/TGb+2CIS7PZySDPn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238063; bh=RyXMgCUzfB
    D9VWIyYNj1J/MrhGAazEZ0UppUpOvheHU=; b=Xmcy8MdoHL2Qs0125k5GJoXN9J
    gx2DFAsVejm2reDZ+KYOsbgcyOACAUemw/SJurnsmfEkX7cJiD7fb3XLZyUyJTHh
    0Az/xPb7+tcdw1Yx6vKBKaT4dObmAB8MmOCPTdL4Cb36GeMFVI343vDGfAYTRXOM
    NdqcWxGgQAGL0kqXAaHrAPSfFVpZuTPyLAcR9Ejs0PwURrkcfZODWCAjvzRoJ6l2
    /Q9udoEzpEJOFf8+jk0B2DdY5UakMbnbeterHrRJs/OxkeOyJlC1wynavz74M5sl
    yNIxsypiZ3N1SYr13OQUqaJoAXHDzeCs3tV3Xw59aQXKdicRTyZLeStG+nuA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JSsWSeVZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JSsWSeVZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMufGToPkORilqrvIF5DphjRF6JZZ8j49Vc27szdMo5i6xOJX3XFpuGHJ9B5ZM6bQA6GP0dbgjThQ4uiXE5YJSQBbYAoHNScL06QHXFV7YwF8s1aUdFJ
    MV6hBuMD1VFIKAgcYe9vXkrzClJMq1L+utUrwxT71xVCxiFq3vCeXlYqjz96y+AufO380CS8K08CXnCCyRp2a8F9YRx7Of3lyMsDMllKJF31jZCmYkHNM8jz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=L-5fpCUWJdCBqBJfpMEA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeDIBkr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:40:47 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932536AbeDIAe6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 008/162] rcu: Make synchronize_rcu_mult()
 check for duplicates
Thread-Topic: [PATCH AUTOSEL for 4.4 008/162] rcu: Make synchronize_rcu_mult()
 check for duplicates
Thread-Index: AQHTz5mWDzgG3nSpl0uHhynD/HCkPA==
Date: Mon, 9 Apr 2018 00:27:48 +0000
Message-ID: <20180409002738.163941-8-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:AngtjdLtZXL1XeO3PdhD8KgZfwCJ3fJvSHd9KQjGcej0ETw0biv+jWOi/oSk5WshNBS+dihmIwRBdSlLvFQQ+ktBbpl7w+waompdl52psnsjzWThCwJeB4IKiz/QIA1pKpSQS+FB6WUwrzsEDByjOWC8+y4QatCvp7WKFtNij/vuKZTQ5rnj50jV+h023MbrP6adHwv/kww2V+sq1LtzqmIjUVNUoSmHTABKi58Laa8qMNpi4745dzwHBJ4Scts8;20:SExEELf3hpP97MdxQttdNsVuBEYtfP1MRFwhwdU1UkQEcOyyZdJNoUc/hgWABnsGfn9zfNXyWWoSPs5dHz2eUfkwWg1QP3gTYtC04ar/xNI9tgScTMhaMOYlvxdt4H6Nn2Y0Yampzu5OMglbnc+Wv2L6YUFUQqcIGj3mzeOjWWc=
X-MS-Office365-Filtering-Correlation-Id: 7b921443-7a19-448b-7774-08d59db1b6ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10130B59E10387C615685D04FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(575784001)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ngD9JDU7aAjLjNZ5LBIvsIzjXsh6uUcD90OlIPAMBBnpDDipVK57rf9bX+9S9O2R38vTUshwj6Yllfm7PERzScq694+QYtilaLitRjWxo2FKquM5C1IPNLV4JWVuwWYeRTVkTATcYBglqBKyWzT05cQqpRRneZ5oCEvucyHjDas3oURxjBKYDKbw7n6OI4fL30OnP8AUDucchtraLdZJlYN+C/rdmJPo+dt9KajKM6N0oSRT5RWkxMoJvod3MfQcHysZ9ybk/FnlPawzpbOhm/BdfLwmZnLXJ6B0OmlfNJmwOubdFISCCyrJ2H/LxEaYnxqQSus5AnNmH379UcQ1qXqrOd8jgOiNMcXJ9eKL6O6fpEFcOSNuh31VFo4MXIsn57nxgYo8FMFBPXw0SeG2jbutVPFQeZO3LgwId7Losow=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b921443-7a19-448b-7774-08d59db1b6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:48.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit 68ab0b4263224157f4d0c0e42854169a183d7534 ]

Currently, doing synchronize_rcu_mult(call_rcu, call_rcu) might
(or might not) wait for two RCU grace periods.  One approach is
of course "don't do that!", but in CONFIG_PREEMPT=3Dn kernels,
synchronize_rcu_mult(call_rcu, call_rcu_sched) does exactly that.
This results in an ugly #ifdef in sched_cpu_deactivate().

This commit therefore makes __wait_rcu_gp() check for duplicates,
which in turn allows duplicates to be passed to synchronize_rcu_mult()
without risk of waiting twice on the same type of grace period.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/rcu/update.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 5f748c5a40f0..d98acb903325 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -324,6 +324,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func=
_t *crcu_array,
 		   struct rcu_synchronize *rs_array)
 {
 	int i;
+	int j;
=20
 	/* Initialize and register callbacks for each flavor specified. */
 	for (i =3D 0; i < n; i++) {
@@ -335,7 +336,11 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_fun=
c_t *crcu_array,
 		}
 		init_rcu_head_on_stack(&rs_array[i].head);
 		init_completion(&rs_array[i].completion);
-		(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		for (j =3D 0; j < i; j++)
+			if (crcu_array[j] =3D=3D crcu_array[i])
+				break;
+		if (j =3D=3D i)
+			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
 	}
=20
 	/* Wait for all callbacks to be invoked. */
@@ -344,7 +349,11 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_fun=
c_t *crcu_array,
 		    (crcu_array[i] =3D=3D call_rcu ||
 		     crcu_array[i] =3D=3D call_rcu_bh))
 			continue;
-		wait_for_completion(&rs_array[i].completion);
+		for (j =3D 0; j < i; j++)
+			if (crcu_array[j] =3D=3D crcu_array[i])
+				break;
+		if (j =3D=3D i)
+			wait_for_completion(&rs_array[i].completion);
 		destroy_rcu_head_on_stack(&rs_array[i].head);
 	}
 }
--=20
2.15.1
