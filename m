Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475778-2-5254191730409466101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475778; b=SHmPPPnwfUTaT7uKpGE02i+5rpjB0Oo5yoropUMJ1p8H4C2
    nN+YBCU2maoyHY8/oeeOsUxLBhn2ONtIR2VLI4UI8FbJtsPgOiM9ldnGHSRGaPUc
    kqxpK4EIQgxMO2/fAMLG22f0NEkA18vEGNCbzRRjbwLpCcuGvHFPa9fvp7HHlJ7H
    1sEzXsfbiSM49f2EPcoudhRiF6gccEYEresDxmPP0ngC7wkXCwH0Owl27Vz29c70
    B/q3wC9akSdyvCmy+l0T9rfmQFGtTjRSSM5BZrBikQNjUOSvznl1bn1DZJxw+Njz
    214j/ZiwgGxA3zNDYiNP69fPMLqxtb2QFgnqpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475778; bh=4obMZA
    L8U3gfhewda4nOzl76zLnopHhNcJZxD9zxAX8=; b=LuGtf0mJFsf3AUt6I79b/O
    Ioael8Uxp5o42gaxhJR2stESIYdkDG06Eje4uQjUbXTMfAFqJX+/RFx9pmI1opE3
    eV51m0MEVnrhmFRA4I7LwDZ0IPKeNSeZIADu0RcGd5Hinv4XxovmuvdHTfHGEdtA
    DfP2Mb50zbrOgLtNlig7qc5bzUt8oeK412qlR3UIolqPHqK+jKBhSnPsvOgh9BT4
    f7uA+J83guXwkKgclYGs4mT2BfEHypacY59An7N6bJY4Vf9/q0ZoAQrmpnUs6fmt
    mHTzOhr602uqq4Cj+7sj1Y8BmU63i3NmoYWvnGQQsz0qdgDpB7T3g3wTVbqHkw2w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NRfnwBEa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdefvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NRfnwBEa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdefvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966145AbeCSQJ3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:29 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:20373
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966407AbeCSQJK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 084/167] perf probe: Add warning message if
 there is unexpected event name
Thread-Topic: [PATCH AUTOSEL for 4.4 084/167] perf probe: Add warning message
 if there is unexpected event name
Thread-Index: AQHTv5xU+BQnRqAn0UagYpGGQpYzaQ==
Date: Mon, 19 Mar 2018 16:07:07 +0000
Message-ID: <20180319160513.16384-84-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:YbIYCAW0IoPJlcgRxUIzBX8FH8VPZqXXJdHHdZLl4jXT+4Ho5iSeuRhjR1Jx0ZexT3roQKxCfWUBEHRjBjWN96H4EbInjMpz1SnNEdMouweZB2l517CMSkwaWwZNlGNoShS2IZHjEXX48qTGUY/omFlIzZUUjUHCaXkxCHkNHUUEdiG//5p8oydJuqJ7FyEUvo5argjVK9p/e0PRQX6E53evy4l5Fk1whh/Az/gF7r+edewGbwisS3RI4Vs03yF9;20:zu9ijpeZYRZJsDHnASN9lmwQlvyA2JsYYbT+vohrYqo4Y3rEwkc5cjT6eSbI4fK8qnKy4hEUNhJvckm0HBR96mC4MGElanQcS/OOJlRryNobvlopY9Q/M3JJgUxJyrlqzBdBTPhQk+mqKlmqqTOY33Ijnoe8YF2Uy6X6QY7fcS4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed0cc189-b4b7-49ad-5813-08d58db3bd9d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902268911E989048F35616EFBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(274839183919467)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(2950100002)(5660300001)(97736004)(39060400002)(81166006)(81156014)(3280700002)(22452003)(8656006)(99286004)(186003)(2906002)(10710500007)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(6306002)(575784001)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(15650500001)(68736007)(7110500001)(3660700001)(478600001)(966005)(72206003)(36756003)(2420400007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: amBRICHaHB3vKQLdQe0lvwb666GgZt6z0lIbGSLQKiXxuWmMx6Y7nNXWgXQqErXjpxGd4wgjbX9B54BUXTQQxHJJ1Egfm9iAfVpYdOs/9yoPJwSfpmubuVGAOay04wZ1mxFEEvmJSTREk6+k6CHnpNibOk8ZSjI3ADTvtrbfBH5mgFQ2VeVKYdIaTyK7h2jkq7o+ojZvhFwNcOuZT53PGABwOL5yrK1Y0mPf+Z92Ky/e3xGm4RfViJd1dK+KuWpWX2B96ylL4wV831VFVOvl6aMAH0++g8fckm38JWp5Dreg86mSBLG/7zw0GWDZU6j3qTCDJpoNVwre8+38AoNqFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0cc189-b4b7-49ad-5813-08d58db3bd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:07.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 03875f9154e7..0195b7e8c54a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2349,6 +2349,14 @@ static int get_new_event_name(char *buf, size_t len,=
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
