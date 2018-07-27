Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B089C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB40A20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Cu+tCuMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB40A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeG0IuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:50:25 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:51264
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbeG0IuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO6tb4ZPGmZBFLIdWJ0c7zHJYS7KjqDapriIGDGVvKQ=;
 b=Cu+tCuMMvYkfyFxEz8QHPRe6SGzbd1cESsSaK4xroCjpRxT4dqMNJldMULmqYD3axK81CyKDQvKeaYlluGYI8h1ffkFleaIfoOScVEyO5ccBeJUCK8tOHyGWIugb6OP1smlR1CfzhvglGFDRidOLuxPGKyjBQievzRP7CIydI/o=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB3168.namprd02.prod.outlook.com (10.164.133.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 07:29:35 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 07:29:35 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry feature
 in the controller
Thread-Topic: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Thread-Index: AQHUIN2h2dmt05eMckmpM4FUm2VKGKSgY1yAgABpkrCAAJTigIAACINg
Date:   Fri, 27 Jul 2018 07:29:35 +0000
Message-ID: <MWHPR02MB2816FFCAB118C07C7754BF58A72A0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532168920-3269-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180725200325.GA21007@rob-hp-laptop>
 <MWHPR02MB2816DDEAE84716F88B08EB46A72B0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <877eli1c72.fsf@linux.intel.com>
In-Reply-To: <877eli1c72.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3168;6:vLCPtrtPrzRNJEW6S+b6ib+dVSWXOt+NIWkPqpvdH3IAOa7EAcBB0P+1n674YaFhK02LoL3senX+DgX7gzzcGXm/NrfN8IKLoE1m97+BMje2KxvkgxJ0kiJVSLuBN8hEjLjOc4fzE1MDz2PBPQudFHYzxrxUsNJ6fxgEjVm6PuIUizPTBWMYfh0nBiuwpdjTMgtW3/cWw09wNf9tYwgUr2mLzZIDRUaw4Y1/lPAZvS66abpdjQsja3PlzgHOYD/qduCQ5Am/gtx+0eu5Lxrr+zThO8J9ZqfMv9RDX8zmiyigocrMicvU+SoRVMrbYdsN/ET3O/gAGauCvpx/LMR4d86oAbQSq3w3CKdkt/H34uCvVI4euOKh9pxVhZjeeXr8xJQY8n4FafN98elKHg5Ipn5lAPTXH+Jqu4fyF+6e8Vubm29aZvcKSxK9TP7uiZUFJv2koax03f0u8b/pE9mlOw==;5:6oysuYoQ48+QdOXihohACuuFBLKaQGvtcXHJnml7VcRQtGueCH37xaaljEXLYLCbSANSW0gqWAFE89CvFZzMPwkAslcKA8vLCCSesxhwSbyYrrplo/52A5FLtjU5pWXzsx9htbPY+ukNFNYx4E42kPpyQHBYB9TMEiuTGV1cdWs=;7:qlJM+MSfPHEtWMTaXoOS441LfXGD88aS0rOOSCCCpDvbJzPJb7RcCF3CuIbnBOWi0tHax6NqBvk6arD859cyjbdsy6GgWrQhZRiARanUQa07byOceJv1Z5Ov13ygbD9j3KUlAR3kUVCnYW9i3jT3A15cKqz2CqFj6sS1cKIV4kXa10w5glacM817PGzufNpjhCKwpMb+F12Q5R0+AMAXh2F7D6zKFHkV272RhvcYzxh7yQQgoj6EtBFmjXYTAcYC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f1b814c2-92a0-4c4a-0016-08d5f392b3fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3168;
x-ms-traffictypediagnostic: MWHPR02MB3168:
x-microsoft-antispam-prvs: <MWHPR02MB316884A7295793021E94307EA72A0@MWHPR02MB3168.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(788757137089)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3168;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3168;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(39860400002)(366004)(136003)(346002)(376002)(13464003)(199004)(189003)(81156014)(81166006)(74316002)(486006)(476003)(11346002)(256004)(53936002)(186003)(76176011)(7696005)(4326008)(305945005)(6246003)(39060400002)(7736002)(551934003)(110136005)(54906003)(102836004)(14454004)(86362001)(6506007)(26005)(316002)(446003)(5250100002)(2900100001)(99286004)(106356001)(229853002)(97736004)(66066001)(2906002)(55016002)(93886005)(9686003)(33656002)(5660300001)(105586002)(6436002)(25786009)(68736007)(8676002)(8936002)(478600001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3168;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gm30Agel++PiL3HNmFVaurVOkYFJvenHHwA6ojWekKcjF5ocBAobCF/oXOZV6hEnk2dNH8AJd6qmR2ZOSzE52x0KivjllovhLYIWMEVv9kwfac69wJ25UVDLq+5ZLg8XLXmWBxtuIpNU/76BjhMW5rGXXA6J7n1MFhbIeJlokIowqEoCswrcHNFvItoVfDMFGAaAwwYVd70FB3AD+osJhr/fzSF7ySkfd4eymA63f9imE7Q41zPLTCcSBUIakUHHJjfgzOpMmgzmTPog+SQ5tT7wuw7Vom1sjjncUVZ2zqJHFIB/CwR8YLsXSHZMfyXm12NOC0/s2NKF+QeneSQsC8XnMlFZF5G6CDc054LahrQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b814c2-92a0-4c4a-0016-08d5f392b3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 07:29:35.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Thursday, July 26, 2018 4:44 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Rob Herring <robh@kernel.o=
rg>
>Cc: gregkh@linuxfoundation.org; mark.rutland@arm.com;
>v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; devicetree@vger.kernel=
.org;
>linux-kernel@vger.kernel.org
>Subject: RE: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry fea=
ture in the
>controller
>
>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
>>>b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> index 7f13ebe..2ba2bc2 100644
>>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> @@ -94,6 +94,11 @@ Optional properties:
>>>>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>>>>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>>>>  			enable periodic ESS TX threshold.
>>>> + - snps,enable_auto_retry: Set to enable Auto retry Feature to make
>>>> + the
>>>
>>>s/_/-/
>> Sorry, I am not able to understand what needs to fixed here. Please
>> help me in understanding, so that I can fix it in v2.
>
>replace _ with -
>
>>>> +			controller operating in Host mode on seeing transaction
>>>> +			errors(CRC errors or internal overrun scenerios) on IN
>>>> +			transfers to reply to the device with a non-terminating
>>>> +			retry ACK (i.e, an ACK TP with Retry=3D1 & Nump !=3D 0)
>>>
>>>Seems like the property is unnecessary. When would you not want this
>>>retry behavior? Why not just enable unconditionally in the driver?
>>>
>> There is no harm in adding this fix always but I think this Retry
>> feature should be added depending on the user and type of the
>> application. For example, applying this feature in a streaming
>> application where isochronous transfers are used might end up in
>
>read the docs. Auto Retry in only for non-isochronous IN endpoints. You do=
n't need
>any quirk for this. Just enable it unconditionally. Actually, you wanna ma=
ke sure the
>core can run in Host mode before setting this, but that's it. No need for =
a quirk.
>
Thanks for making me understand. Will remove this quirk and send v2

Best Regards,
Anurag Kumar Vulisha
