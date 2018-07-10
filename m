Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541E208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rCyGN34h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7541E208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeGJKKj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:10:39 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:60796
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751194AbeGJKKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niwfvfC/ELW27yiR8z9hHvRMNDwYYbTnXkgmR8mD67I=;
 b=rCyGN34hyTciA3SCDGcnZ9z/612tt0bVjXIs+M1jsijYouW8/b5dF3wTxUr2i8ihGMug3YG7C3NQ07aKJnBMl8JNeLt5/8rxs5a+kBMgnNlwEL8tbtNLbscX4VDwR34FvzX8+FPt9nDFwuja+6U18HbwguCho+WdQxDRPiU62To=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB3134.namprd07.prod.outlook.com (10.172.95.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 10:10:32 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::bddd:185e:610a:91b5]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::bddd:185e:610a:91b5%5]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 10:10:32 +0000
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
Subject: RE: [PATCH v9 10/12] pci_endpoint_test: Add 2 ioctl commands
Thread-Topic: [PATCH v9 10/12] pci_endpoint_test: Add 2 ioctl commands
Thread-Index: AQHUF6xIzGp0R8RdtEaRXdhJkPCEoKSIOtsQ
Date:   Tue, 10 Jul 2018 10:10:32 +0000
Message-ID: <MWHPR07MB35020A4BD96C8B34E9A0EB83D85B0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <185f0395d22083c04364cb81b4c2e2448fa89fb2.1531155252.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <185f0395d22083c04364cb81b4c2e2448fa89fb2.1531155252.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04MjQ2OTEyYy04NDI5LTExZTgtODZlNy1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcODI0NjkxMmQtODQyOS0xMWU4LTg2ZTctZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIzMTIzIiB0PSIxMzE3NTY5MTA0NTkyOTM0OTUiIGg9InR0OG1JaGtQZXY5eTI2YVg1ZTNCQ2lYY2JNZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3134;7:HkseitiL+eiAjAelgMV0Hwg6xWtmo5NtwCCwmNT4sU6YjFu/q5WIrxtdImJJlVNvqaiGsaem0V054ud7u57iCl8CcxZjW+Y2U3IOxji+ea+ypCukke79goCYUkarJKLVmG/e38QX+q/wB6ZK0fmJUHoB0V0lXvyrqwS7Vge5RvEW5ceGDTXr7zSBUJXnAHn7euCx1cHK/VD4EKU0UGpTwC2pHHw9cNP+Kg+OIctfo5he1bMmoGrSsl7u3PrLmlrW;20:xiDkp/oANyz2I6MIWqt/Be3Rv9RBFZarAl7P7bR4CnP8jVNyUvmBMl+MoS4ubR+85aEboluYgsdjPE+jQM1jhDzG481qRBnV/SkbCkMAkHo+fzev8jk/FpIEP0jeaTKiIOghqP+d93/fm9HEjEdptmAETwz9jca+H835ICAPkiHLtXV0PCPTQ1HSSUzoTna0dycn7n4BHZ01IvBb301ugeosrP6aKf9wJ99BVSoyER5VoynddmlLM2/3t+jQE5DM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 97f46a14-2396-4a57-0902-08d5e64d5f1f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3134;
x-ms-traffictypediagnostic: MWHPR07MB3134:
x-microsoft-antispam-prvs: <MWHPR07MB31341F57DC57222DF4E3192BD85B0@MWHPR07MB3134.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR07MB3134;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3134;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(36092001)(53936002)(7416002)(110136005)(2906002)(316002)(33656002)(6116002)(54906003)(5660300001)(7696005)(76176011)(6506007)(2900100001)(102836004)(7736002)(53546011)(305945005)(97736004)(74316002)(6246003)(39060400002)(105586002)(3846002)(4326008)(256004)(55016002)(14444005)(9686003)(106356001)(6436002)(66066001)(81166006)(86362001)(2201001)(81156014)(26005)(8676002)(575784001)(14454004)(8936002)(478600001)(99286004)(5250100002)(25786009)(11346002)(476003)(2501003)(229853002)(486006)(68736007)(186003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3134;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rpi8FQfs3Pc3tXmRu9dDuRUXWg5xsHzyeGcuODXwLCkB6aaL74jTnaPKi2SeUMXEeBMVayHpnwBtKLIJ9njrJr6QaqC5WbVW+WzDkdARpfVGDn1xvmBkDVfqopjH9+z2bebPuQtInnMShKKjKIdUGg4ALDJie26tdKj0+plUcRqPaHKhRs7jLT9euy18uqXaN5l4N0B+0rwupGHyab/o0comUl01s6MbT5Tnco2Q/+tm5qrorWOPyYASiXmSpmlvrNPy2nu0OzuTyY9DIZ47FPAJZ9qoSrnzyaQSbo2awwlZgJol6mdgQLgniMBlQIS5X/lzM1sZHKfOuod95RDxd5PS8yEOOVe5xBVEw4/q920=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f46a14-2396-4a57-0902-08d5e64d5f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 10:10:32.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 July 2018 18:43 Gustavo Pimentel wrote:
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
> Change v8->v9:
>  - Added a extra parameter to pci_endpoint_test_alloc_irq_vectors,
> that specifies which irq type should be allocated.
>=20
>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 176 +++++++++++++++++=
------
>  include/uapi/linux/pcitest.h                     |   2 +
>  4 files changed, 136 insertions(+), 47 deletions(-)
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
I've tested this latest set of patches with the cadence ep driver, which
does not yet support MSI-X, and can confirm that setting, getting and using
legacy and MSI IRQ type IRQs is working correctly.  Setting MSI-X fails, as
expected.
