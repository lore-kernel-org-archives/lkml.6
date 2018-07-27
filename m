Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2135C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fu3Xqcmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeG0Iu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:50:28 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:51264
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729416AbeG0Iu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3g1Flm59TgCj/KwAY25lDQOAUZPrBDiKub+Gg6pahA=;
 b=fu3XqcmoMuR7sE3WetI4RMmCk3xaFQL6w2wrA9hPyyCXqpKO9mOv+jNwEgIGQXFkLS36nmcQJWQeQ03Z/PuSURNyOFqiMEMg97Wu+FMRGQZBDBbDgaEDQKjfGOOQfmZFJYt9T7SnfrHTVScAknuRwXGb3xo57W/Z9Qj3ob3wGl0=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB3168.namprd02.prod.outlook.com (10.164.133.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 07:29:37 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 07:29:37 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Thread-Topic: [PATCH v2] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Thread-Index: AQHUJN2BN6j+pPNjJUq6AkpLiXk/dqShckiAgAACXHA=
Date:   Fri, 27 Jul 2018 07:29:37 +0000
Message-ID: <MWHPR02MB281661D98648F430989697E8A72A0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532608663-4091-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87va92yxrs.fsf@linux.intel.com>
In-Reply-To: <87va92yxrs.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3168;6:pBT3u1ejGHCbxMg9KO8GJbV8KGqm4GLyRmkXlUCMW7nO5wHO0folJCIvndgrKtyBSiKvr/WVqV2RfVjacuZHIxzH+FE/xZgJIUBUh4gKuf/8vuEiGxsOMhkETX5/tRAKENgS4wyQYSKIiyLxZNtY0ks6T/9fbZiu/CBEAfNlrzFR/nHXgJy44yxprNsaeExCXem4WFwSIaToBZldDmV8rFgGFl2wKrkL1Khym4ie/M5lczF+99C6QWFl1ZgP3zovoeuCH0dnd9fmneHGiXrKNNr127HtVXNeN7lqkcE6RWAfI+Bxgv4SA6W0srKu8Lqu0xYEFClrTbUZ6QfJb/splzZ/EyWM+Kx7I+nf6RHSc5twB878uCK5PlOJ9UYL/AtbdNpwTEpV8SmJOUyjrEfVwy6LKCwSBChyhzQ5Sw2Ur7eWaRx2nOaVLiDnCOOQFQ8Nthz1QO0c6qzH4ZXROLAB8A==;5:PVZVOBdCDe26HtH5rAfmX5MhsO8K5q4qBwNWv+LCN6YH5aU1aAA4Z+JNGWBjU64JXYkoGykH3y63t99bYcRxRJT7yVXezTkZZzeyIKZCReRMPg3J05eMgrxNS3nfpKo04PbQ/hR2CWaf4sJd4ZgipLQ1DC8pgrQVsPUSUiYXSns=;7:oyBhpNrPgWzqholQMJxD1BL4Z0HW05GCXGWK2iYi6s8NUoI6KUKQXduNkgGv8ochLKRfoiRfHdVpW9/skHcJAj1/gY+/yVI5drzNkfNl8/YrmH36AyT2HT3ZQ1EUQthQWR1fqavzBeY4k62idLxcvOBEP+yEiUt9jJUmvn2yxkGWJWcefz0f1bPHfGNdQxLgsELD5liMdb6y6tvWwcu4oIDUHUwasRlSnaq87XS1euQCrLUwI4JP9kO+jtTeUKW2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 310387c5-c1b9-48a6-7afb-08d5f392b55c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3168;
x-ms-traffictypediagnostic: MWHPR02MB3168:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB31684E8BA473A503099A3DDAA72A0@MWHPR02MB3168.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3168;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3168;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(39860400002)(366004)(136003)(346002)(376002)(13464003)(199004)(189003)(81156014)(81166006)(74316002)(486006)(476003)(11346002)(256004)(53936002)(186003)(76176011)(7696005)(4326008)(305945005)(6246003)(39060400002)(7736002)(551934003)(110136005)(54906003)(102836004)(14454004)(86362001)(6506007)(26005)(316002)(446003)(5250100002)(2900100001)(99286004)(2501003)(106356001)(229853002)(97736004)(66066001)(2906002)(55016002)(9686003)(33656002)(5660300001)(105586002)(6436002)(25786009)(68736007)(8676002)(8936002)(478600001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3168;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mOBdHdlI4bU11KME8UHzDDLZPONvIKqsu9PPxCDxrhbJk053WxqCg3JOba/stNls7g0LfIC2Lyj2X2d6dAh7ecRGLLjWNUXDmSU6LM2PGAzPxWBBy/IAwGK/5h8FHn56gs6uIwQJLmrY9Yxefn0vMzmiyuhtd6ywkVKi9mhm1f/bzq4vyVVyJRVTEtw5qta2KOOhUmCH8b3h4jKpssRtrOR2lfuiWPCp3b9Nl4NXrVF+9dexnz98AGjAh0UGH+C9Az8zKqCmimosHp2S6/Y8lwtTcMpofVtXLyHEJbnviK4S+beYcbT8odeVU6JEbnorK73jbVMdarSp2+0FPkB0YkA3J+oPqUQevOsRq5+WcRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310387c5-c1b9-48a6-7afb-08d5f392b55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 07:29:37.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,

Thanks again for reviewing the patch. Will make the suggested changes and s=
end v3.

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Thursday, July 26, 2018 6:12 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: Re: [PATCH v2] usb: dwc3: core: Add quirk for enabling AutoRetry =
feature in
>the controller
>
>
>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> By default when core sees any transaction error(CRC or overflow) it
>> replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
>> Enabling this Auto Retry feature in controller, on seeing any
>> transaction errors makes the core to send a non-terminating ACK
>> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
>> Doing so will give controller a chance to recover from the error
>> condition.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>>  Changes in v2:
>> 	1. As suggested by Rob Herring & Felipe Balbi removed the
>> 	   quirk logic and setting the AutoRetry bits unconditionally
>> 	   for hostmode
>> ---
>>  drivers/usb/dwc3/core.c | 14 ++++++++++++++  drivers/usb/dwc3/core.h
>> |  3 +++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
>> 1038075..478c8a6 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -883,6 +883,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>  		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
>>  	}
>>
>> +	if (dwc->dr_mode =3D=3D USB_DR_MODE_HOST) {
>
>almost there. You also wanna check for dr_mode =3D=3D OTG. OTG configurati=
ons can
>switch between device and host mode at will.
>
>> +		reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL);
>> +
>> +		/* Enable Auto retry Feature to make the controller operating in
>
>match the multi-line comment style already in this file:
>
>	/*
>         * Enable Auto ....
>
>--
>balbi
