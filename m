Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB638C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956CE20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IXsF5g41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956CE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbeIFUMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:12:31 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:55827
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730122AbeIFUMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyS6OnJsApT61gpJAHoTOchH32zg4lTX3lgkZVKcw6U=;
 b=IXsF5g41WYaZwNODTIkq9EavCB0koS1vMP69WJ2fQFbrLGIf0XJG0w+d4Ws5ZiDKEdHZ3J7t8yA/6qNr7jX4dWdjEvSsEQH0hC5mydcAc1/zIOImc1KKiBiEABayhOjw+0bkSHNArz6UKUHgWN3OA7Qrl7vVW/y3zofxUh/5zgs=
Received: from BN6PR02MB2772.namprd02.prod.outlook.com (10.175.96.7) by
 BN6PR02MB2419.namprd02.prod.outlook.com (10.173.141.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 15:34:45 +0000
Received: from BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::680b:2c1b:aea5:ee5a]) by BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::680b:2c1b:aea5:ee5a%7]) with mapi id 15.20.1101.016; Thu, 6 Sep 2018
 15:34:44 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 3/4] PCI/portdrv: Check platform supported service IRQ's
Thread-Topic: [PATCH 3/4] PCI/portdrv: Check platform supported service IRQ's
Thread-Index: AQHUMMExGjJFavY9kEScci9ocneWu6TgURuAgAM5sMA=
Date:   Thu, 6 Sep 2018 15:34:44 +0000
Message-ID: <BN6PR02MB27724845B839B1DC26B5530BA5010@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180904141227.GD107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180904141227.GD107892@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2419;6:t/N1cv2FAH0USITlTCweo7kHTIAxqWeoEEtSiVdi/mMj1ac9GKd79mqbvZ9rGyialiyKe+SEfxT5a2pmpclO8O0DK9xk/T0TiExXPkI4y8JPqrlvecXQ+ZmnPlaMcCajPAXYYf3LwvvhYA3E62Kkih4Gdune7CoEcfxmzrmuNFwAnM73RCk56k87uuDCPDOKKMglxGMAnsM+OQZx7JMnhX0GxCgkWBk8bwnmcrUc8ZkScLeHmCDF1qQiwiUUlAyOFh3bFfcGKyqV7pq/7xcnJ87ZYuHn+w9i/Rxq1ZHqsUnEZLLLY6k346sFkHMw++gwSjbbaxcBRplAWbWSjEh4m8mpEl2bVoz/Afan246eecnFNCUZ45KK9bIRHwLHWUSYVTCtJQbXspmJXMVbswtfcXU/CkBu6Lix7itIe2splYJdmgYbi69Q/QiK0kx35l7UwC01QmsEnxzU7B6xWqDLxg==;5:5p2cOS2nRknxGo/d2PIDVyvM7y2mMULDNsNjNBBrW1aIi5a/y7m8F13dZ1Pa8eNaCHJEDt9d2/3ut/wBUFC29ho5ZGqceyldSIqkpIrFhtmwa38LH0wtyQiT4OmMVrWOMd22VguKW4jlIZASNmg6EXCCr8CBmPeJ+Za73GEb7nw=;7:SEIQ7qKjwB+rNwI7HabNnqLzP6fsQC1tp5rDYC0yK79/KgYQlvr19JSMSsvud2fvHzRfGO9a7BLp9MXL3onhr3hhIHnM+1qpBejLV0osZgwUzNiz8U0s3/4oKPmP/3CxQcnTDUQ3EnkeCPbvtyM/k4nYdNqFoxjFFa+XJ3FNUc2pMdwA7eT2WUAHBjjXlEI035x+EYWQWHpN82xqXeP5JIPHVwmmqwQapVocWa0zu0gAgng4bHgER1ajI+AnS2Ve
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(9686003)(6436002)(14454004)(316002)(2906002)(54906003)(8936002)(53936002)(66066001)(81156014)(81166006)(5660300001)(229853002)(256004)(76176011)(55016002)(97736004)(14444005)(478600001)(2900100001)(86362001)(99286004)(7696005)(476003)(446003)(4326008)(33656002)(6246003)(25786009)(107886003)(74316002)(5250100002)(6916009)(102836004)(11346002)(6506007)(68736007)(486006)(105586002)(305945005)(106356001)(7736002)(3846002)(186003)(8676002)(6116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2419;H:BN6PR02MB2772.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 2e4c0433-602e-4e09-5edc-08d6140e457f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2419;
x-ms-traffictypediagnostic: BN6PR02MB2419:
x-microsoft-antispam-prvs: <BN6PR02MB2419C23908D6B62B4399FF71A5010@BN6PR02MB2419.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN6PR02MB2419;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2419;
x-forefront-prvs: 0787459938
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dPFPXPMLGg0z+ofAL7eAUsR2plXTo8xJotAD6x2reJFGZ2ZpoFHzMAU0OIxFpskMqqcSX94yX78GgRJ68p4JtOVte866tfi//eexQ+Zg761shgZEDVgxGzIsovDrEmOtTLnFN8co6aqIFaX3SOlVoIeBsAyh497YzK9S/TwiIanXr1p/y11lj0NILRbL05vsIy+PE9oRoX5X2i8XccD2gD3lQMsCYPdMMAnPGSodWSnM4SH1GmhYTv+HJsQusaA9wTfZEG2yW69V6JhWDi7ns8Hde9WdlummcLMiQt8F8shZdBILGoXDyeGawHY9yISZbskF2JSjhWzr3jkG3XOtnWLF3aI6OtosGjucBnAi338=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4c0433-602e-4e09-5edc-08d6140e457f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 15:34:44.6483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 3/4] PCI/portdrv: Check platform supported service IR=
Q's
>=20
> On Fri, Aug 10, 2018 at 09:09:39PM +0530, Bharat Kumar Gogada wrote:
> > Platforms may have dedicated IRQ lines for PCIe services like AER/PME
> > etc., check for such IRQ lines.
> > Check mask and fill legacy irq line for services other than
>=20
> Capitalize "IRQ" consistently in English text like this.
>=20
> Insert blank lines between paragraphs.
>=20
> Add a reference to the relevant spec sections.  PCIe r4.0, sec 6.2.4.1.2,=
 6.2.6,
> 7.5.3.12 seem pertinent.
>=20
Agreed, will do in next patch.
> > platform supported service IRQ number.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c |   19 +++++++++++++++++--
> >  1 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c
> > b/drivers/pci/pcie/portdrv_core.c index e0261ad..a7d024c 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -166,6 +166,19 @@ static int pcie_init_service_irqs(struct pci_dev
> *dev, int *irqs, int mask)
> >  		irqs[i] =3D -1;
> >
> >  	/*
> > +	 * Some platforms have dedicated interrupt line from root complex
> to
> > +	 * interrupt controller for PCIe services like AER/PME etc., check
> > +	 * if platform registered with any such IRQ.
> > +	 */
> > +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
> > +		int plat_mask;
> > +
> > +		plat_mask =3D pci_check_platform_service_irqs(dev, irqs,
> mask);
> > +		if (plat_mask > 0)
>=20
> Masks should be unsigned and tested for zero or "mask & bit".  The rest o=
f
> this file uses "int", which is sloppy because it does the wrong thing if =
we
> happen to use the high-order bit in the mask.
>=20
> > +			mask =3D mask & plat_mask;
> > +	}
>=20
> I think these platform IRQs are neither MSI-X/MSI nor PCI INTx wires.
> But as written, I think this patch executes pcie_port_enable_irq_vec(), w=
hich
> only does MSI-X/MSI stuff.  So this must rely on that failing?
>=20
> And then we fall through to run pci_alloc_irq_vectors(), which is for PCI=
 INTx
> interrupts, which doesn't seem appropriate either.
>=20
> It seems like this platform IRQ case should be completely separated from =
the
> other MSI/INTx cases, i.e., set irqs[PCIE_PORT_SERVICE_AER_SHIFT] directl=
y
> (I think you already do this inside pci_check_platform_service_irqs()) an=
d
> immediately return.
> Then I think you wouldn't need the other hunk below.
Agreed if we check platform service irqs here we need to deal with differen=
t combination
of service IRQ's like AER MSI, pme platform .. and change code accordingly =
to fill irqs[i].
yes it is better to call platform IRQ separately to avoid code changes in d=
ifferent scenarios and=20
chunk below.

Can we do the following code flow:=20
int pcie_port_device_register(struct pci_dev *dev)
{
 ...=20
status =3D pcie_init_service_irqs(dev, irqs, capabilities);
        if (status) {
...
}
pci_check_platform_service_irqs(dev, irqs, capabilities);

Thanks,
Bharat

