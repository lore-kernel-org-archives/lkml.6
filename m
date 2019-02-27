Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30973C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC04D218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dWsHJxHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfB0IoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:44:12 -0500
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:30526
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbfB0IoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uca4WxC5sXYYJJhrQN4x0guMfC/Io0euE/z24jWtEJ0=;
 b=dWsHJxHecR/iCuls6JdXWfbeIsN830ZhO/HFy/0FlnWQwPvUyTy/4EeunGvMeRcjq1ZedEgFYtlbLXmdgalhgb1+dk7U1UPO+i+r3CRnkMmlt1yvyAm66RW6EyXm8nAm9YzepHlG64kZsqVjxluBi9pqMI65Gkrz/fCA4OY2QNw=
Received: from DM6PR02CA0018.namprd02.prod.outlook.com (2603:10b6:5:1c::31) by
 DM5PR02MB2265.namprd02.prod.outlook.com (2603:10b6:3:4f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 08:44:08 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by DM6PR02CA0018.outlook.office365.com
 (2603:10b6:5:1c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.18 via Frontend
 Transport; Wed, 27 Feb 2019 08:44:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 08:44:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gyuox-0008N0-6f; Wed, 27 Feb 2019 00:44:07 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gyuos-0003nW-2c; Wed, 27 Feb 2019 00:44:02 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1R8hvxW031324;
        Wed, 27 Feb 2019 00:43:57 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gyuom-0003n7-UW; Wed, 27 Feb 2019 00:43:57 -0800
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Michal Simek <michal.simek@xilinx.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Harini Katakam <harinik@xilinx.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
 <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
Date:   Wed, 27 Feb 2019 09:43:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(61684003)(199004)(189003)(54094003)(51914003)(65806001)(65956001)(36386004)(44832011)(5024004)(486006)(478600001)(305945005)(8676002)(6636002)(81156014)(81166006)(8936002)(9786002)(2486003)(356004)(6666004)(47776003)(23676004)(186003)(76176011)(4326008)(2906002)(31686004)(50466002)(229853002)(6246003)(126002)(11346002)(36756003)(316002)(93886005)(106466001)(77096007)(446003)(106002)(476003)(58126008)(26005)(426003)(64126003)(336012)(54906003)(2616005)(63266004)(65826007)(110136005)(31696002)(230700001)(5660300002)(41533002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2265;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd6a72a-29b8-4c3d-3b85-08d69c8fbcbc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR02MB2265;
X-MS-TrafficTypeDiagnostic: DM5PR02MB2265:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2265;20:6ZAWSbVjXnssZYLHvJJw/F7+QPXw1HQ9TM8kNFJ0t6S6OT+9QoTF8aJGS0FCs5YxMPkPR+ITT5I8PXjk7tJ68e4ZMsNcIKaZsy6lEI0FhJKCwXgb2fQul7hfFHYhveXQpxytfF2+kdm9BH/cVwTnNLticEq0754Q9s/EmKEsTum8qshz9lAfbqDmiFS4BPOxeHkJxQ0fv+SyRrFTSfF8p6WBV1gu+NyJIej6c8NGB1mO7gaKfhZ0KpzF4OlslAxPyHopx6kQqtbnIb/7NeYFnjgmK6jjRFXLt3AGU0fONg95YYWTs5ymE7G/2z23P34QxSmUftS4s0TYDxfwDiVXFBufas2aEwMJjXzSYo7wICdwoVpxBZxSItGFoIIkD5sYAHeBtqt7YXIPoNMFFvWrwiNZlXebpoXd//8oCDvzpPgR2+sp+DcKISe4zXF2p/a7wFRDSUZsfM9kcyaY3onLDdZ/o7172HlHeyKRqX5M2AIboGmiivQIfOaiWAVBW2y6
X-Microsoft-Antispam-PRVS: <DM5PR02MB226541C5DA24B38C5F84A743C6740@DM5PR02MB2265.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyTUIyMjY1OzIzOkhUbnNOMUF1Q1NFVDN1MXVYMk03RDZSd3Jm?=
 =?utf-8?B?Zk1ESUxwU0F2MVA3R2VmTE04ZGQ2bkR6S1VJeGduUkJzOEJ6aVZ5S0VqVlA2?=
 =?utf-8?B?b0tPbEpZemo5cjlUNUU0RHhtVnRsVFhDaDhONzhTaGpyclZHOVB3V1p5RUhi?=
 =?utf-8?B?dGU1bjlidWNPMjN1Mk9ZTjh4V1A0NEdBQm1ET2RIV2tUcHFRZGhsN0V1TjYv?=
 =?utf-8?B?cXE3VDIxWmRGQ1djSnVGcm9sVkphS2VLVTlyZkx0eFVMajJRa21xTkVjT2M3?=
 =?utf-8?B?QUVRaEtpVXp0MjNpQndVKzJDNjlZQUxpWW9YNmpOd3pCL0owbWVoa250Y1ov?=
 =?utf-8?B?cnVlam54aDJqRkNuQU51M0JoRS91WkdPbjlqTWJyWHJFR0t3NVhWOWxDM1B1?=
 =?utf-8?B?NkdDVFpFMFN1UmM4VzRmMUdsYXZlS2E4YllZWEdyaHZ3U25Yb0hqTFdyUDdY?=
 =?utf-8?B?LysvUEt1TGlNQTU0N0YrYUtHcGVUZHV3YnJ2Ri9ZTTRCQ2hlbUZsRFB6UmFm?=
 =?utf-8?B?bmdpcGUwZ3FhNGdBVGNIeFp2UkFCNUZJL252SWlFbWpRY0Z3YWRjV1NyK1JQ?=
 =?utf-8?B?L1V5Y0Y5WitvUEE4YmhtYmFCRm0wYzgzSG5BUTloWTdEVUM3bE1wclQ5TnZQ?=
 =?utf-8?B?bFNKUlpNaWVLRHB2STErMkNsbUUwMktxSk92RTM3aTFORTNnQUNGOEJsRjYz?=
 =?utf-8?B?bmtCdGM0NVp1c1VnT1A1UXQ3K05ZeFdMTHV1UjB3YTIyaXpBU2QvbkhkSU1T?=
 =?utf-8?B?OTRmQ2RGQ0lwTloyMzRPWE45dkxyYlp3dHNHcXoxSEd0ckJOelVaeVFnYllx?=
 =?utf-8?B?WkVMNmFZNkV5Ky9wRVFwL2JBb1U5VFZQUGRCemR6Tm5MVCsxZUlDZysxSEhG?=
 =?utf-8?B?TVBlUXVjTW1PTHYwUEZKWFhtdkpybHpNN3p1NzFnZTljTWxHRkhjUnlqVUha?=
 =?utf-8?B?bFBhTnBJZUZQTW9jejNxSlZ3K0lqcktPVU8zZDR5dUNuY2x6Wko4a3JVVEV2?=
 =?utf-8?B?QVh5RWxONW9ySGNwZFptVzNkNy90bzYraTN4bHU5N25adDJzWjZCZzJjckV4?=
 =?utf-8?B?NGVhdG9MVEdVSXNURVlDcnE0ZGNUZFp6a0pQWG55Z3MwbkVTSjdKMzdINXc0?=
 =?utf-8?B?TDZjOCtUZFovV3RRd0pPWDFFbWdySThETHcxdGFxMzVMVHRJZXJ4N0pMcXdS?=
 =?utf-8?B?dURGaVlhY1JURmJWRWlUYnRCUm5MRnBuRC9YdUlGN0pubWNjZDdnalpFckd2?=
 =?utf-8?B?ckVQd1ZrVnR4bTdqWEFEZ0UrK1BZRTVpVnpVZTA5WnRYZno1WnFhZm1BVUJy?=
 =?utf-8?B?R0hjRmZxenBrOWR1QVFWaDFJem1wVVdyK2NxT3NtR3B0MkM1MEU2d2dIUDlo?=
 =?utf-8?B?RGs0TWw3a2cwUVpTNTUyM3BKTEhvNldFdGxPZ3BZSkN5WUNiS2RpRFc0b3J2?=
 =?utf-8?B?OExBMEdndEVVSG5Tc3Jpa3pIcEkzYVNDbFdDdlRoWG5qUXpPZEwvaU5mY1Zn?=
 =?utf-8?B?MDVMTlhhYi9hc1FuQnhja2dGR0pubFFWeGNlWDR4cWhnNkxXcExtUkw2bHY1?=
 =?utf-8?B?NlFiclhLMWg0QklrUlpTd0w0RFkyZERnZFFzNmRyRytUTE11bG9uVEhDMjZW?=
 =?utf-8?B?cUJINGorODY4TU9iRk9aVFVNNHpSV281TnFldjRnVjJ1YzRuSE10ODh6cy9T?=
 =?utf-8?B?WUpCa2pCd241VHNlN0pmSzk4RmN0dHNDWGJlYzNzNnhBazJlb2Y5R0ZOZGdp?=
 =?utf-8?B?S1ZUc0EvSTFjbDUzTjkzQmh5cEticzhVM2pEZ3NmRlozVXdNMGdMNFd6VUh2?=
 =?utf-8?B?NlUrWWltQlBrTVAvRXZPQ1JQSGd6RUhFZnZMNFhBT29zdFB3YzFOOHJEMTVR?=
 =?utf-8?Q?Lm8Sr/NYE7A=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8LLJPgCICR+RzE2TaN1HBAAzG0C9zdX2cRPmp6yPBM3eL9IW+ZoQv+XG5yULeyl38CB2szy0d/9qS8psV1MMbfKpGwYVqz1LjFYcsak/CGZAVaHw6OaWc+ePvHxlX4zVcfHYJo4uGUaVRx9d34MhqF74DzlAn2N2aB2tEVDYoS16JrsmsBfvSFGl/0S1H1LV/GlcM300Eb3iNsaGR6FeoTVz0isyG3+xI6xIcDcZ82HEMaXxksijTmGPhlXpkXl6FbTf4JIuYgiSFgCrhOKtpDMmUwwqZ3SfOk3Sdr0D5MLxEUuYB+gvLc8RaP2wPAhgi/cQ87Cshf+scszEUY8QnIf9bWkFv6AN6HnaCHGzEtj4L/DUU/fiMwq6NshAzL7L6Px6iz8N67yQZ3Ld3b5PJPivV/8fC4Ixkm5qdc5NL/4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 08:44:07.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd6a72a-29b8-4c3d-3b85-08d69c8fbcbc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 02. 19 12:03, Michal Simek wrote:
> On 21. 02. 19 11:24, Paul Kocialkowski wrote:
>> Hi,
>>
>> On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
>>> Hi,
>>>
>>> On 19. 02. 19 18:25, Andrew Lunn wrote:
>>>>> Thanks for the suggestion! So I had a closer look at that driver to try
>>>>> and see what could go wrong and it looks like I found a few things
>>>>> there.
>>>>
>>>> Hi Paul
>>>>
>>>> Yes, this driver has issues. If i remember correctly, it got merged
>>>> while i was on vacation. I pointed out a few issues, but the authors
>>>> never responded. Feel free to fix it up.
>>>
>>> Will be good to know who was that person.
>>>
>>> I can't do much this week with this because responsible person for this
>>> driver is out of office this week. That's why please give us some time
>>> to get back to this.
>>
>> Understood. I think we need to start a discussion about how the general
>> design of this driver can be improved.
>>
>> In particular, I wonder if it could work better to make this driver a
>> PHY driver that just redirects all its ops to the actual PHY driver,
>> except for read_status where it should also add some code.
> 
> I didn't take a look at Linux driver but it should work in a way that it
> checks description (more below) and then wait for attached phy to do its
> work and on the way back just setup this bridge based on that.
> 
>> Maybe we could also manage to expose a RGMII PHY mode to the actual PHY
>> this way. Currently, the PHY mode has to be set to GMII for the MAC to
>> be configured correctly, but the PHY also gets this information while
>> it should be told that RGMII is in use. This doesn't seem to play a big
>> role in PHY configuration though, but it's still inadequate.
>>
>> What do you think?
> 
> I stop the driver to be applied to u-boot because exactly this
> gmii/rgmii configuration. There is a need that mac is configured to gmii
> and this needs to be checked but to phy rgmii needs to be exposed.
> I was trying to find out hardware design and board where I can do some
> experiments but didn't find out. That's why I need to wait for
> colleagues to point me to that.

Harini: Can you please respond this thread?

Thanks,
Michal


