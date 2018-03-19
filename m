Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493931-2-3165111965580956501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493931; b=irzBqasF5WtZuVwUPt8CRjhnEJFfqyrnIc5r1WCSCcPchlE
    3n6xiHNt2L3E88khRVUscmhEtSZWH2+047L+buwNJtuDuFYxIkCI6cCXDMtxqdgA
    ojA0EqfvYZDqEGo7gOfFGGRxWLohFZVXULvtFrdMYqzAAm3BNH3kZU/K6fmjDjGj
    mAw+kW14ESxy85P2ZX45b0z5QxXgotRmCyXbpjeLLt4fjOba4jg9KcMWCRNnrBI9
    XJ1d4YW1dNsl1CSJeSm1IYS4ok0ZatjtB8/8Kp8q4+jLytynbijodrwAQC4wpdUM
    KxyIdE8DNBHeOSLT78p3CXqK32hn5/0lpYXO5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493931; bh=lTr5gu
    djchEapPFKCXRh1lirJOkpi9ou2uAM6B6itv8=; b=R3nsHnMNGmSFUAU57DBFIo
    D7IfC27FGnBd9d6AgztII+GMXuv+SwF95G+42auVAImLKaeCQIwhNUbDLMZJu3bC
    xT0XDki3KKUNEhLafeMKJmrbcEnKYsxg8HQC80y+dfd4JmNzebGinyH/7CnM+fhS
    6NHmsNcAcNfb3KrA1P1agYdZOWnJupQxyj4kag9WVy1FIBlQ/FesZjOifx4aTZvz
    amaVPs1JJanP7Gr/kQGVha2nn12PaVue9zANH5sv/tbRpKFPic+9Q+LJL49imGqM
    ctkxQbbWp2/mHPP2SY/5wtRHug7oHjXUhuDZbTAyuIfY0pfhJioWjZSEVyTOyKWQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JYrVxR01 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvdehrdhsohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedthedvnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JYrVxR01 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvdehrdhsohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedthedvnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969189AbeCSVMF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:12:05 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:65216
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934957AbeCSQBq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 125/281] perf probe: Add warning message if
 there is unexpected event name
Thread-Topic: [PATCH AUTOSEL for 4.9 125/281] perf probe: Add warning message
 if there is unexpected event name
Thread-Index: AQHTv5tiNVBF1Fz+qE2qqPtcN2gJ3Q==
Date: Mon, 19 Mar 2018 16:00:21 +0000
Message-ID: <20180319155742.13731-125-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:XiYCTfoscnWJRfA8rEouSkNlHDYOb2ir/EtrE3Oswy+sie7UBRS1ugc4aQrgL4ojvO6rV//LAmEXw+Lrn/Em6cXC9Aokc06kz2Vxn42Bf/Q1jlH53beeiZKbljUyjz7xvErd7d9PoeP+UbMemMP7AH5SR1Rx5Ty4PRJsFm20m7MMkCUOo88JAd9nnwX+LTT6VIhYUPd0VM+7SzaH7lt8UOUm6YlVQZetQPVjZiPsySCk8W1YKd0U+f4VRayp3mde;20:jSEikLVIt6tC8kzSV/DdIWNZ1qpupq7fT+Y562awYgh1WMXfQuM0eYi2LcQnXwxFFeU9PC4nZZiyCTM9iqWiHlShD9NMqYIRDsq6N5fbHVSBWkYlYpe7HPPBWCnfcyDXlRsgH63GNWyND0eLmTxNILad/4vng6D+OioKl2cYcJU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e277b2f2-5866-460b-3b67-08d58db2b4f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093309795E077B7AD98F17D9FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(274839183919467)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(10710500007)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(15650500001)(575784001)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(2420400007)(478600001)(5250100002)(26005)(39060400002)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(7110500001)(54906003)(8676002)(107886003)(316002)(8656006)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: i9MZGeJOTHsIEYmk2Qn9lRBuGodjm9g8dkcU5POb9XUPqtfrkzyP4c0ofL4elfzTsfCl/7RHNApcFeUrIMrbdo8+E9TeQct1Fq1W1wCU+HN901W/3j4npoHr/yLtkSJ2ciQWbrs6ZTTo4leVq5wNjlT/+uM6wSRDPd/EsDERMsTCACS3OCFZUdYyEXb2DhZqbfd0JSy6ez4ofUbkcMungkHguEtyYQfLt85olNHWcXsWotvq/CVBIrpGBTH9LWxUUEui84CdSX+qoUDEBuEpsxI9HBKVsK7pzBItaK2UVi9H6UNniD/2Y2ATfl6s9F610cEDsKlW2Js2LSHeH6IFxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e277b2f2-5866-460b-3b67-08d58db2b4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:21.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 6a6f44dd594b..da778ecba2d3 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2609,6 +2609,14 @@ static int get_new_event_name(char *buf, size_t len,=
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
