Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99C32087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="XrHucgJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfBYJ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:28:21 -0500
Received: from mail-eopbgr1400102.outbound.protection.outlook.com ([40.107.140.102]:28477
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbfBYJ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIBKxZKwo+Ky7nz98oAnEvFwM0+rIESggOGUbjhHJio=;
 b=XrHucgJ9iuGxVqsZtwt6HcOzswQ/beMfTy/aT5Ie12da+OsrCtXrY9FZYNDHwRzhlwpkxe4BToSaCB+iUtynazgigSKrHgKbvbPtNuWTYZ+4cw1cRgpj4+Oq3gz2HugGJ71G2cFO08BSuUETazTqnkwDg7dothXFxh+d5AfiCbU=
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com (20.178.139.140) by
 TYAPR01MB3342.jpnprd01.prod.outlook.com (20.178.136.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 09:28:16 +0000
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::4c6e:195:8a7f:bc73]) by TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::4c6e:195:8a7f:bc73%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 09:28:16 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v4 0/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH v4 0/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUygASMEbBLe3QEkeg1356bZbvXKXtIUmAgAMggqA=
Date:   Mon, 25 Feb 2019 09:28:16 +0000
Message-ID: <TYAPR01MB4015D859E542280ABB5D9DC2DF7A0@TYAPR01MB4015.jpnprd01.prod.outlook.com>
References: <1550765459-14519-1-git-send-email-gareth.williams.jx@renesas.com>
 <20190223093207.GC1018@kunai>
In-Reply-To: <20190223093207.GC1018@kunai>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8d5894b-42f5-4033-be29-08d69b03926a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB3342;
x-ms-traffictypediagnostic: TYAPR01MB3342:
x-microsoft-exchange-diagnostics: 1;TYAPR01MB3342;20:rt34sP7AK3HajUHNs0dnVPD+Ge3ogUyNMjE7v+f8jhJODhhfZyZjlJve0gNpUYQSWNQJdca+4vJzO35fbnQ0zqyEhYSTz1A0vnoTw9cCFGhuVz64+dba8ISdkzZSWYOZ+0tbUtzLIfzaEcmRrFsAhcsvYA1ka59N6ep12xgVc+0=
x-microsoft-antispam-prvs: <TYAPR01MB33421D8FC71DFBF9B0ABAAEDDF7A0@TYAPR01MB3342.jpnprd01.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(51914003)(199004)(7696005)(54906003)(6246003)(52536013)(9686003)(99286004)(316002)(53936002)(5660300002)(86362001)(4744005)(2906002)(14454004)(55016002)(4326008)(107886003)(76176011)(486006)(478600001)(66066001)(71190400001)(71200400001)(11346002)(3846002)(68736007)(14444005)(7416002)(97736004)(256004)(476003)(25786009)(6506007)(53546011)(106356001)(8936002)(81166006)(81156014)(6916009)(305945005)(7736002)(8676002)(6436002)(74316002)(229853002)(186003)(33656002)(26005)(105586002)(446003)(102836004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3342;H:TYAPR01MB4015.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z5rFa5R8ReVNc2jjyXkQLIG7Pv/fh0MrTM9rU5HUxt4yg34E4mJEV8fo88xvz7o07OwusUS6GL+uraQY/rmN8k109QpOOtHDCBpV+7GAnRTqla3PEskR4USRQdJyQFHmzY9ALx9rCS1AupKzoZDwTK/xZwBwlK2kTVqfdKbpFu8jW0CN6FNg7qeXqcHJYbhmt+pBq07Ym0SnkE+nSKCj/mpk13zWqUwaNzsQOOK750bTkhRuFY7WGc4IwyrjmHckBAh8rMjykvneJOTu8/8tnBxRhXk85FMv8dMcW7Gz79Q6PyuawMKDSQ/yiflhLEydYnTpbtiG93phHD+Mwp9JG/bLIX56caQYuUR/3WzkIT7ClfBTKO56Li6OwNYqiCGhGKMZyxEV+6A5BGiYILgvZ+wkHhY+cPdvX8Yb+8XXJ1Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d5894b-42f5-4033-be29-08d69b03926a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 09:28:16.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Feb 23, 2019 at 09:32 +0100, wsa@the-dreams.de wrote:
>> On Thu, Feb 21, 2019 at 04:10:57PM +0000, Gareth Williams wrote:
>> The Synopsys I2C Controller has a peripheral clock that some SoCs
>> require to access the registers. This series also details the new
>> clock property in the bindings documentation.
>
> On Sat, Feb 23, 2019 at 09:32 +0100, wsa@the-dreams.de wrote:
> Your SoB is missing for patch 1. And besides my ack, I'd still like some =
feedback from the actual driver maintainers.

Thanks for the feedback Wolfram. I will wait for input from the driver main=
tainers.


Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
