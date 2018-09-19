Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B572521524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B572521524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbeITEpt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:45:49 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:28146 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeITEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:45:49 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 411732D6B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 23:05:38 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (g2w6309.austin.hp.com [16.197.64.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 503178B;
        Wed, 19 Sep 2018 23:05:37 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 19 Sep 2018 23:05:37 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 19 Sep 2018 23:05:37 +0000
Received: from DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM (10.169.92.23) by
 DF4PR8401MB0395.NAMPRD84.PROD.OUTLOOK.COM (10.169.83.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 23:05:32 +0000
Received: from DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e0cc:6d8a:783f:4318]) by DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e0cc:6d8a:783f:4318%3]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 23:05:32 +0000
From:   "Travis, Mike" <mike.travis@hpe.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>,
        "Masayoshi Mizuma" <m.mizuma@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Thread-Topic: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Thread-Index: AQHURGGsZ2TDbWKoW0+i/7REv2uTxKT2HsKAgAF95wCAAAO+AIAABNsAgAAXKICAAJVWgA==
Date:   Wed, 19 Sep 2018 23:05:32 +0000
Message-ID: <474aaa27-c463-4ba7-8284-ee54d7c33ae5@hpe.com>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
 <20180918133026.gzyix3oyrfcsrdcx@gabell> <20180919121720.GA47424@gmail.com>
 <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
 <20180919124806.GA48413@gmail.com> <20180919141058.krruhvsjkm6hqgmf@gabell>
In-Reply-To: <20180919141058.krruhvsjkm6hqgmf@gabell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:300:ed::21) To DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7610::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.222.225.80]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0395;6:lZS43qGGsRLKmHfkWq/uFs/jM8fbZHIqDkLD71+k+ID3JW8LBY+FtsCGI/tO9nbobt6iXjTKWN8u/S6/Xd0vLfI3gJ4UgTTOp2QkXOyFpV467QqSJvT0i74kmt+7oeqiuIsXzLdVNxKWjK/XpNYMJAxgo/x8qNecmwvjlOqzHF7ACye5WQFSL7N/eVaO5+9E/HusMxCt9HNCft1zGX3iKpcU/rB2WMgdiO1vmX/E8QWKg10x8lxMHmZwRUFH4tQU+t2RP6AKG66pxeEnrk1eLEoiatahk67skRXmUD0kDc7q237nAz5DNtbp+1y/O5FYTAb0ZjlrVLvWJxyKm+LZDBzwGcWbn0yXvE9pc1qXmSOAkzlyTvSVisrgwTlMDSjsdKdQ8XZt6AUp9dPbdZHMSM6wXwRg+cvTxRbGMD6Q3HTvvGsq+zx33LycQRKxJM1d6Zumub/nAbEDzPvT/xzVKQ==;5:LViXh7gbvGerfHce+bbQpjdfWJryvmgIEAHbDa7qCoa2EhAlj+Saf/zl25/CJ/D10zYkl1xVTdnXkfaDEv4UXq8Sab5FCCC6J0XRrugWXCDhFjJCbRtOS+CodJQueUEh5/7ZmUB6bBa6Bqm59e5TfxhgSUeTrSOl7lXWpYjZnak=;7:Gq+y7CaseVaE6nUfqyRdkiKfT6y1dQzdM0P9mQNDqEQd2kehkiCT3UkEAWJJtCSQUkGyZaEAUv4eZeOvy7RUvNjBnzkurt4hcmFQW+Ms44hXVGJfxuY/tD/Nqre5ESrwfdMU+km1+RukjguA9nOg/701ctmrBcxDztmiyIynmk3x0EAUYdevPeIQl9a80RxA03epxQfManZuT75qDGY4Pk9BVCjS+Fua+hhWKjWOAiHjil5vZuFw6uQZAsPH+o3j
x-ms-office365-filtering-correlation-id: e841b9e8-8fc6-42c9-973d-08d61e84664a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0395;
x-ms-traffictypediagnostic: DF4PR8401MB0395:
x-microsoft-antispam-prvs: <DF4PR8401MB03956778324EF730B4ADBCDFE71C0@DF4PR8401MB0395.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(85827821059158)(170618885588394)(268935105599563);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DF4PR8401MB0395;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0395;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39860400002)(396003)(54534003)(199004)(189003)(51344004)(501624003)(39060400002)(68736007)(6246003)(8676002)(5660300001)(486006)(14444005)(97736004)(4326008)(446003)(93886005)(14454004)(229853002)(6486002)(25786009)(256004)(6436002)(305945005)(7736002)(6506007)(476003)(386003)(2616005)(5250100002)(81156014)(11346002)(76176011)(110136005)(31696002)(54906003)(99286004)(186003)(102836004)(81166006)(8936002)(53546011)(316002)(478600001)(86362001)(26005)(52116002)(2900100001)(106356001)(36756003)(53936002)(105586002)(6116002)(6512007)(31686004)(66066001)(3846002)(2906002)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0395;H:DF4PR8401MB1132.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d1e84XpCsbY1XfEm+PImGVik2w98we9Yqe5H8mpLW9iy+ffhzGqnBNbjsYMdPdpym87KqyjiPZHy3EvvhpWnGS1rE+JJicsxsCdsfoNHSYerkVVJVqab74sSwf8UzeVo7adb3AZit3vNzVXMC080dR1+ebllE6PokigdVV3Qg6l+Iz47VCCX4h77CANhC2C8dvfyBUVxu3PFtkU5rTyJsvPUk1E8VifrptK7WSabx9TbxqvXGc4y6nN8EqxHQRp56g+dVDjDZUrSw12BliO8YTnuxjSjR4XDUI/0ZVcdcTP9PLMJUoBLWMKmRCjvcucxRoh9QASRCW+U929icoKeJT5VxQVFNUXUZtNIwF6eQiA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <902B5F814E73624D83B1D3607F97E9BD@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e841b9e8-8fc6-42c9-973d-08d61e84664a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 23:05:32.4458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0395
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2018 7:10 AM, Masayoshi Mizuma wrote:
> On Wed, Sep 19, 2018 at 02:48:06PM +0200, Ingo Molnar wrote:
>>
>> * Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>> On Wed, 19 Sep 2018, Ingo Molnar wrote:
>>>> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>>>>
>>>>> Ping...
>>>>> I would appreciate if someone could review it because this patch
>>>>> fixes the real memory hotplug issue...
>>>>
>>>> Yeah, so I generally try to resist random new boot options that
>>>> work around real bugs, so please convince me that this patch
>>>> is the best option:

I whole hardily concur, that having boot options which are not easily 
understood should be avoided.  The very best is the system should just 
work.  But on very large systems, these boot options are typically 
determined by either automated scripts, or careful instructions to the 
trained onsite customer engineers, who are required to "get it right".

>>>>
>>>>>
>>>>> On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
>>>>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>>>>>
>>>>>> If each node of physical memory layout has huge space for hotplug,
>>>>>> the padding used for the physical memory mapping section is not enough.
>>>>>> For exapmle of the layout:
>>>>>>    SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
>>>>>>    SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
>>>>>>    SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>>>>>>    SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
>>>>>>
>>>>>> We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
>>>>>> however, the needed padding size depends on the system environment.
>>>>>> The kernel option is better than changing the config.
>>>>>>
>>>>>> Change log from v2:
>>>>>>   - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
>>>>>>     but a little different. Remove SGI UV description.
>>>>
>>>> Could you please explain it a bit better where the higher padding requirement comes from?
>>>>
>>>> 'system environment' is very opaque.
>>>
>>> As I understand it, it's depending on the actual physical characteristics
>>> of the machine. So setting a fixed value in Kconfig might work for one, but
>>> not for others and having a command line option allows to tweak that at
>>> boot time and having a common kernel image.
>>>
>>> Ideally we would calculate that from SRAT, but AFAICT SRAT is not available
>>> at the point where this needs to be done.
> 
> Yes, that's right. The KASLR initialization is early boot sequence,
> so SRAT is not available at that time.

Some facts are available via the x86 boot options structure passed from 
BIOS.  Is there enough info in there to help determine what the optimal 
value of this parameter should be?  Even a safe guess gets the system 
booted and can then be refined for the next reboot.

>>
>> Yeah, so could we at least do something like this:
>>
>>   - See whether using the maximum padding as the new default padding would work for everyone?
>>     A bit more virtual memory used, or are there other costs as well?
> 
> The current default padding size if CONFIG_MEMORY_HOTPLUG set is 10TB.
> IMO, it should not be increased because it gets the available entropy
> decreased...
> 
>>   - Add checking code to the later SRAT case to at least _detect_ bad padding after the fact.
>>     We don't utilize RAM with bad padding until that, right?
> 
> I have an idea as following. Does that make sense?
> 
> Add a warning message which shows the padding size is not enough
> for the physical memory mapping and tell to the user about
> recommended padding size. User can change the padding size in next
> reboot to add the boot parameter.

Again, leaving it solely up to the user is probably not the best 
approach, either for single workstation users who may not understand 
what's up, or large system users which will just generate a customer 
service call, because something went wrong and they can't boot.  Or 
their performance went down the drain.  [Normally upgrades that change 
the system config use an onsite CE, but that's not strictly required.]

So basically a deterministic method of calculating what this padding 
should be works best from a customer support angle.  For an individual 
workstation user, having the kernel determine what's correct for proper 
operation is the best.

Thanks,
Mike

>>
>>   - Add 'quirk' to the name of the boot parameter, to make it clear that this is really due to
>>     suboptimal communication between the firmware and the kernel.
> 
> I'm ok if 'quirk' is added to the boot parameter.
> 
> Thanks,
> Masa
> 
