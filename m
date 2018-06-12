Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F3D3EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6584220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xVIcvsG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6584220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeFLHDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:03:45 -0400
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:4583
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753885AbeFLHDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzzBJEz1pBOyhmbr32X7qo4tfuakBFuqU5BiRbPJAcA=;
 b=xVIcvsG0pTp4ObdBtdTIixZP3WJGq//KIh3s+qJ03PdaT6qyDAtkclDAsGWmCtbaem5k0yZ5sXrTD2hn5B9pbJNei6dA4RKOi2zjaonaKnmzPYhGt6qVTHWPWc30wwkVd9N+1aTIE+BcDRdq1QDuL0kCVTpiUlUicc5hinLrjsY=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB2608.namprd02.prod.outlook.com (10.168.205.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 07:03:40 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::d14f:48c0:905:7a42]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::d14f:48c0:905:7a42%2]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 07:03:39 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqRRyRYAgAAzNrCACkAS0A==
Date:   Tue, 12 Jun 2018 07:03:39 +0000
Message-ID: <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2608;7:9oKyYgP52lIE9yeA/xSQF8+peUhBEJkUntkGEgqhdpdrnDcOZj6K5SFxNTWmefOjkDONTw6TDYRMT9WTYSbzPA3jD3l0VXleJRSW6MQO/Bv+qcasVLugwfaZzeR+6kvawRrvrEH84l72wnlmeWQJOP9HbetR/JHhcoih0KZdxapBJbNJ/PhBj3BD2zLKiQRP+vdMwMRGCzuTKUJf73FbzGesrTSj87J8glzWeLUgV6e7ski4Yyt5Ugy/8gt7i/5H
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2608;
x-ms-traffictypediagnostic: MWHPR02MB2608:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB260869DF09534A60228687A7A77F0@MWHPR02MB2608.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2608;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2608;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(366004)(13464003)(189003)(199004)(81166006)(8936002)(68736007)(99286004)(3280700002)(3660700001)(97736004)(2900100001)(33656002)(478600001)(6916009)(54906003)(316002)(14454004)(3846002)(6116002)(55016002)(25786009)(5250100002)(5660300001)(66066001)(81156014)(8676002)(2906002)(9686003)(74316002)(7736002)(305945005)(6436002)(105586002)(106356001)(446003)(4326008)(186003)(486006)(476003)(53936002)(6246003)(102836004)(11346002)(6506007)(55236004)(26005)(86362001)(229853002)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2608;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bXvaZto9tDklLsXRsZYVfSvZYWN5ojUy93UxttZWvbhrtqP6K2zFngG6SV8gv4UhdglboCZsrhLeS7gE8T3kxW9/1O0qXPgR+vsYx8MbMj7LMJMfzXc1He/+MqIVuK05ZPQBtzrfk5LBnElbnTNb144bTFRUT9WcYHjDCI47Maso2d4AwJ8T0x8Xy4AnGg0F
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5910ce92-28e3-4622-6925-08d5d032a058
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5910ce92-28e3-4622-6925-08d5d032a058
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 07:03:39.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please let me know if you have any comments on this patch.=20

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Anurag Kumar Vulisha
>Sent: Wednesday, June 06, 2018 12:11 AM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Mathias Nyman <mathias.nyman@intel.com>; linux-usb@vger.kernel.org; li=
nux-
>kernel@vger.kernel.org
>Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for f=
inding quirks
>
>Hi Greg,
>
>>-----Original Message-----
>>From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
>>Sent: Tuesday, June 05, 2018 8:55 PM
>>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>>Cc: Mathias Nyman <mathias.nyman@intel.com>; linux-usb@vger.kernel.org;
>>linux- kernel@vger.kernel.org
>>Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes
>>for finding quirks
>>
>>On Tue, Jun 05, 2018 at 08:50:56PM +0530, Anurag Kumar Vulisha wrote:
>>> In xhci_plat_probe() both sysdev and pdev->dev are being used for
>>> finding quirks. There are some drivers(like dwc3 host.c) which adds
>>> quirks(like usb3-lpm-capable) into pdev and the logic present in
>>> xhci_plat_probe() checks for quirks in either sysdev or pdev for
>>> finding the quirks. Because of this logic, some of the quirks are
>>> getting missed(usb3-lpm-capable quirk added by dwc3 host.c driver is
>>> getting missed).This patch fixes this by iterating over all the
>>> available parents for finding the quirks. In this way all the quirks
>>> which are present in child or parent are correctly updated.
>>>
>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>
>>So this is a bugfix?  If so, how far back in the kernel releases should i=
t go to?
>>
>I feel this is as a bugfix. This problem started with this patch
>"usb: xhci: use bus->sysdev for DMA configuration (4c39d4b949d36faf)"
>where pdev->dev is replaced with sysdev. If I am not wrong this bug is pre=
sent since
>4.12 kernel release.
>
>Thanks,
>Anurag kumar Vulisha
>
>>thanks,
>>
>>greg k-h
