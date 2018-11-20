Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C86C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MzzX/MQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeKTRbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:31:40 -0500
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:56048
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728703AbeKTRbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFiaB2SLEQ0A7BNDkmMRnByFeP848NQVHHAujJobMrc=;
 b=MzzX/MQw86587/GNsJbn7kqFsQRblcanmcS6L1ihLENwEPVKB9HOpolAyT1GefT3Rl2zR1DZUDnqXHjkZZqpV2AiCQ4F7pLzel+fyq75amHKJ23DS5utcs6kORV8VkoPGVnTUmc5H5exF2gFvp8vfCTG9lz6+cYclqM7UoK+eyM=
Received: from BN6PR02MB2610.namprd02.prod.outlook.com (10.173.142.137) by
 BN6PR02MB2403.namprd02.prod.outlook.com (10.168.254.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 07:02:09 +0000
Received: from BN6PR02MB2610.namprd02.prod.outlook.com
 ([fe80::9d25:8c8a:f39b:9308]) by BN6PR02MB2610.namprd02.prod.outlook.com
 ([fe80::9d25:8c8a:f39b:9308%10]) with mapi id 15.20.1339.025; Tue, 20 Nov
 2018 07:02:08 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKA=
Date:   Tue, 20 Nov 2018 07:02:08 +0000
Message-ID: <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181118204324.373ca9cc@bbrezillon>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181119090246.49060019@bbrezillon>
In-Reply-To: <20181119090246.49060019@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2403;6:Ow4UyKwZVDOxMQqvDXV6oTWDcu7iII/azyeKEcC/Xb4PiOP840LuVuUB7a/bpEMBQ2jbTy6WHzgG2VWV+YldffjQpRTZwF0DS5DECzmKN8StoIQKINZAGo4tIHESa8fbkHNspmsa/RfSc4Q7thhWm1uS5edroTWjwN0oAl5D0OzZxPHeAebpHgX1AQINllGlPDAYOUnFj44Kwb98INxnr/CzM+iXrttz3cNJvyeJFNaXkk1Xn8IVefJRXY42YXAljVYj80L3nz9ISqF+vH5+TmYWyJEIP3p967tLa7opXwNGGqkZwZEpUi2pAix8Nklwn3qHYySBY2QFGPX/aGZZOH2W4iI3WqjSOITitNqgzy3OJY21LwvQOj7hrY1XI4oNex++9zhs/o76/mGFUHPpBnPgReEe35rgtY98e2xzhkZh/4aTFYHv/0xRDEOzKgIRa/Yc0M3f1XRbCU/Wk12Iyw==;5:Ox787NevHTqp/oKgTYq0awASkUpd8/TQDNpF3IIxUtl//7lhmYtGWl8ZF/OfyB7AFQiq+gP6tEIdKPuxL8lWQFy1se4Tk6zmuIC4GOpXHGpQt3Z35pGBcFpSrAKz5hESXHY8A2JLdDFyTa0hpZGDfpcW3xHnq0jpJrFUIZxRnrk=;7:oTvahSIlurntayupDfdUhjGrT0Q6Q28szmWANIaqJif0dIatzra2TCy+vyQou176hyEA0MLJ58OC6Jn4lHPLvbUb2jQ+zZaU9TWtSkqxNsJXiVpdVHQs+csQR2j3rHLMHRNxlV0mj0JRo8RrcVfbSQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(13464003)(189003)(199004)(229853002)(66066001)(99286004)(97736004)(71200400001)(81156014)(71190400001)(81166006)(3846002)(6116002)(9686003)(55016002)(7696005)(76176011)(6506007)(53546011)(14444005)(256004)(102836004)(53936002)(217873002)(316002)(54906003)(14454004)(8936002)(186003)(6246003)(107886003)(26005)(39060400002)(2906002)(4326008)(25786009)(8676002)(93886005)(478600001)(105586002)(106356001)(5660300001)(33656002)(7416002)(446003)(7736002)(305945005)(74316002)(11346002)(86362001)(2900100001)(486006)(6436002)(476003)(6916009)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2403;H:BN6PR02MB2610.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 66874921-7621-4c92-6c93-08d64eb6164e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2403;
x-ms-traffictypediagnostic: BN6PR02MB2403:
x-microsoft-antispam-prvs: <BN6PR02MB2403C8498A18566B34499B4AAFD90@BN6PR02MB2403.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR02MB2403;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2403;
x-forefront-prvs: 08626BE3A5
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DtwQ7cVaxAhn9q0PT/TLRtDJvUj1bOc7ms99bv9F4mf+nLJh4H9ddO8U6JhK16svkhyOMv5mpobNvgioVR6KT1N9oz8wSEr43x41dQtdGbmgllKigbVDf7oyMY2WEHPpEqzz2RHu3C6UNeWDa9AuJOuUsGueTibWwYku4nAoKGrsloQts9PL9z7EenhPpJZR07b5jHjl+uK9EdH4p+0fE0ghGtQR8nhMQehuCR2tZ+zcmpfXcJK89zDH8mdjW4Zxed2BVDm365VR14GZigDd77KwyvHbq3WQdRj+CxGSBAM9+gaQcG9PfhvRCWUTtGLPNALRn/n9DFxTh1exGrRvv5F8i/1j5o6vVisVR3jDzdU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66874921-7621-4c92-6c93-08d64eb6164e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 07:02:08.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2403
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, November 19, 2018 1:33 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; linux-mtd@lists.infra=
dead.org; linux-
> kernel@vger.kernel.org; nagasuresh12@gmail.com; robh@kernel.org; Michal S=
imek
> <michals@xilinx.com>
> Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for =
Arasan NAND
> Flash Controller
>=20
> On Mon, 19 Nov 2018 06:20:28 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > H Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Monday, November 19, 2018 1:13 AM
> > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > linux-mtd@lists.infradead.org; linux- kernel@vger.kernel.org;
> > > nagasuresh12@gmail.com; robh@kernel.org; Michal Simek
> > > <michals@xilinx.com>
> > > Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support
> > > for Arasan NAND Flash Controller
> > >
> > > On Thu, 15 Nov 2018 09:34:16 +0000
> > > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> > >
> > > > Hi Boris & Miquel,
> > > >
> > > > I am updating the driver by addressing your comments, and I have
> > > > one concern,  especially in anfc_read_page_hwecc(), there I am chec=
king for erased pages
> bit flips.
> > > > Since Arasan NAND controller doesn't have multibit error detection
> > > > beyond 24-bit( it can correct up to 24 bit), i.e. there is no
> > > > indication from controller to detect
> > > uncorrectable error beyond 24bit.
> > >
> > > Do you mean that you can't detect uncorrectable errors, or just that
> > > it's not 100% sure to detect errors above max_strength?
> > Yes, in Arasan NAND controller there is no way to detect uncorrectable =
errors beyond 24-
> bit.
>=20
> So how do you detect uncorrectable errors when the strength is less than
> 24bits?
Below or equal to the level of ECC strength, controller will definitely cor=
rect.=20
But beyond the level of ECC strength, it won't even detect the errors.
>=20
> > >
> > > > So I took some error count as default value(MULTI_BIT_ERR_CNT  16, =
I
> > > > put this based on the error count that I got while reading erased p=
age on Micron device).
> > > > And during a page read, will just read the error count register and
> > > > compare this value with the default error count(16) and if it is mo=
re Than default then I
> am
> > > checking for erased page bit flips.
> > >
> > > Hm, that's wrong, especially if you set ecc_strength to something > 1=
6.
> > Ok
> > >
> > > > I am doubting that this will not work in all cases.
> > >
> > > It definitely doesn't.
> > Ok
> > >
> > > > In my case it is just working because the error count that it got o=
n an erased page is 16.
> > > > Could you please suggest a way to do detect erased_page bit flips w=
hen reading a page
> with
> > > HW-ECC?.
> > >
> > > I'm a bit lost. Is the problem only about bitflips in erase pages, or=
 is it also impacting reads
> of
> > > written pages that lead to uncorrectable errors.
> > Yes, it is for both. But in case of read errors that we can't detect be=
yond 24-bit, then the
> answer from HW design team
> > Is that the flash part is bad.
> > Unfortunately till now we haven't ran into that situation(read errors o=
f written pages beyond
> 24-bit).
>=20
> Can you please run nandbiterrs (availaible in mtd-utils). I fear your
> device won't pass the test.
Yes, nandbiterror test is passing till 24bit, after that it is failing.
>=20
> > But we are hitting this because of erased page reading(needed in case o=
f ubifs).
> >
> > >
> > > Don't you have a bit (or several bits) reporting when the ECC engine =
was not able to
> correct
> > > data? I you do, you should base the "detect bitflips in erase pages" =
logic on this information.
> > Bit reporting for several bit errors is there only for Hamming(1bit cor=
rection and 2bit
> detection) but not in BCH.
> >
>=20
> Then I tend to agree with Miquel: your ECC engine is broken, and I'm
> not even sure how to deal with that yet.
So as per the Miquel's suggestion, can I proceed to add the below one?
"you should re-read the page in raw mode and check for the number of bitfli=
ps manually (thanks to the helpers in the core). Again, if the number of BF=
 is above 16, we can assume the page is bad and increment ->ecc.failed acco=
rdingly."

Thanks,
Naga Sureshkumar Relli
