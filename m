Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF1C2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YSCPUHam";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Dyr7uKF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF1C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeKGIqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:46:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38066 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbeKGIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:46:10 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6NEa15007380;
        Tue, 6 Nov 2018 15:17:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I9ArvBNqeBRoCNddO03+8m0yq8frFGmmCt0+z0TMJt0=;
 b=YSCPUHamsR4w1Ex33mzScm2sE9/jVr407XODCEwS8iIpXEBLkASER+gQUpX8yMjzX6AE
 AkEi9Nx6ahBt6oEUkCwmtCkc8roHyZnVoJppUC3fqrAjxIDYULIOY1TyzQQInGRCHMC2
 RrHFD5wJ4tnGsVanQPBO1LPE6t75oMoxclc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkmbs80vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 15:17:55 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 15:17:54 -0800
Received: from PRN-CHUB12.TheFacebook.com (2620:10d:c081:35::21) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 15:17:54 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.22) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 6 Nov 2018 15:17:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9ArvBNqeBRoCNddO03+8m0yq8frFGmmCt0+z0TMJt0=;
 b=Dyr7uKF2tNEmWYd2BmIbh4zBfdsSEqODjnFQCVSPupzWliN8c72RlCOSa703HvnGrISv2N3dz7gV5/Vdqjr7oaLFhPi2A2C8G7HvnkVeq/dNGtVyDBRRAbCRoLTvkKZdTAK5uVoui2f01GLx681GY1vxi4WUDHqLT9JbU414YHo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1789.namprd15.prod.outlook.com (10.174.255.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 23:17:52 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 23:17:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     David Ahern <dsahern@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUdhL1KSxo541SK0a40CXb4K6c4qVDSleAgAAXYgA=
Date:   Tue, 6 Nov 2018 23:17:51 +0000
Message-ID: <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-6-songliubraving@fb.com>
 <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
In-Reply-To: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:7960]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1789;20:KO4JGgVn9T2drPmIrCAaBjeUN3e4nKUcg1Zun6aX5UKnk0vqBbUqGDKkHEVqLyacvsih4BVKJYQnZVedzspXi4vqyTS3TnCdWZvrU6cGaHyEYKYVJpwJBLOGYg6xDEscUHrvGCc+npWlLSLh7XGNHQyZD/DIh4UKhJAI26g2cLI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d90e98b8-e592-4754-d759-08d6443e132f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1789;
x-ms-traffictypediagnostic: MWHPR15MB1789:
x-microsoft-antispam-prvs: <MWHPR15MB1789D119CF335F9A052B0A60B3CB0@MWHPR15MB1789.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1789;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1789;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(76176011)(25786009)(53936002)(102836004)(486006)(33656002)(53546011)(105586002)(6506007)(7736002)(106356001)(476003)(97736004)(186003)(57306001)(305945005)(2616005)(2906002)(81166006)(4326008)(99286004)(1411001)(6916009)(46003)(8936002)(2900100001)(14454004)(83716004)(5660300001)(50226002)(6246003)(6512007)(86362001)(6486002)(71200400001)(71190400001)(8676002)(39060400002)(81156014)(82746002)(36756003)(6116002)(316002)(6436002)(478600001)(68736007)(229853002)(11346002)(446003)(256004)(54906003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1789;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7i0a+p/dg0vG47KeU74IjFW8Vw1nTkUfkkBX77wxsBsoTsy6TwzRmMPzIcwBlyjJdM928n4u5k/jm8O+qaMYST2kJ12xvHk4HmguanpOeoR9ZJ1JKlTtKlViGTzpHRtF9JarM5X0ellGKI9v1rwwJ3jcuJqusr912icdwX0L16JJzfgla1UeEoeNyL+t27Pe3JTVr4XduN7rL8+9Le1N0ig05qDYru/9jsEAJWJ3Af5Efc3bqHN587cLt1HsWFom0pVja9M9Dg6hx9Sns66+m8oSQc586bg5+VXzCneo0Dcs+Tj0tu4m+BhrWXMLJuWH6JuYhV7mpK7VVIvBtCV7w7Vqzzjqhff8EPyDfpOtalo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <415B8356F8F1344398CDDC446A6CFA54@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d90e98b8-e592-4754-d759-08d6443e132f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 23:17:51.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1789
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2018, at 1:54 PM, David Ahern <dsahern@gmail.com> wrote:
>=20
> On 11/6/18 1:52 PM, Song Liu wrote:
>> +
>> static int record__mmap_read_all(struct record *rec)
>> {
>> 	int err;
>>=20
>> +	err =3D record__mmap_process_vip_events(rec);
>> +	if (err)
>> +		return err;
>> +
>> 	err =3D record__mmap_read_evlist(rec, rec->evlist, false);
>> 	if (err)
>> 		return err;
>=20
> Seems to me that is going to increase the overhead of perf on any system
> doing BPF updates. The BPF events cause a wakeup every load and unload,
> and perf processes not only the VIP events but then walks all of the
> other maps.

BPF prog load/unload events should be rare events in real world use cases.=
=20
So I think the overhead is OK. Also, I don't see an easy way to improve=20
this.=20

>=20
>> @@ -1686,6 +1734,8 @@ static struct option __record_options[] =3D {
>> 			  "signal"),
>> 	OPT_BOOLEAN(0, "dry-run", &dry_run,
>> 		    "Parse options then exit"),
>> +	OPT_BOOLEAN(0, "no-bpf-event", &record.no_bpf_event,
>> +		    "do not record event on bpf program load/unload"),
>=20
> Why should this default on? If am recording FIB events, I don't care
> about BPF events.
>=20

I am OK with default off if that's the preferred way.=20

Thanks,
Song

