Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA766ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AC020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ro65KBCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AC020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbeGWIkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:40:32 -0400
Received: from mail-eopbgr20092.outbound.protection.outlook.com ([40.107.2.92]:36016
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387828AbeGWIkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzkQ2WJyTaphGFAp8P42C+cBfBDJaBB6eqeCvsDTMr0=;
 b=ro65KBChwmMQeNyBfiarLaOAtznzZwsSQ3Z2aWjhoO0lZpqvgD27wb34RGOOSFZXCB5Ip60cIB5QdyV/Crk2LFjyhqsfUeYWaabO24iwG74Pf5pk6D3a1Zc4ijBonI4WJYOx0DL+frKHvy7mWa9UbqI3zYzIDFP6ZS4tW1qquvY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2462.eurprd02.prod.outlook.com (2603:10a6:800:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Mon, 23 Jul
 2018 07:40:19 +0000
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
 <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
 <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <690ed3da-c576-5a3b-e0fe-5bfaae3ba5f2@axentia.se>
Date:   Mon, 23 Jul 2018 09:40:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:7:66::11) To VI1PR0201MB2462.eurprd02.prod.outlook.com
 (2603:10a6:800:54::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a01bb2b-37b4-44ad-0433-08d5f06f8b0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;3:w7tARMWyDI5BYjPdbKk9cJvKnCIr1lgI0c71Vz9I51R3QBLe28F80KMzrrm7ip7Y3EDmnLy/kp8joxz1CerwkStlpRk/9li9D8g5V3rXNQ0PuM6FvtxXr6z8bu5w91MM+cYESqhTnbLaSXFFbin+NxNsGUwFL4CXsr8iMpQmcpRuWzrw34fUSqXuha4iyRRB4PDq8DaC6CMhWLIK9ELo44n4bjU999cxNpCHcrC0sszf0sx5ukuChFzrrgJrHBnF;25:49wGKhH352cLdVALlLiA5wqeZ4wTuDwscXN0BueIi/hp2Kv7q+wl35VGb+M771W6dTbmpPoofets/BH9D9FKisnAMtUS7mxMJp/2xZg1+8R50JoZM+4WHoiMbMpeExwgLJtFWgxumhsxSUKmKizF72FW6SEc5AIhjS4AHANfoM19eas0Ky2AZc4hz7goU0P2lBcLWJ7a9JO78ho51XCjbzMsD63B/1beKNsbiIRq0U11H9pUis8tGaY3j49962OBGW5pvKiVJLJWV4VVU/fUVSEbftHGgoXR/DuQmss1ZDl1am/gzKyXXnXALUJnSR2uHMSWCnbPINf2mFiYeWK2bg==;31:qwxtvx5eUgJwwSVYqK76fTR4DdmAXRoiRzhE3iSpgMOZVsqYE5wDRo/sC7E3WBbzkUIs2YQfWJMeRxMWkMN0TmiczKjlmcGb5I6pchglk6HUXoefOml5+tdZ5FHnfSCvmRPqKNX4qQ97aE7aFYj0kTEYcWN8kMGPuYl5ud2A6dnVW8BE2kI0V1ebD3IViJ6egV4gog4vezZSrWLsVRw+lpNAIMw5lOM7q7mtm5uLotE=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2462:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2462531ABF564B0B49FB4254BC560@VI1PR0201MB2462.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;4:Vzd8wobeZ7efYD87zKqMDE/4Q21BAMBwx0N/nR0z2lGwZgCEczH8c4JJY1a4a9QEKnpuSLtXpjsKjGpo+c9vQcWX0eul/AD7ex/QcZwB1cIOp641f5BIl+JS+c3YgUZKyMnqxIGgD2zFxyxRaHM3Xf0XQ1XDsmTVBfiIPg5MV4F79ylUI29IV5qMxbDoemc8c1kB+EwyxhXRH6xiZ9KABKImNzNO3WFPrRNcPwBl0B6kHHIRYFMZ+vWZV5Hvmj8P2sQBcOUqbSSlxK6QW2Q+Ow==
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(136003)(39830400003)(396003)(376002)(346002)(199004)(189003)(66066001)(8936002)(65956001)(65806001)(5660300001)(316002)(106356001)(8676002)(50466002)(97736004)(47776003)(230700001)(6916009)(105586002)(86362001)(14444005)(39060400002)(16526019)(229853002)(486006)(7416002)(6666003)(93886005)(64126003)(476003)(305945005)(6116002)(2616005)(65826007)(81156014)(81166006)(3846002)(68736007)(74482002)(7736002)(26005)(53546011)(117156002)(36756003)(25786009)(3260700006)(31686004)(58126008)(6486002)(54906003)(2906002)(478600001)(386003)(446003)(16576012)(6246003)(36916002)(23676004)(2486003)(52146003)(52116002)(31696002)(186003)(956004)(76176011)(77096007)(53936002)(4326008)(11346002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2462;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjI7MjM6eUpLZlpmRjdWYzFrMGRkSzRFQ1JxeWJr?=
 =?utf-8?B?bWNCQVBpOXhTK2ZrdUZlOUN5TXFpclF2T2M1UXd0L1Q0aGNBRVY0dmp3c3Ez?=
 =?utf-8?B?Vk8xU1hXRHVFMTBmcWlhamZ2bHhsZ2luV2sweDk3VVZuQ1VkSFYwVXFhUzk4?=
 =?utf-8?B?R1FzcDFRTWRYYy9ZS1dpVEx5TXp1clM4WmJPbUZORWovNk1ZbFA4WW5KdVJN?=
 =?utf-8?B?MHlTV09yMS93bit6WTBpbW56YlVZTU45dGN4VVhRVTJiM2h6dFlGSm5UNUp1?=
 =?utf-8?B?TFFWNUZ2UEt1bkVJYy92MUVveU5rQU92NklhclpNWjVDcDVhVnRwOGVta2t3?=
 =?utf-8?B?VW5mNWhXK2pjYU5TeUVzVUJrY25tUlJsNWgwNjcwRjQzdEN5K2ZaN09KZUlK?=
 =?utf-8?B?Z2xWQU9Xa1Uxc2g5QlY4UUpsZ0hlczlmYXhoaENxZEMzMmI2Szk4WUIxUlBQ?=
 =?utf-8?B?c25vK2RyQitMUWR4SGhBWndRcGs3SVZTVHdNT2dqam8zZ3BSbHBEK2VjWTI4?=
 =?utf-8?B?RUp5cldnNEFlK0Y0dUNwblBadWdrYnN3TTBJU0ZWR2h0S2lsVGVOTkROME9T?=
 =?utf-8?B?akV6OWViK3RvcHc1WXZwVFp1Smswdzl2bFFTMHhwazh1dkEvaEhKdG01N2hG?=
 =?utf-8?B?THFEMCtxK0ptNTZSa05jY0RVUi9aZ0c2Mll0NktkUUo3NUR1L2VvSkhhWkFq?=
 =?utf-8?B?NnRQVmpEc3pwcUVnQ1R6MHJra0d4aHJ0U1RQaHIvVWpzQ2kwSDYyWVNLNGto?=
 =?utf-8?B?ZFQwSEpJazVKRmdJcXh3WXIyV2FvWW5hZ2RiaGVNOG1CMXNjUFFaY3EvWFYv?=
 =?utf-8?B?eGkyMlF3YjBWYjc1cDRQaitvZzR0aG51YVJqUHlJQWwrZ1dzbkRVeXRoZXpo?=
 =?utf-8?B?K3UwaE1UMDQzeVhFRlFzeDRJSHRUbi8xM3FqMVRHODFUS29oWTkvcjU1UWcz?=
 =?utf-8?B?VHJIUnRPQUdNYmNLaHVHSU1mM3dpajFKaGVHTVk1b2pZMGZ0N1JIa2s1djJn?=
 =?utf-8?B?UllvczF1c1VpRmsrWEVFbWRpUWN6bXpVRVB3NFRCYTFvU2VFeEZ4QStMSVlC?=
 =?utf-8?B?NEVFU25DN0JjQm1qL3EvaTJ2bmFyTmNUUDUyVjFJYmZ4NW5jTzhGZEtVNXRM?=
 =?utf-8?B?d0E5TTZzc2ZlV0IrVTZMUjY0Q21FcTBybTZBSnN3Z3EralJoaytTcWJYRTNS?=
 =?utf-8?B?RWZYRTJOYStubGhjQm40V2F2VTZDZ2tRRi8vYzR1aWNKTE5KVGUyUEZlTS9M?=
 =?utf-8?B?ZGFMNG1FeUNBL2J3SS9SRGQ3UXlIWE1SOFArWU1MbHUya1JvL3BFeUZsd2Fu?=
 =?utf-8?B?c241Z2g2RCtVTmh4Z0h3czEvWjM4RXFrMVViTlpIMVBMZjVqVDZoY1dOWFNa?=
 =?utf-8?B?OTdMMnowSFZBQUtsZVRYenFzNUpJZWV2OXZnbEdLSkY1Qm9LUzFBRmdxQUNM?=
 =?utf-8?B?cHVlZ2ZlZHh0cWFtWFQzc2xwRVA3Wk04TUxpQzY0VWsxVldNQ050aXlCdmJw?=
 =?utf-8?B?bWJUYmxsQXBhcDAvZTA5Z3J6VWlZWDYvL1FHSmJXb2hicDJBem1MdVU0eTU0?=
 =?utf-8?B?S2JyRmhCbGFlUWtvUDUvSlUrWXZ1MysxTXFkdHpIRkRVM2cweFJ6U3lYdis5?=
 =?utf-8?B?SjMrc3ZUWlh0QWc1TW9NSWpaMnNpaWlUU1Nya0c0L0lQVU9rbFVxMExHdytH?=
 =?utf-8?B?d2Y2TGdZVzFHbHA2SkdXRENab1VnNXNlYlI2azNMRnJaTksweVJVU1Z6MWV6?=
 =?utf-8?B?cTY4TmU2NDdhSXRacDhBcjVHTGVOMUd2dWo0eDFSeDJtWjVPNTBiOFpzdE1r?=
 =?utf-8?B?SnlmbEdlMmtMQ0VOYXIveFBNT2g1SGZTczRpVEZpUUtlQzg0NklmNzhINldC?=
 =?utf-8?B?dGJ5Smh3NmlpRm9aWEwzK3BHcnd0VE1zSlU3dVJuUlk0U3YvUGREV3k4Y0Nm?=
 =?utf-8?B?ODlJZVVxNjQ4cGNzZThvRnV0V1g5cWp2VHVna0szeXZSWmlsUitobURYd3Vt?=
 =?utf-8?B?ZWdyOUxmWmc0UktRY3ZtWDN1eENBV2NsdnBKaGJqaDg3RVpIWXlCbGZCYW5k?=
 =?utf-8?B?MDhWQ1VYekpCQ2NobG5GeWlGR0Y3c0E4RzVEQVdncVc3MjlKVzY4R0lOekZT?=
 =?utf-8?B?YjEzdGJGZElTV250UHl4WXlrcmFSWS96OXRWYm1rNUlWUFRzdlk0QXNQRkIz?=
 =?utf-8?B?ekp4RFNIZW43V3JJSXA5UUJXQUhaVWc9PQ==?=
X-Microsoft-Antispam-Message-Info: ilMdgRRPxVOR5ytDK/WlDcpHcoOdG1x4I19inRzpGa0szNiihJXckE9JZkOA3fsVuvZeC7VRl4yGQGOi0n1Zq2tSJj5XtmxLtD6nvg3hRaToMeiBjH1mNgFS6mYRYOBoaTnZMmbfX1WCtKbCu0iV+yLPUa+r4dyE6Itjs22iQe1dceugHsxa7naAUWWqEr02CzFC+cW/Dd/VYERZcEOx+sEupKQ9qwMKCaB8JetIFeoo7sKvR3VKxWzR8poVL2Ak95vvZNdn+Bctls+JntpGDiFp7SKPlPPWTQSaIcM6ii9sHE7/egzCKZlCENrczTL3aMzVnyFigbGv3h5xsnArVqBztLvdzV+Ly5s4GfH6Xoo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;6:aiqZ5d1A6DnEdpfj3Jbvz9ExWxn4TrMHVgZ++WNEzA/y+6JQmLkPa5LvIDcgdzjPXOI9/WDP5eEfC7SEZKR6Lw3bVuH7yU+AUyazrJ76zQnvINhwB8sGaa0iuJEEo4ro5/CP6ARYRJuX+jie/2umoNZgB6LgcIFqcBLYMOH3DtMye8wPsCzK9qeg9EwYRAQq30UvqV2BL/J1qfM1l3KGlWrKZPtQMd4vXKpzQl3hOqBV+NfVeYfyuOhb6T17q1C9olzkxvgi1CRhMYAsuPl2pnQZip+Imio164K8iras6ldoq7d0JsgPUOW7RieKjDx8dpf5LSIVm02V54xYRNbvBh/WD7QGDt1L0d1OxkNoxR/uS+Yjz4qWQumM3PhPfTsWsoWOz3GHxR3MOF/t+j1DEqW4zoGKR5clnKRKNisiMHG0e3rcE2yZWwPVpeHSC0M35wDVZHaLzXEUhPQm2cSZNQ==;5:u8z/CSn/QwVocTTj1Ad5sbpl89K0Zr25+ltgE4Nw37IOWbYysfh2KIXl9oCWr6X+O9K88e0h12CRFLlZHLZ77g81StX/nUaj7RswfH7reLe6Basuy2DRxeP73GPr4NXYO58tm4HPqYCGtECUQLU801gN336vq1woj69hSx5R7XM=;7:984IkcjkG/3peyJdB/p8JR9ACfsFAGMBKYcxaLIS6PsG/gzV9flsP/ktxTQz4Sxs66Y/GPYnBUB+1Vind5KhpGXOHfhqjs4JzIqgAWbphLmCXfMXnmyrKQukuoI7acyUKL3fcS4c6/vKqduEyATVnT0sBWnUb2FloTXmE36kCCbGmP8v8cUW+kFqUBAwxslDVUUr40nx1TmH8af60l59NEEsqodEAH49Ea0szoyWIrWU5X3NQwj4PSAPEoja8fKY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 07:40:19.2841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a01bb2b-37b4-44ad-0433-08d5f06f8b0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-23 09:24, Andy Shevchenko wrote:
> On Mon, Jul 23, 2018 at 9:12 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
>>> +             /* Handle the remaining bytes which were not sent */
>>> +             while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>>> +                    OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
>>
>> You moved the OWL_ line to the left instead of right, so this is still
>> misaligned and thus not helping the reader.
> 
> Guys, wouldn't be better to
> 
> 
> while (i2c_dev->msg_ptr < msg->len) {
>  u32 fifostat = readl();
> 
>  if (!(fifostat & ...))
>  break;
> ...
> }
> 
> ?
> 
> Same for the other branch.
> 
> Yes, it's more LOCs, but less bikeshedding,

Says the guy arriving late to the table with an incredibly valuable
suggestion... Please explain why my suggestion is bikeshedding and
yours is not?

Aligning with the opening parenthesis is right. Aligning with the wrong
opening parenthesis is of course going to risk confusing the reader.

Cheers,
Peter
