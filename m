Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756024AbeEHV3y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:29:54 -0400
Received: from mail-he1eur01on0094.outbound.protection.outlook.com ([104.47.0.94]:43808
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932572AbeEHV3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:29:42 -0400
From: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC: "Boris.Brezillon@bootlin.com" <Boris.Brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Thread-Topic: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Thread-Index: AQHT5iFM6au6Hr/JoEiTOkjp4NR4i6Ql0FuAgACJ/TA=
Date: Tue, 8 May 2018 21:29:38 +0000
Message-ID: <VI1PR07MB161510CAD11811A897BBB328819A0@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1525710855-8159-1-git-send-email-Jane.Wan@nokia.com>
 <20180508151309.40a78259@windsurf.home>
In-Reply-To: <20180508151309.40a78259@windsurf.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB1615;7:2Cst0qLalUXVY1ejiws0QsrP0q7fz7atJ280cFI+wOwhk3kzayavdNXAvxe4cSVc/2a134KXhY1ERGD2JaMOW26VKEj1DbWcNudmxx+8QZ/ZwJnDESyuONifv+IavOBOL66OFzofezSlpaoeqh+bXMKyldC5wQhqchhpJhPAArmkG6RfwqHG6KSRcx9bs2EVT/EomI4s9G4GXGrGsrJwNdkuUDgNjWLPAV1bnG12dtftZP28ZxyPABIuJmK3hRFr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(39380400002)(346002)(189003)(199004)(13464003)(6506007)(68736007)(54906003)(9686003)(7416002)(97736004)(316002)(8936002)(6916009)(6346003)(7736002)(74316002)(39060400002)(86362001)(81166006)(476003)(8656006)(102836004)(33656002)(7696005)(76176011)(305945005)(186003)(53936002)(106356001)(53546011)(81156014)(55016002)(26005)(105586002)(99286004)(8676002)(6246003)(446003)(5660300001)(6436002)(5250100002)(66066001)(229853002)(14454004)(966005)(478600001)(486006)(2900100001)(11346002)(3280700002)(4326008)(6116002)(3846002)(2906002)(6306002)(25786009)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1615;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:VI1PR07MB1615;
x-ms-traffictypediagnostic: VI1PR07MB1615:
x-microsoft-antispam-prvs: <VI1PR07MB1615D3BECC9AC580CB53DE8A819A0@VI1PR07MB1615.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(82608151540597)(85827821059158)(109105607167333)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1615;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1615;
x-forefront-prvs: 0666E15D35
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-microsoft-antispam-message-info: UkeRDxymBq3S+DZj1m4G4af/Ew33JsXzsqXumjZ3yToNDWrhha+h2wj2NCK8EaW2ZwsIKb1Kos2XU1wszSYSbWIt9mG2GdkGUdP/AdPaWcomlMrdke+ZHvyqKlneM/MWS/loH5HrInq9ggPu8KHfDuWKXXlz+d/Eey2y21hIf5Mp9mB++2rfY/xQg1DoAUke9OSuzcYq2g40Jqy6MazZQ+yZQu5YxCSGrB5Pand+xjA7mkLEplw9wF32FNpLA47y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 304c1013-dac8-40c1-29b2-08d5b52acd79
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304c1013-dac8-40c1-29b2-08d5b52acd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 21:29:38.1985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1615
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48LU1FA013626

Hi Thomas,

I've sent v4 of the patches based on the comments.

Thank you.
Jane

> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@bootlin.com]
> Sent: Tuesday, May 08, 2018 6:13 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: Boris.Brezillon@bootlin.com; miquel.raynal@bootlin.com;
> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> marek.vasut@gmail.com; yamada.masahiro@socionext.com;
> prabhakar.kushwaha@nxp.com; shawnguo@kernel.org;
> jagdish.gediya@nxp.com; shreeya.patel23498@gmail.com; Bos, Ties (Nokia -
> US/Sunnyvale) <ties.bos@nokia.com>; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
> recover the contents of ONFI parameter
> 
> Hello,
> 
> On Mon,  7 May 2018 09:34:15 -0700, Jane Wan wrote:
> > Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> > CRC values, the bit-wise majority may be used to recover the contents
> > of the parameter pages from the parameter page copies present.
> >
> > Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> 
> Minor nit: the commit title contains "fsl_ifc", but this commit doesn't change
> anything in the fsl_ifc driver, it fixes the NAND core.

[Jane] Removed the "fsl_ifc" from the subject in v4.

> 
> Best regards,
> 
> Thomas
> --
> Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons) Embedded Linux and
> Kernel engineering https://bootlin.com
