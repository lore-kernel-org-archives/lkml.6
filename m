Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238138-2-886954554630895735
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
    1523238138; b=tOnFk49aMzfLNAxpxZ0uienKDkyUluou7vGmI7+RhA3WXKXvfG
    +ZwU3YeGS834EA7EVC0nIY4d/ZLKhzpsdV2u/SvMPiub1stQg50LdsmMGoYpkZ3S
    z/N25rnlVnf1T50afHWUxYk4a5inIROLmG4HcQCLImOU0kw1g09qy2ujval7iu+Y
    K8Bca9u0fT7y3WD2qeKiD0CB3sMWw8E6IMDXgKzVlkGJL1TU9TAy6VWCN1q8vVQ8
    tskKh+1O1OWC+4bg3G4VL73pxl7y4lLp692D+/Ms2QeXrte88Cvhcpl9YNzFIAln
    3w7hC40xGaP1i1e0vSuuNRMouy8EazrN65Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238138; bh=Q5FpLzo3Lm
    OutSjM3CmweJVoPYLa/1F7xpU7VQVkW1c=; b=JjNP0S3dmcGLLDqbtn0t4hKMb5
    1p/u82PukZCLltwxXlrkzaXLwkpinY1kKXRgjgIUN/wKTKxvsz4gNlyubYUQFZWk
    cd2RSHkLRd9PtrUuyF/i84ZXbguoC2HvLz8m4UpI9TxaGnLQ69gFI3QWR6LNKP1/
    tdsPMhlldUNb03lx1q1YlsDnDmA2fvZEU8RE9APdM6rrQu5wXEeBWfrhJ3f/qXg5
    BEqdiAjUQAJSmpLK4hyBZB4PAHQ/BUGTaWSoassXtEmvACC5FMT1vmNThZ0j6F5/
    EkNGR3w7FZ6eam0fTCYzSBnLbo6/02qvbBiu+ExO5Vbu7gQVELSN/VCd58mA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n9LgQQY1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n9LgQQY1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCp52tUGj6z+hI3KcDyuG0GAUD1BcQWMzhAgXXCUSX3GA9sPpdHh7AyxrGstc0Zr+bMofi/qQejEAAUQvSpjgTVyI/PCzYSVc7UfijvAPB+MIx9/0tIV
    FDWh3LCdZb/IJK/4xXOVGtUFTD23A+lUb1E6yURMNto5XhTcYnQ7kkWmhUFyW60xt8N0OSPH8lH4l8LIuvY5lgbo8zqyUBlN0lKLP8gfd9nJp0TJPPhj3q0L
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=hT20bRyzTuZkxee3I38A:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbeDIBmG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:42:06 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754614AbeDIAet (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 287/293] tools/libbpf: handle issues with bpf
 ELF objects containing .eh_frames
Thread-Topic: [PATCH AUTOSEL for 4.9 287/293] tools/libbpf: handle issues with
 bpf ELF objects containing .eh_frames
Thread-Index: AQHTz5ltKgVysFsd/0WOcOFfRjj0Jw==
Date: Mon, 9 Apr 2018 00:26:40 +0000
Message-ID: <20180409002239.163177-287-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:hMMRd+kfh/af6oFg74SiYd+9OtmKxWEm//R32J8/1X02Me+C8JHAxDxhU2MkLTucIE8HljE59l5Ler/QSRwFJnSDJk+Ow2KfmuCmHWvSW6HiKkCGxhURVqYC4NsQwM+QnytL7yO8OM2wz5TLzs5INjzDnAkjS41Xd2Jk967KFMq5rD3woXrS8FV4AAOIrFgL+A8+W5ZU9T4eec+kygByeLrBjD28u4jJhokIx+4En2krlPzpvigcfQsaESzgl40j;20:0gfTrNUp8R0iD+Eur/XSPmYqifMLrfRLyNlSF7rIB+r78WVhh8tkEa3x6IbmBNJRgfpB11QeXc3k6zhX4fI1ieaQsSGPCs/jvB/4l96iZSYT15ULRCStZoNBuWz80QbcK706Uw3J0zceFnCw/ytSSuQ3iRZRVvlDLZQWLRsuC/4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e4df9ac-a164-478a-bde7-08d59db1b0fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806E9F9A8457D778A3016E7FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(575784001)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(142923001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WepUSlmNgBER1OJ5EdqLAZfTO9h85t5y+z2jA/GQRKHMqpWpWgli+TFpND0SJWPSJ6UjnH1PJWsIhukPSJKEOrvSSNdMRQxKuWIgiD1xNf1J6GFgH4nTuZwFP1hBOBhT7etTHu+YRNNs83GHK/hhfs/XIIVwLSoN8SfNPL8KyIZt0t2VagOFV0btUlBnq3r9XR+KPB0kISswhpHrCovqPnFJDwduHqUUNYNIiDMQGY3HPEyDvcA/VkEhxBpRkzgajDsDkqrJXTNpYukdPVmOzCB+ycq6lQpJD6kKuELaHM4XAaXvRVuMQ7RFCgD77qPqZ0qGpRPNoxBajzuIVq/O6xohGIIMcX3qRC17prTs/G3U/oYlpGM/A3caCGlxtbkBgyX+f3YdHAmo7LzC3zla7Zx7rHitlmUuPMqIhAOVruo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4df9ac-a164-478a-bde7-08d59db1b0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:40.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index b699aea9a025..7788cfb7cd7e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -590,6 +590,24 @@ bpf_object__init_maps_name(struct bpf_object *obj)
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
@@ -673,6 +691,14 @@ static int bpf_object__elf_collect(struct bpf_object *=
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
