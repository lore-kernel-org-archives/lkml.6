Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A5BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF7C20897
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GkSlwRQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF7C20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeGNP4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:56:52 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:55528
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbeGNP4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAT4vzmRylklcf4V5OKnuhPZo7D+3JhNgeZf4K+x22c=;
 b=GkSlwRQdTusCI7fHOWX8WDT0BCyQkGI4zTIRH/s0cURo75LAMHT5aM2ckiCShQydKecoOa2N18GkjP/yAGcDibWZQqvLTQ7rVeKm9wN/f81gv2rehyGi6mbOggE/aD32MgNS6pkJwYJz50mLrY+YbaFoK+6fXq3zD8zHPDwjTM4=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB3358.namprd02.prod.outlook.com (10.164.187.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Sat, 14 Jul 2018 15:37:20 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::447d:d4fd:d96f:1fd3]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::447d:d4fd:d96f:1fd3%4]) with mapi id 15.20.0952.021; Sat, 14 Jul 2018
 15:37:20 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqRRyRYAgAAzNrCACkAS0IAAEWoAgDLEbDA=
Date:   Sat, 14 Jul 2018 15:37:20 +0000
Message-ID: <MWHPR02MB2816AE6D9F6C065DADA78D7EA75F0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
 <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180612080256.GA17399@kroah.com>
In-Reply-To: <20180612080256.GA17399@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3358;7:XKp5A/hfRhIO+PSaF2niUtlXcJvr2BHArAMoUJNMAEWZ1NXWBf1V/2xJ1iw1QB1nK0iLgs+N4s2HmxANmIXmN4vp0jcRiNqarfrhe/YQnPSEsDBzDKwYvlcP4Vx43IWv/ksQPHDQWE4H8XB/ShzU1iH3q4VnuzejHBCWWwr9f3mzJHHOgxbCnNlWQfDr9YjJ/eQBWUz1PAAph8wMq+oxi/ApTkn2wTmSuk+6F7ESPvXjOlBFMpea4w8eTDYJHyMn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1ff5fd96-2c3d-4498-c997-08d5e99fb039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3358;
x-ms-traffictypediagnostic: MWHPR02MB3358:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB33581CB099702EF9BAC29FD7A75F0@MWHPR02MB3358.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3358;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3358;
x-forefront-prvs: 07334CBCCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(13464003)(446003)(256004)(11346002)(476003)(26005)(76176011)(6506007)(55236004)(102836004)(7696005)(74316002)(2906002)(99286004)(486006)(55016002)(53936002)(93886005)(25786009)(6916009)(6246003)(8936002)(7736002)(305945005)(39060400002)(4326008)(81166006)(186003)(81156014)(8676002)(2900100001)(33656002)(316002)(97736004)(86362001)(6436002)(5660300001)(106356001)(6116002)(3846002)(66066001)(54906003)(229853002)(5250100002)(9686003)(478600001)(68736007)(105586002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3358;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6SwtIvSAGQsU1Ot7/X7o0BmlD7shN9vywFM15KZU/kUlRRZloAA5wQXvyqBG3BNKtr6ejdZVE3ma6af/tpVL11vw7tz9rP6qlvTaRbXcRG+vL2WcKMsN2Z+TNvWndVraKdQMsBUyM1vKhYVx0YBfKXNv2YivHY1yg9e2qjWWebxLs9M4xuzlNxhSLfSaTvV83SzGq1gVK8d+6MXhwcLOh/6CbvUDCFwQIX5qTLB4eQ26uT5CciI6Zn3O7OaMhCaQgwrrEuq/ICM1Cd9QKs17JA3njcasPvP7ZhlVCtfm8Km8QVvuaylwo0sciOSYlX7gtiUzTjHBwqKA2W55j1cLpKakPSU7y4BIjIR9n35ruu4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff5fd96-2c3d-4498-c997-08d5e99fb039
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2018 15:37:20.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Greg,

Ping!
Thought of giving a friendly remainder about this patch.

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
>Sent: Tuesday, June 12, 2018 1:33 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>Cc: Mathias Nyman <mathias.nyman@intel.com>; linux-usb@vger.kernel.org; li=
nux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for f=
inding quirks
>
>On Tue, Jun 12, 2018 at 07:03:39AM +0000, Anurag Kumar Vulisha wrote:
>> Hi Greg,
>>
>> Please let me know if you have any comments on this patch.
>
>It is the middle of the merge window, I can not do anything with any patch=
es until
>after 4.18-rc1 is out.
>
>Please be patient.
>
>thanks,
>
>greg k-h
