Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC340C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6373E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nsTK8tKP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aRb5cZnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6373E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeLJWqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:46:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55420 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727405AbeLJWqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:46:51 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAMhNuW015022;
        Mon, 10 Dec 2018 14:46:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rt9OGorEGVpJ6iaaljvu5WBMpZrGn+ygK0twMmdKPmY=;
 b=nsTK8tKPn7GBf6FxrORc0W/W7S2XxDTHRc6TfRc64oCISPYISjqSwozymx9qsfNtJ1QZ
 BD2jvf7mnKcXRqCNFWG81T9j/vyvyGhqVYGTEn1xndZ4kcmYRLGXF+UsBtz8oZWE14Bm
 Xo9qZ+PAIxxrWE3zz1+Z/kIL7J5cVGft0Rw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9yxf89v5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 14:46:30 -0800
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 14:46:27 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 14:46:27 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 14:46:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt9OGorEGVpJ6iaaljvu5WBMpZrGn+ygK0twMmdKPmY=;
 b=aRb5cZntYJvN2RzpFImgmyb+0fvQ8mHgWRyiGs3Z7uG1el/iMqRClaScWrX+Kxs9IOyInRxa+EdkXvh9rxpnjVPR22qD74DyzKPLq9bLBE/1UZjGJY9WpnD2tL7VaB7dNPHprgSX3kVK3BBcjYAVanlIkxt6/d1/WTra656nOCM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2519.namprd15.prod.outlook.com (20.179.154.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 22:46:05 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 22:46:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Yonghong Song <yhs@fb.com>
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
Thread-Index: AQHUjpCFRX6wnHEMq0K3+QCygntWjaV0MZaAgARliIA=
Date:   Mon, 10 Dec 2018 22:46:04 +0000
Message-ID: <20181210224600.GB28954@tower.DHCP.thefacebook.com>
References: <20181208005315.3500-1-guro@fb.com>
 <20181208005315.3500-2-guro@fb.com>
 <60a77f17-6d63-2f73-e0b2-0ca8b5338169@fb.com>
In-Reply-To: <60a77f17-6d63-2f73-e0b2-0ca8b5338169@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:101:1f::13) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:9244]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2519;20:AV7g2xg93PYRwuI1isv7pcFbghdhppi5bhTUriWheOhviPo3oDIY2YETPQoQGbyNo2m2AiiJlGX2PKaF4P6zFsTf89ARv38Le6Vpxk9QO4s4sl3RAkITTA2akcntep4NFB5XHhRNAsKFqUc1xCi5rXrz6lbr6n+7Dw7CJjsIkuY=
x-ms-office365-filtering-correlation-id: 6a680f4b-e497-4bb8-032a-08d65ef14433
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2519;
x-ms-traffictypediagnostic: BYAPR15MB2519:
x-microsoft-antispam-prvs: <BYAPR15MB2519EFEEF3FB2765DAF615FFBEA50@BYAPR15MB2519.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3002001)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2519;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2519;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(46003)(9686003)(256004)(6116002)(6436002)(11346002)(6636002)(39060400002)(446003)(478600001)(7736002)(6512007)(5024004)(14444005)(33656002)(6486002)(476003)(53546011)(386003)(186003)(102836004)(25786009)(52116002)(86362001)(71190400001)(81166006)(81156014)(71200400001)(33896004)(8676002)(305945005)(76176011)(1076002)(14454004)(2906002)(105586002)(345774005)(68736007)(99286004)(486006)(97736004)(6506007)(54906003)(6246003)(6862004)(229853002)(53936002)(106356001)(4326008)(316002)(8936002)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2519;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wPiFgqs+qH6xMd2aNZ4TlbpWAIGgE+C6gVwHkZNbTH46VX56DWA6eZPS9Tc0frFZ1OwGsX+QhJe8sBXiNPCPkRU6q5FUqKgpGoRDnyTUBXLMQngdScEFR9L3VU4OkZSuOW/ebE0k2LsEJj1Ag3Wx5WWh8at5DEyifTCnCSGm7qsNGxKySfZBGGiMAYfeuzRXaIl83f1icL2WKAo0IGu8zSOBiZTjxUaQWt90pEgwMzg/Px9jjFw4y/KzoYexLh7ScM1NLjDUGFd4PujLAYZDwJJYrWPLQOl0X9vi3h7KQHo1lQLMUskWRCpfmZAYv4bz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DBAF662DDA8D34AAF6C834832E54642@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a680f4b-e497-4bb8-032a-08d65ef14433
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 22:46:04.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 07:37:35PM -0800, Yonghong Song wrote:
>=20
>=20
> On 12/7/18 4:53 PM, Roman Gushchin wrote:
> > Implement bpffs pretty printing for cgroup local storage maps
> > (both shared and per-cpu).
> > Output example (captured for tools/testing/selftests/bpf/netcnt_prog.c)=
:
> >=20
> > Shared:
> >    $ cat /sys/fs/bpf/map_2
> >    # WARNING!! The output is for debug purpose only
> >    # WARNING!! The output format will change
> >    {4294968594,1}: {9999,1039896}
> >=20
> > Per-cpu:
> >    $ cat /sys/fs/bpf/map_1
> >    # WARNING!! The output is for debug purpose only
> >    # WARNING!! The output format will change
> >    {4294968594,1}: {
> >    	cpu0: {0,0,0,0,0}
> >    	cpu1: {0,0,0,0,0}
> >    	cpu2: {1,104,0,0,0}
> >    	cpu3: {0,0,0,0,0}
> >    }
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >   include/linux/btf.h        | 10 +++++
> >   kernel/bpf/local_storage.c | 90 +++++++++++++++++++++++++++++++++++++=
-
> >   2 files changed, 99 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 8c2199b5d250..ac67bc4cbfd9 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -5,6 +5,7 @@
> >   #define _LINUX_BTF_H 1
> >  =20
> >   #include <linux/types.h>
> > +#include <uapi/linux/btf.h>
> >  =20
> >   struct btf;
> >   struct btf_type;
> > @@ -63,4 +64,13 @@ static inline const char *btf_name_by_offset(const s=
truct btf *btf,
> >   }
> >   #endif
> >  =20
> > +static inline const struct btf_type *btf_orig_type(const struct btf *b=
tf,
> > +						   const struct btf_type *t)
> > +{
> > +	while (t && BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPEDEF)
> > +		t =3D btf_type_by_id(btf, t->type);
> technically, type modifier "const" and "volatile" can apply to member=20
> type as well. But these modifiers really don't make sense here.
> Could you add a comment here to mention that they will be treated
> as an error since such a programming is not really recommended?

Switched over to btf_type_id_size() based on Martin's suggestion.

>=20
> > +
> > +	return t;
> > +}
> > +
> >   #endif
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index b65017dead44..7b51fe1aba3c 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -1,11 +1,13 @@
> >   //SPDX-License-Identifier: GPL-2.0
> >   #include <linux/bpf-cgroup.h>
> >   #include <linux/bpf.h>
> > +#include <linux/btf.h>
> >   #include <linux/bug.h>
> >   #include <linux/filter.h>
> >   #include <linux/mm.h>
> >   #include <linux/rbtree.h>
> >   #include <linux/slab.h>
> > +#include <uapi/linux/btf.h>
> >  =20
> >   DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF=
_CGROUP_STORAGE_TYPE]);
> >  =20
> > @@ -308,6 +310,91 @@ static int cgroup_storage_delete_elem(struct bpf_m=
ap *map, void *key)
> >   	return -EINVAL;
> >   }
> >  =20
> > +static int cgroup_storage_check_btf(const struct bpf_map *map,
> > +				    const struct btf *btf,
> > +				    const struct btf_type *key_type,
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
> > +		return -EINVAL;
>=20
> We should not use t->size here. The "t->size" is the type size, and the
> real number of bits held by the member is BTF_INT_BITS(...) with the=20
> argument of the u32 int value after "t".
>=20
> > +
> > +	/*
> > +	 * The second field must be a 32 bit integer at 0 offset.
> > +	 */
> > +	m =3D m + 1;
> > +	t =3D btf_orig_type(btf, btf_type_by_id(btf, m->type));
> > +	if (!t || BTF_INFO_KIND(t->info) !=3D BTF_KIND_INT ||
> > +	    m->offset !=3D offsetof(struct bpf_cgroup_storage_key, attach_typ=
e) *
> > +	    BITS_PER_BYTE || t->size !=3D
> > +	    FIELD_SIZEOF(struct bpf_cgroup_storage_key, attach_type))
> > +		return -EINVAL;
>=20
> The same is here. t->size should not be used.
> BTF_INT_BITS(...) should be used.

Fixed in v2, which I'll send soon.

Thank you for the review!
