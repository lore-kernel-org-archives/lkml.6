Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EE1204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iwCZvPaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EE1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeIFUDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:03:47 -0400
Received: from mail-bn3nam01on0086.outbound.protection.outlook.com ([104.47.33.86]:23670
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729991AbeIFUDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF9aebO+tiUFzN/aNGW6cz5i0DIsraG+U44oOWfTCmM=;
 b=iwCZvPaZ805WskduSzGxE2A34NlkpJUof2y3WVn+yKhQIRTnunD+2XB1L6aC4jMOkWGwMwlgbBdGMiSMiEmm8UyLPAr9oF29VKztEH9hKu7IWY+1zuqe8mGJfSSyjRUatJEAhil0S7syhFciEnXOk5eWn4HZ1P0c1hsD6b9U5Z8=
Received: from BN6PR02MB2772.namprd02.prod.outlook.com (10.175.96.7) by
 BN6PR02MB2180.namprd02.prod.outlook.com (10.168.253.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 15:27:41 +0000
Received: from BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::680b:2c1b:aea5:ee5a]) by BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::680b:2c1b:aea5:ee5a%7]) with mapi id 15.20.1101.016; Thu, 6 Sep 2018
 15:27:40 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Thread-Topic: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Thread-Index: AQHUMMEvYQXdyRdHrUqZcZ0+kpU/maTgSo2AgAM9QmA=
Date:   Thu, 6 Sep 2018 15:27:40 +0000
Message-ID: <BN6PR02MB2772814D31D45FB093183458A5010@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180904134859.GC107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180904134859.GC107892@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2180;6:a4Xr+0sPh5n2DLHzMiaNitbnjGpOlSayAbumUyyQHXWJd4wnzgdanXKPVHGl5jwODh/dv4PPEctuTDO1zS/FyesjP/M5l6BrqcaQNyjTKqSJg4kENBo6uQDbE6sssOvDNqmPsjhsoImp513wAsx6tv0odaHJXsl7082jO3zDyIws4aHbK9dqEKGf755LkBY9tD2IX1y0C9eFyeKreOU0QkPHrPiyAt+BqFjd7xoeCpPqgdWLOYP2yJTNitWZFpay+e1P4OLZwd2Rsj/hmT6yZ8erNSjn5EvBLod/320jF+TtKfl5aHmjRu/kbvD4781Din9GmtkTn4Glr7Jf6DExd0eL+cPM0+Xn1q1Ewcq3HpaotQecJgjFRp6YwTniczmvsLgo0X/Bc/gpzmW0qxBuPrzamzQWJbxOH8DNE9751bF4bx0TI1teIap5y/F6M/uoau+CYcPSBiBHojoha7FcSA==;5:xe8zFxZ+0lObdFq+V7/GLUzsFRT95/LDtDi/5XQENBDhuZRXZfF4evcRO8yiT3h+VOG2OZIwzMOVW7umlsLZVJJ7AGO+ouCpyX5XGSteVwvRikuepk3JRLGux4mAvEHkyWRvorv4V+hzZTZa5J1RzeCk+Zd6Z0rK+ULj7kreqD8=;7:9J+8aWI7nyafZnGdE//Fe4hwmyDSCWzWqGYXTta/HrgkicW92McNm8TJEHfDucXQdjW7sddz67q74U016/kUqRYypZ5FNYKSYUeCMDGSC4RAqoM1GUTpb4lj0aEkHdWePwN5/zbE+0jvwAQ6oS1Ez8kQvfVxQz2a38Yvo4yH8jcCQUTBc6UeWD60k6Bpp3exP4sinMCKv11B/NIuuSltd2vBjOScLPuVzMG7/QdQ/RblJJGVdkSPaXXfFjkCeUIw
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(9686003)(14454004)(3846002)(76176011)(476003)(6116002)(66066001)(305945005)(486006)(446003)(11346002)(7696005)(478600001)(97736004)(229853002)(5250100002)(4326008)(86362001)(6246003)(55016002)(107886003)(106356001)(25786009)(8676002)(26005)(6916009)(54906003)(316002)(68736007)(33656002)(6506007)(74316002)(53936002)(81156014)(81166006)(102836004)(105586002)(2906002)(8936002)(6436002)(186003)(5660300001)(256004)(99286004)(7736002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2180;H:BN6PR02MB2772.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: e79b5c5e-e2b9-4b4b-aa80-08d6140d4879
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2180;
x-ms-traffictypediagnostic: BN6PR02MB2180:
x-microsoft-antispam-prvs: <BN6PR02MB2180EFBC5480533B07CC96D3A5010@BN6PR02MB2180.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN6PR02MB2180;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2180;
x-forefront-prvs: 0787459938
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3xRSUuaPdTInTIzCCHLAwqJvjKRyTc0+sB2mFsg3qeZhHEOZWXhjklT32+aOk5yr6gDRS7y9kPqVnFUN5bebcLmcN5AeJMChzpznoZQ4yqGRIORBO+PHpwuxKSvMigPswn0in0kAdtafUOpfLcfNlsqAEFuwrUeZzssGBhy+yNfSuSPV0fWgdt+GFUFw4YquUJkRclkKymXSjQI2XB/cF6XOxVx0slELw47NR/LBz1c5L1Sn6xpR4HuLiLELWYLywq9sr/FpnPpoSDSyHRlYv/Y3Azcr4vYt3Rx34jYolWdxlr1vBxGuZ2qoktYaBPhEm6E6LCyoZZpI+O5TqckqlnytEMPnk/FqqKOikjY+3rY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79b5c5e-e2b9-4b4b-aa80-08d6140d4879
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 15:27:40.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
> setup_platform_service_irq hook
>=20
> On Fri, Aug 10, 2018 at 09:09:40PM +0530, Bharat Kumar Gogada wrote:
> > Add nwl_setup_service_irqs hook to setup_platform_service_irq IRQs to
> > register platform provided IRQ number to kernel AER service.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index fb32840..285647b 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >
> >  #include "../pci.h"
> > +#include "../pcie/portdrv.h"
> >
> >  /* Bridge core config registers */
> >  #define BRCFG_PCIE_RX0			0x00000000
> > @@ -819,6 +820,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie=
,
> >  	return 0;
> >  }
> >
> > +int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
> > +			   int plat_mask)
> > +{
> > +	struct nwl_pcie *pcie;
> > +
> > +	pcie =3D pci_host_bridge_priv(bridge);
> > +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
> > +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] =3D pcie->irq_misc;
> > +		plat_mask &=3D ~(1 << PCIE_PORT_SERVICE_AER_SHIFT);
> > +	}
>=20
> If I understand correctly, this ultimately results in pcie->irq_misc bein=
g
> hooked up to aer_irq() via the aer_probe() path.  We already have pcie-
> >irq_misc being hooked up to nwl_pcie_misc_handler() via
> nwl_pcie_bridge_init().
>=20
> We can't rely on the ordering of the two handlers.  Is it safe if
> nwl_pcie_misc_handler() runs first, followed by aer_irq()?  It looks like
> nwl_pcie_misc_handler() might log messages and clear AER-related errors. =
 If
> that's the case aer_irq() might not find anything to do.
>=20
Hi Bjorn, the nwl_pcie_misc_handler() prints all pcie errors along with AER=
 and then clears=20
controller register (MSGF_MISC_STATUS) in which these status bits are set.=
=20
But clearing this controller register will not effect any bits in AER capab=
ilities.
So in our case we need  to clear controller register and also handle AER as=
 per spec.
This will not cause any ordering issue as both paths are accessing differen=
t set of registers.

Thanks,
Bharat


