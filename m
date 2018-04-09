Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236001-2-10317842183905576479
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
    1523236000; b=gE0a+3lrvl5Lp/910xQvaMT+8R5fNw855VCW2m1/LzWbFLJK4e
    K39YMn1qVaAmxd6GOnpq8bv8xoDG7biEdw6Vv6LsEslDeWALbrjDntFPwJzVXljF
    mm6OPgj4346/HuClBl9GpovJHUD+OZ+TO/dthRWsuvSjSbRFqGowJH1uGBDr1bVd
    Vpdyq6VkyNOG07QcOh3dua8WC3Lfy2+W+J7C/DL0gHx5azWb0rDycQ26UEzWsq4y
    I8f54a17k3aSKxJs5bpx2/J+EYoaj3eCyrEIWm5CVtr9Mq4Ae970awAFp+XqE6zB
    hoSejKOwGI0YS0KGTp57PaONU/qFiL4MqVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236000; bh=17ae+K4dBM
    g2CglbT4L+d89//kJsObQfpztteTXE70Q=; b=vmTHglov/hJegW2cbuOKwcujiz
    5ioZWR5hkukW81ElsXNBeKH6ek1Y7vbUH1BhVFSrj4UEvrQegu/6stU2pqHAODfI
    0WTxWvqGV+Gx5HMEWfvXqPFdxwqM5hsvnD5JGOnkqkRzTSsf27DCkyKPM23l7o8u
    4k9JiJMrjnyEf8QZtCk4uQ6HXqz3eVkF0pGAbvHlYsJpdRmdmKt4jJ9DlJGr16zg
    UWWFe5bv3F2MKMCn6NLfIKzT2HNF8UsLYTPrXZOeyMRUZsf2X88Q3wh3F4BOa/pJ
    hxKpCF8vZ26s54dSfH7GySRVeDzyChJyIHpME1Lr3Q6d/9ZMKZwsBruAcBGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=amBCsHgV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=amBCsHgV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDIyju/thRNZ/PT5crrFiPVkTm8xdlkboe2h7ExBWaPunxiDt/svSmnSykyTx90+dQ5aruuUoutZPx+i+jSx1fekCs7SJ0rprNkS17KBzR4pxiKx713y
    USVq1tn4lxqe8D8HySRjE4NZWPkC+wygwNKUVDvhffnHgNTg7uA50gbqxfKQ+vW6D+BtnoEgGpukuKVq7MxbtH4foT5A/A09xDO/bJFna1vO9i6Q4hrauKh+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=hT20bRyzTuZkxee3I38A:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeDIBGE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:06:04 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933095AbeDIAjY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 160/162] tools/libbpf: handle issues with bpf
 ELF objects containing .eh_frames
Thread-Topic: [PATCH AUTOSEL for 4.4 160/162] tools/libbpf: handle issues with
 bpf ELF objects containing .eh_frames
Thread-Index: AQHTz5ni7GKPoHAs7ki5m8buuwU1TQ==
Date: Mon, 9 Apr 2018 00:29:55 +0000
Message-ID: <20180409002738.163941-160-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:t4EfFtXD+zU8/nIPnE2syJNDybSmr93kvqKUBc4+y7isBAZ0ZKNyc1x0Lrx7SCi3ZWci5N3otEZbSW3h+NhkgLAm0FmdHnH7OS6D0SD6P49ktxrNd1LdVA3WcPXfoQ2/j/suxPrVbHVV9UsdDdCvCSjl7z5BCkCbRmzEaQ82ErpgNJWRyznMBBNR3WhfsrrFr4qmuJY22hx6HeK2U0qYltYzQL15M1j1YHDob9xSeUFM0Jf+s6IdPOhFj2Tuz7EQ;20:4by2WDWz1YaMq31jYnOjxgGor1pb1JnwvmUEIEC1RN0KS8o4mVhKR7rkql2DLk/yR+fpt9xDQ3si11G/3AOiKfKmhI1tuYD0XWgTXZGZZANLEmIFsMoKvyqVu+donJP4jbJBnaGNf9fxvkv+VAWndgZloQrs9gvRC0rI7ysB6EA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56caa183-7081-4657-7791-08d59db256df
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10478B6E3BE12799461943E5FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(476003)(76176011)(6506007)(22906009)(142923001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y0Qcl9rz+ZnEgT8mMeixzp6scekvY+A1/bPeBMmUggnAchdLuM+uhaswkgj/0DeCkg86Guf8kVc307EP663Lk4MsKKH7gEVK63KxT6mHrNRTjaWJSGXYmdZ7wnw2wkxezmfPfJlfg9fn0k03iUE2FAW9mrIGPpwailQymetwrDE/OGyJBM7ClKGJMYqthTpDmk3V8q4v7/7Rx9KUkNxcZXNNiE32VcO9GKbOzDg9so2kMyF6YZGO4l8VDOpdNaLBeP8ez/lvOHmNVQco8anZdaJQO9ni3CP0M32JO4NX/6km2umdoK4IaXQXSpzvQSY4MFh2fp5lru1IbkbhodKW+ChtVRwP9vDhj9iRPTfJBHqWxZtzC6H08Ge0I6eSZczKk+hHB6/IsiaI8KWOnoH1wXJrA+j7GYyBTzlZ4tFcXbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56caa183-7081-4657-7791-08d59db256df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:55.7871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit e3d91b0ca523d53158f435a3e13df7f0cb360ea2 ]

V3: More generic skipping of relo-section (suggested by Daniel)

If clang >=3D 4.0.1 is missing the option '-target bpf', it will cause
llc/llvm to create two ELF sections for "Exception Frames", with
section names '.eh_frame' and '.rel.eh_frame'.

The BPF ELF loader library libbpf fails when loading files with these
sections.  The other in-kernel BPF ELF loader in samples/bpf/bpf_load.c,
handle this gracefully. And iproute2 loader also seems to work with these
"eh" sections.

The issue in libbpf is caused by bpf_object__elf_collect() skipping
some sections, and later when performing relocation it will be
pointing to a skipped section, as these sections cannot be found by
bpf_object__find_prog_by_idx() in bpf_object__collect_reloc().

This is a general issue that also occurs for other sections, like
debug sections which are also skipped and can have relo section.

As suggested by Daniel.  To avoid keeping state about all skipped
sections, instead perform a direct qlookup in the ELF object.  Lookup
the section that the relo-section points to and check if it contains
executable machine instructions (denoted by the sh_flags
SHF_EXECINSTR).  Use this check to also skip irrelevant relo-sections.

Note, for samples/bpf/ the '-target bpf' parameter to clang cannot be used
due to incompatibility with asm embedded headers, that some of the samples
include. This is explained in more details by Yonghong Song in bpf_devel_QA=
.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/bpf/libbpf.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e176bad19bcb..ca080a129b33 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -487,6 +487,24 @@ bpf_object__init_maps(struct bpf_object *obj, void *da=
ta,
 	return 0;
 }
=20
+static bool section_have_execinstr(struct bpf_object *obj, int idx)
+{
+	Elf_Scn *scn;
+	GElf_Shdr sh;
+
+	scn =3D elf_getscn(obj->efile.elf, idx);
+	if (!scn)
+		return false;
+
+	if (gelf_getshdr(scn, &sh) !=3D &sh)
+		return false;
+
+	if (sh.sh_flags & SHF_EXECINSTR)
+		return true;
+
+	return false;
+}
+
 static int bpf_object__elf_collect(struct bpf_object *obj)
 {
 	Elf *elf =3D obj->efile.elf;
@@ -567,6 +585,14 @@ static int bpf_object__elf_collect(struct bpf_object *=
obj)
 		} else if (sh.sh_type =3D=3D SHT_REL) {
 			void *reloc =3D obj->efile.reloc;
 			int nr_reloc =3D obj->efile.nr_reloc + 1;
+			int sec =3D sh.sh_info; /* points to other section */
+
+			/* Only do relo for section with exec instructions */
+			if (!section_have_execinstr(obj, sec)) {
+				pr_debug("skip relo %s(%d) for section(%d)\n",
+					 name, idx, sec);
+				continue;
+			}
=20
 			reloc =3D realloc(reloc,
 					sizeof(*obj->efile.reloc) * nr_reloc);
--=20
2.15.1
