Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214FAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF08F20864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bo5q0CHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF08F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756665AbeFOWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:15:29 -0400
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:13584
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753726AbeFOWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yrnAIZtwm8xIBEAi7dTp7BJcmmTiN4h0sfEZ+EzxaE=;
 b=bo5q0CHvFq5XgIfD0FJTmuFIQUK+KtvBp6NWmlBi9kPQMCadRhvS72TrAbLpulEoUSzKinR8MgXSEkd6Suks/c3QNF6gLCI1+x1C42eJ96TV70IjB1BI8uKxTtLIgATNCzFd4XRVsy85mq0cmWe6fleTH1bCdj9WCmvizwUFvr0=
Received: from MWHPR12MB1407.namprd12.prod.outlook.com (10.169.206.18) by
 MWHPR12MB1454.namprd12.prod.outlook.com (10.172.55.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 22:15:24 +0000
Received: from MWHPR12MB1407.namprd12.prod.outlook.com
 ([fe80::2c11:9cea:f169:a871]) by MWHPR12MB1407.namprd12.prod.outlook.com
 ([fe80::2c11:9cea:f169:a871%9]) with mapi id 15.20.0863.016; Fri, 15 Jun 2018
 22:15:24 +0000
From:   "Grimm, Jon" <Jon.Grimm@amd.com>
To:     Rudolf Marek <r.marek@assembler.cz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Chris Ouellet <rabbit.of.war@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Ryzen 2700 Temperature offset?
Thread-Topic: Ryzen 2700 Temperature offset?
Thread-Index: AQHUBPPTGwu59AYr30G87fBJrlqt2KRh3ikw
Date:   Fri, 15 Jun 2018 22:15:24 +0000
Message-ID: <MWHPR12MB14073E683C1B8438D11EA963E47C0@MWHPR12MB1407.namprd12.prod.outlook.com>
References: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
 <20180607154915.GA7061@roeck-us.net>
 <54EAD835-C48D-4751-9BFF-71536241129A@canonical.com>
 <20180610051420.GA22601@roeck-us.net>
 <abf1f966-f56f-70f2-7c79-047b31fc066f@assembler.cz>
In-Reply-To: <abf1f966-f56f-70f2-7c79-047b31fc066f@assembler.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jon.Grimm@amd.com; 
x-originating-ip: [72.177.57.116]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR12MB1454;7:2IF79PdTShYLy611NzruqfQXiG6y6aqW/VbF7u5KXs66vPPozk7aiU7H2vTqJxtnJOkPq1xCoY8kJqGY403JUC82cQSSOSYIygM6LfkNv1nLWoiS69empbMdhkpC0BOyWJpbhsTks165N0Qw1W/UQ9FOlLckEfPs0zN62cGmuJWSWy5W9580Aj0crVQYqEYOq0dX3OufOcE0R/DnjLsyF0cd912hyNN+hnuiRtfQ1hFiisRstqbsp0Sj5nI9RD/K;20:CNeSymBmSzcCdbDp310LnwF8xBj3iNIhZ+TSC7Ta32KfGl8HfUvI/w7Dis7gLnebqRDltZ23YuFbKdIVkLzsVBRIROjcQAcGf0wzEcsktVf1WtJBh+IOfWaKb6rKsrfOnKPN8RAm18zhBTiyGWjw62oSqxR5fhsk741kWANdWXxUk/hvGp1BM8yK/GBdhktlbGR//7hbd61uFM1dWB45DoD2E4h5pWg+dERYxPJiglR/2z+kb+sIIlysq7S9jcEN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dd21d0f-f98f-4e66-82db-08d5d30d7ded
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1454;
x-ms-traffictypediagnostic: MWHPR12MB1454:
x-microsoft-antispam-prvs: <MWHPR12MB14544E444C6518FA8979881AE47C0@MWHPR12MB1454.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(211254476889703)(9452136761055)(85827821059158)(767451399110)(24339691489775)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1454;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1454;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(39380400002)(376002)(396003)(189003)(13464003)(129404003)(199004)(6246003)(7116003)(476003)(4326008)(9686003)(14454004)(3660700001)(2906002)(8676002)(186003)(53936002)(3280700002)(446003)(25786009)(26005)(55016002)(229853002)(81156014)(81166006)(86362001)(8936002)(66066001)(486006)(5660300001)(39060400002)(6306002)(11346002)(33656002)(74316002)(305945005)(68736007)(105586002)(2900100001)(966005)(102836004)(59450400001)(97736004)(3846002)(7736002)(478600001)(76176011)(6506007)(6116002)(5250100002)(7696005)(72206003)(99286004)(53546011)(110136005)(6436002)(316002)(54906003)(106356001)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1454;H:MWHPR12MB1407.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZWY4Zc6j3tLw+5cAqZolKY88elSsSErKMweSPwhJEAKaSqmXYNFB2C1M5XAwfGV2CjqJUWsKsHi8/a/M/7uxyZqhqvKE7UP4x08lXJA7fHF2ErBNI9kFEQLKjTEKdbj8L9LkFkSlcbyMmW/iJhXD8FSFDNFwMHmfBOhN6L+eAWo7LY+So0qutWR8Tb9jE9a8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd21d0f-f98f-4e66-82db-08d5d30d7ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 22:15:24.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rudolf,=20

Yeah, let me do some checking.  I was already aware that our docs were miss=
ing this information; need to check if there are actual plans to address or=
 not. =20

Best Regards,=20
Jon


> -----Original Message-----
> From: Rudolf Marek <r.marek@assembler.cz>
> Sent: Friday, June 15, 2018 4:57 PM
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>; Grimm, Jon
> <Jon.Grimm@amd.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; Chris Ouellet
> <rabbit.of.war@gmail.com>; linux-hwmon@vger.kernel.org; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Ryzen 2700 Temperature offset?
>=20
> Hi Jon,
>=20
> Please can you help?
>=20
> Thanks
> Rudolf
>=20
>=20
> Dne 10.6.2018 v 07:14 Guenter Roeck napsal(a):
> > On Sun, Jun 10, 2018 at 03:03:47AM +0800, Kai-Heng Feng wrote:
> >> at 23:49, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >>> On Thu, Jun 07, 2018 at 11:03:13AM +0800, Kai Heng Feng wrote:
> >>>> Hi Guenter,
> >>>>
> >>>> A user thinks the Ryzen 2700 temperature may not be correct [1].
> >>>> Can you take a look when you have time? Thanks.
> >>>>
> >>>> Also, where can I find all these temperature offsets? I googled but
> >>>> with no result.
> >>> Problem is that the offsets are not documented in public, making it
> >>> difficult to find out. For Ryzen 2700, there is currently no offset
> >>> configured; I was told that there is none. For Ryzen 2700X, the
> >>> offset is 10 degrees C.
> >>
> >> I am still quite interesting where you get this information...
> >>
> > Primarily lots of online research. Windows tools usually support the
> > offsets, so screendumps help in some cases.
> >
> >>>
> >>>> [1] https://bugs.launchpad.net/bugs/1774817
> >>>
> >>> The key here is the commit mentioned in the log (1b59788979acd). It
> >>> does not only adjust the per-CPU offset, but also takes a
> >>> configurable offset of 49 degrees C into account. You'll need to
> >>> apply that patch in your kernel, or the temperature may be off by 49
> degrees C.
> >>
> >> So unless AMD shares these offsets value, we can never know what
> >> correct offsets are?
> >>
> > Unfortunately that is correct.
> >
> > AFAIK the information is available from AMD under NDA. I can not sign
> > such an NDA, and even if I could and would, I could not use the
> > information in an open source driver. Kind of a loose-loose situation.
> > If you (Canonical) have any influence at AMD, it might be useful to
> > let them know that their policy is not very helpful.
> >
> > Guenter
> >
> >
> >> Kai-Heng
> >>
> >>>
> >>> Hope this helps. If not, please let me know. Note that I am
> >>> travelling; responses may be delayed.
> >>>
> >>> Guenter
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-hwmon" in the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-hwmon"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
