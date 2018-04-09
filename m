Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235077-2-15039066451565007671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235076; b=o84LthBt2FDVKF9arDFo/Upiu+blVWWDKfoLUc2TECM3fKj/nm
    VA6Qzem/UnHD/yBU9Y4rKXQu5bKVOxPcgasmSNTRbmKtgnocy2yeuvjf3sFgFN22
    xC2djdiVtdONtoDfdmqCqAiknQar1msQoNfcOo8diYRxDDHtt0EEgroXasaGcbMI
    SmzZCBQrIbK6BnsBDlKxlezw/jpzVPuav8AYl6nAoe31XKqEEmNl0kLegdaKTEWY
    PAUXtSwtJdWxVHt1Rf8OT9zEGsyBixU3l3ue9iydtorKIuoTkv37HW1MJCFsLoog
    8dCSpr7mDLktK0MnRzH7TL/kBehQKYL5FGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235076; bh=ZHHETnZYR6
    VW3ZXM5DetKJ2E13HQaxnnA/mcw9IwRrc=; b=XWeni1hr0ft4G9SriK3iTaJw44
    VHCZl7GBpPbiHN5QUWW7eEMdjZXcfAqmAB2kome9xJFxVW2krA9rkmFPN8gKCTqe
    G5ldpLJg19Y1dIc9C6QN0coTEvAFbltZMtLGhtbw3n9g/+iYDGVfIRXJ+KPkUFwK
    IQZdxRZIVWWTjElJCUmcgh10s6pW/2FIjANvWqvLwMdOxqNELka9keXZ430aUJ9+
    wyLAOnGlaLtJtirxLK96Ow4bp/RoIcg73g/+Z1iTLKQ8AksTAtLXxCKGoHpTsOx2
    Fcdq0ZfOtWj2YRofXZbtQY0HkA235m64ugSQ6qxsW8dK6ICAukvwVsDyQ+Yw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DZddrRiE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DZddrRiE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGUOcyaMKsbMeJh2CjEP7qPKFJPisZhUau8YBhI0/CSNcZN+CysDTRgniQFHXGfXSVrEStql47q8rcKG4X1HWBUwnK7voIK/HX9QxcexAGfBRc+iVLaG
    DxjUjTm/HUQQ7WfDB7F9GX3/7vWTZ1yUZybOATS8vg9ktdK1qcwUz8/4zwc6fxtJrV66TafBDdMHVsfKvTK65kTnuOf6Ujosl3DAdVgaBnFK1VN4ReHO/sCd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=Tty9oNO6AAAA:8 a=20KFwNOVAAAA:8
    a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8 a=GGDxioHbr3M6G35mKG0A:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Bts-Es6F1CBXvF7u4C_G:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeDIAl3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:29 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933414AbeDIAl1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jessica Yu <jeyu@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 060/101] fs: warn in case userspace lied
 about modprobe return
Thread-Topic: [PATCH AUTOSEL for 3.18 060/101] fs: warn in case userspace lied
 about modprobe return
Thread-Index: AQHTz5t86AxsIrRmEkK/2FvNlU8ecA==
Date: Mon, 9 Apr 2018 00:41:23 +0000
Message-ID: <20180409004042.164920-10-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:WJoW1UHxEb91ogvkUsMATIGQ8cev/E2H/36PHvzpEEPFI6F4i5qjmaAY++cwgU5LisYzbOwR5+kA7vcuUz5UctLqtS68+XxG4g1u8mgLATFfFPt1c8fpyJ18j8Jy87YupCFn/ytTEQbupzllM613X5VUIsN6YXRWw4bTftitD18Am+ZVDWEf7q78WsapqYV0PErUYhQMzwUUF0pi+pBVtZED0rD/n9dhxyppy4mTUUXCIn3DRX9jiSoMowswC8Pz;20:amvXfOjtfxMzMiTTKxuQCQ/rI384zJGu4nDybXvY13s5SnUofiWX3YXQJ45Rs55QJdBMWSF3jGmtk0noAKJ/OOX+RSwG9NEO0IVUi8i+hQUTpsF9xH28B3lbFO+SDWV+5B6C9JXju34VEp0zpxscOcDL18pI45ak7F6dN0M03s0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f823effa-93f3-4cae-4022-08d59db29f59
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09019215ACADC948B4B69F0CFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(84791874153150)(46150409022019);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Z0YOcaAuFZGGE+Wg9z2+eXEtJsfoI8KOamdrCLB9im3IeKKRSgAHZhQ3/+Ifj8mvjCyjGECIbQpQqFseOFzPlFCxQjOHw6bveChnuIGoTs4kOT7y4VdQKdiuvpsYuqzfEZIPb+bUk9vut1DJ/fAScibjnkFRcm9A+mDkNIuzsda33AnO29AfreRZnM+A7SZOpKP2OHF24Eg6wzj5Wb2ZTC1HBC3RWdnn2Pch+gbqQbn7oDA8estus8+vLjGPNDBGyxDPV1FRdE2jOBDi8Necr0uSgaOvMiO4e2pUr7xkYHZzWN/Avm9mq3H89nBHzD90GTxZeXRhjpXjuUR9K6ni9w2ymO8ZRhp55ILtVyvbkCBXAgzBLmrL6+kux9C3Q3oS0WB84EoSC2odzoiFeHtw+ZJVCSOBpgFWFjt6v18utTg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f823effa-93f3-4cae-4022-08d59db29f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:23.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
