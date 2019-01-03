Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01886C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A922220815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C/L6m6Wp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Hhyj/9mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfACTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:12:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52566 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbfACTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:12:21 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03J8r25001488;
        Thu, 3 Jan 2019 11:12:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=bEEQiVEyN4PSFg7QgJRakhj747V2bF6VcEkqn4jqSb4=;
 b=C/L6m6WpxhmjVrSy+5wv/Xzd8R+DUuSWRc2DwARGQB4aUNT0CYqV1l6FYCg0KMbXTAPK
 dinOnbt5xxA0vjTH7d5Emd2bdbeqZZcoW1G2U9oZzGfiUZlOS1Z7d67FlsaJtdrNI0O9
 VUGcjMTb3MBhEimWS5cU2JzlpKTuNoQfwws= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2psr3x01u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Jan 2019 11:12:10 -0800
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 3 Jan 2019 11:12:09 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 3 Jan 2019 11:12:09 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 3 Jan 2019 11:12:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEEQiVEyN4PSFg7QgJRakhj747V2bF6VcEkqn4jqSb4=;
 b=Hhyj/9miKVgmH2V8O85jkmJV90CztXJ8kJFvGqi3pSyFmfkqmOX3ATX8d6HG31cjeQjrIqhmwLuxgKNtdwucEFkR3aUpntz2+xTLg7WgoI2bSwJQ7q2u/LcP/kSlgyLtXsSYFw9lCPxMXI0nmC7MrKfIke52HehCdtMv830iUe0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 3 Jan 2019 19:12:05 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::b109:3050:fc26:dabd]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::b109:3050:fc26:dabd%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 19:12:05 +0000
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
Thread-Index: AQHUo1n4FpegqxaW/0erdMKyg0tF/KWd6bEA
Date:   Thu, 3 Jan 2019 19:12:05 +0000
Message-ID: <20190103191158.yu4cjkb3wd3zvpqk@kafai-mbp>
References: <20190103114613.GB3957@osiris>
In-Reply-To: <20190103114613.GB3957@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:301:2::14) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:3d39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1134;20:35vbQ2iR7/uE4JXl8IcgsUrIywdoKEK+QyS+XurTPKM32yFGj+mccL4+r1iCcNyGM7QO2my+zs3Curq8PHCDsDpmxyA3FHB0mOeSWAnDBXOFLcktq70nnxCSn6joIfXW2e3ztIFUan2k3vWiswxIQK9psQieNksPLofH8vIER7s=
x-ms-office365-filtering-correlation-id: a92656a2-8d17-47e1-08c4-08d671af5932
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1134;
x-ms-traffictypediagnostic: MWHPR15MB1134:
x-microsoft-antispam-prvs: <MWHPR15MB1134F69CFC0AC79515EB6BA2D58D0@MWHPR15MB1134.namprd15.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1134;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1134;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(6116002)(6436002)(446003)(14454004)(316002)(486006)(1076003)(5660300001)(6916009)(476003)(25786009)(6486002)(229853002)(966005)(478600001)(102836004)(99286004)(54906003)(97736004)(46003)(6506007)(11346002)(68736007)(386003)(52116002)(39060400002)(5024004)(14444005)(33716001)(186003)(53936002)(71200400001)(71190400001)(256004)(76176011)(9686003)(6306002)(6512007)(2906002)(106356001)(7736002)(105586002)(305945005)(33896004)(6246003)(4326008)(81166006)(8936002)(81156014)(575784001)(86362001)(8676002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1134;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ObUIpHwLn2Gm8yHnwcPMRspZ6apR1A7B9SmJezLoBTo2Q0vjHjnulOs8qJDMMy7HINLXddiWcfnz6sWFPzjz5XW+J4MrQoOFCiJthV3DoMYCMxybJnpYVZAM6kmF5AfOLhLud0wKy6YXgZAS6EZYGB3YQW2cEHnicz5fBwrGvaHx2ze6kXlPvWDQjSccYES8q2x2JXQUvANtR7+iDeSxgoh8ft2EpGXSQ5e/XzAqxdya3uYmHtFU9hV702o0YMOr1noiE98h8c3u7Mm3VL349HZDXe8VmZgObKE49rrLlFoLhK2XqxIZhKevtcmJgcHf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCFFCA13C59B134B811877CA2F0BA00C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a92656a2-8d17-47e1-08c4-08d671af5932
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 19:12:05.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 12:46:13PM +0100, Heiko Carstens wrote:
> Hello,
>=20
> the kernel commit 7337224fc150 ("bpf: Improve the info.func_info and
> info.func_info_rec_size behavior") breaks one of strace's self tests:
>=20
> FAIL: bpf-obj_get_info_by_fd-prog-v.gen
The strace's bpf-obj_get_info_by_fd-prog-v test did fail.  However,
I failed to see how 7337224fc150 broke it.  How do you trace down to
commit 7337224fc150 and can you share your test output?

The failure I can reproduce is EFAULT.  It should have been failing
as early as "nr_jited_ksyms" is added to "struct bpf_prog_info"
in linux/bpf.h.

The sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &bpf_prog_get_info_attr, ...) is called
in a loop. The bpf_prog_get_info_attr.info object is in size 104 but
bpf_prog_get_info_attr.info_len is in size 168.  Hence,
if the prog is jited, the second iteraton onwards will have nr_jited_ksyms =
=3D=3D 1
which is asking the kernel to fill the bpf_prog_get_info_attr.info.jited_ks=
yms
and it is NULL.

This fix the strace's test program:
diff --git i/tests/bpf-obj_get_info_by_fd.c w/tests/bpf-obj_get_info_by_fd.=
c
index e95afda27b3d..953083720822 100644
--- i/tests/bpf-obj_get_info_by_fd.c
+++ w/tests/bpf-obj_get_info_by_fd.c
@@ -19,6 +19,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 #include <sys/sysmacros.h>
 #include <asm/unistd.h>
=20
@@ -341,6 +342,7 @@ main(void)
 	size_t old_prog_info_len =3D PROG_INFO_SZ;
=20
 	for (unsigned int i =3D 0; i < 4; i++) {
+		memset(prog_info + 1, 0, PROG_INFO_SZ - sizeof(*prog_info));
 		prog_info->jited_prog_len =3D 0;
 		switch (i) {
 		case 1:

After the above change:
[root@arch-fb-vm1 tests]# ./bpf-obj_get_info_by_fd-prog-v
bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_ARRAY, key_size=3D4, value_siz=
e=3D8, max_entries=3D1, map_flags=3D0, inner_map_fd=3D0</dev/null>, map_nam=
e=3D"test_map", map_ifindex=3D0}, 48) =3D 3<anon_inode:bpf-map>
bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=3D9, =
insns=3D[{code=3DBPF_ALU64|BPF_K|BPF_MOV, dst_reg=3DBPF_REG_1, src_reg=3DBP=
F_REG_0, off=3D0, imm=3D0}, {code=3DBPF_STX|BPF_W|BPF_MEM, dst_reg=3DBPF_RE=
G_10, src_reg=3DBPF_REG_1, off=3D-4, imm=3D0}, {code=3DBPF_ALU64|BPF_X|BPF_=
MOV, dst_reg=3DBPF_REG_2, src_reg=3DBPF_REG_10, off=3D0, imm=3D0}, {code=3D=
BPF_ALU64|BPF_K|BPF_ADD, dst_reg=3DBPF_REG_2, src_reg=3DBPF_REG_0, off=3D0,=
 imm=3D0xfffffffc}, {code=3DBPF_LD|BPF_DW|BPF_IMM, dst_reg=3DBPF_REG_1, src=
_reg=3DBPF_REG_1, off=3D0, imm=3D0x3}, {code=3DBPF_LD|BPF_W|BPF_IMM, dst_re=
g=3DBPF_REG_0, src_reg=3DBPF_REG_0, off=3D0, imm=3D0}, {code=3DBPF_JMP|BPF_=
K|BPF_CALL, dst_reg=3DBPF_REG_0, src_reg=3DBPF_REG_0, off=3D0, imm=3D0x1}, =
{code=3DBPF_ALU64|BPF_K|BPF_MOV, dst_reg=3DBPF_REG_0, src_reg=3DBPF_REG_0, =
off=3D0, imm=3D0}, {code=3DBPF_JMP|BPF_K|BPF_EXIT, dst_reg=3DBPF_REG_0, src=
_reg=3DBPF_REG_0, off=3D0, imm=3D0}], license=3D"BSD", log_level=3D42, log_=
size=3D4096, log_buf=3D"", kern_version=3DKERNEL_VERSION(57005, 192, 222), =
prog_flags=3D0, prog_name=3D"test_prog", prog_ifindex=3D0, expected_attach_=
type=3DBPF_CGROUP_INET_INGRESS}, 72) =3D 4<anon_inode:bpf-prog>
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D3<anon_inode:bpf-map>, info_l=
en=3D128 =3D> 80, info=3D{type=3DBPF_MAP_TYPE_ARRAY, id=3D13, key_size=3D4,=
 value_size=3D8, max_entries=3D1, map_flags=3D0, name=3D"test_map", ifindex=
=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}}, 16) =3D 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info_=
len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D12, tag=3D"\xda=
\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_insn=
s=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3DNULL, load_time=
=3D1360454956729, created_by_uid=3D0, nr_map_ids=3D0 =3D> 1, map_ids=3DNULL=
, name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0=
}}}, 16) =3D 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info_=
len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D12, tag=3D"\xda=
\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0, jited_prog_insns=3DNULL,=
 xlated_prog_len=3D336, xlated_prog_insns=3D0x7fda42a02000, load_time=3D136=
0454956729, created_by_uid=3D0, nr_map_ids=3D2, map_ids=3D0x7fda429f5000, n=
ame=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}}=
, 16) =3D -1 EFAULT (Bad address)
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info_=
len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D12, tag=3D"\xda=
\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_insn=
s=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_time=
=3D1360454956729, created_by_uid=3D0, nr_map_ids=3D0 =3D> 1, map_ids=3D[], =
name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0}}=
}, 16) =3D 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, info_=
len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D12, tag=3D"\xda=
\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog_insn=
s=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_time=
=3D1360454956729, created_by_uid=3D0, nr_map_ids=3D2 =3D> 1, map_ids=3D[13]=
, name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D0=
}}}, 16) =3D 0
+++ exited with 0 +++

>=20
> Looking into the kernel commit, it seems that the user space visible
> uapi change is intentional; even though it might break existing user
> space.
>=20
> To reproduce:
>=20
> git clone https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.c=
om_strace_strace.git&d=3DDwIDAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DVQnoQ7LvghIj=
0gVEaiQSUw&m=3D0KV2Bnx31aCm6v7x7mYMZ26wy_rnRwk6QrpXEXP0CIE&s=3Dc7S2IRhn_p6F=
F1Z2HrhC8mAMvncVDYMPpLxhvftDlV8&e=3D
> cd strace
> ./bootstrap
> ./configure
> make -j $(nproc)
> cd tests
> make -j $(nproc) check
>=20
