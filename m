Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244910-2-8452120674761660510
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
    1523244909; b=l+Q3pnpH8sXN4+ypfwuQEXuM8aK4FAMDfRm8iIoDT4yJ2QtN/j
    5AXZw5O3AyLxxgR3F55xRX08F78FkDaIeF+2GCu2arrm28+ZUv5SYVlgpL17qGQO
    KDiRBuJtz7OOqGY8U1AKkwtiGnKDPLuAsEQuluQPE7c9q+KDbFiCJNX7YtF0v7LT
    w8O/Ne9VJF7I204D0zRIRftJQh5CMrPkHvlRNVoFQHZd/rtU9qYjcpRk+TISWfcZ
    jo4AbcLvpxu/Me9bnA9X1+Y16zRnx5mIQi4pFjtRm0ulrY6DkuslPv/wt9qj0fZd
    rTHYuKgizq2i2umYbl0oSVbLh924kmCMaIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244909; bh=+qpvAMdYgI
    hTw79DjpsxI+nZy+CP8AwwOY2QcqPWo0o=; b=CLzVj6z8peZSYP73Hg7Ma/kL56
    IcB23f3bsRzYkSVSjT7u3mnPqRmROnQDpbuY2OOwALZq8qFqsCZFPDT0LmS3W7vh
    vWXxQ8rlssfsVxQojSZR2mldPKphJN9ZzkquQDIVDRCPfIrswzwclaPyhEZSjNN/
    2/k5nGVBUwY0TDQMMzWQbXHo6a9vrov4sFact6TE3MK2YQz3y3LCq9gogGrAqH1K
    62Aki3DNANavuTTrwyT9GL0kYHAiP5WRtjD9DJNQsyVlDyDTRhdfWf1djXYhg7uC
    Fa8174vXcE/H8zLTRRcLpR7MWr6DCypOeL3WaLjM0jpI+Htgv30+tjfE9qtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fsMENOP5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fsMENOP5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIGVjaXHE/zZ9XpSN02CqtHoiRjgNOJ4K00hKdEKudGg95UMb9qCnne0fC/RGlOLd3qs+L/819VLzaegdOonV9IovCpIEbspcvv/PBxduWtFEIkg9YvK
    lvNG+HQbqFooQoEmW9TB+8amZ2YyQvsUJLi+gakH0iVlf8nvnTxg85AtJz0oLefKnKtNUjPysrmAFxV6RZXM8zHkd6mIbMp7DYrd9eYv2uYfRX2dLd2lMqHO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=vPoSAMVIJj5PBQCth28A:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeDIDea (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:34:30 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754423AbeDIAVR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 173/189] tools/libbpf: handle issues with bpf
 ELF objects containing .eh_frames
Thread-Topic: [PATCH AUTOSEL for 4.15 173/189] tools/libbpf: handle issues
 with bpf ELF objects containing .eh_frames
Thread-Index: AQHTz5hfUbQW3PyWmEik3hbCaeql/A==
Date: Mon, 9 Apr 2018 00:19:06 +0000
Message-ID: <20180409001637.162453-173-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:yWKDnWHunRv41JF42h72gyWBGGvbvdGmLkxHdAhCFaqAeigDCo1YfPfClrvpb6AQHjJdtKGLeSfvZpRLLY56yfAthw6od5TD2YUF8o1+Z8W9Ni7rE6mdOYxdfy6LZeId6u7FrnXUqvROE0pMZe1QCwfVmF5PFo+J3E8k+vkyXqHMeJLDJqAZUUjGB3rhD0zNLDQuYH+KsjIxCH5WLUwx/9noBYQAjigI+f3TkDlZyeOg/o2BL2W7aXCJirfmwdXd;20:InyLBXNYftnWcFEF3eWCkMqM6URk6OJGVlD912/ebSzV9FhW1neG9MQqYbvg10xIjWH/UcYh4c/n+n9OaE/ny7uS0D38pw4ZTiG9UglC4Dbaf4C39kWvYFHuxhaOR+XjusoyS/gYO5ISLuBUEy2O+RwzYWGqL2l+xa2CqBQUAqc=
X-MS-Office365-Filtering-Correlation-Id: 97352dc2-aa3a-461b-ac07-08d59dafcc98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112502DE94B91A5F1CA6BED1FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(142923001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DskgG/zL1NCCuq1gbyoA+ay27MLf1pt4I/nTBw3F8+Kqv0ZFyzV4KlVK7oq2ru3zcvDeRLACEUMcskO31m0ZorRI8U+M5kjju4NXrYjzj+jF9yrawzY7mSMxI4+JAThczJU7s2dO9fdBfTVfqZ3E+K+xw19K0+XBuX7aMYCgjlVGt9ewnX8ANKKaO88myORvdEMdw7hLlYjhwa27Ye41kMKED3ybrRrhKRD5r7iOa8tWO1Fzv3T2NRbv/3pB6zLlFYBU27mL7kJleNwLud+CX5eEvWKXDUoL2SN6pywGOwuOMg4GJnJPoKa8WwudqQZfRhZu94/kMiXmPenXSCAyIcg17vHKXPLAUmsl2KEx5Xx+Etb8arxGH1/JstyvEi8jyABnESEvdpn69OwMsM/secpnkVqcyHLZPszcpA8O2a4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97352dc2-aa3a-461b-ac07-08d59dafcc98
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:06.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index cda652a12880..8aeedf71ea28 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -726,6 +726,24 @@ bpf_object__init_maps(struct bpf_object *obj)
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
@@ -807,6 +825,14 @@ static int bpf_object__elf_collect(struct bpf_object *=
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
