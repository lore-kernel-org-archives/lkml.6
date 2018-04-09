Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242395-2-12671916969842252981
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
    1523242394; b=JrOMcVYepgw9IHwN2Mp8LKvT23ED4gWqaRn9TZEJbsrgSTO0Se
    oe2VQc0iYETrPzClO3C242QAMxid5Nak4mQj+b4Q48hi+OXmBmczT9qwNHJY8cDg
    gJFNbJMB7Nk1GcuSNdlqks0GKV2Aw47Xd+0lcQM2ai8ZaVcz/rtNxA0ch4j/1qoG
    h5KhT2XT+5bE5hvL0vWm7AsPM8cPI1mNkMmt/uu/nze9IsVCNhWzuv4aqXCBgs3u
    Hacoeum7p48CNPBgoKLDTsZSJfC25yN6ja1Gq/cwYBdSfErnomXyhoiit7LyyGQF
    QmHjB3+mdvzU/HSCPWuvD1GM0kwWb/Eo/POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242394; bh=axaJSs4JA3
    fO2HkT/wYbmjMmzuTL6x6Ygt5O4Jz/yKw=; b=BVcJsDkP/MA2yUjzTVwHOWaNZg
    FBQp8N0qZT2j+YVBoKwsH+kov1DCGSRJR1MWfbewAyxD5wOvlWbFxhbPVwmi/3SG
    uWjShvHtKBrVLiZ/37BAl7QSci44yaiJyqJTDbGV3dQCgTjspyhHFqT0pqCJMh0D
    hGQZJ1EYH5RC9Uau+kGt664ehOoZxzlDVnugkHpy0bdNjtnJ6OUSOag13hMiNRC9
    GW8VNvU3fDdRZ+3NegpVY36lbfB/ZD6CGDPf9F0WDb2aAFLndMnEaZEd6y1XrVoU
    kn7s5NvPgk2mUZuC1lyGquY3E56TdWuDjB1471m0TCAGLeMu47hy4Dh5OwVg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n0CNfij2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n0CNfij2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMA3EbzKL89Byu6C1wiFs0m+ZSTyuVeT3SjTk2Wo1HQWT36a56ebLV5Fn2RTencRmKAk+vCoThLjBLVRbcs8EF4hGrWD7QuZKKndcDnhbx2pk/bG/E6K
    KZC3b3luNgi5ziQ0d2SRipP3TgFHepPI4237/hWfqiTe/o6rDeg3rPKO+QovaVJFdRthVjg28JekWCS1pZxNMCKym210AM5s6ZBj2enJ0fhh5GVwYC/E6z3u
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=hT20bRyzTuZkxee3I38A:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeDICwg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:52:36 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755337AbeDIA0a (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 146/161] tools/libbpf: handle issues with bpf
 ELF objects containing .eh_frames
Thread-Topic: [PATCH AUTOSEL for 4.14 146/161] tools/libbpf: handle issues
 with bpf ELF objects containing .eh_frames
Thread-Index: AQHTz5jCSdTubh2rb0KcnFVcSec9/w==
Date: Mon, 9 Apr 2018 00:21:52 +0000
Message-ID: <20180409001936.162706-146-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:ZvuhHy5VG8pDupRmr2oM9zE7P6M3kGmB7ofGLq5GVUxScx0YNdeb7HYaLFKN+0oz5huxxy8aM3ebVe3Plf+eo7JZFe1Lw+mdTFa75lw/IcivUA1ydSVuY9ivvz0DqgIljEzF3qeduRyeAxN5RgHJXjRQYXdySr9ivRd7zrDhkhaaDD1ENJFzId+6D83zlgU7WUiQZMjPhrFi0zUNgiPEhItnqp2epIxeyXyDFSB0+SAGGidaxeDbvVA1z36Q48JR;20:zjFl5nZnCu+o4SpoFMtIPM6786ua5p4ZxzXPFcPs6xC75/eB75DOU/EBYdxLXM0wAs222aZfCJRDX/p1Ms8XdfN+hRiPgGd/d7FjCi1hV+uMt7lQSGJBkENHRv5RKZTLM+iakrm5vnGvYg+LHknOO/GFTfLdlVd3Ra5635CXsUU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffc9e790-249a-494e-479f-08d59db082fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725AB755F2B883E99F46C89FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(142923001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Q0WtFA1bWQQnTB5/7fHDWuRXTYduDEELRBWDYIl9pLss24swELwCfAG55RZP21gOL3fPSaLfBRuGXo1PsOwdLCeaCWQM/CnXCHOkv8ILTWqDMkkaOn6pkG1yIp+0zRVjzh5ZkoW/IMWyoWpEV6Knib15FsTWe40nhvhORJZU2S9a1iGFZ17ky6NqIMS7/U64YlOA/cU2zi9WrrgOqqMRhjuo5MrDO7rfrSugVvs6DX1HtBWbo67NqdY3TM30NzO892qtLcv0y3AKs4jk72h4rjYe/LsWh8/m8AgIeBDxaVBXPt9v0/LWhyeVYtRKxAHQ3i0JKvWliJ072qMryovnCHQC3/gblMWpOZsOS4ZQBGwi8evGHoeFn1wLWzRB1P1BcLB7mxsiFd8s3471ewDwqNHcnGfG9TYsgH4dk2lmxK8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc9e790-249a-494e-479f-08d59db082fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:52.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 35f6dfcdc565..701d29c8364f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -661,6 +661,24 @@ bpf_object__init_maps(struct bpf_object *obj)
 	return bpf_object__validate_maps(obj);
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
@@ -742,6 +760,14 @@ static int bpf_object__elf_collect(struct bpf_object *=
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
