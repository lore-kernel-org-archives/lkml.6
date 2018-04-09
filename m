Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239467-2-16443789552205109188
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
    1523239466; b=fSPF3Yb3/Wr1WxIlyNBZekVongN1qaqNO9ai6u2nouagzcs9GB
    VRyvgPPtkgBjV7RCoEC1oAg1OqImxJP4oov7tpZCXR6qBVNPuvB28xYNhUjMk/1m
    1D70KilsNDDAdlyYPM7+7T1fSe3wOO7ptpLCyhOLwC/XptXiylD2tWUxneJBPlqO
    0cSQj13OmnVpDUoNJAb0ccTvDN63vmWnACa1yRWt5+/5Crbwv6qtrVZu/qaFqX9v
    AeBwupfWvMMTZsBjr7fXK8+Q58zuuFFb3pdzK207jXI03kKg7Ca13Wp0+JBfeoz8
    Tq6lKb7BrvULZwi44NhyfJ4CuZF8hyCMJp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239466; bh=ncme75TnUW
    rFp40PTE+DVllzqVbosr7gxGo7cLxjhmY=; b=fNVJZFu516TlJ7IFCsZkjHqHUL
    7+UowDnC/2Q9adi9JreE4Ft5EurJEVv9wkFW1hkdaHTbjh5aPlOlKeHi6koZNnSZ
    1kMf6SbSFKK96AZ1GWWxgOIRjQMUvE9hT7wH6VxM+Rns14DwVNDEggPbSp9H7yoc
    2h9umo5pk27MAX3Rs5B6tm10XLlCUoihnN+RQ0N/71K8E+znnOtwVHNc9yu/+8pV
    r64NukH9GNG4a6drq7RNxdx7NpX/79Prn3Po2zGSrA4DZVezPa+10yOukgfpZe6z
    Les0zSEVeRvABiJpGaQiSOt2+0fUt3mUF7nwJOSILMPE3Vqtp2JyJ5S6VnbQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LT/bnem0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LT/bnem0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNzAPuk3033IONHQHTaNtIYb2wWo/cMVhn2QvOZ9xUmUOoAbBTFCT/e0Pn13O3OYy+DUUhEy2pedyWHTuc61M55VphNsjjoP+lZa891JR8SYtW5xSeJJ
    LIuccfY9WFrGr8l/yEpiQZ36jaB8pYtxigxnof6wMun7ZBnHaxE3j7w5e/gZFEBz3HHGE/Etc5xOw8xo0339x45uB/TtnYum3JlZkbXfXe6aw00mxGbtSSvK
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=Tty9oNO6AAAA:8 a=20KFwNOVAAAA:8
    a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8 a=GGDxioHbr3M6G35mKG0A:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Bts-Es6F1CBXvF7u4C_G:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeDICEH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:04:07 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756383AbeDIAcD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jessica Yu <jeyu@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 188/293] fs: warn in case userspace lied about
 modprobe return
Thread-Topic: [PATCH AUTOSEL for 4.9 188/293] fs: warn in case userspace lied
 about modprobe return
Thread-Index: AQHTz5k+eUfPN3Az6EK5dPqovdg1uA==
Date: Mon, 9 Apr 2018 00:25:21 +0000
Message-ID: <20180409002239.163177-188-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:BR2EmWU2Husjn7th176OSNXYH12kHoQd9+2/jVw0BMnAwTn3roCXGpJx09BWQVnBIkL1T0AXOd8kJwT9Jf01GD54qEP+d5rf5I3Aw8dQBmkQkDNEmAV2yy+xcy/sNo9vNl4keTL0B43gxyxIa3M4VwMnQ/L5D42ewT7N+svVLGQJbASnZ1II1FaOXiJryxxJzwg0LNkXfpUmAl2WNCSogZyYmbY/3AjxE+Xr9AOsm7HmKqr21bzeXQ0xbQexeyq7;20:qsC1aC+J61CHhieudzrBIWAzpQByHPs3msTy0ZccoaJQTqCEGHfWm79v1FdvLOMpIlqoFzB3qvAQdZOspm+1QbgTD4igyly91IqhOfBiFcb8pr5nPXA5yecOg7jEPkdtjqdxMw8eeuUa1hWLojer45gwp7iUR6i2leSJKGYliLU=
X-MS-Office365-Filtering-Correlation-Id: d09f7bfb-43db-4f89-514e-08d59db14e6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11266D7A9F249B1A3855EB3EFBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(84791874153150)(46150409022019);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(6306002)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(966005)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gmrushgs7GqUbF084R243TGDrqo8VrFwgG9hp8yUBW+PQiAQUFTiBv7PIIaqYlIb/ZA0Yy3GQ6nvb4nLXObLjByYlVKFkMZTzuyrvBlfnltafD0JrIfZ8JjOLe/ATm3VZYD+9mcndlbgfkuYV4rAmvMVuRafTp7BkdvwWmTck4tJ5ECJ/lfYN3aRgaI9cFoOPKYSQfKWE/fvCQ9e8aJ3ODsaGGkeuKNnoSqbC8Is5S8G9axVK+aqw8g9/QF0+3G0id4JnPbbjC5FJDl07MQVVu3QKC8XebzBsDp7/m89NAxoWXYbwpSl+CV+u+3C1AoQzodD1vI+6hVsGKrpHRB8sAkYPds76/RVCnqpn0A4xjMDkFI2p8HF8DVrEPObVWE8YVQeVFJ3aa9724bqeRHJ1cwqqE0whwMyXuSlhCmCpGQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f7bfb-43db-4f89-514e-08d59db14e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:21.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

[ Upstream commit 41124db869b7e00e12052555f8987867ac01d70c ]

kmod <=3D v19 was broken -- it could return 0 to modprobe calls,
incorrectly assuming that a kernel module was built-in, whereas in
reality the module was just forming in the kernel. The reason for this
is an incorrect userspace heuristics. A userspace kmod fix is available
for it [0], however should userspace break again we could go on with
an failed get_fs_type() which is hard to debug as the request_module()
is detected as returning 0. The first suspect would be that there is
something worth with the kernel's module loader and obviously in this
case that is not the issue.

Since these issues are painful to debug complain when we know userspace
has outright lied to us.

[0] http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/li=
bkmod-module.c?id=3Dfd44a98ae2eb5eb32161088954ab21e58e19dfc4

Suggested-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/filesystems.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index c5618db110be..cd7ba6301a60 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -275,8 +275,10 @@ struct file_system_type *get_fs_type(const char *name)
 	int len =3D dot ? dot - name : strlen(name);
=20
 	fs =3D __get_fs_type(name, len);
-	if (!fs && (request_module("fs-%.*s", len, name) =3D=3D 0))
+	if (!fs && (request_module("fs-%.*s", len, name) =3D=3D 0)) {
 		fs =3D __get_fs_type(name, len);
+		WARN_ONCE(!fs, "request_module fs-%.*s succeeded, but still no fs?\n", l=
en, name);
+	}
=20
 	if (dot && fs && !(fs->fs_flags & FS_HAS_SUBTYPE)) {
 		put_filesystem(fs);
--=20
2.15.1
