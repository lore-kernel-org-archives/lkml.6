Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C95C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5681214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Hu/Bm2ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5681214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLFPrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:47:39 -0500
Received: from mail-eopbgr710059.outbound.protection.outlook.com ([40.107.71.59]:55296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbeLFPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM29Kj4gI0JrGQFH2NM1oiUEqi3V9YClootFV/uB6dk=;
 b=Hu/Bm2ar0zWww0e6mEDlvhgz3cJbSbNaDqHZ7ddgsEvGRL2J2LyTp++lw60WgdusI4MBzfocaAefmcxISC0cNUSLL2SsTkRl/g6ovjoRx1XS7gWvXE+Oa9zHuRL7AT+uvbEX5TUyqDGQ6/N186j0djVj/8XR+1rEvyo+rJop/M8=
Received: from MWHPR02MB2783.namprd02.prod.outlook.com (10.175.49.149) by
 MWHPR02MB2528.namprd02.prod.outlook.com (10.168.205.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 15:47:36 +0000
Received: from MWHPR02MB2783.namprd02.prod.outlook.com
 ([fe80::3cdc:f4c:38f2:f62f]) by MWHPR02MB2783.namprd02.prod.outlook.com
 ([fe80::3cdc:f4c:38f2:f62f%3]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 15:47:34 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v2 0/4] Add support to register platform service IRQ
Thread-Topic: [PATCH v2 0/4] Add support to register platform service IRQ
Thread-Index: AQHUfCoaaO4km+A5C0WJAhnBWxE0a6Vx/aAg
Date:   Thu, 6 Dec 2018 15:47:34 +0000
Message-ID: <MWHPR02MB27832B867A3557D07B8788BAA5A90@MWHPR02MB2783.namprd02.prod.outlook.com>
References: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2528;6:IYHP6z/xTqzwHhpVjVU0y3ajaFz9TGSKzyiIyyUDd/xPe9DlLVFIibaQJjzoDzBgDW6ZXjkFdI1vcwZ8VdZ6E6zq9x+PSoiyj8ztENxBioJob543KuFogsOpQOcJhkqSljMyiG+9NQHqObJEk8EI/91ZQYp+ysn+779Onke/U4HY3J04UKq6FzNNQ6ScXs4xDmrbNiS0R6nbdEwfL8320r3WqcOVy3LNy1+ASz3XZTTHqbURTZY2pGxq/In5PHfQg9kU8o5b6z3MOPveokLOB+chFGIMhYZxSdvER0vbRMEejfFns97zcioKwxxOrlL/sBBpOC7LhOwsFT/+ws8HwZOrU7w7/68JGbCyxoUh01nAwWnFAkJKW7OYKHicJ61sXDzq+0faEI98CRCojTZS7WYeZuQLeF+QA9rhpJagW7vanOSFTry3slhmb1s8lqdgyZ2lFyilaSdMpKmpVLPsAA==;5:Q19Yj7oCBgamRvE+xklBLQBRYx65yFDPbcN9bFia1JXaSou3kUKNgk+aqZuC0jhF48PS4YLDsCwopBSulD6/dw+K59w1fsPAB3LPMsUhGLSSOs3c5VaWnj+vx4rU0K/525WZm0PVK6+rlvAT2Os71WDM5kqvjonSzcOsIExMaA4=;7:xuJXEPZ6+2AKvSJILPi7jSUrgNnBZBgp2qKbK7wtiVt3KAZH7lAc5lIMrTWx2eNlW27XKLTt0W1bVCME1urAhCQgK4j/MNj7PEv6AzDFB0uOSK6CDa6bJuzAItyknQAtp+fMQPqDjydnLPETEvRpwQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(13464003)(189003)(199004)(53754006)(186003)(26005)(97736004)(6436002)(105586002)(55016002)(2501003)(8936002)(99286004)(110136005)(54906003)(316002)(81166006)(68736007)(229853002)(8676002)(86362001)(2906002)(6116002)(3846002)(81156014)(446003)(486006)(476003)(25786009)(74316002)(7736002)(305945005)(53546011)(6506007)(76176011)(5660300001)(478600001)(256004)(102836004)(33656002)(14454004)(11346002)(106356001)(6246003)(107886003)(4326008)(71190400001)(53936002)(66066001)(71200400001)(7696005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2528;H:MWHPR02MB2783.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 91488485-e8f3-470b-539e-08d65b9223f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2528;
x-ms-traffictypediagnostic: MWHPR02MB2528:
x-microsoft-antispam-prvs: <MWHPR02MB2528901BBE40D75117135FC0A5A90@MWHPR02MB2528.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2528;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2528;
x-forefront-prvs: 087894CD3C
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fipCMGBervP40xuF9gEklhAnJVcG+Xoj2ePRp5VHRdubhOImWPAa4F1ptzZiA+wmYnId7MpstbDjPIXz1c0/xFECv2vpViYSTI2tt89w7ihsrJ80ppy03CEhL+oVlEw+9qgVbBhL8OaQ282z5ro++oMG8g8K7oiZgoY7A5mxEKolVtakE4bRXF8T9w1MVbBsshWDB2DVKRyZIyoQAb6KmzsazqwlRJfm+/d3DYRIpu0Ru2epFf/H8VN/AcVn1/6q5FDU8ahxegzhDIo2nqEAr0bm/8P3xyCFvTIE5NxEIZpro/JM4WDu89EUbptmkxkkFLDWt+WkJJkYorKCo49Ua6YLJxTvjHy4kpITOjTH57M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91488485-e8f3-470b-539e-08d65b9223f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 15:47:34.3363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Please let me know if anyone has any issue with this patch series.

Regards,
Bharat

> -----Original Message-----
> From: Bharat Kumar Gogada [mailto:bharat.kumar.gogada@xilinx.com]
> Sent: Wednesday, November 14, 2018 8:18 PM
> To: linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com; Ravikiran Gummaluri <rgummal@xilinx.com>;
> Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: [PATCH v2 0/4] Add support to register platform service IRQ
>=20
> Some platforms have dedicated IRQ lines for PCIe services like AER/PME et=
c.
> The root complex on these platform will use these seperate IRQ lines to
> report AER/PME etc., interrupts and will not generate MSI/MSI-X/INTx
> interrupts for these services.
> These patches will add new method for these kind of platforms to register
> the platform IRQ number with respective PCIe services.
>=20
> Bharat Kumar Gogada (4):
>   PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
>   PCI: Add pci_check_platform_service_irqs
>   PCI/portdrv: Check platform supported service IRQ's
>   PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
>=20
>  drivers/pci/controller/pcie-xilinx-nwl.c | 12 ++++++++++++
>  drivers/pci/pcie/portdrv_core.c          |  8 ++++++++
>  include/linux/pci.h                      | 20 ++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>=20
> --
> 2.7.4

