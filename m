Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89490C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A973222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MWy0xNcw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PifJ1sgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfBORCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:02:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59740 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbfBORCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:02:44 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1FGqUb2007466;
        Fri, 15 Feb 2019 09:02:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n9yRfEWUjZ+aFI6H/2lXEisFpEcR0i6H8wOS38t26Tk=;
 b=MWy0xNcwuX7M8XkACizHYYar/gXYEsAt0eZIXsmSF+KX9pppBejlUAZJBm2bLMs44yX1
 08V7ZBj5prNjfRooJU6vejtxrB71T8JR4kVOJ8FBWCURqnCDJTdkiUZVs6GCfxZQhqBX
 FWjq2ES/pmRoPONy+1BQtkFJY4Ux1S3rVZY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2qp0np0675-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:02:15 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:02:05 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:02:05 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:02:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9yRfEWUjZ+aFI6H/2lXEisFpEcR0i6H8wOS38t26Tk=;
 b=PifJ1sgDblQ9bQQEisCMcd9vCQgNSoFffEPF3iWV95tTHcPX63zqlitwc8TFNyLyCQX7BjwAgJ5+hsTtMNMo95PQb2dFY9G+iyCifbMPEKfD7Wl0Pz//d98jTn0eS2yvqhHKtuVgbXR4Fu1H33l/rNm5z1dGKvOObE/6FQTFLZo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1901.namprd15.prod.outlook.com (10.174.100.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:02:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 17:02:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 01/11] perf, bpf: consider events with
 attr.bpf_event as side-band events
Thread-Topic: [PATCH v2 perf,bpf 01/11] perf, bpf: consider events with
 attr.bpf_event as side-band events
Thread-Index: AQHUxMFKDT3mU7nYpk6WlPSL73cA8qXg5+qAgAAu6YA=
Date:   Fri, 15 Feb 2019 17:02:02 +0000
Message-ID: <ECDC9D1F-3AA3-451A-BAC7-E089D4CAAEEC@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190214235840.2587123-1-songliubraving@fb.com>
 <20190215141407.GA5784@redhat.com>
In-Reply-To: <20190215141407.GA5784@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b68aa783-5458-4116-51ec-08d693674ecf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1901;
x-ms-traffictypediagnostic: MWHPR15MB1901:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1901;20:azPtHEUYc77FdfBcqTECDRxjWLe+TDQejz6b1mLs22nP+493A3zcA1BuM+8oFk1171qNwy0z5R5bY7/d1oWYdkM13Xcod6KvZXXVXcwyn30ttYYMR1zE03j+nuADmdhEy3B/XhvE4pkuajncs6Kf/CdS53+RPzJjfUavXwpgYvM=
x-microsoft-antispam-prvs: <MWHPR15MB190105143823D17AA7D5EB6BB3600@MWHPR15MB1901.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(6436002)(53546011)(6512007)(36756003)(97736004)(8676002)(53936002)(8936002)(105586002)(106356001)(81156014)(81166006)(229853002)(305945005)(86362001)(54906003)(82746002)(7736002)(71190400001)(71200400001)(83716004)(6246003)(316002)(50226002)(4326008)(6916009)(99286004)(486006)(2616005)(6116002)(476003)(76176011)(11346002)(446003)(478600001)(2906002)(25786009)(6506007)(6486002)(46003)(33656002)(57306001)(256004)(14444005)(68736007)(186003)(14454004)(102836004)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1901;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8FGdCFFDkIHU/L7B1IOSakQ1Geo/e6po+a4i/T7HG9r1Dv7nhPuUTd+e783A7ARPyN7oWUQk+pZC4RX35FlAYqWFQL83CF2pg+n9J+AHPF1rVDKULXiPPg/gPg84COtz/41u+ePXCyisb5mJP0umR0D+uRKcDHS2G18UlwKKcDPNfVRuT+XlqbgiIaWFz3qhFIHDO1sqU9rjP3WVoQOrXcUTRCfj5QGlxDs0+6IW6FkQyu9kw0V1RUuPkXpFskZvTiH6PRV2blkViihA9vFQuzF21XXWhLGgIUCO7r6nFgdvOoxWNzT/WHLCgzUww74XuFZdP9jd/mwRvh/ZORJD0viVHfUq9SHJMuMpjamx56ZUa3iexosymXHQRL15/+oKgC41F0oUskq1u2fC/vLvAiDSjyUY64Le1qHosLRT3iw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEE67E75530A3E488942A5B755AE0667@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b68aa783-5458-4116-51ec-08d693674ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:02:03.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1901
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 6:14 AM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Thu, Feb 14, 2019 at 03:58:40PM -0800, Song Liu escreveu:
>> Events with bpf_event should be considered as side-band event, as they
>> carry information about BPF programs.
>>=20
>> Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> kernel/events/core.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 0a8dab322111..9403bdda5f8c 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4238,7 +4238,8 @@ static bool is_sb_event(struct perf_event *event)
>> 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
>> 	    attr->comm || attr->comm_exec ||
>> 	    attr->task || attr->ksymbol ||
				^ here

>> -	    attr->context_switch)
>> +	    attr->context_switch ||
>> +	    attr->bpf_event)
>=20
> What about attr->ksymbol?
>=20
> - Arnaldo

It is already included up there. attr->bpf_event was missed initially=20
because we didn't use events with bpf_event but not ksymbol. With this=20
set, the polling thread only has bpf_event, so we need this fix.=20

Thanks,
Song


