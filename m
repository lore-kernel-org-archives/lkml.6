Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA734C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C72208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xcbx7f7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C72208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeHXPus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:50:48 -0400
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:22652
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbeHXPus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6/YTK1y495voATbz2HArc0+s+FHBGning6kPwyVHQE=;
 b=xcbx7f7xDi0gB6UDC8KWtk/nZHbaS3skjhqUvkEicefNn46TdniJzTrCfu9/54Oq9UKxUhbs0s9UK384Vet30FlUTXz8SPZbCMa/FYQFKZMz3AbiOynLdDCqDevx43p/2bWEcLpjAHlpBc/jbRIyX2Qm5PHKmMVrF5ueWfic0H8=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB4804.namprd02.prod.outlook.com (20.177.144.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 24 Aug 2018 12:16:21 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::e42c:5d04:1f44:ad9d]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::e42c:5d04:1f44:ad9d%5]) with mapi id 15.20.1080.015; Fri, 24 Aug 2018
 12:16:21 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 0/4] Add support to register platform service IRQ
Thread-Topic: [PATCH 0/4] Add support to register platform service IRQ
Thread-Index: AQHUMMEsB57PuvO7j0OWoAlx1MGXrKTO5qiQ
Date:   Fri, 24 Aug 2018 12:16:20 +0000
Message-ID: <BL0PR02MB48498C30DD4082D3215B5444A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4804;6:OvoVzFo0IUVvO/D85bpVVQPhWT9lSn9+k0gONhZndL/ZlwaFi58ttBQ3CpBWHQ29OspcyS/sZt4p1VYiODAVI2N9wJn8fphL3aR4A0ajrbadYnaTx/aH7oQw9iaVUR6UdxZ26rurj1Q6S62ULN0dOCHsveEZo5blL6qpm2+x/MsMrVjY62lo0pmwn2gNGow5uEiK35ONTLtEEHdrDZCQ8gNpQdPnSkR4sdgtTRHNLlk0LHMShouJQzuyswYt5r9Tq9gorTjOH08HYs8QzfL+q4+a+YHBYkUd1/qXyv10tOdQI0HdESXmkLvxUm2+vytAhm5u8MiSh0SS1Jsksx0LKHN6SF23tv4cI372kQOQqIji2avPTvjhVAub8dFe0VhfbaDhLkzTCCaFnV0Ze6aVZnfMikD34W4bTJ0gjRz+D4toz71oOUppz0nUAMvcawy8gwREu8ji0UIKiHuWiEx+4Q==;5:FZ1QfYhTE5RTgsa2ota8QfXlC3mPAxiYZ7t3O6d1At6qQZVK/lBWLQyIZSe7McZP8ojih3ZdJ5N/QHbHnafaqxPITm1XZKzIDVMe9xP/4JKtPAU8myIoO5vPEtPgI0rk2CHr33ewAqWIbKkLLM5j438AhM7SHYLWx5mh6OfmyA0=;7:AtolYmWYzs1it4QhBqVXDT1yWb1MdI3iz0FMFFJYwjgnGq3zmkPhn9h/e0WeM30dF2S6HOuspYzuUF8mVXmsEcQAzJCiY3PNly9UlU6rFXpQ+OKjg8yZoi1+NffzmCWL7UalAFoeVQbzsapCce5qQmTsQRCggGQ0XlQH7I3nGS5HGnmMXyqgp0CgVg6cMbZzEd8h9d09hYDnOR99t1JgdXBBbc05kl46LaGRF8gf15Dfx8xFPIPjfk0XrR+TnBC9
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(6246003)(54906003)(7696005)(76176011)(110136005)(99286004)(316002)(14454004)(106356001)(478600001)(2501003)(5250100002)(105586002)(2201001)(86362001)(446003)(476003)(26005)(102836004)(74316002)(11346002)(6506007)(305945005)(2900100001)(7736002)(256004)(33656002)(486006)(8676002)(81156014)(81166006)(229853002)(4326008)(66066001)(97736004)(6436002)(25786009)(2906002)(55016002)(9686003)(107886003)(53936002)(8936002)(5660300001)(3846002)(6116002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4804;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 18f8c14e-1ca7-419f-60a9-08d609bb66fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4804;
x-ms-traffictypediagnostic: BL0PR02MB4804:
x-microsoft-antispam-prvs: <BL0PR02MB480428E274627A8D59DA23A8A5360@BL0PR02MB4804.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BL0PR02MB4804;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4804;
x-forefront-prvs: 07749F8C42
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sVArG9USuhY3bUrY3pEoFKoMyCzzjOmWrQchGO4ssRESe0uvNIMonbvpMn/Fgcv5yq1HQ459TSR6rOXw9cUjGEV7FVWwfmXN1S/1Bc1fAVklLe8l4Abvswhs3sXnRIFJ8R1oUcrw9/4YbxLzn2DB5Avm85H3cvaAwJYKblGw08JHEiwJA9BI9Cm8Jx0+dxUGowCXrPi6qjyGhAwwbodMVeKrGEkMT1jwD/Rr7QT2XBdxjFj9D3yIkzK+P8wREMyZb0aG++nj0DDaDpJN0zG02g62ClZyjNvdeERUZrinNLA6LNYH0oPoivnj3oVnc1l+ve54TrOz6tCstNMk1UBZ8LnB/9lpci6cj3dub3k3314=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f8c14e-1ca7-419f-60a9-08d609bb66fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 12:16:20.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/4] Add support to register platform service IRQ
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
>  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
>  drivers/pci/pcie/portdrv_core.c          |   19 +++++++++++++++++--
>  include/linux/pci.h                      |   25 ++++++++++++++++++++++++=
+
>  3 files changed, 58 insertions(+), 2 deletions(-)

Hi Bjorn,
Can you comment on this series.

Bharat
