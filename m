Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92692C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333621848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HPLLo5fV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TSo3Zxjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBSFsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:48:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40358 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbfBSFsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:48:52 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1J5haSc022745;
        Mon, 18 Feb 2019 21:48:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RbBxPPIaDpyPtsxjgzMNvB1W+VAmwQFsscJyXTBZYLg=;
 b=HPLLo5fVU/UhwMhhnMt1bBCJkumNWghfziurF+4j1pL4aMyO0sdgi4BH4nB61/psSoG1
 dKWkuJzv7YuKkgVzzjNHKZ3rM8eiR04xtiD76km6AMxiX40mVB2LcfckMyLj8jHpM6Fp
 BHI/4h3t/hkcoTQQeIYCkkXg92uzOYh2Ppw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qr6t30n4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 21:48:23 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 21:48:22 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 21:48:22 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 18 Feb 2019 21:48:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbBxPPIaDpyPtsxjgzMNvB1W+VAmwQFsscJyXTBZYLg=;
 b=TSo3ZxjvjLyYRWRyFBepFgVrdxeiXg1Danp8BRj7AJOVwIJtglkmKrqA6Z+ME1frGX20QEVHxVXyTe5ej0reg+RduW6Usxg+XDP/UicnGmrOa3nqPiR7eetpVJyDQQW8nDyNQfPT3Sj9rrOgcuy8wMF0mw2MDGx777tG+xgdSyU=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1817.namprd15.prod.outlook.com (10.174.246.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 05:48:00 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560%7]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 05:48:00 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Topic: [PATCH v3 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Index: AQHUxXkOtt2/XwJ2AkyRgaHgmJLyD6Xkn+uAgAICeYA=
Date:   Tue, 19 Feb 2019 05:48:00 +0000
Message-ID: <0F68F234-7913-4869-B56B-59A1AF06BB8C@fb.com>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-9-songliubraving@fb.com>
 <20190217230637.GK7443@krava>
In-Reply-To: <20190217230637.GK7443@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:7569]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85744184-074f-4746-58c4-08d6962dcea6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1817;
x-ms-traffictypediagnostic: DM5PR15MB1817:
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1817;20:F1AgRp2frUc6td0SSINzV1ozYCtH4ILSoEd/AYuHDYlVD8oiqZzfUiIHM/H/iKHzOvaBSMjoUW1wS2NZyG2+NfVdETQ1DBqLaA4WN6i50V5LhsTATkD4eHDGMgGj3+4Xlx/rlNzig+behwb2QB1t7zE95zGarKlsNviLx3l9Oiw=
x-microsoft-antispam-prvs: <DM5PR15MB1817BB35B80BDD507788BE66B37C0@DM5PR15MB1817.namprd15.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(36756003)(5660300002)(83716004)(6512007)(106356001)(86362001)(68736007)(6506007)(6436002)(256004)(478600001)(71190400001)(71200400001)(14444005)(82746002)(102836004)(105586002)(6916009)(316002)(53936002)(25786009)(6246003)(305945005)(6116002)(53546011)(7736002)(4326008)(54906003)(97736004)(57306001)(50226002)(33656002)(2906002)(446003)(11346002)(6486002)(76176011)(2616005)(486006)(476003)(81166006)(8676002)(46003)(14454004)(99286004)(81156014)(229853002)(186003)(8936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1817;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nwk43Ui3pMnIqyIdddpEXoLNNBb7ry78P2YLt4SpGii01lHtbAN9BBuaVqYZvXmGsGASW7kLKL9CQ+qYHVBBWPFCLu9I0S5rwinqrxxTE/rUVQOYvYWP+vcALPPqi0rGckP03GW6fXanZGVC0NpcJH8AcHuVszceqi9vKGriSXJLEznF+gJwIeJUcJ7MKZqIzKxHgv6uwk5I6B1npoPG+o/nZZwdSdPwsBU7A3Xen3OxpDW0MF7j/bjls5pz6nGLcoWn/T9tbmTedNGi8OzIAsazs9e1oikAxjI96BKdxJoRyYaZZYB40nrdE/UxhgWJk4lkTaHDZDtzd7w2SEOC5OmtHgwEzSp+5+CeH6ma/zFU7bmynZGalEXjGG2pjFumnalN3A9GET6VGAbbxhKW+BrwNKZD9+HP4UYUCL1jW4E=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C564A5BE9EC8B246BF44EFBCF204BBE0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85744184-074f-4746-58c4-08d6962dcea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 05:48:00.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 17, 2019, at 3:06 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Feb 15, 2019 at 01:53:51PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +static int process_btf(struct feat_fd *ff, void *data __maybe_unused)
>> +{
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	u32 count, i;
>> +
>> +	if (do_read_u32(ff, &count))
>> +		return -1;
>> +
>> +	down_write(&env->bpf_progs.bpf_info_lock);
>> +
>> +	for (i =3D 0; i < count; ++i) {
>> +		struct btf_node btf_node;
>> +		struct btf_node *node;
>> +
>> +		if (__do_read(ff, &btf_node, sizeof(struct btf_node)))
>> +			return -1;
>> +
>> +		node =3D malloc(sizeof(struct btf_node) + btf_node.data_size);
>> +		if (!node)
>> +			return -1;
>> +
>> +		node->id =3D btf_node.id;
>> +		node->data_size =3D btf_node.data_size;
>> +
>> +		if (__do_read(ff, node->data, btf_node.data_size)) {
>> +			free(node);
>> +			return -1;
>> +		}
>=20
> hows endianity swap handled got struct btf_node and data in here?
>=20
> thanks,
> jirka

I thought about endianity at some point, but forgot about it. Let=20
me see how to fix it.=20

Thanks,
Song=20


