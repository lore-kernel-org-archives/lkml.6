Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67255C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 01:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7892081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 01:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Xy1MbHF0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TDW3o0Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7892081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLIB5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 20:57:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60692 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbeLIB5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 20:57:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB91um7w006877;
        Sat, 8 Dec 2018 17:56:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=J93kjmZIobs0uI+Jj+LVEg78S3ihiwxZ9U7Um8VRRiw=;
 b=Xy1MbHF07IMhPtkg5j36eNN9thvbtCmTcp5G+uXJOV/L6sUVee2XBAElmnXyz5+dvGIU
 F9FuE6Hq0VAOG0iF5wl3Cgu02ic2I9o+if9cCeyD2oNpTUQMJzbm1I8DvdJN6gxSe6TG
 rsW7e/51Vwuve0q3u1YphAC1RHKZE24VWBU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p8nawrek9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 08 Dec 2018 17:56:53 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sat, 8 Dec 2018 17:56:52 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Sat, 8 Dec 2018 17:56:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J93kjmZIobs0uI+Jj+LVEg78S3ihiwxZ9U7Um8VRRiw=;
 b=TDW3o0DtAhfQhwdXP6iJbnpxqS0/jdNfN9IJGgD6wgjx+5CezR4acV0JFsq1jasgz3YQVMaH2WD+3sKGFcxF0oIRuxSal4cUczvunw7Gc3+i2PJReNMxyHcLoVozok4L42wvXZgvv56MzS5kPi59acOvKnd++jVvJtg75va92XE=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1328.namprd15.prod.outlook.com (10.175.3.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Sun, 9 Dec 2018 01:56:30 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::9d20:17f:ac07:601]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::9d20:17f:ac07:601%5]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 01:56:30 +0000
From:   Martin Lau <kafai@fb.com>
To:     Roman Gushchin <guroan@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 2/3] bpf: add bpffs pretty print for cgroup local
 storage maps
Thread-Topic: [PATCH bpf-next 2/3] bpf: add bpffs pretty print for cgroup
 local storage maps
Thread-Index: AQHUjpCDCEcwAFHkIk67Bg9UX8GCJKV1p6mA
Date:   Sun, 9 Dec 2018 01:56:30 +0000
Message-ID: <20181209015627.tkyspsafhwl3ak5b@kafai-mbp.dhcp.thefacebook.com>
References: <20181208005315.3500-1-guro@fb.com>
 <20181208005315.3500-2-guro@fb.com>
In-Reply-To: <20181208005315.3500-2-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:300:95::25) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:352d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1328;20:gIkWWrjZlJLR9Hs40GcTAFYrediURX3oICaG/6GZu0IeCvc6Cwfzsrs8WXhSW9Y0hc+oQNi47oZyTRtUZw+hq0q41ovXyDgJRNqr7vTmFB9S1U4K13PPLErduimKWt378YQSardQ+y//oTB4lkwtrpsGGp8hh5QhMghsUOxnsus=
x-ms-office365-filtering-correlation-id: ad303a40-44b6-409f-2f7b-08d65d79895c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1328;
x-ms-traffictypediagnostic: MWHPR15MB1328:
x-microsoft-antispam-prvs: <MWHPR15MB13280B6ECDB248E8CE1BCE3CD5A40@MWHPR15MB1328.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231455)(999002)(11241501185)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1328;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1328;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(106356001)(105586002)(97736004)(5660300001)(4326008)(68736007)(53936002)(7736002)(9686003)(6512007)(6116002)(25786009)(305945005)(6246003)(186003)(39060400002)(76176011)(102836004)(46003)(1076002)(2906002)(52116002)(33896004)(99286004)(386003)(81166006)(54906003)(316002)(6436002)(8676002)(8936002)(81156014)(14444005)(5024004)(486006)(446003)(11346002)(256004)(476003)(478600001)(71190400001)(1411001)(6486002)(6506007)(6916009)(71200400001)(14454004)(86362001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1328;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zUVKJxbeTGKPSCL0jBEKGR0s0S6/a6iuRqd6Qnqr4igEqc48rua7DMuctC5Bbo0L2GSDqhxgUt0su23Vgkdw5n0zVlWNguydsiKPtWQt5Zq1Ua97eJTuW0Ex25ppQGOiCr5erE6pP5x92lMg3ltdE7LFSH52u3ucSh8gP/8dxxjMK1QrpPuQH2w/JUBq4qGm9AP00qQ0TYIqdsnKYCZMT2Q6S8K6HbRwKFDuOPDglBU6CTxZg711su5tExr8DT+lEqOEcLt5xcS7qL4z0CzENmeNMO8ro39kifuMB1KoABobWBb2LCXthb8mcPU7s2XrCEPKjoMBeA70yyOx9O8Ez1aEga/hqpj2rq4HOysckDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD51390EA99D2644A482E388843B86E7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad303a40-44b6-409f-2f7b-08d65d79895c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 01:56:30.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:53:14PM -0800, Roman Gushchin wrote:
> Implement bpffs pretty printing for cgroup local storage maps
> (both shared and per-cpu).
> Output example (captured for tools/testing/selftests/bpf/netcnt_prog.c):
>=20
> Shared:
>   $ cat /sys/fs/bpf/map_2
>   # WARNING!! The output is for debug purpose only
>   # WARNING!! The output format will change
>   {4294968594,1}: {9999,1039896}
>=20
> Per-cpu:
>   $ cat /sys/fs/bpf/map_1
>   # WARNING!! The output is for debug purpose only
>   # WARNING!! The output format will change
>   {4294968594,1}: {
>   	cpu0: {0,0,0,0,0}
>   	cpu1: {0,0,0,0,0}
>   	cpu2: {1,104,0,0,0}
>   	cpu3: {0,0,0,0,0}
>   }
>=20
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/btf.h        | 10 +++++
>  kernel/bpf/local_storage.c | 90 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 8c2199b5d250..ac67bc4cbfd9 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -5,6 +5,7 @@
>  #define _LINUX_BTF_H 1
> =20
>  #include <linux/types.h>
> +#include <uapi/linux/btf.h>
> =20
>  struct btf;
>  struct btf_type;
> @@ -63,4 +64,13 @@ static inline const char *btf_name_by_offset(const str=
uct btf *btf,
>  }
>  #endif
> =20
> +static inline const struct btf_type *btf_orig_type(const struct btf *btf=
,
> +						   const struct btf_type *t)
> +{
> +	while (t && BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPEDEF)
> +		t =3D btf_type_by_id(btf, t->type);
Only typedef is allowed?  Not even const?
If that is not the case, can btf_type_id_size() be reused?
The "type following" has already been done once and then remembered
in the verification time.

If cgroup_storage_check_btf() can only allow typedef, please
move "btf_orig_type()" to the local_storage.c.

> +
> +	return t;
> +}
> +
>  #endif
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index b65017dead44..7b51fe1aba3c 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -1,11 +1,13 @@
>  //SPDX-License-Identifier: GPL-2.0
>  #include <linux/bpf-cgroup.h>
>  #include <linux/bpf.h>
> +#include <linux/btf.h>
>  #include <linux/bug.h>
>  #include <linux/filter.h>
>  #include <linux/mm.h>
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
> +#include <uapi/linux/btf.h>
> =20
>  DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CG=
ROUP_STORAGE_TYPE]);
> =20
> @@ -308,6 +310,91 @@ static int cgroup_storage_delete_elem(struct bpf_map=
 *map, void *key)
>  	return -EINVAL;
>  }
> =20
> +static int cgroup_storage_check_btf(const struct bpf_map *map,
> +				    const struct btf *btf,
> +				    const struct btf_type *key_type,
Actually, in "map_check_btf()" (just before cgroup_storage_check_btf()
is called), btf_type_id_size() has already been called
to get the true size and the resolved type (i.e. BTF_INFO_KIND_STRUCT here)
in order to reject "key_size !=3D map->key_size".  Hence, the key_type
passed to cgroup_storage_check_btf() here will not be KIND_TYPEDEF or
KIND_CONST.

> +				    const struct btf_type *value_type)
> +{
> +	const struct btf_type *st, *t;
> +	struct btf_member *m;
> +
> +	/* Key is expected to be of struct bpf_cgroup_storage_key type,
> +	 * which is:
> +	 * struct bpf_cgroup_storage_key {
> +	 *	__u64	cgroup_inode_id;
> +	 *	__u32	attach_type;
> +	 * };
> +	 */
> +
> +	/*
> +	 * Key_type must be a structure (or a typedef of a structure) with
> +	 * two members.
> +	 */
> +	st =3D btf_orig_type(btf, key_type);
> +	if (BTF_INFO_KIND(st->info) !=3D BTF_KIND_STRUCT ||
> +	    BTF_INFO_VLEN(st->info) !=3D 2)
> +		return -EINVAL;
> +
> +	/*
> +	 * The first field must be a 64 bit integer at 0 offset.
> +	 */
> +	m =3D (struct btf_member *)(st + 1);
> +	t =3D btf_orig_type(btf, btf_type_by_id(btf, m->type));
> +	if (!t || BTF_INFO_KIND(t->info) !=3D BTF_KIND_INT || m->offset ||
> +	    t->size !=3D
> +	    FIELD_SIZEOF(struct bpf_cgroup_storage_key, cgroup_inode_id))
Instead of t->size,
BTF_INT_BITS() and BTF_INT_OFFSET() need to be checked (please refer to the
key_type check in array_map_check_btf()).

I think exposing "btf_type_int_is_regular()" from btf.c will be easier here=
.
Actually, add "btf_type_is_reg_int(t, expected_size)" to btf.h and btf.c,
like (uncompiled and untested code):

/*
 * Not a bit field and it must be the expected size.
 */
bool btf_type_is_reg_int(const struct btf_type *t, u32 expected_size)
{
 	u8 nr_bits, nr_bytes;
        u32 int_data;

	if (!btf_type_is_int(t))
		return false;

	int_data =3D btf_type_int(t);
	nr_bits =3D BTF_INT_BITS(int_data);
	nr_bytes =3D BITS_ROUNDUP_BYTES(nr_bits);
	if (BITS_PER_BYTE_MASKED(nr_bits) ||
	    BTF_INT_OFFSET(int_data) ||
	    nr_bytes !=3D expected_size)
                return false;

	return true;
}


> +		return -EINVAL;
> +
> +	/*
> +	 * The second field must be a 32 bit integer at 0 offset.
> +	 */
> +	m =3D m + 1;
> +	t =3D btf_orig_type(btf, btf_type_by_id(btf, m->type));
> +	if (!t || BTF_INFO_KIND(t->info) !=3D BTF_KIND_INT ||
> +	    m->offset !=3D offsetof(struct bpf_cgroup_storage_key, attach_type)=
 *
> +	    BITS_PER_BYTE || t->size !=3D
> +	    FIELD_SIZEOF(struct bpf_cgroup_storage_key, attach_type))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *_key=
,
> +					 struct seq_file *m)
> +{
> +	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
> +	struct bpf_cgroup_storage_key *key =3D _key;
> +	struct bpf_cgroup_storage *storage;
> +	int cpu;
> +
> +	rcu_read_lock();
> +	storage =3D cgroup_storage_lookup(map_to_storage(map), key, false);
> +	if (!storage) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
> +	stype =3D cgroup_storage_type(map);
> +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
> +		seq_puts(m, ": ");
> +		btf_type_seq_show(map->btf, map->btf_value_type_id,
> +				  &READ_ONCE(storage->buf)->data[0], m);
> +		seq_puts(m, "\n");
> +	} else {
> +		seq_puts(m, ": {\n");
> +		for_each_possible_cpu(cpu) {
> +			seq_printf(m, "\tcpu%d: ", cpu);
> +			btf_type_seq_show(map->btf, map->btf_value_type_id,
> +					  per_cpu_ptr(storage->percpu_buf, cpu),
> +					  m);
> +			seq_puts(m, "\n");
> +		}
> +		seq_puts(m, "}\n");
> +	}
> +	rcu_read_unlock();
> +}
> +
>  const struct bpf_map_ops cgroup_storage_map_ops =3D {
>  	.map_alloc =3D cgroup_storage_map_alloc,
>  	.map_free =3D cgroup_storage_map_free,
> @@ -315,7 +402,8 @@ const struct bpf_map_ops cgroup_storage_map_ops =3D {
>  	.map_lookup_elem =3D cgroup_storage_lookup_elem,
>  	.map_update_elem =3D cgroup_storage_update_elem,
>  	.map_delete_elem =3D cgroup_storage_delete_elem,
> -	.map_check_btf =3D map_check_no_btf,
> +	.map_check_btf =3D cgroup_storage_check_btf,
> +	.map_seq_show_elem =3D cgroup_storage_seq_show_elem,
>  };
> =20
>  int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_ma=
p)
> --=20
> 2.19.2
>=20
