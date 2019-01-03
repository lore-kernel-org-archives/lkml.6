Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E36C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775820660
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WrmEtm1o";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="C/hYev+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfACXxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:53:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbfACXxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:53:02 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03Nn9uE002077;
        Thu, 3 Jan 2019 15:52:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uiW5y2SLuk1HXpD3LH7XkUq5wvpVpBDiKaW3y/ZPvTM=;
 b=WrmEtm1ov+oRjm2kHaoxs4nqsE3XxJJofa/HH5VFOLiVY4PZH4pHjQmHpxFd0v33arGi
 14N/vd+Rqrfhhp3HSBWlw2w10M5UvJrhMFeNYWLeNlXQYzS8jGpGMDkL34Dt122r5enB
 GGbPlUte/j8ILMys0/H2hkr3mDNJa3qqelE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2psrxy8nny-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Jan 2019 15:52:55 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 3 Jan 2019 15:52:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 3 Jan 2019 15:52:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiW5y2SLuk1HXpD3LH7XkUq5wvpVpBDiKaW3y/ZPvTM=;
 b=C/hYev+XfAg38mbWqQ3gYfNL7sMG8dJCi6BV6ybTRKti3OfXwytX+veP7soScu0r7A5mvLHfTamW3QfVPCSuyS+6EUwxyNk3wLa1JfqOWGHTB430vrWYC1d0CPmY1/TkLXfpnCsE6w+zalWoqOEE0BlcXadUa8uK7JrYliBWc1o=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1901.namprd15.prod.outlook.com (10.174.100.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 3 Jan 2019 23:52:51 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::b109:3050:fc26:dabd]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::b109:3050:fc26:dabd%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 23:52:51 +0000
From:   Martin Lau <kafai@fb.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
CC:     Eugene Syromyatnikov <evgsyr@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: "bpf: Improve the info.func_info and info.func_info_rec_size
 behavior" breaks strace self tests
Thread-Topic: "bpf: Improve the info.func_info and info.func_info_rec_size
 behavior" breaks strace self tests
Thread-Index: AQHUo1n4FpegqxaW/0erdMKyg0tF/KWd6bEAgAA6fACAABP7AA==
Date:   Thu, 3 Jan 2019 23:52:51 +0000
Message-ID: <20190103235248.kxvhhwq4brcdxzps@kafai-mbp>
References: <20190103114613.GB3957@osiris>
 <20190103191158.yu4cjkb3wd3zvpqk@kafai-mbp> <20190103224118.GA4491@osiris>
In-Reply-To: <20190103224118.GA4491@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:102:1::48) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:3d39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1901;20:a4jcwl3Hu52uIOX4kLReZDk+Py3yQkgAvnRNP/QUYHBFwx6raZ4cXQF8sUR9LkQGuy4GgWwZedNn6B//sPjfj2E9own2TcrZ9QMA5vHZzI3MOVrwcfRQdgCz7ek+gap+oitrrNzVTQModtd3oEBuRieHyKHyz/bytV1gknNlgQQ=
x-ms-office365-filtering-correlation-id: 70b4685e-ef1e-4a44-6fe5-08d671d69223
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1901;
x-ms-traffictypediagnostic: MWHPR15MB1901:
x-microsoft-antispam-prvs: <MWHPR15MB1901EEB92F4D9B4466A995E4D58D0@MWHPR15MB1901.namprd15.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1901;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1901;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(39060400002)(4326008)(14454004)(25786009)(5660300001)(316002)(54906003)(52116002)(76176011)(6916009)(33896004)(4744004)(1076003)(68736007)(256004)(14444005)(5024004)(478600001)(229853002)(11346002)(446003)(71190400001)(476003)(71200400001)(86362001)(46003)(186003)(6486002)(6436002)(33716001)(386003)(7736002)(305945005)(2906002)(81166006)(81156014)(8936002)(6506007)(8676002)(486006)(99286004)(102836004)(6246003)(105586002)(53936002)(9686003)(6512007)(106356001)(97736004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1901;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xt6WWZ6qRfRa1G5oR6gjbymQgPyGfyXu0voQyi0H3BvoTnLNZ2Yr+7Q0+AxRd8iM26uKq5cZfA0ApkXsVWd8RA1JvjLB9UAEsegn75c+Q5HfZ4zTREVktKQsmvRHIs5kY6C8kSNAA5HS6M1l4kUsy7yoENMJo+33jq7XsT067FUr00PqHPpW5UBRERmtoP1SkM/oavdHZZdMe3I83TV7NVISAwniVPZW+BMDjYNMNROZRXCZBQ1kKuqm4XmeWuw25HjU1+1hFDtNFUHVX3MzZi1mBWdnODodsxDANB5/nSrhCf3BHC75/QmSStGu5Ej+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <202FEBDFE625884D9D66C73A7081E090@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b4685e-ef1e-4a44-6fe5-08d671d69223
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 23:52:51.5896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1901
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 11:41:18PM +0100, Heiko Carstens wrote:
> On Thu, Jan 03, 2019 at 07:12:05PM +0000, Martin Lau wrote:
> > On Thu, Jan 03, 2019 at 12:46:13PM +0100, Heiko Carstens wrote:
> > > Hello,
> > >=20
> > > the kernel commit 7337224fc150 ("bpf: Improve the info.func_info and
> > > info.func_info_rec_size behavior") breaks one of strace's self tests:
> > >=20
> > > FAIL: bpf-obj_get_info_by_fd-prog-v.gen
> > The strace's bpf-obj_get_info_by_fd-prog-v test did fail.  However,
> > I failed to see how 7337224fc150 broke it.  How do you trace down to
> > commit 7337224fc150 and can you share your test output?
> >=20
> > The failure I can reproduce is EFAULT.  It should have been failing
> > as early as "nr_jited_ksyms" is added to "struct bpf_prog_info"
> > in linux/bpf.h.
>=20
> Ah, sorry(!), I forgot to mention an important detail: the test
> failure happens only if executed as normal (non-root) user.
>=20
> With 7337224fc150 ("bpf: Improve the info.func_info and
> info.func_info_rec_size behavior") the failure happens. With commit
> 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
> it passes; which is one commit earlier.
>=20
> FAIL: bpf-obj_get_info_by_fd-prog-v.gen
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> --- exp	2019-01-03 23:31:49.576949303 +0100
> +++ log	2019-01-03 23:31:49.576949303 +0100
> @@ -1,8 +1,8 @@
>  bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_ARRAY, key_size=3D4, value_=
size=3D8, max_entries=3D1, map_flags=3D0, inner_map_fd=3D0</dev/null>, map_=
name=3D"test_map", map_ifindex=3D0}, 48) =3D 3<anon_inode:bpf-map>
>  bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=3D=
9, insns=3D[{code=3DBPF_ALU64|BPF_K|BPF_MOV, dst_reg=3DBPF_REG_1, src_reg=
=3DBPF_REG_0, off=3D0, imm=3D0}, {code=3DBPF_STX|BPF_W|BPF_MEM, dst_reg=3DB=
PF_REG_10, src_reg=3DBPF_REG_1, off=3D-4, imm=3D0}, {code=3DBPF_ALU64|BPF_X=
|BPF_MOV, dst_reg=3DBPF_REG_2, src_reg=3DBPF_REG_10, off=3D0, imm=3D0}, {co=
de=3DBPF_ALU64|BPF_K|BPF_ADD, dst_reg=3DBPF_REG_2, src_reg=3DBPF_REG_0, off=
=3D0, imm=3D0xfffffffc}, {code=3DBPF_LD|BPF_DW|BPF_IMM, dst_reg=3DBPF_REG_1=
, src_reg=3DBPF_REG_1, off=3D0, imm=3D0x3}, {code=3DBPF_LD|BPF_W|BPF_IMM, d=
st_reg=3DBPF_REG_0, src_reg=3DBPF_REG_0, off=3D0, imm=3D0}, {code=3DBPF_JMP=
|BPF_K|BPF_CALL, dst_reg=3DBPF_REG_0, src_reg=3DBPF_REG_0, off=3D0, imm=3D0=
x1}, {code=3DBPF_ALU64|BPF_K|BPF_MOV, dst_reg=3DBPF_REG_0, src_reg=3DBPF_RE=
G_0, off=3D0, imm=3D0}, {code=3DBPF_JMP|BPF_K|BPF_EXIT, dst_reg=3DBPF_REG_0=
, src_reg=3DBPF_REG_0, off=3D0, imm=3D0}], license=3D"BSD", log_level=3D42,=
 log_size=3D4096, log_buf=3D"", kern_version=3DKERNEL_VERSION(57005, 192, 2=
22), prog_flags=3D0, prog_name=3D"test_prog", prog_ifindex=3D0, expected_at=
tach_type=3DBPF_CGROUP_INET_INGRESS}, 72) =3D 4<anon_inode:bpf-prog>
>  bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D3<anon_inode:bpf-map>, inf=
o_len=3D128 =3D> 80, info=3D{type=3DBPF_MAP_TYPE_ARRAY, id=3D15, key_size=
=3D4, value_size=3D8, max_entries=3D1, map_flags=3D0, name=3D"test_map", if=
index=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}}, 16) =3D 0
> -bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D168 =3D> 152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, =
tag=3D"\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_in=
sns=3DNULL, xlated_prog_len=3D0, xlated_prog_insns=3DNULL, load_time=3D2828=
1352029, created_by_uid=3D1000, nr_map_ids=3D0 =3D> 1, map_ids=3DNULL, name=
=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}}, 1=
6) =3D 0
> -bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, tag=3D"\x=
de\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_insns=3DNUL=
L, xlated_prog_len=3D336, xlated_prog_insns=3D0x3ff8d6f7000, load_time=3D28=
281352029, created_by_uid=3D1000, nr_map_ids=3D2, map_ids=3D0x3ff8d6f1000, =
name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}=
}, 16) =3D -1 EFAULT (Bad address)
> -bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, tag=3D"\x=
de\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_insns=3DNUL=
L, xlated_prog_len=3D0, xlated_prog_insns=3D[], load_time=3D28281352029, cr=
eated_by_uid=3D1000, nr_map_ids=3D0 =3D> 1, map_ids=3D[], name=3D"test_prog=
", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}}, 16) =3D 0
> -bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, tag=3D"\x=
de\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_insns=3DNUL=
L, xlated_prog_len=3D0, xlated_prog_insns=3D[], load_time=3D28281352029, cr=
eated_by_uid=3D1000, nr_map_ids=3D2 =3D> 1, map_ids=3D[15], name=3D"test_pr=
og", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}}, 16) =3D 0
> +bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D168 =3D> 152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, =
tag=3D"\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_in=
sns=3DNULL, xlated_prog_len=3D0, xlated_prog_insns=3DNULL, load_time=3D2828=
1352029, created_by_uid=3D1000, nr_map_ids=3D0 =3D> 1, map_ids=3DNULL, name=
=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0, /* b=
ytes 104..151 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0
> +bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, tag=3D"\x=
de\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_insns=3DNUL=
L, xlated_prog_len=3D336, xlated_prog_insns=3D0x3ff8d6f7000, load_time=3D28=
281352029, created_by_uid=3D1000, nr_map_ids=3D2, map_ids=3D0x3ff8d6f1000, =
name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0, =
/* bytes 104..151 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =
=3D -1 EFAULT (Bad address)
> +bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, tag=3D"\x=
de\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_insns=3DNUL=
L, xlated_prog_len=3D0, xlated_prog_insns=3D[], load_time=3D28281352029, cr=
eated_by_uid=3D1000, nr_map_ids=3D0 =3D> 1, map_ids=3D[], name=3D"test_prog=
", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0, /* bytes 104..151=
 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0
> +bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, in=
fo_len=3D152, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D8, tag=3D"\x=
de\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=3D0, jited_prog_insns=3DNUL=
L, xlated_prog_len=3D0, xlated_prog_insns=3D[], load_time=3D28281352029, cr=
eated_by_uid=3D1000, nr_map_ids=3D2 =3D> 1, map_ids=3D[15], name=3D"test_pr=
og", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0, /* bytes 104..1=
51 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0
>  +++ exited with 0 +++
> bpf-obj_get_info_by_fd-prog-v.gen.test: failed test: ../../strace -a20 -y=
 -v -e trace=3Dbpf ../bpf-obj_get_info_by_fd-prog-v output mismatch
> FAIL bpf-obj_get_info_by_fd-prog-v.gen.test (exit status: 1)
>
I am running against linux-next.  I don't see how root and non-root affect
thing here.  I guess the test has been running without jit so far?

1) root or not, if jit is enabled,
   without the memset() fix in the bpf-obj_get_info_by_fd.c in my last emai=
l,
   they all failed:
   [root@arch-fb-vm1 tests]# ./bpf-obj_get_info_by_fd-prog-v.gen.test
   BPF_OBJ_GET_INFO_BY_FD prog 2 failed: Bad address
   bpf-obj_get_info_by_fd-prog-v.gen.test: skipped test: ../bpf-obj_get_inf=
o_by_fd-prog-v exited with code 77

   Please fix this first.

2) After having the memset fix:
   Root or not, for jited program, if I run
   ./bpf-obj_get_info_by_fd-prog-v.gen.test, they failed.  If I read the
   init.sh correclty, it fails because there is a diff between the
   ./bpf-obj_get_info_by_fd-prog-v stdout and the "strace -o log".  I think
   "strace -o log" only has the /* bytes 104..151 */ part if some bytes
   are non-zero?

   Regardless, the test program "bpf-obj_get_info_by_fd.c" is telling
   the kernel that the userspace "info" is in size 168 bytes.
   The kernel then tells as much details as possible about
   a bpf prog in "info".  I don't see a ABI breakage here.

   I believe the test just happens to work so far because it has been runni=
ng
   without jit?

   If I run it with jit enabled:
-bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info=
_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D"\xd=
a\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_ins=
ns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_time=
=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D0 =3D> 1, map_ids=3D[], =
name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}=
}, 16) =3D 0
-bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info=
_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D"\xd=
a\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_ins=
ns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_time=
=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D2 =3D> 1, map_ids=3D[36]=
, name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0=
}}}, 16) =3D 0
+bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info=
_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D"\xd=
a\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_ins=
ns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_time=
=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D0 =3D> 1, map_ids=3D[], =
name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0, =
/* bytes 104..167 */ "\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0
+bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info=
_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D"\xd=
a\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_ins=
ns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_time=
=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D2 =3D> 1, map_ids=3D[36]=
, name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0=
, /* bytes 104..167 */ "\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0

  The diff comes in as early as byte 104-th which is the nr_jited_ksyms =3D=
=3D 1.

  Please fix the test program.  A protential fix is in bpf-obj_get_info_by_=
fd.c
  to printf the non-zero "/* bytes 104..1xx */..." the same way as the
  "strace -o log" does.

