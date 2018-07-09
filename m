Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6571720873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JkAkV4G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6571720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeGIPXE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:23:04 -0400
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:45056
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932898AbeGIPXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abrUFSZKdG0t8BmlElFB/v0XHlLUSX32Dnh7poggEp0=;
 b=JkAkV4G7nW+1KAAkoZBEEx3BmvwdK+IaOlU1tFeBzev6TldVX+XutZG+isxW0jxFbfN87J93e28Zuili9wQBgZp0gIdEzZMKU7FTji0q72JTUnJiG5pKp8EY2ch3O3b83sEWV8YrMlyI+B4fZA24FdDnQLVtQ3rltI3KVIkXOl0=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB2781.namprd07.prod.outlook.com (10.169.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 15:22:58 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::bddd:185e:610a:91b5]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::bddd:185e:610a:91b5%5]) with mapi id 15.20.0930.022; Mon, 9 Jul 2018
 15:22:58 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 09/11] pci_endpoint_test: Add 2 ioctl commands
Thread-Topic: [PATCH v8 09/11] pci_endpoint_test: Add 2 ioctl commands
Thread-Index: AQHUFUFA1nR2kaYS60m2jKj3Yfc37qSHBCdQ
Date:   Mon, 9 Jul 2018 15:22:58 +0000
Message-ID: <MWHPR07MB350246B23FF90D27B60CF0B2D8440@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
 <93f542ee1ec24d3a24150d8909074614536d6ce9.1530891871.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <93f542ee1ec24d3a24150d8909074614536d6ce9.1530891871.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mYzkzMzNhYy04MzhiLTExZTgtODZlNy1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcZmM5MzMzYWQtODM4Yi0xMWU4LTg2ZTctZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSI3MTMwIiB0PSIxMzE3NTYyMzM5MDYzMzk2ODQiIGg9IkFLWlhlNU1OSWdhN25tVmppczB5Z1VyYkdzVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB2781;7:UY1kPBud+cF71aaVZUjOnOY8e/x4yhX4Hr015K0qvOncV9+KTws9eP8IX/JphoB2Fueyqd7rkrj4ZFZ5K63JbdGQ+6wlq5CS90Oxe8H7WZoeAp3ScvhobpGILEY7GmO35FqKLUz4V/nFI1rs20xR++WMI13l0G6k7g8wy6g7NalY8qLCirMkOxPqioeQm+2Ujp3KLZkem21Ld7cbYgEZ3EUQy6qd1EVf7/5qs5UtGSTLvfWLiN32rut7rmdxfcUJ;20:STSBgGcvrVgoVrT/WBoh/w5159B4/ao5Y/9Z2ASek7HnUMu9fPpJqTY0OK1lmAqClMkEuqlL5prFGJRJ7CAIn87cyjb/PjjbSt3vT5EEyOAQkGvm6PWw7oMBzDTe3+1kBtBBCJAck+IoPJQJzD5SRZLi7egbpXf+PYUw784RkURNQSZDbqpotuTYcg0Cyx/MGe2C0WOGdAPXbjOZOP+otQ+5nuOWJXO1oerTrnxj/xSTOvZabpVe8+BS9864CKU+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8a8f7b7-3d89-4abf-3e45-08d5e5afda06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2781;
x-ms-traffictypediagnostic: MWHPR07MB2781:
x-microsoft-antispam-prvs: <MWHPR07MB27811D40A10DE5709302D041D8440@MWHPR07MB2781.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR07MB2781;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2781;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(36092001)(199004)(189003)(97736004)(8936002)(8676002)(5660300001)(25786009)(81166006)(81156014)(106356001)(3846002)(6116002)(316002)(53936002)(74316002)(305945005)(7736002)(6246003)(105586002)(2900100001)(39060400002)(26005)(2906002)(14454004)(66066001)(478600001)(7416002)(4326008)(102836004)(486006)(33656002)(11346002)(446003)(476003)(6506007)(53546011)(76176011)(55016002)(256004)(5250100002)(7696005)(575784001)(54906003)(110136005)(14444005)(2501003)(6436002)(2201001)(229853002)(86362001)(9686003)(99286004)(186003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2781;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HARalAeeVN+LpNK132zauSmPHRhGHCfbcshLA25BmEKRFGULE/Gt9LgadZvfiQ2rTYFQi/c/1FkIcPYNwBvYgeME2RJrPiPvm3nNmEY847b+zxGHR8Vqcma3YWRASvWvfIZWwhIjXmuZxBcpwAP2/QEU42Dxr00uZLwi4vvWWF5DczBNbHOFhZU7XT359otcNkboPv7Kyo34sve8FHLIIDuAUCCKz6QdI2CMKY671II28E0QYwAKMclxWxOIoQ/Cr5llU5qtKS6mC7qYpP3Ctve34mwWwiUSUOJ/+baI/kvLW12RLVDrw0AqMhEnbA8Erpm2LxybAIkJ69W6G6YCAhj2ko4YEHx6BhGT6ZpGZko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a8f7b7-3d89-4abf-3e45-08d5e5afda06
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 15:22:58.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On  06 July 2018 16:52 Gustavo Pimentel <gustavo.pimentel@synopsys.com> wro=
te:
> Add MSI-X support and update driver documentation accordingly.
>=20
> Add 2 new IOCTL commands:
>  - Allow to reconfigure driver IRQ type in runtime.
>  - Allow to retrieve current driver IRQ type configured.
>=20
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v2->v3:
>  - New patch file created base on the previous patch
> "misc: pci_endpoint_test: Add MSI-X support" patch file following
> Kishon's suggestion.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Change v5->v6:
>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
> from patch #10 to here.
>  - Increased ioctl parameters range associated to
> drivers/misc/pci_endpoint_test.c driver.
> Change v6->v7:
>  - irq_type variable update just before returning the function.
> Change v7->v8:
>  - Re-sending the patch series.
>=20
>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 175 +++++++++++++++++=
------
>  include/uapi/linux/pcitest.h                     |   2 +
>  4 files changed, 135 insertions(+), 47 deletions(-)
>=20
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/i=
octl-number.txt
> index 65259d4..c15c4f3 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>  'P'	all	linux/soundcard.h	conflict!
>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
> -'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
> +'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
>  'Q'	all	linux/soundcard.h
>  'R'	00-1F	linux/random.h		conflict!
>  'R'	01	linux/rfkill.h		conflict!
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documenta=
tion/misc-devices/pci-endpoint-test.txt
> index fdfa0f6..58ccca4 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -28,6 +28,9 @@ ioctl
>  	      to be tested should be passed as argument.
>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>  	      to be tested should be passed as argument.
> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ typ=
e
> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be pa=
ssed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be pass=
ed
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index f4fef10..97082e3 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int =
irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test =
*test)
> +{
> +	int i;
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +
> +	for (i =3D 0; i < test->num_irqs; i++)
> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
> +
> +	test->num_irqs =3D 0;
> +}
> +
> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test=
 *test)
> +{
> +	int irq =3D -1;
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +	bool res =3D true;
> +
> +	switch (irq_type) {
> +	case IRQ_TYPE_LEGACY:
> +		irq =3D 0;
> +		break;
> +	case IRQ_TYPE_MSI:
> +		irq =3D pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI interrupts\n");
> +		break;
> +	case IRQ_TYPE_MSIX:
> +		irq =3D pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> +		if (irq < 0)
> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
> +		break;
> +	default:
> +		dev_err(dev, "Invalid IRQ type selected\n");
> +	}
> +
> +	if (irq < 0) {
> +		irq =3D 0;
> +		res =3D false;
> +	}
> +	test->num_irqs =3D irq;
> +
> +	return res;
> +}
> +
> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test=
)
> +{
> +	struct pci_dev *pdev =3D test->pdev;
> +
> +	pci_disable_msi(pdev);
> +	pci_disable_msix(pdev);
> +}
> +
> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test=
)
> +{
> +	int i;
> +	int err;
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +
> +	err =3D devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
> +	if (err) {
> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
> +		return false;
> +	}
> +
> +	for (i =3D 1; i < test->num_irqs; i++) {
> +		err =3D devm_request_irq(dev, pci_irq_vector(pdev, i),
> +				       pci_endpoint_test_irqhandler,
> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
> +		if (err)
> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
> +				pci_irq_vector(pdev, i),
> +				irq_type =3D=3D IRQ_TYPE_MSIX ? "-X" : "", i + 1);
> +	}
> +
> +	return true;
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> @@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoi=
nt_test *test, size_t size)
>  	return ret;
>  }
>=20
> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> +				      int req_irq_type)
> +{
> +	struct pci_dev *pdev =3D test->pdev;
> +	struct device *dev =3D &pdev->dev;
> +
> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		return false;
> +	}
> +
> +	if (irq_type =3D=3D req_irq_type)
> +		return true;
> +
> +	pci_endpoint_test_free_irq_vectors(test);
> +	pci_endpoint_test_release_irq(test);
> +
> +	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
> +		pci_endpoint_test_release_irq(test);
> +		return false;
> +	}
I am testing the latest patch set with the cadence driver, and find this st=
ep is not working correctly.
pci_endpoint_test_alloc_irq_vectors relies on the value of static irq_type =
to request the appropriate IRQ.
However, you don't set this value until a few lines later, so the first att=
empt to set the IRQ type fails.  (A
second attempt to set it will succeed however.)  I suggest setting irq_type=
 before the call, or even adding
a parameter to pci_endpoint_test_alloc_irq_vectors() with the requested IRQ=
 type to avoid having to set it
back again after a failed call.
> +
> +	if (!pci_endpoint_test_request_irq(test)) {
> +		pci_endpoint_test_release_irq(test);
> +		return false;
> +	}

> +
> +	irq_type =3D req_irq_type;
> +
> +	return true;
> +}
