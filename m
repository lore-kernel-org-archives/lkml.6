Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289D2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6F620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="v3F5rs7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6F620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeKSQnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:43:13 -0500
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:55472
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeKSQnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/p8DXZHqNxXeObY2t64gy7MY+uoU81J13q8+2FXKpk=;
 b=v3F5rs7JDI07adeIL6oUAlFvXkKjiT7lADLS9PIIxIaHfnc0RZJM3rFQ/t8YI0WKWT6P55zHGIJRDRIBUBi7LQMaDZAXMEpzm83ZCGjJHjIUSp35UQGsyrDobwmC5E/KkqYd9uNvVwwahBOHbsGYvewpeRGSqcj+mal9NohN3Zk=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2543.namprd02.prod.outlook.com (10.168.205.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 19 Nov 2018 06:20:29 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.045; Mon, 19 Nov 2018
 06:20:28 +0000
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
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewA==
Date:   Mon, 19 Nov 2018 06:20:28 +0000
Message-ID: <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181118204324.373ca9cc@bbrezillon>
In-Reply-To: <20181118204324.373ca9cc@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2543;6:p1uvurhxvTixbKCp9m7sR1MGjPA7GW8ndgnSjUzBK/KnbNN1wCWv4ZZudMGy1y+HVCMJEW44UPMXVv3prBaB+LgNwEGztuFHjViLctCTHUtxHYo31WTx5R1LgHeWryachXBr0Gi5d5oKRedkYSG663g/yFcHuXQg895jK0AfsTx61oV+NgCYakxEN8u1ij6aBs7/H0ygXDHEOzko8q24sDwtidnNZDSA4BxAt+5tI4rrW/tJGNsQSQk/2kYwAavSBtbQeP4cAUyYyDHG+7X8h/Ip1cT5vW/liaAnxvtqvFWPfmoGQTF0QRX7XP+prF8bNpqU+rYaGqZgybZ0oyaBDECIn6gdoyXeM84xxZgLTb8j/6t8kFCTOli7y3AFOAfoS+reaeKn94hCOP5uF0xEkkJR0ZEtY/G68Vj7irlrljxZbS2r0wv60fZjUNEJexi1AQ8GOhYMEsSN6Zg/tDH/zQ==;5:h64PWQPm9P08klRcilbT5NhK4mg0z75Oqk5MUXUzwz7Qdmh/1+VHzHND5zb0vvczSm2OMVlqpxaFSxRo9F66eOiZ9xC9K865T+1nJKx8RQRuRDjqS3Dyvi9IJg7g4opX7LjdkTuTGiUBBD6hGbh78bYL4uU2mRh+LmlTUBQAt1E=;7:4W5+0onL57oSwHBYXJw3DWPJqrq9S8Hb+FkpbbbkCswmjnRXbL0Ini3VGZeXQnkN1mcEIgdYCYC8Y2dmNyjVgCuQ2veVjHrv3VXnNaznIk6fit6DlSGoOuurHg2S8vCeLj3LH3TFI+HjMKcpJYnvjg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(13464003)(189003)(199004)(6916009)(486006)(7416002)(6436002)(7736002)(74316002)(2900100001)(446003)(6116002)(8676002)(3846002)(186003)(81156014)(11346002)(476003)(305945005)(86362001)(8936002)(229853002)(81166006)(53546011)(5660300001)(7696005)(76176011)(99286004)(66066001)(6506007)(217873002)(102836004)(54906003)(478600001)(316002)(14454004)(71200400001)(71190400001)(53936002)(6246003)(68736007)(105586002)(9686003)(106356001)(55016002)(107886003)(2906002)(97736004)(25786009)(39060400002)(33656002)(4326008)(256004)(14444005)(26005)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2543;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 45294649-146f-49d0-02b1-08d64de719b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2543;
x-ms-traffictypediagnostic: MWHPR02MB2543:
x-microsoft-antispam-prvs: <MWHPR02MB2543CF47AD281BC0263925DEAFD80@MWHPR02MB2543.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(211171220733660)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2543;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2543;
x-forefront-prvs: 08617F610C
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bigtQMgLpTNAN3nhaM0b4Jo3GxES273hqptV4ZGXYeFiHk9xwvMBS2zXkCb6CYLCd+pRrH5xE9DB8/TJoTLnLjp4dMEhHGVGQFvYiUO3GDCuhthuOvElLTp0d/KtLg6DLg4z8+w6o6ipZGrezYGd9RNrI/9Yaw6vFB3kFr/VYr7GhTmbxNLd63g8byXIpyv5jrXwZUUSa7SMQNJpbPmKt43sGzwtbcWC058GxkiKrf2uI5+Uebne31zj+0b90jFFLMwzroKcgOnQs7o+ASzeP1DRYSG+eHU2EDOgbd4+txtf/0q62f2tod3UsMU+drnhur2XB0y8Cx+3azLxmHR2uaN2I8m6jnWBw6IrE+Dqnog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45294649-146f-49d0-02b1-08d64de719b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 06:20:28.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, November 19, 2018 1:13 AM
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
> On Thu, 15 Nov 2018 09:34:16 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > Hi Boris & Miquel,
> >
> > I am updating the driver by addressing your comments, and I have one
> > concern,  especially in anfc_read_page_hwecc(), there I am checking for=
 erased pages bit flips.
> > Since Arasan NAND controller doesn't have multibit error detection
> > beyond 24-bit( it can correct up to 24 bit), i.e. there is no indicatio=
n from controller to detect
> uncorrectable error beyond 24bit.
>=20
> Do you mean that you can't detect uncorrectable errors, or just that it's=
 not 100% sure to detect
> errors above max_strength?
Yes, in Arasan NAND controller there is no way to detect uncorrectable erro=
rs beyond 24-bit.
>=20
> > So I took some error count as default value(MULTI_BIT_ERR_CNT  16, I
> > put this based on the error count that I got while reading erased page =
on Micron device).
> > And during a page read, will just read the error count register and
> > compare this value with the default error count(16) and if it is more T=
han default then I am
> checking for erased page bit flips.
>=20
> Hm, that's wrong, especially if you set ecc_strength to something > 16.
Ok
>=20
> > I am doubting that this will not work in all cases.
>=20
> It definitely doesn't.
Ok
>=20
> > In my case it is just working because the error count that it got on an=
 erased page is 16.
> > Could you please suggest a way to do detect erased_page bit flips when =
reading a page with
> HW-ECC?.
>=20
> I'm a bit lost. Is the problem only about bitflips in erase pages, or is =
it also impacting reads of
> written pages that lead to uncorrectable errors.
Yes, it is for both. But in case of read errors that we can't detect beyond=
 24-bit, then the answer from HW design team
Is that the flash part is bad.
Unfortunately till now we haven't ran into that situation(read errors of wr=
itten pages beyond 24-bit).
But we are hitting this because of erased page reading(needed in case of ub=
ifs).

>=20
> Don't you have a bit (or several bits) reporting when the ECC engine was =
not able to correct
> data? I you do, you should base the "detect bitflips in erase pages" logi=
c on this information.
Bit reporting for several bit errors is there only for Hamming(1bit correct=
ion and 2bit detection) but not in BCH.

Thanks,
Naga Sureshkumar Relli
