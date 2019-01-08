Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA680C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B36C20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SmfLWt8B";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hW+k5Kl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfAHS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:56:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728138AbfAHS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:56:52 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08InnBA005358;
        Tue, 8 Jan 2019 10:56:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=i6UDyN2q0nONgBZSfpDWjWcESn/cAMTvUIGm3r+1R0U=;
 b=SmfLWt8ByytQ142g3kPByGpXkzAhxSoLnD9a4gX8ljnWd1YLddC6/U90y8ZtOCo1VVPQ
 WilIEaYXrIyjUHVXlWMbGoILyyfqlrvxt52VqMnjKiomYMZWa0qvqrpDe2b5v6vbIoFM
 Wh1+Eq1E8QRDG0JtcjX4RRBtMU+I1zqSo28= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pw0ps86xv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 10:56:26 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 10:56:23 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 8 Jan 2019 10:56:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6UDyN2q0nONgBZSfpDWjWcESn/cAMTvUIGm3r+1R0U=;
 b=hW+k5Kl+yTnjeO32fSPkpB/ylUgYY1i1mc5JOIx6BTLrNLazYfs06pn4lb7U7Oz/ebS5TOTL43n6rN9c4q5avUcnVN7nSnkNrl5X1P0kUL+5IE3OjiGo92X3Dh1w4V7yQPnpZRFa0i57ZB5rV8kpwaSzhJ9XB9snrS6g0woZDuA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1309.namprd15.prod.outlook.com (10.175.3.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 18:56:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 18:56:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v5 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUmJH6kYqvy9D0HUGZuPKL3otxb6Wlz5eAgAAG8QA=
Date:   Tue, 8 Jan 2019 18:56:19 +0000
Message-ID: <A7A11A44-FDF0-4FB5-98B6-3E47A35E7120@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-2-songliubraving@fb.com>
 <20190108183127.GB30894@hirez.programming.kicks-ass.net>
In-Reply-To: <20190108183127.GB30894@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:43fb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1309;20:ammcVKbGoCzXcIdw7iKszGfl1CePv5/tOcoHImv9OhBCw2JUbewU+bERETbq0RSZ9ETn21h7vLyvdgzlENWippy7RZlJ5lmN9rWjODk90FN/gXH+F6k2jFHBARVeWZCINJFWR7voq7ni1DAVpbT6LvnKydnai71+Hs0IimglaP4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d4a2254c-3efd-4dd6-9972-08d6759af9dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1309;
x-ms-traffictypediagnostic: MWHPR15MB1309:
x-microsoft-antispam-prvs: <MWHPR15MB13097D4073F9DB3CF99C5A62B38A0@MWHPR15MB1309.namprd15.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(82746002)(4326008)(14454004)(76176011)(97736004)(316002)(478600001)(71200400001)(25786009)(2616005)(71190400001)(68736007)(256004)(486006)(83716004)(6436002)(476003)(11346002)(6512007)(54906003)(446003)(57306001)(2906002)(36756003)(6246003)(33656002)(6116002)(229853002)(8936002)(6486002)(81156014)(81166006)(8676002)(99286004)(86362001)(102836004)(106356001)(50226002)(5660300001)(186003)(105586002)(46003)(53546011)(6506007)(53936002)(6916009)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1309;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BffilrQA6oqujGywZOVW7npsdxdsVUAH/yjxVm5knb1tDnEytNRWwfiLe2/46s9RcBLFgAO09+JIG17kBfhmu7FqTUP6x9WDWGjWJ8HIj/C9jycB2x6J9qVjE2HkYr5e37oDAWbYgA5HR4eqjflXAx8/x4yRwHu6b8bU6+Kmcu9Mpbu+7A0bzdQaQV01BW3O35kh8d4d/+snz5Dd1Jg8RNPOoUNP66Is7IUuUlJpEG2vTm7FczQsrEo3Gb+3LxCrzbG0UEgqr3jaDe4+bpfRnizq84ccrGlC9wbqdtoztOqf3QWTzqHpWRrpIlncahwm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B7DEC51D6E7CF419E6677AECC6376BA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a2254c-3efd-4dd6-9972-08d6759af9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 18:56:19.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1309
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Peter!

> On Jan 8, 2019, at 10:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Dec 20, 2018 at 10:28:58AM -0800, Song Liu wrote:
>=20
>> @@ -648,11 +649,18 @@ struct perf_event_mmap_page {
>>  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
>>  *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal=
)
>>  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
>> + *   PERF_RECORD_MISC_KSYMBOL_*  - PERF_RECORD_KSYMBOL event
>>  */
>> #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
>> #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
>> #define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
>> #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
>> +
>> +#define PERF_RECORD_MISC_KSYMBOL_UNREGISTER	(1 << 3)
>> +#define PERF_RECORD_MISC_KSYMBOL_TYPE_MASK	(7 << 4)
>> +#define PERF_RECORD_MISC_KSYMBOL_TYPE_UNKNOWN	(0 << 4)
>> +#define PERF_RECORD_MISC_KSYMBOL_TYPE_BPF	(1 << 4)
>=20
> So this gives us 8 possible types, of which 2 are claimed.
>=20
> I suppose we already know of FTRACE_TRAMPOLINE and MODULE, which
> accounts for half the space.
>=20
>> +
>> /*
>>  * These PERF_RECORD_MISC_* flags below are safely reused
>>  * for the following events:
>> @@ -965,6 +973,19 @@ enum perf_event_type {
>> 	 */
>> 	PERF_RECORD_NAMESPACES			=3D 16,
>>=20
>> +	/*
>> +	 * Record ksymbol register/unregister events:
>> +	 *
>> +	 * struct {
>> +	 *	struct perf_event_header	header;
>> +	 *	u64				addr;
>> +	 *	u64				len;
>> +	 *	char				name[];
>> +	 *	struct sample_id		sample_id;
>> +	 * };
>> +	 */
>> +	PERF_RECORD_KSYMBOL			=3D 17,
>=20
> Do we really need u64 length? That is, are we willing to consider
> symbols larger than 4G ?
>=20
> Could we not reclaim the top 32 or 16 bits thereof for that type thing
> instead of using a few misc bits?

I don't think we need u64 length. 32 bit should be more than enough.=20

How about we revise it as:

+       /*
+        * Record ksymbol register/unregister events:
+        *
+        * struct {
+        *      struct perf_event_header        header;
+        *      u64                             addr;
+        *      u32                             len;
+        *      u16                             type;
+        *      u16                             reserved;
+        *      char                            name[];
+        *      struct sample_id                sample_id;
+        * };
+        */
+       PERF_RECORD_KSYMBOL                     =3D 17,

[...]

+#define PERF_RECORD_MISC_KSYMBOL_TYPE_UNKNOWN  0
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_BPF      1
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_MODULE   2
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_FTRACE_TRAMPOLINE      3

Thanks again,
Song





