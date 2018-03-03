Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116348-2-10837165532436136315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116347; b=iQy/0Yn+6qwF7g0KNd9ZNOEW8iE3EeEkbqLrjV79tAt4yko
    HIXzksg8K8FCRVWHUUDJwgbiJIH3BwfiKe9TOP/SsoWBV1uUqpGoNypvJ3y3s+8t
    Gj/mFzFUjqFnZ8ytj+wWF1SJjfG3cNnM0NJNhGd2zIi7tbENORbacpvfrOjMqdoT
    lJcZ4uQd5Y7IuuxqlmkuUlc39JctCFsmYGCiOIm1fl0Sm8D6i3Ewgy9KVNUxbWRK
    QPhigbY1DGXG2LGDEftqy59jXZiL5TKW237dfMNCSZZnOWmrZkldLpIL7+1O2xTi
    olqXGoz5+DjcV9nTa/nmTm/C7wFtA+UjtSWoVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116347; bh=m2DFet
    bgwAWH4jiXbetJ+piS1zwWB35PjxI1BOivark=; b=mUIBMP304TB/VSadDdkiXp
    0YPg8KWmyJc7zKbZPKHlFQUjyTJAtqgjqKMcwnkCNdDiycHN8kjeXJltFXe3ZEmO
    tXbvM81qgn1i8P6zLYHdObE72Zs5zfvys0ZPw7/8rSlhtE52F+NQ17qKIJV7Vclg
    IOEGIxV9jE/08mXaZQATLnPGtRHtBCjvYJk6BmHD6CoCZj63YAqZaIjWrICWMzIT
    0Eu/GEyLe3U9d7Z8bst0KRxf903tjkCE0oBbIkXiREt2Xe/ZCgarBVKeo9rl3R5D
    a0YAW1XrBSWeFPTo4z2bNdEKmYDZGT7LctMlwfNTbicZiKQlaTHaS+V5UgG79A+A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G9xpbJ4E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G9xpbJ4E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933807AbeCCWcR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:17 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933793AbeCCWcK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 044/219] perf probe: Return errno when not
 hitting any event
Thread-Topic: [PATCH AUTOSEL for 4.9 044/219] perf probe: Return errno when
 not hitting any event
Thread-Index: AQHTsz7vzj+BKoW7nUSlFmD21/rWUw==
Date: Sat, 3 Mar 2018 22:28:21 +0000
Message-ID: <20180303222716.26640-44-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:v4JrDGNgLbVeJfLy6Xxf6dyJfqRhYPuqAmPF2kWYt4FSmdCK+XY8e8o0oZ+M6Ex7Fp9KQRvU9GYLoc0CP3CefbLF8QZQkuAZoSz88iH3RthOm/cs5AUDs/WAxszIrpwfqGKU86YnszzJzWzbTCqQD+eEpeLoiLhlhWCWROUMMMV/UAPmBiA40xQ7RAooip/wMhr0UJQKljhRiNA5sjSc8h1VXniOdYbrMzurOIBKk4OLR20VldtKZBqUJ/r/wdw8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 821da8fd-1b32-4fd0-cfd9-08d5815696b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083607526AC6B48C4B6B258FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6306002)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(966005)(2501003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: X4RVT1EjKV6unTIegrydwP8cfVk9Kg2XbjzgTZcg4ltCK5YZXOCV2u8lBZtgJiynhCjYRhV2rGJZmKrXzxnVyYEBxLlvB6gw5WUmm7t+fjna4Xy0TbqJ+mepCc0F1vigJC99V7HnnJvJLXeMynhTKIBD2/akT1/r0sEYj8fOGcE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821da8fd-1b32-4fd0-cfd9-08d5815696b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:21.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 70946723eeb859466f026274b29c6196e39149c4 ]

On old perf, when using 'perf probe -d' to delete an inexistent event,
it returns errno, eg,

  -bash-4.3# perf probe -d xxx  || echo $?
  Info: Event "*:xxx" does not exist.
    Error: Failed to delete events.
  255

But now perf_del_probe_events() will always set ret =3D 0, different from
previous del_perf_probe_events(). After this, it returns errno again,
eg,

  -bash-4.3# ./perf probe -d xxx  || echo $?
  "xxx" does not hit any event.
    Error: Failed to delete events.
  254

And it is more appropriate to return -ENOENT instead of -EPERM.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: dddc7ee32fa1 ("perf probe: Fix an error when deleting probes success=
fully")
Link: http://lkml.kernel.org/r/1489738592-61011-1-git-send-email-wangkefeng=
.wang@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-probe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index f87996b0cb29..9a250c71840e 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -442,9 +442,9 @@ static int perf_del_probe_events(struct strfilter *filt=
er)
 	}
=20
 	if (ret =3D=3D -ENOENT && ret2 =3D=3D -ENOENT)
-		pr_debug("\"%s\" does not hit any event.\n", str);
-		/* Note that this is silently ignored */
-	ret =3D 0;
+		pr_warning("\"%s\" does not hit any event.\n", str);
+	else
+		ret =3D 0;
=20
 error:
 	if (kfd >=3D 0)
--=20
2.14.1
