Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A54ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA4F208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hGyztZiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA4F208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGMOKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:10:11 -0400
Received: from mail-sn1nam02on0043.outbound.protection.outlook.com ([104.47.36.43]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729634AbeGMOKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3mZcbQoFxvsnQ7lh4ULmjfk/gZ0cXdSo78LHBh66rI=;
 b=hGyztZiECZJ1h6oYXHue3qC0duGTSdt3oNbaQ/gOPhsBhNGBVEdRc3N5SNtbj91mwpEoTFNOjtn0Vy1R8gDeye6E1JGOMr8o8m4HjxCXww16UzAR2kU5wumIMbMxWJGB7Eb0bIKuD+nhSOfuA9NaJG3BGimWXT686n1KNCuHUUQ=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB4771.namprd02.prod.outlook.com (20.177.144.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 13 Jul 2018 13:55:20 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8%2]) with mapi id 15.20.0930.022; Fri, 13 Jul 2018
 13:55:20 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "poza@codeaurora.org" <poza@codeaurora.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Topic: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Index: AQHUGe+qorjjnGNCwk6pQY3qlu/zFKSMnOsAgACFQpA=
Date:   Fri, 13 Jul 2018 13:55:20 +0000
Message-ID: <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
In-Reply-To: <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4771;7:0o2UYr0yKp3by/tQ/MQgrH3jD8gxruPaAmHQtgrl6gHRbIXW/2+EQynayNKQm6BLsF0zc/7/kEBkSa+Jws+/vvUvi/SYfdvpGb3InKYMjMARlljs8mawqzLr3ZS9DotDTdnvMkw0Vh5mLBHpL66WjjIdFApBEgGiVMYh9bTz4a0fXY3NLG8dYWWve69+eMa9nsTxejH3j23YMVSPOn0Oina6VmY+03u7ysDi07iiWCiotv86dGt9o8p3/z+eL6I2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 143dad58-1399-4d5b-d085-08d5e8c845f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4771;
x-ms-traffictypediagnostic: BL0PR02MB4771:
x-microsoft-antispam-prvs: <BL0PR02MB47715BDD2444C1F526E5B57DA5580@BL0PR02MB4771.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4771;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4771;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(6246003)(2501003)(5660300001)(86362001)(476003)(5250100002)(99286004)(8936002)(66066001)(102836004)(2900100001)(76176011)(6916009)(6506007)(55236004)(7696005)(53936002)(305945005)(74316002)(26005)(256004)(7736002)(106356001)(446003)(186003)(4326008)(486006)(1730700003)(11346002)(81166006)(105586002)(81156014)(25786009)(8676002)(97736004)(54906003)(6116002)(3846002)(2906002)(478600001)(6436002)(316002)(14454004)(229853002)(5640700003)(55016002)(9686003)(2351001)(33656002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4771;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v0A65po3ajHn3FgLOW6UwiMHEtaaqVYC5GcAcRRnyYFR8KIWTGq7wxgEUfzciLKDh4aMK40d24uofAigtAr3NRkGrqk0fPDXE7sqvPbuUs+z5fyiMMF8/qmsB3oZMD7BUxSJBFArh2t2vGP6amAZlKRUt0FnHbKo6Njz9DFcb4oBJYwjzZhJtdzgOqm8SvXwCh4Dl7oTZuewxNk1OBG30FY5HzhFCI+wDgCNaGB+uj2XRsq2tyUEXoQgwXAbL4LG5B/q0ZEO5IqO4CwCRpdjKY/QtqekR2HP58nKBKo2CBNZXOxjWW7UlShcCu2czPQgfkdvQmyIh3yaOKSYEa6D+FajtRMwqLpirOo4634B9B4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143dad58-1399-4d5b-d085-08d5e8c845f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 13:55:20.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> > This bit is required for forwarding errors reported by EP devices to
> > upstream device.
> > This patch enables SERR# for Type-1 PCI device.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> > a2e8838..943e084 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
> > pci_dev
> > *dev)
> >  	if (!dev->aer_cap)
> >  		return -EIO;
> >
> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/*
> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
> coming
> > +		 * from an endpoint if SERR# forwarding is not enabled.
> > +		 */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> > +		control |=3D PCI_BRIDGE_CTL_SERR;
> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> > +	}
> > +
> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> > PCI_EXP_AER_FLAGS);  }
> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> > @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct
> > pci_dev *dev)
> >  	if (pcie_aer_get_firmware_first(dev))
> >  		return -EIO;
> >
> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/* Clear SERR Forwarding */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> > +		control &=3D ~PCI_BRIDGE_CTL_SERR;
> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> > +	}
> > +
> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >  					  PCI_EXP_AER_FLAGS);
> >  }
>=20
>=20
> Should this configuration no be set by Firmware ? why should Linux dictat=
e it
> ?
Hi Oza, Can you please let us know why this should be set by firmware ?
Spec clearly states ERR_CORR,ERR_FATAL/NON FATAL will be forwarded only if =
this bit is set.
If linux AER service is being enabled without checking/setting this bit, th=
en AER service will=20
not do anything even ERR_* is seen on link.

Regards,
Bharat=20

