Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121322-2-4757133116784874755
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
    t=1520121322; b=gRh2i3xVOkEVbfzs4vWBQBmUL48CjSsoRMFxSsuWsLXbplT
    dujlOf9F9cWwc/B3y3gs2CJSWRmeTL/uL+BmmjbnMuvXs00kJK05U1QOmSVZ8Mda
    MyAljGcmCc4yUjWhnlMaLwy81P2On7LXg6VS52/kE4w4A4IBazfLP6zXxe0qFz/J
    hdD7h1U489dAjrjr97ieCBndpyr7aAhSucMub+0LZGJeULzDyhJhUeTlDAKpGZCW
    IESkMJwCnOwKgXI9rNGfT6D3NpS7+6e/NGL9t6QvkkRTU9YkfTk9bh1GJw71x/4t
    iJxHZYSrG0JphrhPob4m5V2tWOYXAHe7BsB4nlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121322; bh=wWp/ex
    G5kjJNYBuKf47jAb7rs82BGfi3yoY7G626eKo=; b=hvufyC7gyHSTQLwrpfVat4
    Q649bT/zFrufKcNAVqLk9+0Dur4o2SxqHGlbx7hHng+g1Heygtlq6lcHfyKbXeej
    xX9qmU29AFSnb/p3fuZiDS6oZ+Bc5jtkbZh2slNdowH/+lm9IXZGxffWUkVIPhQk
    CS98lUkzYTqMUIeogOzlqFUCcNKHQjMNQg1CZ0GJmmMKo+LRM3zUQoKafNQSIVJ8
    U8TReT1hLBzx7kg3SBDtK4LOKrHQUVelncX1tNCChWODVdAXF1/FbtTmC7KtXeXl
    p+DV3pzGSxamDDvpV5wx+GXGHz5gSN+RvDaYJzCtpMDFSUxzO7mHrvsYb22tQ2vw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BPYWrXZY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BPYWrXZY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933463AbeCCXzD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:55:03 -0500
Received: from mail-by2nam01on0092.outbound.protection.outlook.com ([104.47.34.92]:32992
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933911AbeCCWc4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tommi Rantala <tommi.t.rantala@nokia.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 071/219] perf buildid: Do not assume that
 readlink() returns a null terminated string
Thread-Topic: [PATCH AUTOSEL for 4.9 071/219] perf buildid: Do not assume that
 readlink() returns a null terminated string
Thread-Index: AQHTsz75nv6a20QuvUWTqTcO1Pvl0Q==
Date: Sat, 3 Mar 2018 22:28:37 +0000
Message-ID: <20180303222716.26640-71-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:tqR21AmqIawdTzMzZnDelbhaGCxQzQpypzPlf9Xd0tnYXuL2UONvhSDY+3/CEaef52fUic6aHt9Un5WCcUABcsI4OSCeIKQGG82oGDPy1+QwtZ1QdYVHaZ58oTRieE9GuZ/xi6QyJVFRuYm5YIZUDq6t07z3LuqSFVxsksjfDMUEmqZgwxFoDsTImdpwY/HEjf0DNtgktnb3d8t5lgbux+TGZQ4vZmeMDwPkzgyKIL+6C9KJo0NEInNcBrcVhh7q
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1a4a9a3-ded4-4a96-44f6-08d58156b511
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10972451D873C0B647F371F0FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(82608151540597)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(966005)(478600001)(186003)(110136005)(26005)(316002)(2906002)(6306002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(8656006)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rE9WGHiMZCV3sQnkYJWgtVorgmgxQ7lypblUtffNVfzYSzI1vydCdE+/k4CqcoYTfCjdmUtssAndDn2kPrHre7qN+dsVm06Uq/Uop5F7V6r/UvABsj9Frf3njemPu4VokxTd+e+FjANcpZdFdskbWJ7w1z94LzArWORl03EgwCo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a4a9a3-ded4-4a96-44f6-08d58156b511
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:37.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tommi Rantala <tommi.t.rantala@nokia.com>

[ Upstream commit 5a2342111c68e623e27ee7ea3d0492d8dad6bda0 ]

Valgrind was complaining:

  $ valgrind ./perf list >/dev/null
  =3D=3D11643=3D=3D Memcheck, a memory error detector
  =3D=3D11643=3D=3D Copyright (C) 2002-2015, and GNU GPL'd, by Julian Sewar=
d et al.
  =3D=3D11643=3D=3D Using Valgrind-3.12.0 and LibVEX; rerun with -h for cop=
yright info
  =3D=3D11643=3D=3D Command: ./perf list
  =3D=3D11643=3D=3D
  =3D=3D11643=3D=3D Conditional jump or move depends on uninitialised value=
(s)
  =3D=3D11643=3D=3D    at 0x4C30620: rindex (vg_replace_strmem.c:199)
  =3D=3D11643=3D=3D    by 0x49DAA9: build_id_cache__origname (build-id.c:19=
8)
  =3D=3D11643=3D=3D    by 0x49E1C7: build_id_cache__valid_id (build-id.c:22=
2)
  =3D=3D11643=3D=3D    by 0x49E1C7: build_id_cache__list_all (build-id.c:50=
7)
  =3D=3D11643=3D=3D    by 0x4B9C8F: print_sdt_events (parse-events.c:2067)
  =3D=3D11643=3D=3D    by 0x4BB0B3: print_events (parse-events.c:2313)
  =3D=3D11643=3D=3D    by 0x439501: cmd_list (builtin-list.c:53)
  =3D=3D11643=3D=3D    by 0x497150: run_builtin (perf.c:359)
  =3D=3D11643=3D=3D    by 0x428CE0: handle_internal_command (perf.c:421)
  =3D=3D11643=3D=3D    by 0x428CE0: run_argv (perf.c:467)
  =3D=3D11643=3D=3D    by 0x428CE0: main (perf.c:614)
  [...]

Additionally, a zero length result from readlink() is not very interesting.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170322130624.21881-3-tommi.t.rantala@nokia=
.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/build-id.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e528c40739cc..993ef2762508 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -182,13 +182,17 @@ char *build_id_cache__origname(const char *sbuild_id)
 	char buf[PATH_MAX];
 	char *ret =3D NULL, *p;
 	size_t offs =3D 5;	/* =3D=3D strlen("../..") */
+	ssize_t len;
=20
 	linkname =3D build_id_cache__linkname(sbuild_id, NULL, 0);
 	if (!linkname)
 		return NULL;
=20
-	if (readlink(linkname, buf, PATH_MAX) < 0)
+	len =3D readlink(linkname, buf, sizeof(buf) - 1);
+	if (len <=3D 0)
 		goto out;
+	buf[len] =3D '\0';
+
 	/* The link should be "../..<origpath>/<sbuild_id>" */
 	p =3D strrchr(buf, '/');	/* Cut off the "/<sbuild_id>" */
 	if (p && (p > buf + offs)) {
--=20
2.14.1
