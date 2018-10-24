Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF53ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B7205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TCdaj2Zg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O6oxcoeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9B7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJYFNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:13:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbeJYFNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:13:21 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9OKhAh6019406;
        Wed, 24 Oct 2018 13:43:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Z2M6QeUQ3iA8OmmYzFT1+O/HVsUo9IdIoZ4V0N0/95U=;
 b=TCdaj2ZgoaQQ23ieylYU0UscniVAR/SNs1ww+By7h2CRMqtXCoo1qOfOqXDM8ahwXpSO
 3vxWUh5VzpWRa4E/dHbp8RSVE8G/xvorxbttSXPPGwZJA/yX4JUBhqQ+Gz26+JMgRr1v
 PAEVZg45kTt/U0CMNxLcrnMU9fPGjv98qrM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2naxmk090n-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Oct 2018 13:43:23 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 24 Oct 2018 13:42:28 -0700
Received: from FRC-CHUB01.TheFacebook.com (2620:10d:c021:18::10) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 24 Oct 2018 13:42:28 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 24 Oct 2018 16:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2M6QeUQ3iA8OmmYzFT1+O/HVsUo9IdIoZ4V0N0/95U=;
 b=O6oxcoeI7GS0whCeaa6ONoWa/83dfKkj1plVdXKKJ+kjCXOnIZ6WSodlOZYhokGlPMOeFoo5bRaIMHpzLC3Vmbn2AoRFvW140WOq4FjWGud2Dh4BgwEJqFNG4Pd6PCJ/mTVURPxC6PqbA/G0NhQxONFGzR0hG4MAH0k1WHT3+nk=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1792.namprd15.prod.outlook.com (10.174.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Wed, 24 Oct 2018 20:42:25 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419%3]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 20:42:25 +0000
From:   Martin Lau <kafai@fb.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bpf: btf: Fix a missing-check bug
Thread-Topic: [PATCH v2] bpf: btf: Fix a missing-check bug
Thread-Index: AQHUa5mXie9xmsybbEORoB7Wt/lhG6UuMIAAgACFY4CAACcGgA==
Date:   Wed, 24 Oct 2018 20:42:25 +0000
Message-ID: <20181024203548.glxgu3bqd47minmg@kafai-mbp>
References: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
 <20181024172514.l33dsaqdvs5yewvm@kafai-mbp>
 <20181024182239.lz7uicceihzmxabh@kafai-mbp>
In-Reply-To: <20181024182239.lz7uicceihzmxabh@kafai-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:301:1::21) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:be1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1792;20:7sajFSEbBk9wAm11FNc3Fotpo6kbMeUhBffHkVvInQMf83kqOfVTXnvHdtjEJDJ5YayYjg5LAXifq0lAE6vJgqz+lpby1FRn4T+IZaJglVK4vQ6XQIHsK2ClezQE1yJIHUizN5oJ5wUzBQxexZBjmrR6hjmFyassLLRB3TyxQgk=
x-ms-office365-filtering-correlation-id: 63bbc4d9-56f2-436f-59cb-08d639f13460
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1792;
x-ms-traffictypediagnostic: MWHPR15MB1792:
x-microsoft-antispam-prvs: <MWHPR15MB1792920F0088655433AC811DD5F60@MWHPR15MB1792.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1792;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1792;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(14454004)(53936002)(106356001)(2900100001)(316002)(105586002)(33716001)(6506007)(386003)(54906003)(71190400001)(71200400001)(8676002)(81156014)(99286004)(229853002)(81166006)(8936002)(6916009)(25786009)(76176011)(68736007)(33896004)(102836004)(97736004)(52116002)(5660300001)(478600001)(4326008)(186003)(46003)(6486002)(6436002)(5250100002)(476003)(256004)(14444005)(446003)(11346002)(486006)(2906002)(575784001)(6116002)(86362001)(305945005)(7736002)(2171002)(6246003)(6512007)(1076002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1792;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /KCqMxv+EbGr4HChnfN8Z3HM30Au91Qknim1C9sazHQxT++IVxEO4E7ki50fE2IxhRBBIt7B+00EpArryNR535gjSn+BrKTTzTvbiHlmqRfG+dlIb4lBDkHcjAWLHiSrn8IfhdYXYbT3vf8lsq65mekeiwuDmjIHn771CckY36OAUvqgGFC1/qTC8aR3q9LDdWL+hx7Yu2t1Dx0EgGBHzOphoU5d14Nipdk2wtECSSY7YBR/3wz+PQNo0ldtAYoDssfk+2su9lxnRDyu4RKhT90+xbroP6UeXu3Yqbn/6bNnHUHGd10AiyGLdYwxqvoK0Iaiis8gd0qo48CJ4PZXk4iN9QJGfJA93lm/KG8fmV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD9F5996ED0FAA42A91E171B3B7FA2B9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bbc4d9-56f2-436f-59cb-08d639f13460
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 20:42:25.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1792
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 06:22:46PM +0000, Martin Lau wrote:
> On Wed, Oct 24, 2018 at 05:26:23PM +0000, Martin Lau wrote:
> > On Wed, Oct 24, 2018 at 08:00:19AM -0500, Wenwen Wang wrote:
> > > In btf_parse(), the header of the user-space btf data 'btf_data' is f=
irstly
> > > parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the =
header
> > > is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and t=
hen
> > > verified. If no error happens during the verification process, the wh=
ole
> > > data of 'btf_data', including the header, is then copied to 'data' in
> > > btf_parse(). It is obvious that the header is copied twice here. More
> > > importantly, no check is enforced after the second copy to make sure =
the
> > > headers obtained in these two copies are same. Given that 'btf_data'
> > > resides in the user space, a malicious user can race to modify the he=
ader
> > > between these two copies. By doing so, the user can inject inconsiste=
nt
> > > data, which can cause undefined behavior of the kernel and introduce
> > > potential security risk.
> btw, I am working on a patch that copies the btf_data before parsing/veri=
fying
> the header.  That should avoid this from happening but that will
> require a bit more code churns for the bpf branch.
>=20
It is what I have in mind:


It is not a good idea to check the BTF header before copying the
user btf_data.  The verified header may not be the one actually
copied to btf->data (e.g. userspace may modify the passed in
btf_data in between).  Like the one fixed in
commit 8af03d1ae2e1 ("bpf: btf: Fix a missing check bug").

This patch copies the user btf_data before parsing/verifying
the BTF header.

Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/btf.c | 58 +++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 378cef70341c..ee4c82667d65 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2067,56 +2067,47 @@ static int btf_check_sec_info(struct btf_verifier_e=
nv *env,
 	return 0;
 }
=20
-static int btf_parse_hdr(struct btf_verifier_env *env, void __user *btf_da=
ta,
-			 u32 btf_data_size)
+static int btf_parse_hdr(struct btf_verifier_env *env)
 {
+	u32 hdr_len, hdr_copy, btf_data_size;
 	const struct btf_header *hdr;
-	u32 hdr_len, hdr_copy;
-	/*
-	 * Minimal part of the "struct btf_header" that
-	 * contains the hdr_len.
-	 */
-	struct btf_min_header {
-		u16	magic;
-		u8	version;
-		u8	flags;
-		u32	hdr_len;
-	} __user *min_hdr;
 	struct btf *btf;
 	int err;
=20
 	btf =3D env->btf;
-	min_hdr =3D btf_data;
+	btf_data_size =3D btf->data_size;
=20
-	if (btf_data_size < sizeof(*min_hdr)) {
+	if (btf_data_size <
+	    offsetof(struct btf_header, hdr_len) + sizeof(hdr->hdr_len)) {
 		btf_verifier_log(env, "hdr_len not found");
 		return -EINVAL;
 	}
=20
-	if (get_user(hdr_len, &min_hdr->hdr_len))
-		return -EFAULT;
-
+	hdr =3D btf->data;
+	hdr_len =3D hdr->hdr_len;
 	if (btf_data_size < hdr_len) {
 		btf_verifier_log(env, "btf_header not found");
 		return -EINVAL;
 	}
=20
-	err =3D bpf_check_uarg_tail_zero(btf_data, sizeof(btf->hdr), hdr_len);
-	if (err) {
-		if (err =3D=3D -E2BIG)
-			btf_verifier_log(env, "Unsupported btf_header");
-		return err;
+	/* Ensure the unsupported header fields are zero */
+	if (hdr_len > sizeof(btf->hdr)) {
+		u8 *expected_zero =3D btf->data + sizeof(btf->hdr);
+		u8 *end =3D btf->data + hdr_len;
+
+		for (; expected_zero < end; expected_zero++) {
+			if (*expected_zero) {
+				btf_verifier_log(env, "Unsupported btf_header");
+				return -E2BIG;
+			}
+		}
 	}
=20
 	hdr_copy =3D min_t(u32, hdr_len, sizeof(btf->hdr));
-	if (copy_from_user(&btf->hdr, btf_data, hdr_copy))
-		return -EFAULT;
+	memcpy(&btf->hdr, btf->data, hdr_copy);
=20
 	hdr =3D &btf->hdr;
=20
-	if (hdr->hdr_len !=3D hdr_len)
-		return -EINVAL;
-
 	btf_verifier_log_hdr(env, btf_data_size);
=20
 	if (hdr->magic !=3D BTF_MAGIC) {
@@ -2186,10 +2177,6 @@ static struct btf *btf_parse(void __user *btf_data, =
u32 btf_data_size,
 	}
 	env->btf =3D btf;
=20
-	err =3D btf_parse_hdr(env, btf_data, btf_data_size);
-	if (err)
-		goto errout;
-
 	data =3D kvmalloc(btf_data_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
 		err =3D -ENOMEM;
@@ -2198,13 +2185,18 @@ static struct btf *btf_parse(void __user *btf_data,=
 u32 btf_data_size,
=20
 	btf->data =3D data;
 	btf->data_size =3D btf_data_size;
-	btf->nohdr_data =3D btf->data + btf->hdr.hdr_len;
=20
 	if (copy_from_user(data, btf_data, btf_data_size)) {
 		err =3D -EFAULT;
 		goto errout;
 	}
=20
+	err =3D btf_parse_hdr(env);
+	if (err)
+		goto errout;
+
+	btf->nohdr_data =3D btf->data + btf->hdr.hdr_len;
+
 	err =3D btf_parse_str_sec(env);
 	if (err)
 		goto errout;
--=20
2.17.1


