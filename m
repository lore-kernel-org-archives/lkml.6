Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ACD206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fux7z+d5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B5+cIQNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ACD206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbeKVJMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:12:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57666 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731656AbeKVJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:12:37 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALMY5BM014461;
        Wed, 21 Nov 2018 14:35:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rx/gp50BgvpBuPSFySWByBkUqZmrco9t9dH7v9ioFFU=;
 b=Fux7z+d5nVzUxZRW0sWZtHa/U72xC4fl7GbEz70HCfkM/x6er10+qtJPQSos3s2dkVa0
 XSXJSpRWAordI3wUec8pZG5wwBHFweOY1GiqBs4PR0iA44MxEjUHrd0/Y4rWgdkp25zm
 C557jNco+7VqDA+hdKRgIIElAfycOUjHEXw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nwfqfr392-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Nov 2018 14:35:39 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 21 Nov 2018 14:35:37 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 21 Nov 2018 14:35:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 21 Nov 2018 14:35:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx/gp50BgvpBuPSFySWByBkUqZmrco9t9dH7v9ioFFU=;
 b=B5+cIQNcYurokYTOwabTCjUpb0OGqSjhJYVvGjTYuygnRFYeLp7fYEwHzF6dTU5TbD/E/UcEoHex77/xd0rTrhBRJ7rJdBpv64ZamTXrr3o67LswTM2DAdCG8hDzad+9fvYee60fcbRZr0VyMl1v3bTO3m5MGXgNbyYzm0J4Mwk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1918.namprd15.prod.outlook.com (10.174.100.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 22:35:35 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.015; Wed, 21 Nov 2018
 22:35:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [PATCH perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUgdQ+kfQLaz1BnkqiHcRIr5oTIaVayrqAgAAGpQA=
Date:   Wed, 21 Nov 2018 22:35:35 +0000
Message-ID: <67063BF9-6237-4CF4-A0EB-0B14C5CA8A21@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181121195502.3259930-6-songliubraving@fb.com>
 <20181121221145.2cxph7zv27x7lbg6@ast-mbp>
In-Reply-To: <20181121221145.2cxph7zv27x7lbg6@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::4:a03]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1918;20:T7W1Kp2GqH6VnHpVFZ+cvhaQd6swHCpXcQh78wP6wTLLw/uaA3QCi4JkH6wtzF9BNDJq9FyZiaU0xs8pxdobfxHDDKd2x+l+NmRp/UP6KCQOMro8xj7QBPoUfbHZu+JVma0zCvcOZA3k1bnqfu0avkYKJuiDBGDffzCkKaQ4OrU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce76aa3c-26cc-452a-e886-08d65001a782
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1918;
x-ms-traffictypediagnostic: MWHPR15MB1918:
x-microsoft-antispam-prvs: <MWHPR15MB19182E39C09DDBAC89A7DB70B3DA0@MWHPR15MB1918.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3231442)(11241501184)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1918;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1918;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(71200400001)(102836004)(71190400001)(76176011)(68736007)(53546011)(316002)(6506007)(54906003)(81156014)(97736004)(8676002)(50226002)(6916009)(6116002)(106356001)(8936002)(6512007)(2900100001)(39060400002)(81166006)(105586002)(186003)(2906002)(5660300001)(4326008)(256004)(6246003)(33656002)(478600001)(25786009)(486006)(83716004)(82746002)(5024004)(57306001)(6436002)(7736002)(6486002)(53936002)(14454004)(229853002)(305945005)(99286004)(2616005)(46003)(36756003)(476003)(446003)(86362001)(11346002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1918;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TifQi04yjHW+plC0KelJaYYQmXlPDuDU01Ie+V1EjuDNOFl+uXrHD4U2LUgZLu70PGLlF7NHDKNvjnroxqSHpfm8UXuCnJb5j2Mx2smcsgjEOn2jz0jen3df0MEXsxfjjhnG7v9vYqCgJk7z2AEs+MDHJR6cRRCs/OsmHYMnF8LOcw/vexqOP4TLlZpB1VA3b7lVVJtT6QdJ42O9b68k5Yr4yXPhxt7rWA0RlEWEN2mc75ASuMk4mXc1yzzSyu6xnSGEjKBg52MBg1mOCnakIIe2y6ptg/1cX22woR0+OvDnUt8/34MZ+1FHx7Hbbz0c08Qw4dgYhLwDnc7XQK8ElIpqhnnhScA1lCQJrCzd/SM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37CB87FF292E1748A99D2730D7CF682D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce76aa3c-26cc-452a-e886-08d65001a782
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 22:35:35.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1918
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2018, at 2:11 PM, Alexei Starovoitov <alexei.starovoitov@gmail=
.com> wrote:
>=20
> On Wed, Nov 21, 2018 at 11:55:02AM -0800, Song Liu wrote:
>> This patch enables perf-record to listen to bpf_event and generate
>> bpf_prog_info_event for bpf programs loaded and unloaded during
>> perf-record run.
>>=20
>> To minimize latency between bpf_event and following bpf calls, separate
>> mmap with watermark of 1 is created to process these vip events. Then
>> a separate dummy event is attached to the special mmap. A separate threa=
d
>> is used to only poll bpf events.
>>=20
>> By default, perf-record will listen to bpf_event. Option no-bpf-event is
>> added in case the user would opt out.
>=20
> I think only default perf-record for sampling should include it.
> perf record -e for tracepoints, kprobes and anything else should imply no=
-bpf-event.
>=20

Maybe something like
 =20
   if (software_event && ! -g)
        no_bpf_event =3D true;

?

This will allow attaching kprobe on bpf helper and see which bpf program
calls it.=20

Thanks,
Song=
