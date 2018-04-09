Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236819-2-7108672828714345024
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
    1523236818; b=hBywbWedpmCAszPEAV+HUKJdw0LTezkkrhVoEu/9KGT4+ob7TX
    OHwj/48gGrwyX7LtC5hsVkAPmGf4mfF1+rN3b2tso67eycvKsvAmYXmxAdSUE8/l
    5iSbzoCpH1EaMGQa9ki5DNKkJuuxKN8vB4DLpIhNeINkC/WgN63vvArIH0HY5AZa
    WbRxUQIPr0WY3aR9EdD+n4+AKWfRXxydwNiTQvhNpizPQBRYTPxIQjX58U7qR668
    wFtcQynY9wEqq3NN3s3xVm/IoU5op/mZfJy25xh1UP6vZ4Rxo4W4CtL6haAsqmtM
    hFpkGXf/8lO4clnbBw5hRhgXGi/FyE5XA53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236818; bh=ZHHETnZYR6
    VW3ZXM5DetKJ2E13HQaxnnA/mcw9IwRrc=; b=E5qSIzHmqufe4sv81KtKE4DIBA
    VAC6ErDvd/iBAOKv87vCMOHcphSqcuVwu3diNSAAVFljLuMqj1EdwOvT2fnSYFL1
    fS3lfxTRT/AtZlQkgEczX531q2DcdZFKneGmnNIdx+RAXbFw/PoQ7DQ9HiTULV3d
    XA5mwBNd+H5UgR8k6BdX/hesg4k+IqNE5L3CNAdnoy7ij4ggqBvyj3zeATOy/BCQ
    ZjtrGh2UkiJGLC21HNHtAjusHfF5v8Z8wKsw92AoB8msbZVUG5gjgJRP7CQvEwK1
    vHvclT9Rp7MC5tOQXkHjx2ek2UKibk8aML33m00DBYq1UGB3mNGtXd9rVdvw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V14oNfhq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V14oNfhq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJOY1Lbr5LUW+UpzrAMXPGBt38uhGBJl7MtxfwmoCo53GfiGuIzsgeoX+32jODC89PDB0gYNpmo/cjX1UbpbzLiaElj7HOzUOFFbnvp7Ecd/jz/aSJ2
    1jsYxKlbz320ostAVLcAo+bUZSWYTAx0rOhsSq7yiooeQidUqAyS44BabCpmozMJfDfKh0djA04izycefVQugF6FJTuX42Tte0q2W2QeRnHx6SpJH/e36mxf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=Tty9oNO6AAAA:8 a=20KFwNOVAAAA:8
    a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8 a=GGDxioHbr3M6G35mKG0A:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Bts-Es6F1CBXvF7u4C_G:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeDIBUC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:20:02 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756056AbeDIAho (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jessica Yu <jeyu@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 095/162] fs: warn in case userspace lied about
 modprobe return
Thread-Topic: [PATCH AUTOSEL for 4.4 095/162] fs: warn in case userspace lied
 about modprobe return
Thread-Index: AQHTz5m9ZwujDvXiwU6400nq9z+0qQ==
Date: Mon, 9 Apr 2018 00:28:54 +0000
Message-ID: <20180409002738.163941-95-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:rBGUPwyAYm0lJT3JUkghVgFunh2Bv+zTET8ZUfC5kEmx6mK5Vq7xk2KPWpqJIQYg2AIsuTHDU+Q27TH+FeHzkeIrA+0ebalXAbhX4i2vJK+h0a12H1Mz4iPRXo2bgKxDlq0suSzdU9a/HEtCvWorajyPmgyHr0E6KeiVwPNJbzNO+FarGtAySR9dhgGbKFbK7hM0HSRRcfc9yd+u5QxIhMPju2n+ngiXzDI8c5JMBfyM4w25fr8SKYBE98I2BEHi;20:+x5UdwEt/IF/JvTLhL4g123qCqoZKAZFkdcQ4AEdPzYu/Uk8T5jaQnkH68f/ayMe7isaEyxisLjuZu2iYcTrfIW2OOaM3BS5j1eez+4jdJ5mvum2hiv+Ff9SJ+Qjgcav2VF78418nbSJicSSW5TGyt3nbdF0fJHkXVHHDwiJLrs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23fba50e-cbfd-47cf-9b8d-08d59db21a39
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312C7A5B958EDDBC10B197FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(84791874153150)(46150409022019);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NYW+cbU8o8nudYFLIV6x1KbyV5gtufGgQnu7SFKQedYKDMBTFabMD322joquQv8ftHkhQicDeSv684hXMtt6g+ajXW9lCGzIr1wqJuAylLRppXL6lNjNx1D/L7kaKgsY5l+tRJPc6TjgUpbBE1MVt178gtBt8dTzay2muAbBzshBe6b1NqLDHSBcL0ZMpHkZgFZUUxMFwvTFiBWC7ywOHYfhYcY9/5JBM4ZGAMCm6neDrIOEJGnRihCOQsspakALEjmFZT8dytmXgaJO+fWdT1rSBD6ONDCXYd09f90yaNkq2BB1J/992VDYKQ50DryyTDK2kwfGTVI+d7LE0bqNhp0KUtiiwe27Ci4q59s7kjWZ0G6kcwe2zMHLaSGMXnl/X6SiZ5uUbQAgCxhTNclQtb/p8A+DOxvKZ1E0eem/g+Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fba50e-cbfd-47cf-9b8d-08d59db21a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:54.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 5797d45a78cb..2a7ae03f821e 100644
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
