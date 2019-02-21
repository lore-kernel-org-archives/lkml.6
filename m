Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0371120675
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aTc32Dwy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hFb8R5oB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfBUHM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:12:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57292 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfBUHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:12:59 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L78Ue3014082;
        Wed, 20 Feb 2019 23:12:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=icGBY0fIb+biFfBGioQ6SMyf7M3N9F/Lai3Xf6RPNGc=;
 b=aTc32DwyYqK4E4ZJzAjp6YFAR5NBcsh7iwcq2lX460csYP4Fgaqo3Nt3oqwB+05Iyt7Z
 QIKxu3C1Bzb8AwFhLHM/Uo5IWcd22ICA/Qwf+XBpWToSNQRnV26b7YuoDPU9tuM+m+/g
 WUP4ha2FUalXT161jqqusoJaq7tsY1gxUIE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qsq7b810p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 23:12:28 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 23:12:26 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 23:12:26 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 20 Feb 2019 23:12:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icGBY0fIb+biFfBGioQ6SMyf7M3N9F/Lai3Xf6RPNGc=;
 b=hFb8R5oB2zHbxD6fu39jnDZ0fFw+4y6RTatAvUKMZqbwnU2SzKTdnYDq9995+yMX84e4st1g/B7Scu6fUlGBhhW/iYeabgeFELYjm4H+diHvnqIwhHrKR1y8kxfxMn/ab7IA793gX0KTJla6DUQCFJ5M7JfV1EmR2pEtxLftFtc=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1642.namprd15.prod.outlook.com (10.175.105.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 07:12:11 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560%7]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 07:12:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf/core: use strndup_user() instead of buggy
 open-coded version
Thread-Topic: [PATCH v2] perf/core: use strndup_user() instead of buggy
 open-coded version
Thread-Index: AQHUyT0KVDZjyaS/1UygC2UYJqI28qXpZCeAgABXOQA=
Date:   Thu, 21 Feb 2019 07:12:10 +0000
Message-ID: <7F433C6B-451A-4C3B-9B7E-0CB2CE4821DD@fb.com>
References: <20190220165443.152385-1-jannh@google.com>
 <20190221092057.8c56fa4db9eb39b7b14cd0fe@kernel.org>
In-Reply-To: <20190221092057.8c56fa4db9eb39b7b14cd0fe@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:7f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37dcefd9-716c-4438-3774-08d697cbe5e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1642;
x-ms-traffictypediagnostic: DM5PR15MB1642:
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1642;20:7/S1s53REYh4DvnYCZfxy9qmHuGcMVHIPD7OiywocLHZoGuzKYg4c5dW+Imp3SFwwc7Wrg5Dea7WjGue9fQqR0SN+X1ryGP74P//QisvNREvhQ2kMxxQlKpxfBFJy2wN9FqfoSm/4lUCcjq8+NVor4llCzEl6YPyE0cNJFjCYZ4=
x-microsoft-antispam-prvs: <DM5PR15MB1642D58624AB7F3B5D7B53AEB37E0@DM5PR15MB1642.namprd15.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(366004)(376002)(189003)(51914003)(199004)(8676002)(83716004)(7736002)(305945005)(102836004)(6512007)(6506007)(5660300002)(486006)(2616005)(71190400001)(71200400001)(186003)(53546011)(446003)(25786009)(11346002)(476003)(68736007)(8936002)(50226002)(81166006)(6486002)(81156014)(46003)(6436002)(2906002)(6246003)(478600001)(229853002)(4326008)(86362001)(97736004)(14454004)(53936002)(76176011)(6116002)(82746002)(256004)(36756003)(57306001)(33656002)(316002)(54906003)(105586002)(6916009)(99286004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1642;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Srv92cNChZ0xSxI4apf6GykeNSLSD5Ha5ZnUN61PifPn6bQAnVsKc2uKfGTl9tBBtHo3QXnZrSRbcAEHVdBZxjS3fPeKGHhpOZnohBEt7qEe3Z9csojFu+/XU+GWe5l0lcj3S5GH75cUoRpVxsMoLjHsjNDP3SX+TLym5B+VCTinIj7AWo5JmmgqFBBiLa8oCdecfwPVm8xqEUoeWswCaiWeVi0BJrOrTNLebDvbnT7YuKLwXwDYMgYZx8UGtYKLz/A2Ui0jmp2aqum8BQMluLnCGDPF4axdYKXKcN8admTLz/D0CHy3oYkfM54zPjOkVVKNU9FsOWEJyooMcbuIFGz6nDZ6lNLVstHORdFzNlbaHOg7i1afR+6+Z4w36hoShNOYRW/GoXYFnX1dkCceERJxYfkIMc+sDoqdBkk9pew=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23D1AEB73CD24042AE20C7C60690C506@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dcefd9-716c-4438-3774-08d697cbe5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 07:12:10.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1642
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 20, 2019, at 4:20 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote=
:
>=20
> Hi Jann,
>=20
> On Wed, 20 Feb 2019 17:54:43 +0100
> Jann Horn <jannh@google.com> wrote:
>=20
>> The first version of this method was missing the check for
>> `ret =3D=3D PATH_MAX`; then such a check was added, but it didn't call k=
free()
>> on error, so there was still a small memory leak in the error case.
>> Fix it by using strndup_user() instead of open-coding it.
>>=20
>=20
> This looks good to me.
>=20
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>=20
> BTW, for stable, this is good. For the long term, I think we should
> fix strndup_user() to return -E2BUG when the user string is longer
> than max.
>=20
> Thank you,
>=20
>> Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
>> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for the fix!

Acked-by: Song Liu <songliubraving@fb.com>


>> ---
>> v2:
>> - be compatible with existing error codes (Masami Hiramatsu)
>>=20
>> kernel/trace/trace_event_perf.c | 16 +++++++---------
>> 1 file changed, 7 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_=
perf.c
>> index 76217bbef815..4629a6104474 100644
>> --- a/kernel/trace/trace_event_perf.c
>> +++ b/kernel/trace/trace_event_perf.c
>> @@ -299,15 +299,13 @@ int perf_uprobe_init(struct perf_event *p_event,
>>=20
>> 	if (!p_event->attr.uprobe_path)
>> 		return -EINVAL;
>> -	path =3D kzalloc(PATH_MAX, GFP_KERNEL);
>> -	if (!path)
>> -		return -ENOMEM;
>> -	ret =3D strncpy_from_user(
>> -		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
>> -	if (ret =3D=3D PATH_MAX)
>> -		return -E2BIG;
>> -	if (ret < 0)
>> -		goto out;
>> +
>> +	path =3D strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
>> +			    PATH_MAX);
>> +	if (IS_ERR(path)) {
>> +		ret =3D PTR_ERR(path);
>> +		return (ret =3D=3D -EINVAL) ? -E2BIG : ret;
>> +	}
>> 	if (path[0] =3D=3D '\0') {
>> 		ret =3D -EINVAL;
>> 		goto out;
>> --=20
>> 2.21.0.rc0.258.g878e2cd30e-goog
>>=20
>=20
>=20
> --=20
> Masami Hiramatsu <mhiramat@kernel.org>

