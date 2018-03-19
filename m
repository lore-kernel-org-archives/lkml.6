Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494233-2-6928814138771368577
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494232; b=o5XHo/ILxTV9bP4WIEnTWyBbHstmCMirwN41WcCav1XNvkL
    G1sOwKSfxs2VDf7fMIIUUHqpqO39bhbmXcR1jkfIwgS8aGUU0kxaqj0qHq5Sn/9A
    316ymMLD4yJ27ibuA4DScIfbo6xLTFaGoyfaywgS1FcGqtEuPal2J7INPfxbwTIh
    oy4/L4yeg6595U/IW1aZBYOdfRNCtZFVV8mcDpmn5NuladeF6zOOme2vaKUbFqZf
    3ojSBKrTkLPGlPUisR9zgE8GpJJkddMTUq26+ydteQL3aNx0oYSF4Dnisf2Lovyx
    XmOXsVdxjP1gp915h0FqcFO6rw5UV/1eLeZFopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494232; bh=z8P6ob
    kzVQDW2bZTosKMvOo941EvY+dEl8Zpu/jK8vU=; b=lQx+yL0FjSnz4r/gqGIW7l
    EexjXrYYn+2fCRQXkDWXRGPeot+K198yu/tupVnczQshNiRBcmLnXZHwKUjkGqkY
    V4SS3J8FCOibGidk0v648XmdQfTpM7F2obnX444fZNa2BizrUdsSNO3XQiOFQA8N
    Rjw+6DyLN3Yu6AQbhPCKyI9klO0nKxCXUxyfRIfkmGb5XCCrieTIPCSPSZG4QWsR
    2PEWmFtQI9fbBxjkrgy4p8nj7lVVeTaeB9r/kI7WeOHRNlMYR/2KgGE4KDUFjMEH
    tooJhdwTLD12f/XaJ7quFrqtUwRq8PtffQdYxFbz/qXp5QVWNWmS4emdQVXpOJdA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i9cbcXnJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledujeeknecuvehluhhsthgvrhfuihiivgepuddv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i9cbcXnJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledujeeknecuvehluhhsthgvrhfuihiivgepuddv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbeCSVQU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:16:20 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:15552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965303AbeCSQBM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 114/281] cpuhotplug: Link lock stacks for
 hotplug callbacks
Thread-Topic: [PATCH AUTOSEL for 4.9 114/281] cpuhotplug: Link lock stacks for
 hotplug callbacks
Thread-Index: AQHTv5tblLBqC57ilEKl29Wu+IV8pQ==
Date: Mon, 19 Mar 2018 16:00:09 +0000
Message-ID: <20180319155742.13731-114-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:YDYr92ntND39BQW0qr3PNQTSjL92hKV/4EF3fCM2zO1mEwOEZoCUYyA9TyLpdA0wjsSNdor7+6Vv5n7gVMsMhXOY+0GcGZyZhIj6pom07qSrl8zOdItk1I1o0DWPXKXohZ74OJH23y1Dua9iCdn3UAwRj2U5LAlwahP/j6vPYBch/Bc2g9axK41s7M6xKt4+EAuTtLton76OB8RuXLOX66Fkf9cRWQwSE+7eCmlGL504CHI0OFcp+Pfg6fWRBQ/U;20:XlygOIVzmqcrPhWqvX+p+EwWtX2LB7gQe9nCiQKiVIbQGfJ2vROVzuBGtvvIqfTDyfAPDHBFL6HXdtiHSBkcaZKnRztsjUUXAn+FQpcVsh1umUm6XjESOvNXG+LV7V65IhWiOMszbeMDj4BpCNDblSQhO7YGRt5Ah5XmdbsDB1I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66d0abcc-13e7-4e4b-0c8e-08d58db29cf1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015EBC74F7CF3E016AD019FFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(104084551191319)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(6306002)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(966005)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nIP7mA9SaSyaVGHxSpfD7Vzx5WxaxTM374jwrKcmvsTUza3D3LdLBh98unschg7oD23DcdaUUcqGO8FotKRR80dXDJH7zTqxYTOZUbP5y0TwUBWoC0bfwRUOxeffzF39jDwRDMfVUi4khP4c+J2hVCSYzZLRQO03DmK3TBdkcMkgu6qqW0irT5TymGp+eMbOTol3ZwHqIF2oXTfNPf0EJNk6pl1qxO5dIoxSWCt2NMQK83r2lXmyraqotJ/L0I2eJVcs7+dziJxEQt0rOhSHMx5NxIMqhqVksE4rR022+qLOfYo3v8exzyxzOjDuxSZiIQPTJqIWj0M7kXEx1E6QbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d0abcc-13e7-4e4b-0c8e-08d58db29cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:09.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 49dfe2a6779717d9c18395684ee31bdc98b22e53 ]

The CPU hotplug callbacks are not covered by lockdep versus the cpu hotplug
rwsem.

CPU0						CPU1
cpuhp_setup_state(STATE, startup, teardown);
 cpus_read_lock();
  invoke_callback_on_ap();
    kick_hotplug_thread(ap);
    wait_for_completion();			hotplug_thread_fn()
    						  lock(m);
						  do_stuff();
						  unlock(m);

Lockdep does not know about this dependency and will not trigger on the
following code sequence:

	  lock(m);
	  cpus_read_lock();

Add a lockdep map and connect the initiators lock chain with the hotplug
thread lock chain, so potential deadlocks can be detected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170524081549.709375845@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 802eb3361a0a..967163fb90a8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -63,6 +63,12 @@ struct cpuhp_cpu_state {
=20
 static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state);
=20
+#if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
+static struct lock_class_key cpuhp_state_key;
+static struct lockdep_map cpuhp_state_lock_map =3D
+	STATIC_LOCKDEP_MAP_INIT("cpuhp_state", &cpuhp_state_key);
+#endif
+
 /**
  * cpuhp_step - Hotplug state machine step
  * @name:	Name of the step
@@ -563,6 +569,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
=20
 	st->should_run =3D false;
=20
+	lock_map_acquire(&cpuhp_state_lock_map);
 	/* Single callback invocation for [un]install ? */
 	if (st->single) {
 		if (st->cb_state < CPUHP_AP_ONLINE) {
@@ -594,6 +601,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		else if (st->state > st->target)
 			ret =3D cpuhp_ap_offline(cpu, st);
 	}
+	lock_map_release(&cpuhp_state_lock_map);
 	st->result =3D ret;
 	complete(&st->done);
 }
@@ -608,6 +616,9 @@ cpuhp_invoke_ap_callback(int cpu, enum cpuhp_state stat=
e, bool bringup,
 	if (!cpu_online(cpu))
 		return 0;
=20
+	lock_map_acquire(&cpuhp_state_lock_map);
+	lock_map_release(&cpuhp_state_lock_map);
+
 	/*
 	 * If we are up and running, use the hotplug thread. For early calls
 	 * we invoke the thread function directly.
@@ -651,6 +662,8 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
 	enum cpuhp_state state =3D st->state;
=20
 	trace_cpuhp_enter(cpu, st->target, state, cpuhp_kick_ap_work);
+	lock_map_acquire(&cpuhp_state_lock_map);
+	lock_map_release(&cpuhp_state_lock_map);
 	__cpuhp_kick_ap_work(st);
 	wait_for_completion(&st->done);
 	trace_cpuhp_exit(cpu, st->state, state, st->result);
--=20
2.14.1
