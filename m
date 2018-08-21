Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B31C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A85F214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0/ndhO18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A85F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeHUMlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:41:37 -0400
Received: from mail-eopbgr690077.outbound.protection.outlook.com ([40.107.69.77]:2912
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbeHUMlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldqKfQKX5G9lcMGQiiTzb6ngN8ENnYy/QEgjcbcsBe4=;
 b=0/ndhO18vRzhl+LFH/w/tnRSMPWEkc5z9zemYc4j9ALRJSbO2oJw0gpo2pp3kWAWxq9NSZ/g5rbl/9D2V0G3hYuzrQKATcfPg0pRNFNgMAyNBo/QMSw6bSsEI95L/mlz0p7Bom60a2eM+1O9dOUsRyJftZFsg18jTfkmiat/fys=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3325.namprd02.prod.outlook.com (10.164.187.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Tue, 21 Aug 2018 09:22:10 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 09:22:07 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUNiz1pd9TJsD6BkCdX9soxsgc9aTIl58AgAEHRSCAAB0XAIAANHvg
Date:   Tue, 21 Aug 2018 09:22:07 +0000
Message-ID: <MWHPR02MB2623E78222225D1CE8167463AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820143324.61af9027@bbrezillon>
        <MWHPR02MB2623F315C6D4C9775CDA08D8AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180821075948.28962170@bbrezillon>
In-Reply-To: <20180821075948.28962170@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3325;6:DObbCEkkxw2HLvsH1TY+86B0epuwBcjS8VKV6OpB5qtkkKQevFSwL2SkW4cEAw+VjJr1fd7BemUQ1CxaX3FWgl+3J1EHJMhO5nnVFe1Wpwb02949+h3Gq9EM4XEO78P+pG+HB8aKhy+sbSlCY5YbfNdQ+AjWTu2QoescjOcMsHF5By8Iw/IDxxKmSz6AUdcu13Kboxvo6bWuiD30hHTDaaJTV3ydTTIPBE5A3yRo6Axzapkk9T3pnWTG+LWEpMtVbqoi3VWQM0213C1ri1ea3PrRclIHssSCri31SnyGZufqTNVSIN9laHQfYt8VtBc2hqdGwX5dWHs38GPrbpwV6ElLUU1JOLB2aZRPzNAqzWPgL0jRg77LqicSaDLnShy3bk7VDTZGGDvg49evEWrUY5Abqri0E28J1cQeZ1ALIoREUNsy09iKuBALVnhpe7j41gS+ygePScNnbSokyXKSFg==;5:SjuMXkNsqYKpZCMADT3dM9YT8cErcwTPVl2btkMfuykPIaRVYCVkjgHUCTyK6qLogUoklEzuZ2BL08QY2XN7VCV+ejgx5VfSIXOz2ToYqTMJoJMZlJddNPBWdIhQQ6IkAutsPVpoUWSxqFBdduhT2VbvAyvq5O7fxem4Oo0c6ug=;7:v5jjEmIVci7wOQ1BmXYSr9gk2Me83h0eIB3Le8/kQJSsAuVIPQfaCqQDoCz+YIcAQTyQr9qd4b/x9ZFMpkWk4LOwGfpiWeZS0zpC9lP2fflAIh8vG0HtHtyKxT1x+EF0XwAiIAtp9Ac7DnVlWb82JHbzWrCjdQeSIih44zNot9M5REhKRZdUD5SvFSiqCgJA36rLxjPSmng3yt9s1hGodAq9pNI1O1AKnEPHdDZofZECvDucVIVdnHtrNHBvqSrx
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(199004)(189003)(13464003)(106356001)(229853002)(8936002)(486006)(99286004)(6246003)(7696005)(76176011)(446003)(5250100002)(68736007)(53936002)(39060400002)(476003)(6306002)(9686003)(316002)(2906002)(55016002)(3846002)(6116002)(2900100001)(11346002)(478600001)(14454004)(6436002)(66066001)(74316002)(105586002)(54906003)(86362001)(7736002)(26005)(305945005)(7416002)(6916009)(186003)(14444005)(97736004)(256004)(81166006)(8676002)(81156014)(5660300001)(217873002)(102836004)(53546011)(33656002)(25786009)(6506007)(93886005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3325;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: eeffbb2d-3771-4cef-8a26-08d6074790e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3325;
x-ms-traffictypediagnostic: MWHPR02MB3325:
x-microsoft-antispam-prvs: <MWHPR02MB3325760C17617F5968B1DBB1AF310@MWHPR02MB3325.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:MWHPR02MB3325;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3325;
x-forefront-prvs: 0771670921
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PDUZUiKtYGls2zdnQS64tlVimqmCUZpBADYatiwCMo8pJNEPdDg4qLVBmvjKP+zjXM7rTVoOyQMpmB1jC801RFlq92Pmrx4S1DykVxFyJ3+d0gTQYY58l3eFkJlwF5Lwnf+Q+KhXVFwL3dLr984imJXp0+PgtttBbXimUqC9mGcQmaAHfUjGPzBii7y7WxbIwzU1zUDzKEOZPMjv+c3+bQ9Oc5QO98bj1Dr1Lr4OGIGCtYJ7pU7b3p+JUhXKL7XiGV5Xk7LvLpT2hoQXqjDHP8pAxlMM+EPWZ5C8vOkyOmMX1Kt8kc0PghruVsTMv/G/MvYSeK466R6GZdXrZ6Fau8k7PJwjcq7js6/jIf3vQBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeffbb2d-3771-4cef-8a26-08d6074790e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 09:22:07.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, August 21, 2018 11:30 AM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; kyungmin.park@samsung=
.com;
> absahu@codeaurora.org; peterpandong@micron.com; frieder.schrempf@exceet.d=
e; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device t=
ree binding
> documentation
>=20
> On Tue, 21 Aug 2018 05:47:18 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > > > +Required properties:
> > > > +- compatible:		Should be "xlnx,zynqmp-nand" or "arasan,nfc-v3p10"
> > >
> > > In your example it's not an "or" since both are defined.
> > In our previous discussion
> > (https://lore.kernel.org/patchwork/patch/748901/)
> > We decided to have compatible strings like " compatible =3D "<soc-vendo=
r>,<ip-revision>",
> "arasan,<ip-revision>";"
> > So it should be either of these.
> > so I will write something like below
> > "Possible values are  "xlnx,zynqmp-nand"
> > 			"arasan,nfc-v3p10"
> > And in example I will mention any one compatible.
> > Is it ok?
>=20
> Hm, why do you need arasan,nfc-v3p10 at all if it's supposed to be overlo=
aded by a soc specific
> compat?
Actually we put these compatible strings based on the comments on v7 series=
.
Anyway I will just keep "xlnx,zynqmp-nand" as compatible.
>=20
> > > > +
> > > > +Optional properties:
> > > > +- arasan,has-mdma: Enables DMA support
> > >
> > > Can't you detect that based on the compatible (or thanks to a
> > > register). If it's something you choose when configuring the IP and c=
an't detect at
> runtime I guess it's fine.
> > There is no way to select DMA when configuring the IP.
> > But it has internal DMA and there is a register to select PIO or DMA wh=
ile starting a
> transfer.
> > So if user really don't want DMA, then we will never set DMA in the cod=
e based on DT
> property.
>=20
> If it's a purely SW choice, then is shouldn't be described in the DT.
> You can use a module param, but I'm not even sure why one would want to d=
isable DMA.
UBIFS doesn't work with DMA, hence we are using a DT property to operate th=
e driver in IO.
But as you pointed (use virt_is_valid()), with this we can switch our drive=
r to operate in PIO or DMA.
I will remove this from DT.

Thanks,
Naga Sureshkumar Relli.
