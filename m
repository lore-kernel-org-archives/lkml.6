Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE1BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B27E21582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="agQg33m5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TXSzIxTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B27E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbeKVEcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:32:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732745AbeKVEcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:32:19 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wALHo5CH013645;
        Wed, 21 Nov 2018 09:56:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kxl9roHD4JA7WDAdxIWFD8edyruC2D8CguYdfBJPEV0=;
 b=agQg33m5jYLQdKmLzHITM70x5JT8ez8D1qDIH7MByggCPPAzprzArV2u3SA9TDKW+raw
 /d/vWZPUCdWwvg2iqqfBMpg0cb5lajjt6HVZcyqfjbJFDXqGMv2dhBeItcdRRJ/lkRCU
 niIJQvPIfCB9uxbUaLDYi7wNO6Hsn71Na5M= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2nw8v70q7q-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Nov 2018 09:56:24 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 21 Nov 2018 09:56:07 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 21 Nov 2018 09:56:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxl9roHD4JA7WDAdxIWFD8edyruC2D8CguYdfBJPEV0=;
 b=TXSzIxTNZK4NENIErk+k3AvkBOwGInejfMW5MGOvXfxan1qSpSkG2l3RKt8EwAbDlb9D2cRA0zuVVOYoAJBXrYsXYiMp7T6ShfeQThrlrXPTXpNPWuwEUYc+VJQea/k0c1NGl5p0R1cr+FA1kHwBwWKFCMKw5cbY4MSS9TTD+qQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1405.namprd15.prod.outlook.com (10.173.234.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 17:56:04 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.015; Wed, 21 Nov 2018
 17:56:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: perf tools: remove option --tail-synthesize ?
Thread-Topic: perf tools: remove option --tail-synthesize ?
Thread-Index: AQHUgW4siyZx02jtZEikk8vk0I6CCqVaDD8AgAB31IA=
Date:   Wed, 21 Nov 2018 17:56:04 +0000
Message-ID: <35DD0769-1AB5-498E-9173-DB7DAF9BD580@fb.com>
References: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
 <20181121104710.GA9402@krava>
In-Reply-To: <20181121104710.GA9402@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::4:a03]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1405;20:73qarQ9HhDmEZhMp2X/Dtlh+8C9iBUeqyIHh4lnGC32a0ZpNXP9NrgUrJEJcBZftch7845a7vvauJ0CvJWnLqKln+OAvrbf4xXySfOmolNOljoGzi8LQ6J4x95M9yVH16PkgQGguP6dU76iDLCFNDUpdibCYWg7389ufl602sY8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c8a2b81d-2aab-4497-a807-08d64fda9b37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1405;
x-ms-traffictypediagnostic: MWHPR15MB1405:
x-microsoft-antispam-prvs: <MWHPR15MB14050CC05F43F5C1A43265D6B3DA0@MWHPR15MB1405.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231442)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1405;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1405;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(51444003)(189003)(199004)(54906003)(2906002)(6916009)(478600001)(5660300001)(6116002)(256004)(71190400001)(14454004)(71200400001)(53936002)(6436002)(83716004)(316002)(186003)(2900100001)(106356001)(105586002)(25786009)(6512007)(229853002)(6246003)(7736002)(11346002)(6486002)(82746002)(8676002)(102836004)(46003)(4326008)(53546011)(33656002)(305945005)(446003)(57306001)(6506007)(97736004)(575784001)(50226002)(486006)(81156014)(476003)(2616005)(81166006)(8936002)(68736007)(76176011)(36756003)(99286004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1405;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xEk6zLZJc9C7vl5TuvNLsBwC3zevz/CUhoypJrPjoStRJVZbZB0A0ZlgMbQgaE3yk1fuRyEQs7s1z+dwGXSOKkB4WEqWFR6kve6u8woSZIcrZ4EegN9SBmrqRXT+tssAbywVZ3dD2NxSFpHJXHGFAhXVJNBwcZiNtndvKL+1Ks/axSZxzMOpTLsx9Fe1WN0vDH/ehSbBc3TjoRew1kIg1aMYQJVzVCpq+k62k8LQXZweeSXDWZgfyiMKwRn+Ebpu3GQ7IXPma42vIS8ZDOCQtg4DKi/Z7Qmd57e07GXzfiAsBg3LFSLaAIIDWku+DR75IDw9ugkYfhhNwn8+s94dB8qsjKg39INTTScv6uxA8ns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F86A62414EA19A43943DC7E2B490867F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a2b81d-2aab-4497-a807-08d64fda9b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 17:56:04.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2018, at 2:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 21, 2018 at 07:45:28AM +0000, Song Liu wrote:
>> Hi,
>>=20
>> I found perf-record --tail-synthesize without --overwrite breaks symbols
>> for perf-script, perf-report, etc. For example:
>>=20
>> [root@]# ~/perf record -ag --tail-synthesize -- sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 1.129 MB perf.data (3531 samples) ]
>> [root@]# ~/perf script | head
>> swapper     0 [000] 1250675.051971:          1 cycles:ppp:
>>        ffffffff81009e15 [unknown] ([unknown])
>>        ffffffff81196b19 [unknown] ([unknown])
>>        ffffffff81196579 [unknown] ([unknown])
>>        ffffffff81110ca7 [unknown] ([unknown])
>>        ffffffff81a01f4a [unknown] ([unknown])
>>        ffffffff81a017bf [unknown] ([unknown])
>>        ffffffff8180e17a [unknown] ([unknown])
>>=20
>> perf-record with --overwrite does NOT have this issue.
>=20
> actualy I think that now it works properly, if you turn on
> task and mmap events, you'll see the samples get resolved
> right after aux events are processed:
>=20
> 	[root@krava perf]# ./perf script --show-info --show-task-events --show-m=
map-events
> 	...
> 	swapper     0 [007] 620566.187355:      64821 cycles:ppp:
> 		ffffffffab0b4d7c [unknown] ([unknown])
> 		ffffffffaba01b1f [unknown] ([unknown])
> 		ffffffffab75d567 [unknown] ([unknown])
> 		ffffffffab0e1f56 [unknown] ([unknown])
> 		ffffffffab0e216f [unknown] ([unknown])
> 		ffffffffab050dc7 [unknown] ([unknown])
> 		ffffffffab0000d5 [unknown] ([unknown])
>=20
> 	swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffab00=
0000(0x152c8000) @ 0xffffffffab000000]: x [kernel.kallsyms]_text
> 	swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffc02c=
8000(0x4000) @ 0]: x /lib/modules/4.18.17-200.fc28.x86_64/kernel/drivers/th=
ermal/int340x_thermal/int3403_thermal.ko.xz
> 	swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffc02c=
d000(0x4000) @ 0]: x /lib/modules/4.18.17-200.fc28.x86_64/kernel/drivers/th=
ermal/intel_pch_thermal.ko.xz
> 	...
> 	ext4-rsv-conver     0 [000]     0.000000: PERF_RECORD_COMM: ext4-rsv-con=
ver:989/989
> 	perf 20063 [005] 620566.187438:    1056712 cycles:ppp:
> 		ffffffffab1f605d filemap_map_pages+0x9d (/usr/lib/debug/lib/modules/4.1=
8.17-200.fc28.x86_64/vmlinux)
> 		ffffffffab23aaa8 __handle_mm_fault+0x1018 (/usr/lib/debug/lib/modules/4=
.18.17-200.fc28.x86_64/vmlinux)
> 		ffffffffab23ae7a handle_mm_fault+0xda (/usr/lib/debug/lib/modules/4.18.=
17-200.fc28.x86_64/vmlinux)
> 		ffffffffab06ac90 __do_page_fault+0x240 (/usr/lib/debug/lib/modules/4.18=
.17-200.fc28.x86_64/vmlinux)
> 		ffffffffab06af62 do_page_fault+0x32 (/usr/lib/debug/lib/modules/4.18.17=
-200.fc28.x86_64/vmlinux)
> 		ffffffffaba010ee page_fault+0x1e (/usr/lib/debug/lib/modules/4.18.17-20=
0.fc28.x86_64/vmlinux)
> 	...
>=20
> if you record with --overwrite and --tail-synthesize the aux events
> will go to the top of the perf.data, so all's good
>=20
>>=20
>> After digging into this, I found this issue is introduced by commit
>> a73e24d240bc136619d382b1268f34d75c9d25ce.
>=20
> right, we got rid of that, because it will store the 'current/live'
> server mmaps for report/script, which is not what you want

Agreed.

>> Reverting this commit does fix this issue. However, on a second thought,
>> I feel it is probably better just drop --tail-synthesize, as it doesn't
>> make much sense without --overwrite. All we need is to do tail_synthesiz=
e
>> when --overwrite is set.
>>=20
>> Thoughts?
>=20
> maybe we should make --tail-synthesize non optionable for --overwrite,
> and get rid of that option completely.. Wang, any idea?
>=20
> but definitelly not allow that for non overwrite
>=20

--overwrite forces tail-synthesize already:

        if (record.opts.overwrite)
                record.opts.tail_synthesize =3D true;

So I guess all we need is to remove --tail-synthesize. If we all agree=20
with this direction, I can draft patch for it.=20

Thanks,
Song


