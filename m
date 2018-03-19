Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479697-2-5052966523784748689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479697; b=Qs1COmYzB/pgeBJt93JMkJDNmBMUEEUSirWn9Md1HJUR/Am
    Pl2po2u1FnRwBLCzaT4OPyTzIKp7anReDgC5q8spCfoRCXtZuvkD6mrm43X01W5c
    xZq2hbfvxmPREVAI+tZHZ5h/rLImXjUeol/JGl6bVmco9xyQln6vGSWX+KlOMa8a
    hUqr7DsK1YdB2BoBvtwiyLS+5642MxiXn7LF0DAUCHci6GPCLzprs8ZNNVIb0xwt
    b9M/gavBghRZJFbwSbSSl5VA1knvhCSzrcS6XEwTw71ZHwHqGrtT9okbr/71Dcdh
    lxCNqO/hsXlvxIrBgkyIcMu9LdaM9Uf6rGbBwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479697; bh=yHSDZM
    032uPS+PzRvFamTAhgnAs2LAAReRkhtvaplfc=; b=rwPrtrCYa+AtPWiBGWGc40
    LG4A41bNipv/4ajtBzZHUO92OIF/8zKF3qIjM0KGVIRLGgYWQ83NVyWJ9MQBQCl1
    m+CL9t/j5d18Oz69CZCOPgAX5W/MK+ainK8jHWDLSUvuNoH6McCvtBBDGT5F6xXk
    eeYFHrcrcF/X4P/Gv3TJRKvViONIp+oIM5wFdhxSgf1+bu0fGoQXRndryhiNBWsu
    RBPNZ+B0L9uJTjE3rso5pt/IO8+31lEcrHrm0gQz3fPpQT8dO/F8FM0D7bF81KjO
    lwtSVUvJ3L7mKx0iMoXsjeG69Qw/ppNQKbuTnMCHbLHGkYR6wOzRHU4Gib1NZZJQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zwf0xo34 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvddtleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zwf0xo34 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvddtleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967860AbeCSRON (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:14:13 -0400
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:22396
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966571AbeCSQKJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 114/167] perf trace: Add mmap alias for s390
Thread-Topic: [PATCH AUTOSEL for 4.4 114/167] perf trace: Add mmap alias for
 s390
Thread-Index: AQHTv5xq0P+DlG6Wa0Who9ETJjp7Jw==
Date: Mon, 19 Mar 2018 16:07:45 +0000
Message-ID: <20180319160513.16384-114-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:jpj2+3J+aigC311ViZMpAwRF92n2MDS660byvCDRbJopPOBS8zJCMJs5qK4zPE28Z3zGR3U5WnHP+XWmqZHzXuK6WQ3iMalYJiBrwh+Vfs0COth1FD4llqqXXGt3fptOYIwGv3SZgHoeEyi1l9VbeRWOm1956CUZCW1fYMUrGkiP6IBVY73IDEZfPSRhTgTXJP1h4ZOjBikBlmfrYO1xo4bu/0NQJWhqRqGHQLrKdHtmfw7Qd/TBrnirv+u7rZXu;20:JDRh06ETQTXtXLQtYu4U45sANYox2FEIc0Fbeutz6+LAf/D/h+O5eX86Jh5vJrpSrhH5gkqWqPh/cRgeprOu8VM0qOlPrWWrg5670JQqDPK9tn5OUK7tZxj5Ohk3/34BuW1FWAkDZQ5q1y2Ox3Lw3HpLzDa8RH2EdLlmM1sxWWQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51ba241c-df5e-4409-9be6-08d58db3ddf3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919962B47829C5EBE5BB501FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6306002)(6512007)(99286004)(102836004)(966005)(106356001)(72206003)(81156014)(39060400002)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C/yIZNRkkmQDU8hOcI/GmjACTGsxkUNsHwkPnpnI97wcDDpmnGLW5JRMrCTSGbX06PVTeZyAGYDe1VGTGuptiqaQ1qwLCjBMYynqM4yrr3qLrTYPi5K/ilvKr48PTdaC3UBOWGzb9NYF/D+cDGol1ZPnYDYo4Uutb295XY2/xzf8oGXE88U/YDPnW1gm0krCkxg5uRpBkps8dWQP7+Z5Q522zu9+EzfDh8pz1Uvh0+d71EbO781wBeqYbhKpriW02SYFpZdgcaC5rBgDAHogJZXav6QvAv2Z6mNUuraTQlM4xiC/S49sPAj86bZOO7PobQxuEsIA3htACw1Hhml7Nw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ba241c-df5e-4409-9be6-08d58db3ddf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:45.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 54265664c15a68905d8d67d19205e9a767636434 ]

The s390 architecture maps sys_mmap (nr 90) into sys_old_mmap.  For this
reason perf trace can't find the proper syscall event to get args format
from and displays it wrongly as 'continued'.

To fix that fill the "alias" field with "old_mmap" for trace's mmap record
to get the correct translation.

Before:
     0.042 ( 0.011 ms): vest/43052 fstat(statbuf: 0x3ffff89fd90            =
    ) =3D 0
     0.042 ( 0.028 ms): vest/43052  ... [continued]: mmap()) =3D 0x3fffd6e2=
000
     0.072 ( 0.025 ms): vest/43052 read(buf: 0x3fffd6e2000, count: 4096    =
    ) =3D 6

After:
     0.045 ( 0.011 ms): fstat(statbuf: 0x3ffff8a0930                       =
    ) =3D 0
     0.057 ( 0.018 ms): mmap(arg: 0x3ffff8a0858                            =
    ) =3D 0x3fffd14a000
     0.076 ( 0.025 ms): read(buf: 0x3fffd14a000, count: 4096               =
    ) =3D 6

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170531113557.19175-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ebe7115c751a..da8afc121118 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1152,6 +1152,10 @@ static struct syscall_fmt {
 	{ .name	    =3D "mlockall",   .errmsg =3D true,
 	  .arg_scnprintf =3D { [0] =3D SCA_HEX, /* addr */ }, },
 	{ .name	    =3D "mmap",	    .hexret =3D true,
+/* The standard mmap maps to old_mmap on s390x */
+#if defined(__s390x__)
+	.alias =3D "old_mmap",
+#endif
 	  .arg_scnprintf =3D { [0] =3D SCA_HEX,	  /* addr */
 			     [2] =3D SCA_MMAP_PROT, /* prot */
 			     [3] =3D SCA_MMAP_FLAGS, /* flags */
--=20
2.14.1
