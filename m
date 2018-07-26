Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84665C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C8D204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="X98lSmlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C8D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeGZDt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:49:59 -0400
Received: from mail-eopbgr720083.outbound.protection.outlook.com ([40.107.72.83]:37920
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbeGZDt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O0F0ZqQJlBV8tFFzE/83a7klzsoWgEFnHmKPJ8mQ/0=;
 b=X98lSmlECn78d14dPf5k6W+4UHLxx77YH1eN23qKgI9N4FCQJDoffqO1b5bHMO3HsxvBZMw8hvZPWqbvQPZkcVeDAyOLPoNNKZJz9jNgZ0o/G/k1o+uRqAH4kmuQf5Hri+VhRyBjUqIwkn2+9Tb1tQIjGc8bQ7gaMzQ8UnReSns=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB2191.namprd02.prod.outlook.com (10.168.243.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 02:35:16 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.014; Thu, 26 Jul 2018
 02:35:16 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry feature
 in the controller
Thread-Topic: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Thread-Index: AQHUIN2h2dmt05eMckmpM4FUm2VKGKSgY1yAgABpkrA=
Date:   Thu, 26 Jul 2018 02:35:16 +0000
Message-ID: <MWHPR02MB2816DDEAE84716F88B08EB46A72B0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532168920-3269-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180725200325.GA21007@rob-hp-laptop>
In-Reply-To: <20180725200325.GA21007@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2191;6:H0+gk+dkB3V9A3a1YLICAeTYCnsNBkbdCZ5udlZztr/QrmG8mESYYvhKzGYmJoIA2vhBi6H9p6ZVxi9Gpuhr2P5T8mWbMUMQfUXKJ8pfvtF2n63QU8ydHK+wWdfvbj2/FtJrENwPY+4YSeLAMrXUgI+7FtY67JpfRyqUfe3gy7qrqw75J8aAoJh6m4oZRA1WEZPj8Sop8wdr3SFNpzlSmRZ6QI0KaN0oR7HJXgl+0ifnd5KM0n2AD8oX4pX3mpznkfoiWsqQJ1Z2e369+ROa2GxXvtWQDUhuAuKh9Ij0ZMFUNv3rjs2q2MLD3c3H9a7hFVGuVbtujdxqjvF3ayIN+bliQBXGKWOIQDz/f89oK6sFlmid6HD+PyhVSuzdARd5IByvu10UOiAVepC1jLG6tpMcqd6szv9rPIHd/T9Xb5Q4TX2exIQRi1JnS3AK9E8M7sAL149C28AFhekcxaDa8w==;5:PLNeDB/8WWFQITBKAbdDu4qHEmzMUj/cLPIOYujkbc4OXjVN8lmP1Vl7+OmFNNOA8F8d2MO8k3vZ5dqqSXfsx+7wXcVf2LoUoNfEyE7/O5ffKhTJzjHpHsl726jEa/tOl1V52+L2BotZzF9LpibzqXQgnXeiCDyBU+lBRyIv3Pg=;7:cMpUJf2zkDf+fEuTMsaIFN2cxdTPASaYGiWR10IXUszd9Us26ZW8zzPpiGRjuO9ARKfYwpqa3dB9JWfrEiawMa6VSpwPDUrTawYX8JZM1irCnNcRk76hphW1NYTkItyzZEw6MckWCSZT+qJkK9YoLERO6iKmpjGpNl8jWN7y+q8PDZgpfY8fB4nuINdT+dd3bYz92LQA/jLiPohFXKUQYF9OllROlPI4h1n6sa9izthJAYCJVmHX67CIXF/eGH6S
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 977edd8a-bb09-4f8f-7abf-08d5f2a06c54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2191;
x-ms-traffictypediagnostic: MWHPR02MB2191:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB2191FE861CA920D5C12BFF0AA72B0@MWHPR02MB2191.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2191;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2191;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(53474002)(13464003)(199004)(189003)(76176011)(81156014)(8676002)(6506007)(102836004)(446003)(97736004)(105586002)(7696005)(11346002)(106356001)(81166006)(53936002)(68736007)(7736002)(5250100002)(6116002)(305945005)(186003)(3846002)(26005)(66066001)(4326008)(39060400002)(551934003)(86362001)(74316002)(6246003)(25786009)(5660300001)(2900100001)(316002)(229853002)(6916009)(6436002)(14454004)(33656002)(55016002)(9686003)(99286004)(486006)(8936002)(476003)(2906002)(478600001)(256004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2191;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lxvd7pmIs0ckojJLVmx039j2ulrTcrnw5tUHgTzmY8917JzW+T6rYJuZ4BH2c3C1hx2k7Tv7UQcCNAuKs+T6JaYj5GgxZbHE6ZSUdYlqWx2Y4IpYOg8VkBLnmo3EqVzzohl4d7FUMmcd6IOJbZDp1Noruy2JVuYvBsc5yJj3MNucnpiqnwVQJK1hBYEqGqg7FQRbj5aK194y+h4RWAWCZGMTAP8Xn1/x5q5Ud17fqMpd3PAFNngbA5B238u4PKZH0I8fI3REDjZkEbh/H/cIUmFc6lqb0vWXBuDc2BKHm8Fgs7MdKa/QUxoo7UZdsA0S3sR1NDIgCsweUrMXrfMJOoi2rn3fm4cA5L87rYaWwkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977edd8a-bb09-4f8f-7abf-08d5f2a06c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 02:35:16.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your comments, please see my comments inline

>-----Original Message-----
>From: Rob Herring [mailto:robh@kernel.org]
>Sent: Thursday, July 26, 2018 1:33 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>Cc: gregkh@linuxfoundation.org; mark.rutland@arm.com; balbi@kernel.org;
>v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; devicetree@vger.kernel=
.org;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry fea=
ture in the
>controller
>
>On Sat, Jul 21, 2018 at 03:58:40PM +0530, Anurag Kumar Vulisha wrote:
>> By default when core sees any transaction error(CRC or overflow)
>> it replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
>> Enabling this Auto Retry feature in controller, on seeing any
>> transaction errors makes the core to send an non-terminating ACK
>> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
>> Doing so will give controller a chance to recover from the error
>> condition.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>>  Documentation/devicetree/bindings/usb/dwc3.txt |  5 +++++
>>  drivers/usb/dwc3/core.c                        | 16 ++++++++++++++++
>>  drivers/usb/dwc3/core.h                        |  6 ++++++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
>b/Documentation/devicetree/bindings/usb/dwc3.txt
>> index 7f13ebe..2ba2bc2 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>> @@ -94,6 +94,11 @@ Optional properties:
>>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>>  			enable periodic ESS TX threshold.
>> + - snps,enable_auto_retry: Set to enable Auto retry Feature to make the
>
>s/_/-/
Sorry, I am not able to understand what needs to fixed here. Please help me=
 in
understanding, so that I can fix it in v2.
>
>> +			controller operating in Host mode on seeing transaction
>> +			errors(CRC errors or internal overrun scenerios) on IN
>> +			transfers to reply to the device with a non-terminating
>> +			retry ACK (i.e, an ACK TP with Retry=3D1 & Nump !=3D 0)
>
>Seems like the property is unnecessary. When would you not want this
>retry behavior? Why not just enable unconditionally in the driver?
>
There is no harm in adding this fix always but I think this Retry feature s=
hould be added
depending on the user and type of the application. For example, applying th=
is feature in
a streaming application where isochronous transfers  are used might end up =
in retrying
in failed packet until timeout happens, this might reduce the performance. =
And there may
be cases where the user want to know when the transfer error occurred. Enab=
ling this feature
always will fail in both the above mentioned cases. Because of this reason =
added this quirk,
so that user can decide when to apply and not. Please correct me if I am wr=
ong=20

Thanks,
Anurag Kumar Vulisha
