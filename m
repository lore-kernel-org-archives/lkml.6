Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119107-2-14337632547720083302
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
    t=1520119106; b=Ra3Uw7jbphJYgnt3KlF5ho6z1LmclyV86BBoHX6wuDAJzqW
    e6BDcihk+SwZJWUhECUXj+/fVKCWy5LwMrrANPNo6tHLc9tS9Ek2T8i2c4F6a2kv
    OEcL4LYu9/cdViiB2M+MKqFsVPcwpmi2H+r2FEVwbNI6iVgrQeD0jssI/kwwzfWp
    VKWtBS7P5R+mLAzRLRZpbMMA32/fHI4IsPQT8lQTd6DQ4UGIAtSSZ0upS60hzPFz
    dUw+q5sVu3ZUvS87JNmY2M17RoL0WU9HewezdOAXTPoxf/u/PE3sDdJp8/H8J0lO
    3pUaQWPp3Z7SPExXY+7MqfYppJRYWW/FBmOObPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119106; bh=+I0Lpb
    j+vMCIZO5Zd/SJIpkzL8Vjx6HWThJ1G+vJJgE=; b=dmWLKtEg16bUU4zASeHae/
    K4D+NS8yaQesBz6eCu5myDg5hxtKytJZCn8vIe5w7wDO15pBSgiC+FsEBOHlmVE+
    ntIPpf3lPKRbOaZpUD4bQthMHovXVbaQRCqbkkLPJ1T2O1mDrEswsdNsQZPDdo6m
    IDsw+pfKtylC/XOdNMKWVI7gTkYNkJmJcF7vNtPwGCi1sbhorucse07qku0oRy5/
    bNvfol4v50XS8BP20+3MlOea4uDNnJi4UBo4kQf0MnxbrwQj26WdfNq3jKLYEMWo
    yxZLwwTwNGkryLJ+0IM9XeUayho1v30r5Zr29RrKl2ewVqH6Ruqw4MviqXmUN+sw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fwqUApjI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fwqUApjI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeCCXSY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:18:24 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934812AbeCCWiJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:09 -0500
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
Subject: [PATCH AUTOSEL for 4.4 018/115] perf probe: Return errno when not
 hitting any event
Thread-Topic: [PATCH AUTOSEL for 4.4 018/115] perf probe: Return errno when
 not hitting any event
Thread-Index: AQHTsz9MJBxbS4NBv0WSHJUOt4Vy9w==
Date: Sat, 3 Mar 2018 22:30:58 +0000
Message-ID: <20180303223010.27106-18-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:KBM2vulsyU+0NSfjVknRCSXMWX13DmXIan2ZaYSNuUu4dsyLm1XPWf8EjYZDT0G4qtxzzZt8oGYIOsXDZZm9s1fWuMNgv13bgH+nP855/E8ymFD4q774Wtg69yGFwBQiexj0uLgr/hxGE7TT+AF1LQ5q2CI0I/46CAwXTxl629HficFCHCXKane7MtT6J6qvEZ19XZgyvEo/hGX0lJ4xYWbV1VLvWsaU5X2Ouzm8IjleMYltbWOtPWB+PIa8D9s8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 618e463a-054b-4696-5358-08d581576e14
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10674FBAB323CB241EEFF8BFFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(6306002)(36756003)(6486002)(54906003)(966005)(6436002)(68736007)(22452003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cU//xEW0j6YHEd24++sIxr/hmZ5JJOBe4xMc+8fy5p1RM8h8KgPLGQ8fNkckDWyWm+VtreZtDFQ9Wh545e+kBe8JdjpdHdCUIR0LVduQZld9YLlEQJFdH3tGAlRBKz4RdbnlaGmrrGJcyk80cHrQxysn6/tDJgQ9ya73N3mJAbw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618e463a-054b-4696-5358-08d581576e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:58.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index 132afc97676c..9d4ac90ca87e 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -405,9 +405,9 @@ static int perf_del_probe_events(struct strfilter *filt=
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
