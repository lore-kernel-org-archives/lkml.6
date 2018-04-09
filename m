Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233615-2-11298088229299182258
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
    1523233615; b=bIwKlUjIj3hoinZB6kTCggV7tR2BlYE2sbA8i2I6F481VJg1hS
    Y0PH+a01hf3AvUCWfWSqV5T6bkSj51gEMo2AZ4aVCMn/NCkOZlRIv2RMeRpqWBRN
    TSGSHr3zMQtmjX4U9MPMN6suL87JBzv954Dc2gGKFSvz5syjleLkWCt+xu/IyiXd
    Uuz4JZD6Ek7Oao2XCwRwoT7ifx+/9/Y+rcCHKL1GpFjsetPF4HK7KR7j8RO2qMno
    4sBU+kff4z0WqzZ1sJzoD4zSMYwIvrBECWUTg4UGNJb8zaLxu4DlCG0bqxFj4H+U
    CGzNc8WXZPtPltnGuJHxLqrXzqmnMmoJbJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233615; bh=wIyr0FhEn/
    vTJ/Fc1FIUgk66gQ+Ux6FtihVmEYqNdHk=; b=wDUXNmwdyalad2zy0hwSQEdQ1+
    2selH0Rzpmcr0JYkI2V39AehOCOo1sslfRd5QvtkcPASAC8fnrmhrCkVzzZOljo+
    5xqDpYL33W3Jz/wJ3MYxwtJG13CX0eKIn1eeSNJQnTE9d2CsE8ZO13P0tzcR+jMC
    +zACdr8RC8jBbwzPZdoq2D+T8HXevcwUDvwISPImeRPgnV7DHQ/oYu7K79ToIKk5
    NeD1xreUBcnYDmN23zPcWM6GLNQvudhX0yo7dcPW9ZbZc1E1cOeT3Uvh34o/bqc7
    FimX5paoz9OvpANL8UbiWHFOSCDYB5nu4rv+/HLWgZgJXCOFFCP65Pne6Mgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gbJG9XEv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gbJG9XEv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJG39B8LCshRujK3Xhl8Cf1v7n9b8riGc8o94uIzNY7lfbUQMlzQTf/8TOLVHVzryWh8f2fKgY6tw6nTqbtNh0YE8LnFaDKXOzTuQUfDl3hIFked56bN
    p2FI0ZXPCQUzFCTQKd/uQNLqvmldWJZv9/AUFhZRey4+7DG4QaH01ReIAOK7DevLTqRTeSC/bFZU+erqSsl/x9SVJDRz54GxfxQ1g10WtoIQUSo0IBjYBcI0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=L-5fpCUWJdCBqBJfpMEA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeDIA0u (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:50 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754330AbeDIA0o (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 013/293] rcu: Make synchronize_rcu_mult()
 check for duplicates
Thread-Topic: [PATCH AUTOSEL for 4.9 013/293] rcu: Make synchronize_rcu_mult()
 check for duplicates
Thread-Index: AQHTz5jpoc1keyMGgE+O0ZXLVRl4Gg==
Date: Mon, 9 Apr 2018 00:22:58 +0000
Message-ID: <20180409002239.163177-13-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:Q18nVxacFZ9wEPPYrJUBBsjH0aI4xxaTs/aXrQ8Fo6hdCIWXjNrgDOhhdf0dwkS46w3NwkwWcas2yS9r/S5X+BgDrw1Kpnqm9IlCPXYsp3MrDGWGQaeeoJ5D1p3uHMjXtpLwwaev5xQzHFULd6WQ4yM9D+1oH0lFesva3xA2l4htLzlStKW/VmOtn7GNcEZpzkjRJCJIBCZo0Sq34aktdJboNs2MyazUY5wCERYOI2bBgOYESXDg/x89jgI/AmQg;20:tNiqBpnVqJ3xcVOmZ0jD9FNMUSJqKqxcUlmotP8NmHdF0rpSO4HNnO3y81/c2R0cl+4FGyfPtsMssVjnqP2wzMNqPzrZE78V4EhFqNg1/F6XMhV/NW2dpg/Sf/vVOLhq53kgMOxYifEmbq1lI0Ri/P3vW7txi9FXZbbxx/w3WMo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d766530e-f67a-44d5-2962-08d59db08e7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015AFB1EEA56D001D42384FFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l7cR3swnH/qDORkW6ocB37BL0xaZrOYW0qZF864ESfqqdk+2R9HM3EeQFZqf+oiH+rxcDFens5H8gyRNNM4Agi1OkENLTzLqXw64GxgqMNpv/84MZOVod1oTYZMgMYk4pjM+ndpJ6IXmFwvmrLzUjJ6aEmOFha6EFiGN64LfZvsLr96/yjmeeX8au1Nejc5SHRLb6z215OPz0uWPxGiAfiewnhPXunyC/Nqng0CyIC7EayC/6V96lo2DbhSC9d+dnEGUkMmoOfo3lF04kffA7aBm6bjX4twt3eR01U8wEYhegf8Tcz6X98VYvMfdUMnRRLbIBoWUqGN3rf9LWDHK06mBct9kMbq5mUAZERx2uCfNvWdjM8RPjmfnV0nQGTGaSCku2fSbEHXeZEj+vdMvkZTEaec+0w5bKDabCLjOoy4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d766530e-f67a-44d5-2962-08d59db08e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:58.0341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 4f6db7e6a117..2164c9cc6fd8 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -346,6 +346,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func=
_t *crcu_array,
 		   struct rcu_synchronize *rs_array)
 {
 	int i;
+	int j;
=20
 	/* Initialize and register callbacks for each flavor specified. */
 	for (i =3D 0; i < n; i++) {
@@ -357,7 +358,11 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_fun=
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
@@ -366,7 +371,11 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_fun=
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
