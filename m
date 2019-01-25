Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6409C218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FZzIT2+M";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AsloyTI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfAYUQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:16:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbfAYUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:16:14 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PKEr62003387;
        Fri, 25 Jan 2019 12:16:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1HQ66HyqKo3gpnXUMpTtZ9cJ5lycP8J1PcB28jRyhe8=;
 b=FZzIT2+MzTCvgIOPRQcwzcyyYq4wJzZSc1+WtSHi+3sYWBLgiuMHf3NcTXteE05A4kFk
 m8cy49WWblEvQ669CF3r4MEZJwK4gKhQecR2/3gdVfRW1gdHk8lwRpEUMAOGtJ6vnLdQ
 wUOs97i+IkTcK8kCGX/y8SniCuSihhLSMGk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q86rpgjfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 12:16:11 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 12:16:10 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 12:16:10 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 25 Jan 2019 12:16:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HQ66HyqKo3gpnXUMpTtZ9cJ5lycP8J1PcB28jRyhe8=;
 b=AsloyTI0bbeqXpPbjIl3UZfvfuFici8oWDFLW1psh2eoypACIBUpVTUFqieFCIfFF+cui4YsMl/6GkBBjZlecEFN5NINPexTD376dyOuxnWaWSdTOT+FTuCdch7V/108k+vOlxNsjpsaeKQP2J9RVt3BlXnPnd/N60hVjEj9vB4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1568.namprd15.prod.outlook.com (10.173.235.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Fri, 25 Jan 2019 20:16:09 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 20:16:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: perf/x86/intel/uncore
Thread-Topic: perf/x86/intel/uncore
Thread-Index: AQHUtN9mTaQDMPjjHkuN91Z74fJpgaXAabGAgAACLQA=
Date:   Fri, 25 Jan 2019 20:16:08 +0000
Message-ID: <5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com>
References: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
 <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
In-Reply-To: <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:7f1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1568;20:h0zAM3S76NqSiIaXdK3vRckMOL1FdaIGmjtd08b8J6q+VbuhVPE49+QLzYiaawIsHznmzIEAMBbLW3yjCFzjYIZ54bIrZYft6IXNyS89FH2eWt6BdVYqSTaYVyFrLL2wpBE+tm8a/4oE8YMIP1ALrIpYljhYwx6MYN8AUkBOLHo=
x-ms-office365-filtering-correlation-id: 1dfcb91c-b2b0-44c9-668f-08d68301f1a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1568;
x-ms-traffictypediagnostic: MWHPR15MB1568:
x-microsoft-antispam-prvs: <MWHPR15MB1568EFC3D61DBCE3C4ECA2A0B39B0@MWHPR15MB1568.namprd15.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(189003)(68736007)(6916009)(6116002)(36756003)(53546011)(6506007)(186003)(478600001)(102836004)(14454004)(53936002)(256004)(4326008)(6486002)(97736004)(6436002)(229853002)(6246003)(6512007)(25786009)(2906002)(8936002)(50226002)(71190400001)(81156014)(57306001)(86362001)(316002)(8676002)(81166006)(83716004)(71200400001)(76176011)(99286004)(46003)(11346002)(446003)(305945005)(476003)(33656002)(2616005)(106356001)(105586002)(82746002)(486006)(7736002)(21314003)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1568;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lclLEk+KLv3Jw9WDiOcKnWJbyIzVKdoqTFcp8kyzYYX+OenrDQDlU/9bxGp2YMqobXBFBFjZ16LrOiFcvX2FHILz4hzm8+VtfQq8HCmmSd4aj94e1R8BCoWICyMFtrdh0nuVLoGSJyTVUqCYxzjNscWTh7AjUoKNcC8PftoXo/WzKEZoc9nN6LeSUVUbHXVFoc/oASngbMYrWTrk06zTxFHH56MWnOwXkBv9wuh6IQrAvnK24HfALSBcRCbKE+MPl6nIzkaDbQoUwVBW6XL0VOJhrYsJI2knovkI7PHuryEHSje5hSlYoYOjLBugpQupvtArJ/Hs2DMgx3u44YVajesTrUWqdMvrAhmw9jxzaaFM42QSpJPvCCXWGSvbeacSqI5sbXIxzM1BGslhlHy3UFKlreHfzuqFKu1ltVpiqW4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3269951BF92204FBF63AE899AEF0E1D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfcb91c-b2b0-44c9-668f-08d68301f1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 20:16:08.9332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kan!

> On Jan 25, 2019, at 12:08 PM, Liang, Kan <kan.liang@linux.intel.com> wrot=
e:
>=20
>=20
>=20
> On 1/25/2019 1:54 PM, Song Liu wrote:
>> Hi,
>> We are debugging an issue that skx_pci_uncores cannot be registered on
>> 8-socket system with Xeon Platinum 8176 CPUs. After poking around for a
>> while, I found it is caused by snbep_pci2phy_map_init() couldn't find
>> a unbox_dev:
>>   ubox_dev =3D pci_get_device(PCI_VENDOR_ID_INTEL, devid, ubox_dev);
>>   unbox_dev =3D=3D NULL
>>   ...
>> The same kernel (Linus' master) works fine on some single socket SKX
>> systems.
>> I am not sure what to check next. And I am not sure whether this is
>> specific to this system (HPE Superdome Flex).
>=20
> Could you please share the offset 0xC0 and 0xD4 of the PCI configuration =
space for each device which PCI ID is 0x2014?
>=20
> snbep_pci2phy_map_init() tries to build a mapping from BUS# to Socket ID.
> CPUNODEID (0xc0) discloses the Node ID of current BUS.
> GIDNIDMAP (0xd4) discloses the mapping between Socket ID and Node ID.
>=20
> Here is an example from a 4 socket SKX.
> BUS    CPUNODEID(bit2:0)    GIDNIDMAP
> 0x0    0x0            0x688
> 0x40    0x1            0x688
> 0x80    0x2            0x688
> 0xC0    0x3            0x688
>=20

Here is the data I get:

# lspci -xxx | grep "86 80 14 20" -A 15 -B 1 | grep -e "86 80 14 20" -e c0:=
 -e d0: -e Intel
0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: 00 a0 00 00 2f 00 00 80 01 00 02 00 2f 2f 2f 20
d0: 02 00 00 00 88 d6 b6 00 01 00 00 00 00 00 00 00

0001:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: 01 80 00 00 1f 00 00 80 01 00 02 00 1f 1f 1f 10
d0: 02 00 00 00 88 46 92 00 01 00 00 00 00 00 00 00

0002:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: 02 e0 00 00 8f 00 00 80 01 00 02 00 8f 8f 8f 80
d0: 02 00 00 00 88 f6 ff 00 01 00 00 00 00 00 00 00

0003:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: 03 c0 00 00 4f 00 00 80 01 00 02 00 4f 4f 4f 40
d0: 02 00 00 00 88 66 db 00 01 00 00 00 00 00 00 00

0004:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: a0 b4 00 00 2f 00 00 80 01 00 02 00 2f 2f 2f 20
d0: 02 00 00 00 6d 8b 68 00 01 00 00 00 00 00 00 00

0005:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: 81 90 00 00 1f 00 00 80 01 00 02 00 1f 1f 1f 10
d0: 02 00 00 00 24 89 68 00 01 00 00 00 00 00 00 00

0006:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: e2 fc 00 00 8f 00 00 80 01 00 02 00 8f 8f 8f 80
d0: 02 00 00 00 ff 8f 68 00 01 00 00 00 00 00 00 00

0007:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
c0: c3 d8 00 00 4f 00 00 80 01 00 02 00 4f 4f 4f 40
d0: 02 00 00 00 b6 8d 68 00 01 00 00 00 00 00 00 00

Song
>=20
>> One thing I noticed is that the PCI configuration space shows
>> subsystem vendor ID of 0x1590 instead of 0x8086:
>> 0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 90 15 14 20   << subsystem vendo=
r
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
>> But I don't think that is the problem as the code search with PCI_ANY_ID=
.
>>=20
>=20
> It looks for the device with PCI ID 0x2014.
>=20
>=20
> Thanks,
> Kan

