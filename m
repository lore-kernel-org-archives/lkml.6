Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13998C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967BD20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jiz29T/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967BD20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeIKKUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:20:44 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:43492
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbeIKKUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvMZ4I5fDyFWFrWkDmnNKWbcPDm/uzUdy4uYcM1Sdoc=;
 b=jiz29T/XHciXYgsbTiCv8osnD2dPilNcqZB2AuA7sHbqXshBxqEOc9oX9BMknsyTX80JrY0hpzvf6r56s+EGyy4AVQTXB2PvKOSONWSsTfZq+jy2n2GkWfM13UHR9G/0kdve00qQmMiujxFY4Xuvou4d3VHcxUkEG1myitvlCT0=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2336.namprd02.prod.outlook.com (10.168.244.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 05:23:09 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::948a:706d:2ec5:4b6f]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::948a:706d:2ec5:4b6f%7]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 05:23:09 +0000
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
Subject: RE: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TI3JSAgCHUiIA=
Date:   Tue, 11 Sep 2018 05:23:09 +0000
Message-ID: <MWHPR02MB2623A761C40745AD4AE2A295AF040@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180820184013.57fd7b5c@bbrezillon>
In-Reply-To: <20180820184013.57fd7b5c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2336;6:AbR7BiutiSgiA/Qr4Fsdw/yKu2bwoFBDYsYM8KCggm27FA21PFC7yEzdM+k91UZiieKqJA9sY9RVIZlrgTm/oBaXpm/3cVzjwC5SAi5HwHWTFGfeWXGPNz8GBhJj0xt5NKCvA0l6yCOK7PB5tKaV3RnKjH80ajfkeUWoRqMdtDaqloX7yPRfTs7ropdw4eyRNo9GxPI35dBSSY+e9rps9iqYOihz/HW0wzj9ALv0yOgvoUV6XK+9lO/BxMQnsZN8gzhi4z3F8d8e2hWVgO9aqLI70Ob2xgmTMHrEG6yIAR762ZH8xN6q+XNnZ4uGWmRuOCQSrZLWC/HQKbwzGJHnp6BhOCnoMlAGJM6AeJy8ZQUMlLxjC4eDRnpH0dxl1Hz5/h6i2saLh+sMHLR87SyF3WYcBg8w46pw1Endf7epaBIyIGJ2QSx6UINhzHqgz1m3tMiRyfjq58dd8eUZJea5aA==;5:DHl9ffQT0YmXDerlhX992sr1zoje9xWThutEef7nR1WdTb5ZzoP9VHr4EliH0cYpsvjLDLFN3RD1zNmGzfAKhJxNLd29rEfnLKo+lgUINcQQh3eCHZ68nyjUzKRJXFjzjk9HKlmRYH+42OdmRHj+PQ2Js24SZX+gzKDICzIo6L4=;7:JiZ1Pcx0OmeJPhMOej8ybDKs2pVafOsuEjY6t6vTtcIE308zIOzYtToF7jJpPAe7y5+GgwNovY5HzyMjk1yqTo3FlAQnUg84c0JyfXmaOx6Ut4S8aczmMT8V9Z1/5GyXBJ3EPHjMzDxUZ0IDX2O/4ubRLoF12S05mFN8Qqj0vwGu530rnwrJr68LgX/lUf/oHNnLQKz0/W3GJSzccxTftYmMBjX4MuJsA18i7fhyr0Th9zGqdKsag6j0lLFHPvoj
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(13464003)(189003)(199004)(6436002)(99286004)(7416002)(53546011)(7696005)(6346003)(106356001)(102836004)(8936002)(86362001)(6506007)(81156014)(446003)(11346002)(105586002)(6916009)(478600001)(476003)(186003)(486006)(81166006)(26005)(76176011)(39060400002)(316002)(74316002)(4326008)(305945005)(25786009)(6246003)(68736007)(33656002)(66066001)(14454004)(217873002)(54906003)(7736002)(14444005)(256004)(5660300001)(9686003)(2900100001)(53936002)(6116002)(3846002)(2906002)(97736004)(55016002)(8676002)(5250100002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2336;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4477e4b6-306a-413a-5715-08d617a6a945
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2336;
x-ms-traffictypediagnostic: MWHPR02MB2336:
x-microsoft-antispam-prvs: <MWHPR02MB233648F7DA37F0E4B7A214CFAF040@MWHPR02MB2336.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:MWHPR02MB2336;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2336;
x-forefront-prvs: 0792DBEAD0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-message-info: SVo5CcKR//fny73mBefGAHnxli1I22EezRuX3ll5qwu3k1weAQ5nYKXFzzpU0LjpRFZyp9BqJloAbh5Ee+JjW5rUDjeWtWK+aeysdmGeTEuEjxtzgVj55AJmp/MLTb5+dacuSwO3Jryn5fStNlCSpKH/AjDsCpT62WtXoBF/EOfaMW6TsYiyDAiQfwula/bad5k5/2Z+r5YiivAAxt7xHM1NMYsMzucLU+MZgZl9aWBHZ9PhCoUpHW3VOVqkcny6tmyUCsCL+OQaWHZt94t4qqRpot6+yWzbHk57mar+xPSTCustbh8hxm/NIChRWTB0QcdgObAKhWlg+5/tcrjyoIEf1SkSZPuiuRuwhLtmMPQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4477e4b6-306a-413a-5715-08d617a6a945
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 05:23:09.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, August 20, 2018 10:10 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; kyungmin.park@samsung=
.com;
> absahu@codeaurora.org; peterpandong@micron.com; frieder.schrempf@exceet.d=
e; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for =
Arasan NAND
> Flash Controller
>=20
> Hi Naga,
>=20
> On Fri, 17 Aug 2018 18:49:24 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
>=20
> I haven't finished reviewing the driver but there are still a bunch of th=
ings that look strange, for
> instance, your ->read/write_page() implementation looks suspicious. Let's=
 discuss that before
> you send a new version.
Could you please review the remaining stuff?
I have the changes ready with me which will address all your comments given=
 to this series.

Thanks,
Naga Sureshkumar Relli
