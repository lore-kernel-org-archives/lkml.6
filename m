Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497513-2-18168899221375610117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497512; b=FFa3Hs6GKRf7xMIrJacXpEj2LGGQjSucXm3sgYvCs5sp6yp
    4lHlrnbgnDcEgqJXrBFI/beB1+TnN5hpwMZ8q0clKC/NCF93V+Dt7n3L414A02rm
    9qF7h1LLWpKGeLadMrYKR/o5ZcTyextsMm3DMZfCku/7KlLeV3OwRvKHwFz94tSo
    Jp3OWWW/j6zKY0qfIlmSJ0HEm+KU85EwSG/Pp5DJ69J8GbvRlPl9JlL+Nrk4QVEA
    IMvZQWelC9USeSIqmwvq9Z/aMYM6m/9BTD7PtoNzeB0FWPpeUrB++n79orkG6VLk
    8oAV4cTZejywWriW+lxkzDMKOBf22+032VvQWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497512; bh=Si2o/S
    3JQUvrpH0l+eE5lhWX+odWalqCs2gcGWQ2LQ4=; b=YN+J+KJdQXYxqp4I0WMvMd
    A8BTfi9KZ/fKenugd3UR45oOTqkWwbCL1WvrA74SPZViq0hfnoJTX2NBTiKxPn20
    C/3pHAeRBvj7clVN2DhC2o7tFz9XaGafJxfC4Ir+0mwanoR/e8RK54nePPP7bwdz
    IQdCHx/BcJGpBjZp/qMxlP58Vcyy+xE/5oqNid6uqXAJx7w+yTQy/vHXyJgP4ixJ
    R48k9btT4kHqfzCEWogYB06H834coUS7BFx6hs8k9NNXzqe11oqfuhWgTBe5hAZI
    bkHWy7n0cGLUCDF8HovPQcDTFHLC8zCj8nuO+WFDn19JD2ppnOeOWYNHRNm4IGfQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SmsCZ5tx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvdehrdhsohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtfedtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SmsCZ5tx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvdehrdhsohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtfedtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972324AbeCSWK7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:10:59 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:27808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934051AbeCSPyi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 10/97] perf probe: Add warning message if
 there is unexpected event name
Thread-Topic: [PATCH AUTOSEL for 4.14 10/97] perf probe: Add warning message
 if there is unexpected event name
Thread-Index: AQHTv5qSiVn+17g0ykuXZB+UFffi+A==
Date: Mon, 19 Mar 2018 15:54:32 +0000
Message-ID: <20180319155411.12348-10-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:6e1bo6AYmkpPTiS6Zlf3WGLT3K4AHpggnF6RdqnxGaxW/aFjXuDaUuytIGbhgo5cLYtbaGQNfyFaBul98A9QgC5aEpDJu8Y78JwnZmAmg8ojM8zMSKMaoLLTZrMiTPTPfVxcecjXgSL0m3LUjYFQYnJM7EN54pny/vYfOd99F/MZALT6tkJUUxaBrosQ/ajngB4372oZ52LoKEOa7Bvw0CkmCyqBmJ2azy4epZKMUWvDpbzXUzM1BGOeEtcyxiCL;20:/coki2K7hTFs+DRE4rOKNl22mXCCV17UeIGT02hC/TSdMhNjO2TqjvCntPXkicaEqrtci8aTD8HmQ+th6sq8d4R/cZd8benHOo4BJZik9FqLZHkUvKruYj7+tA+RlBpMttmIC2pV/mCns0jUv8liBeQn1R80p65/mCkkesflOM8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ffae069-a855-46ff-cc7d-08d58db1b512
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0903FD5CF4DCA0C099CEBECFFBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(274839183919467)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(8656006)(7110500001)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(10710500007)(3660700001)(2420400007)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(966005)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(6306002)(15650500001)(8936002)(68736007)(39060400002)(6506007)(76176011)(14454004)(59450400001)(4326008)(2900100001)(3280700002)(25786009)(575784001)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zCDHpu909B8B9E+Z2bjgl45IDK/z6M5vKZ1mrQND3x1EtYscvwFNJ8iVf1YTdmAGEZ9X4CMjtg5Rzd44cyd39nibhOBWU4h9haIZoLVcUZsLU/E/IFFPfQPefXLT3s5tW46rki129IQEKascFMIyapBaB8ZoCPmATywClblg/38xi8wnsF3UjjbKxfpJdFIdRhkVOQWoqvbv1PF4/TXr6iRW6QDW8/ykG2p5k0hCyMb28chUwSPg6H9oBDfuKGV/X1IIVEc12tPn5LTS6/i4P/wcifcOBJXXz2FCbtmrUT828/fmKVvsxiqGokSjzRSu6mTYZNhAkrKFRwonrYnFUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffae069-a855-46ff-cc7d-08d58db1b512
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:32.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 9f5c6d8777a2d962b0eeacb2a16f37da6bea545b ]

This improve the error message so that user can know event-name error
before writing new events to kprobe-events interface.

E.g.
   =3D=3D=3D=3D=3D=3D
   #./perf probe -x /lib64/libc-2.25.so malloc_get_state*
   Internal error: "malloc_get_state@GLIBC_2" is an invalid event name.
     Error: Failed to add events.
   =3D=3D=3D=3D=3D=3D

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275040665.24652.5188568529237584489.stgit=
@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/probe-event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c3cd3488fee7..68786bb7790e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2625,6 +2625,14 @@ static int get_new_event_name(char *buf, size_t len,=
 const char *base,
=20
 out:
 	free(nbase);
+
+	/* Final validation */
+	if (ret >=3D 0 && !is_c_func_name(buf)) {
+		pr_warning("Internal error: \"%s\" is an invalid event name.\n",
+			   buf);
+		ret =3D -EINVAL;
+	}
+
 	return ret;
 }
=20
--=20
2.14.1
