Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD0CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDDD20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JQFseOkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeIMKKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:10:19 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:7311
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbeIMKKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byw47gAMFflqQL6YLbOuXSUxFOHO4wWHN+mft4oG0kE=;
 b=JQFseOkBDSsPEYJPZ4QkTa/GUcSsWSYxskpz084WEh8/jIxOrFegmqRcNgxyGgngy9kGHs7rPQFVq1Yx55/kThS2dXQnWJXjkO7not9i2zKXVUtf86oOKOUY2ErwtHdKzG6y8+Bm+t5rQ7O58vLeqWbufsB200D51n8os6RJvvE=
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com (20.177.53.224) by
 VI1PR04MB1358.eurprd04.prod.outlook.com (10.163.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Thu, 13 Sep 2018 05:01:47 +0000
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::7c64:f2d0:93d6:6566]) by VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::7c64:f2d0:93d6:6566%3]) with mapi id 15.20.1122.020; Thu, 13 Sep 2018
 05:01:47 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Thread-Topic: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Thread-Index: AQHUSQ0tJQ2pnYp3XEGMoFJmGcMMnKTs4aGAgADJxXA=
Date:   Thu, 13 Sep 2018 05:01:46 +0000
Message-ID: <VI1PR04MB448065E40C0930BA42FDE08DE61A0@VI1PR04MB4480.eurprd04.prod.outlook.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
 <20180912165845.GD16071@arm.com>
In-Reply-To: <20180912165845.GD16071@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1358;6:CwTiPz+AE7+lqwHv4ErGRMGPpAoxSe/nEr7gMWrCVS1KKA4E9ulcCWtD4g/PWMW5qnuD7Bx5yi+F2S49VRtnKq42+pmVVkh3LX+PaATHcYH3++NGkUT5a1PcRjLCwoESKdzWyQqEFRR+j1osurhumNlwSymqz8Ci2BKo9UKyKLXiwYiMoCHeqNwtrazSvvhLNx/5iIApSPOXdRIwv00hkUT8aWMxpsreBzlamq7gd3qmVbnjg9VJ5E/BHEdi4ArPTNk8vJyak4nWvlZQIH5bgtzhz8UsOnP6VtYvc4+2xBMNsWKdkd5CV5Qy8sHL2FB0OXTEQsMj1gTfoc/hRwN/eiFFpsI6mWzCRto2MNYJhkqf59L1/k+w8lWsJqAP+6JSCjzctGSy7PXtma/mTNdXWgG/OeobiwGyIXwcNHhZDLh2zM++L+VTpLSKXZur47On+eBSg0iM0MEMqMmOtAZY/w==;5:0Jj6OQfJ9zv96YhvLxGp2bLrQovHdHkYvR1vQ/6fsPO1eisF9NKowjm6xuWSpFyhvpFrM9k+RxJ5d9H9hCnf1H6j+cgm17nUtrPcZtWjHDghrBekFrQZd+Tbcoh1amL4iugM3n+QRkXsy2V1tz6GGFgTKgwv9eAjcix9u+A7O1Q=;7:3tkv7C3OwiTznDKlhJeoKF9jIYmy+k4CsJq1Qnj+g5hUJlWZrXhC5mZj4aE1cvLEg3/pkXOK7zJaXomxfNyGFlNNTlPfKrf4COK/uil798K/R/j3weSbw2SjVUHF9nqm8MoCSaZv7dxbIxo11IUk4Sl4kVx3z4w+fGbXUGzgVM29K6WHV8nmzrBARv4byFRx360lGkPz6JbmmFtn/TWxwpaYOt3dzL5lSb5PF7hGVTwjjC0DQE32Q0JX81m5IldY
x-ms-office365-filtering-correlation-id: e5d840ef-d6da-4219-3c91-08d6193601f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1358;
x-ms-traffictypediagnostic: VI1PR04MB1358:
x-microsoft-antispam-prvs: <VI1PR04MB13580C0DF864D0E29C0981ECE61A0@VI1PR04MB1358.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB1358;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1358;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(13464003)(8676002)(86362001)(478600001)(66066001)(5250100002)(7696005)(55016002)(6436002)(9686003)(53936002)(186003)(14454004)(68736007)(7416002)(106356001)(6116002)(316002)(6916009)(76176011)(97736004)(102836004)(54906003)(256004)(3846002)(5660300001)(55236004)(33656002)(11346002)(105586002)(476003)(446003)(2906002)(99286004)(6246003)(486006)(8936002)(44832011)(81156014)(74316002)(39060400002)(7736002)(4326008)(81166006)(26005)(229853002)(2900100001)(305945005)(25786009)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1358;H:VI1PR04MB4480.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M2VQwNoQz0//2eA/8wsXXLqk056OM1hPFtLuASkFF/EGh561DDahMoSiiF/vcVAEOcnuQ/bkMcGWdhomegeIRoZUvQKVKeOaRICpObu5G8aTJrG++qD87LfVUeRVREenlJ4fJ1AETaa4B9IGswCezW1DedKLEvK0XOEmdIBzNLgykALMjC/Q+Nq6XOaHudNMt5SToiyhG5PC1bf5gmXQ3bNz+05LIJ9ScfND3QF4vTZi2WgAB46syv+SCmNjV4ZD258ZqLna+MGIXJLCjtEsxbumaRFdPRJkp4NbR6fWAzj0+fBldmAa4GbzBTZ8Oq8gfIRk0sFYra8Dl9fYUfcmnpk79U6sdyr8vu/oN0w8zV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d840ef-d6da-4219-3c91-08d6193601f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 05:01:46.9493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Wednesday, September 12, 2018 10:29 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: joro@8bytes.org; robin.murphy@arm.com; robh+dt@kernel.org;
> robh@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> gregkh@linuxfoundation.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> bhelgaas@google.com; hch@lst.de; m.szyprowski@samsung.com;
> shawnguo@kernel.org; frowand.list@gmail.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMM=
U
>=20
> Hi Nipun,
>=20
> On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> > This patchset defines IOMMU DT binding for fsl-mc bus and adds
> > support in SMMU for fsl-mc bus.
> >
> > These patches
> >   - Define property 'iommu-map' for fsl-mc bus (patch 1)
> >   - Integrates the fsl-mc bus with the SMMU using this
> >     IOMMU binding (patch 2,3,4)
> >   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
> >   - Updates the fsl-mc device node with iommu/dma related changes (patc=
h 7)
>=20
> It looks like you have all the Acks in place for this series now, so I
> assume it's going to go via Joerg directly. Is that right?

This is what I am expecting :)
=20
> Will
>=20

