Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D159C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EE021523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e39P1Lzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EE021523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbeIUTyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:54:44 -0400
Received: from mail-eopbgr730053.outbound.protection.outlook.com ([40.107.73.53]:50932
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbeIUTyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ6tOBcAoiUoJBDZUDIrTttWwlYMtkcCUQTOQeeU6Sw=;
 b=e39P1LzspIKfHyOlNvKU9AIA4NX5Z5hMVuiXLqpNgPAoPzPxNUZba7hJzcC6JnXFLwl0ApOzxjkxLD5wUPjmyccl9b7b13bXYh5Kz2xaZiJpPVgMJCSaBVTmbDiiUQg3JoE/JZoutxfhEw2bPjTsGbxCcHrO8FdA87bMudNgzc8=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.13; Fri, 21 Sep 2018 14:05:28 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 14:05:27 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        "joglekartejas@gmail.com" <joglekartejas@gmail.com>
Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Topic: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Index: AQHUTQCoBCMdjS6uDUqQ64x43Vb2OaT6xu+g
Date:   Fri, 21 Sep 2018 14:05:27 +0000
Message-ID: <BN3PR0201MB099350017190F7148107F51CA7120@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <6DE59E7D7B09224BB10C87AEADB5972690BB1B@IN01WEMBXB.internal.synopsys.com>
In-Reply-To: <6DE59E7D7B09224BB10C87AEADB5972690BB1B@IN01WEMBXB.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0993;6:pL2zEdq6lCvpdcKdgU2x1+XiXn5tqAY2frhfnOk+KduzOB6ksmT42EV3dDYIhR8tGCNMNqO/MKBsLn/ki52Eyuezf8vEljFCZIJX7McX8mk03GoC+E7Ov1iAWsHfDIX9Pus7S2qtMelR5d81oSpD0dokmYGjpMGLTEUVdgK56T3g6UVKwfhwQ3eelHIVTN3Snpp05g3XM8joDTiQxH5mxZikMunqKiN61o1hZvg+4N3IZk8knYGe+kLmibn7uExYgCHJODcAUy76cQZ9tazqFAe9t643MZ3xno64KWtICqf1Lmptsk0COFsRc9Rzg1c6f3ElSv0e+03gT0qlI1WcNhmfuLaNSNkPrXF4luinOmysuDgv9uNvjtUi8jazQxkXnnNMMsVzqw3UpvG5igIEH8wD/roJqHiRIUadzAt/02VSYDYznet2SFH7TL3SMWRn4NVsGvjD8cfertd/0ZA7dg==;5:4WbTbA/+s53X4XCBclJ5TpXcI8iT+KxYFrb4p9GGGEFpDWVx+h0OigfnN5nsbT0XXt/PwMT+Q3tBTyZo9L6WMqzTdhBuLQzJa0pWCys8azmS1GRQue7VYISoqYaj+I3hZbOhl1UgYoHxfFF3yV4Ou6uyUkw5ZZ0jhZptJFwOlqU=;7:x88KIM+c7GNji4M5c74lTKzHC9sVVcyg2uIIQVjY2h8//DQJPDrX/hf44mx4r2bvcgaDDbru8rZ6rvJiRo2iQ5kkLlGE75qo2zvVp+FVGEySTcvkQc/qG0swMZRoyPgUgedgOWRSnvOJZwpS/85VfA5jDl+pSaC5duzGebIoYdNmmDeMgsU/u9EkH8igKGupA1fzkZ1+hsYBB5XQROa3nbg6YC3/FN81QfYKLz9A36cbPCWVf0Bgd0PLZNckbRRU
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 836b2a8e-77f6-4767-0025-08d61fcb48b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0993;
x-ms-traffictypediagnostic: BN3PR0201MB0993:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0993BEECF3F6A710D2D185DCA7120@BN3PR0201MB0993.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BN3PR0201MB0993;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0993;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(13464003)(106356001)(6506007)(97736004)(68736007)(86362001)(4326008)(55016002)(11346002)(81156014)(8936002)(486006)(446003)(2906002)(476003)(9686003)(551934003)(81166006)(229853002)(33656002)(186003)(25786009)(7736002)(71190400001)(71200400001)(74316002)(305945005)(6246003)(8676002)(6436002)(39060400002)(2900100001)(6116002)(3846002)(53936002)(5660300001)(26005)(478600001)(76176011)(110136005)(316002)(102836004)(14454004)(5250100002)(105586002)(99286004)(2501003)(2201001)(54906003)(7696005)(256004)(66066001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0993;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R2aUIaFVenqrRpM2O28mmlojRqHVbkST6Bno07E9O+LJfk0qzTOrWlEH+Kde0pb10G/w9hj28HOAejMbSA1Cpa92X5/tMQzDh8BOPGuv3KZWjYCnnp0xc/bnO6/P4P+yWJJVQNs/Y4qbgx7ib7re62Q3iX0VpkUhkDDPIEaLn+Df7/SCkCJCPhRMtn+X8VQdiymkxfC2LBs2f8QioDlnwZuQQH1AtXd4XRhaPMBnuoK9vY499IsM5AKG/rlE7lR+tDI05vxGAjU4UD9MCrubsCE3yExm7DqH6SYxA4PCxgjb1x34xHK/EJzmdxLlm/mHTgO65PR/w3GZFvkgz88UUMaYvtMDl7YUO5Vq8AfNlo8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836b2a8e-77f6-4767-0025-08d61fcb48b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 14:05:27.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0993
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tejas,

>-----Original Message-----
>From: Tejas Joglekar [mailto:Tejas.Joglekar@synopsys.com]
>Sent: Friday, September 21, 2018 7:01 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; balbi@kernel.org;
>gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Thinh.Nguyen@synopsys.com; Ajay Yugalkishore Pande=
y
><APANDEY@xilinx.com>; joglekartejas@gmail.com
>Subject: Re: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to d=
wc3
>gadget driver
>
>Hello Anurag,
>On 9/15/2018 8:00 PM, Anurag Kumar Vulisha wrote:
>> These patch series fixes the broken BULK streaming support in
>> dwc3 gadget driver.
>>
>> Changes in v5:
>> 	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"
>>
>> Changes in v4:
>> 	1. Corrected the commit messgae and stream timeout description
>> 	   as suggested by "Thinh Nguyen"
>>
>> Changes in v3:
>> 	1. Added the changes suggested by "Thinh Nguyen"
>>
>> Changes in v2:
>> 	1. Added "usb: dwc3:" in subject heading
>>
>> Anurag Kumar Vulisha (8):
>>   usb: dwc3: Correct the logic for checking TRB full in
>>     __dwc3_prepare_one_trb()
>>   usb: dwc3: update stream id in depcmd
>>   usb: dwc3: make controller clear transfer resources after complete
>>   usb: dwc3: implement stream transfer timeout
>>   usb: dwc3: don't issue no-op trb for stream capable endpoints
>>   usb: dwc3: check for requests in started list for stream capable
>>     endpoints
>>   usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
>>     fields
>>   usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
>>
>>  drivers/usb/dwc3/core.h   |  7 ++++
>>  drivers/usb/dwc3/gadget.c | 85
>++++++++++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 84 insertions(+), 8 deletions(-)
>>
>Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
>I have tested this patch series except the stream transfer timeout patch o=
n HAPS-DX
>platform.  I am not aware of exact scenarios to test the timeout patch and=
 don't have
>a test for the same.

Thanks for testing the patches. The issue mentioned in the timeout patch (P=
atch 4) will
occur very rarely on the long runs and only when tested with stream capable=
 host. This
issue happens only when the host & dwc3 controller go out of sync, where th=
e dwc3
controller may wait for host to issue prime transaction and host may wait f=
or the gadget
to issue ERDY. I used controller version 2.90A  for testing this issue.  Th=
is issue is mentioned
in databook section 9.5.2

Thanks,
Anurag Kumar Vulisha

