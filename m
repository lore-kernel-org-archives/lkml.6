Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E24C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880692084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RlDsUd+A";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZLNudDqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880692084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeLJSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:19:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38854 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbeLJSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:19:40 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAIFFkW031084;
        Mon, 10 Dec 2018 10:19:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hw5DPuZuonFZdqTqMxagMmy4kKcGYCfImM6xlrSnWA8=;
 b=RlDsUd+AIg0sk8PhMFKOCVQ3PHhDRCA55UD/HxGMAv7fP+/0Btzw62F4qhnRdhgiThkM
 pWx64KsdK4Zh8kv1VuHbNjzWlgTDZ8XXP2V2Ug4J4oIdoyxrTSti1mQDuVeOoAuG0acy
 r3TiZ1Eg0hhLIT/ffBqyJpURnxjB377zjT0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9v1w0bkp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 10:19:17 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 10:19:00 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 10:19:00 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 10:19:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw5DPuZuonFZdqTqMxagMmy4kKcGYCfImM6xlrSnWA8=;
 b=ZLNudDqN4EPwyKkBsLlpJitG1N0G7RQ4srykAhFM14gUM0C2egWpUhXOx5Nx4fUFiAwl2zhl954I03JNn0NOr8Y0luknKbbi3YA3AtE4eqEGskgZrp48zLR9wK4GoYPHwUarHXDYwcr2z2kRqNn7QUz6Ik4Xw4SxA1bXO697Tog=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2549.namprd15.prod.outlook.com (20.179.155.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 18:18:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 18:18:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Martin Lau <kafai@fb.com>
CC:     Roman Gushchin <guroan@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 2/3] bpf: add bpffs pretty print for cgroup local
 storage maps
Thread-Topic: [PATCH bpf-next 2/3] bpf: add bpffs pretty print for cgroup
 local storage maps
Thread-Index: AQHUjpCFRX6wnHEMq0K3+QCygntWjaV1p60AgAKkzwA=
Date:   Mon, 10 Dec 2018 18:18:58 +0000
Message-ID: <20181210181852.GA28954@tower.DHCP.thefacebook.com>
References: <20181208005315.3500-1-guro@fb.com>
 <20181208005315.3500-2-guro@fb.com>
 <20181209015627.tkyspsafhwl3ak5b@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20181209015627.tkyspsafhwl3ak5b@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:300:6c::20) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:9244]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2549;20:s9s8Bbb4OxSc5Fl4IIRkkHmM08YQvkfOVT8G9zTrP3ZNBg7lbnFoOq8AbTZ3WOCp1mkJ4oXrEmId81a4QWVEo8XkOzb/2XSW/1ljQsUumMvYNVGrpASh8wCR2FZXpK5Zfkmx3/FGkfRPRQ7vqo3sIhuCGzCOQX4vXgIKpe3XuU0=
x-ms-office365-filtering-correlation-id: a8ddaa89-0d92-4599-6640-08d65ecbf3b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2549;
x-ms-traffictypediagnostic: BYAPR15MB2549:
x-microsoft-antispam-prvs: <BYAPR15MB254998A9B615A376B69AB523BEA50@BYAPR15MB2549.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(11241501185)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2549;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2549;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(71200400001)(9686003)(6512007)(386003)(5660300001)(97736004)(71190400001)(14454004)(102836004)(106356001)(446003)(6506007)(105586002)(2906002)(186003)(8676002)(486006)(99286004)(478600001)(46003)(6436002)(52116002)(7736002)(33896004)(6636002)(53936002)(316002)(6486002)(76176011)(476003)(305945005)(11346002)(25786009)(81166006)(81156014)(256004)(14444005)(6862004)(8936002)(1076002)(86362001)(229853002)(6116002)(33656002)(4326008)(6246003)(68736007)(54906003)(39060400002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2549;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iisSv0sO5VXTJPqEHaq3hSYGS12TMPHTskS5ykvaseyjcsyabd9TFgczgdBKMYu8cnQk48wbb6uDfo5cNnvxXdv86ywAUQWG1otaZkooOzDKf6N/qQOwQrlMzm1QTgZwpX04tLijekyYugsStMxlcTTCAFRMB3R0hDrsvQ1fLFywOX1D6rQyDD+kWEbQVTICBn6TWJZbbm05AcO9clQQmfKCiQfBJyx3GyLZeyYNkmEKr4EmJT+2VGuaQLS1Pp2udbpLNrTkGLFrZOwjb4/H37C0xdb7367xeyHkXTDvkmiTjF8YxKTDdgpqXLQm5FqK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <425FAA4079CE3942B4070CDDF991A41A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ddaa89-0d92-4599-6640-08d65ecbf3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 18:18:58.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2549
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 05:56:30PM -0800, Martin Lau wrote:
> On Fri, Dec 07, 2018 at 04:53:14PM -0800, Roman Gushchin wrote:
> > Implement bpffs pretty printing for cgroup local storage maps
> > (both shared and per-cpu).
> > Output example (captured for tools/testing/selftests/bpf/netcnt_prog.c)=
:
> >=20
> > Shared:
> >   $ cat /sys/fs/bpf/map_2
> >   # WARNING!! The output is for debug purpose only
> >   # WARNING!! The output format will change
> >   {4294968594,1}: {9999,1039896}
> >=20
> > Per-cpu:
> >   $ cat /sys/fs/bpf/map_1
> >   # WARNING!! The output is for debug purpose only
> >   # WARNING!! The output format will change
> >   {4294968594,1}: {
> >   	cpu0: {0,0,0,0,0}
> >   	cpu1: {0,0,0,0,0}
> >   	cpu2: {1,104,0,0,0}
> >   	cpu3: {0,0,0,0,0}
> >   }
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  include/linux/btf.h        | 10 +++++
> >  kernel/bpf/local_storage.c | 90 +++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 99 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 8c2199b5d250..ac67bc4cbfd9 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -5,6 +5,7 @@
> >  #define _LINUX_BTF_H 1
> > =20
> >  #include <linux/types.h>
> > +#include <uapi/linux/btf.h>
> > =20
> >  struct btf;
> >  struct btf_type;
> > @@ -63,4 +64,13 @@ static inline const char *btf_name_by_offset(const s=
truct btf *btf,
> >  }
> >  #endif
> > =20
> > +static inline const struct btf_type *btf_orig_type(const struct btf *b=
tf,
> > +						   const struct btf_type *t)
> > +{
> > +	while (t && BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPEDEF)
> > +		t =3D btf_type_by_id(btf, t->type);
> Only typedef is allowed?  Not even const?
> If that is not the case, can btf_type_id_size() be reused?
> The "type following" has already been done once and then remembered
> in the verification time.
>=20
> If cgroup_storage_check_btf() can only allow typedef, please
> move "btf_orig_type()" to the local_storage.c.
>=20
> > +
> > +	return t;
> > +}
> > +
> >  #endif
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index b65017dead44..7b51fe1aba3c 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -1,11 +1,13 @@
> >  //SPDX-License-Identifier: GPL-2.0
> >  #include <linux/bpf-cgroup.h>
> >  #include <linux/bpf.h>
> > +#include <linux/btf.h>
> >  #include <linux/bug.h>
> >  #include <linux/filter.h>
> >  #include <linux/mm.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/slab.h>
> > +#include <uapi/linux/btf.h>
> > =20
> >  DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_=
CGROUP_STORAGE_TYPE]);
> > =20
> > @@ -308,6 +310,91 @@ static int cgroup_storage_delete_elem(struct bpf_m=
ap *map, void *key)
> >  	return -EINVAL;
> >  }
> > =20
> > +static int cgroup_storage_check_btf(const struct bpf_map *map,
> > +				    const struct btf *btf,
> > +				    const struct btf_type *key_type,
> Actually, in "map_check_btf()" (just before cgroup_storage_check_btf()
> is called), btf_type_id_size() has already been called
> to get the true size and the resolved type (i.e. BTF_INFO_KIND_STRUCT her=
e)
> in order to reject "key_size !=3D map->key_size".  Hence, the key_type
> passed to cgroup_storage_check_btf() here will not be KIND_TYPEDEF or
> KIND_CONST.

So, the type here is a structure, and its fields are typedefs of ints.
Looks like reusing btf_type_id_size() is the best approach.

>=20
> > +				    const struct btf_type *value_type)
> > +{
> > +	const struct btf_type *st, *t;
> > +	struct btf_member *m;
> > +
> > +	/* Key is expected to be of struct bpf_cgroup_storage_key type,
> > +	 * which is:
> > +	 * struct bpf_cgroup_storage_key {
> > +	 *	__u64	cgroup_inode_id;
> > +	 *	__u32	attach_type;
> > +	 * };
> > +	 */
> > +
> > +	/*
> > +	 * Key_type must be a structure (or a typedef of a structure) with
> > +	 * two members.
> > +	 */
> > +	st =3D btf_orig_type(btf, key_type);
> > +	if (BTF_INFO_KIND(st->info) !=3D BTF_KIND_STRUCT ||
> > +	    BTF_INFO_VLEN(st->info) !=3D 2)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The first field must be a 64 bit integer at 0 offset.
> > +	 */
> > +	m =3D (struct btf_member *)(st + 1);
> > +	t =3D btf_orig_type(btf, btf_type_by_id(btf, m->type));
> > +	if (!t || BTF_INFO_KIND(t->info) !=3D BTF_KIND_INT || m->offset ||
> > +	    t->size !=3D
> > +	    FIELD_SIZEOF(struct bpf_cgroup_storage_key, cgroup_inode_id))
> Instead of t->size,
> BTF_INT_BITS() and BTF_INT_OFFSET() need to be checked (please refer to t=
he
> key_type check in array_map_check_btf()).

Gotcha.

>=20
> I think exposing "btf_type_int_is_regular()" from btf.c will be easier he=
re.
> Actually, add "btf_type_is_reg_int(t, expected_size)" to btf.h and btf.c,
> like (uncompiled and untested code):

>=20
> /*
>  * Not a bit field and it must be the expected size.
>  */
> bool btf_type_is_reg_int(const struct btf_type *t, u32 expected_size)
> {
>  	u8 nr_bits, nr_bytes;
>         u32 int_data;
>=20
> 	if (!btf_type_is_int(t))
> 		return false;
>=20
> 	int_data =3D btf_type_int(t);
> 	nr_bits =3D BTF_INT_BITS(int_data);
> 	nr_bytes =3D BITS_ROUNDUP_BYTES(nr_bits);
> 	if (BITS_PER_BYTE_MASKED(nr_bits) ||
> 	    BTF_INT_OFFSET(int_data) ||
> 	    nr_bytes !=3D expected_size)
>                 return false;
>=20
> 	return true;
> }

Looks good to me. Will implement in v2.

Thanks!
