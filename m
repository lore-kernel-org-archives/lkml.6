Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511C3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A6321582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wliVSikh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A6321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeI0QWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:22:01 -0400
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:38962
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbeI0QWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bRxng4tkRwiFoSnKT1R8x1+W1UjaxKhG+DcIqC3kB8=;
 b=wliVSikhWQ2P21FD7OtTamz3Eev3aX0KN9abH3Xew3cRfVe5/Vpkd6ppR9HzoSuvDm7/j8+JH5l7PCold7rIh8f9shScJYjdVklOrLRnPVhdyMxzH4jfmkzDDgKOvnfsmBNBtOTv3mruzm1sCGkYmZ8lbJYw9KnEL5uvHoXMS5I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [10.20.24.174] (193.144.61.240) by
 BY2PR12MB0179.namprd12.prod.outlook.com (2a01:111:e400:585a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.19; Thu, 27 Sep
 2018 10:04:09 +0000
Subject: Re: [PATCH] drm/amd/display: Change status's type in
 aux_reply_transaction_data
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20180921215505.14634-1-natechancellor@gmail.com>
 <CAKwvOd=PYNbPjK86Fxct=LShqnuRNhX3nih8whyjEUQBULDTLg@mail.gmail.com>
 <20180924222225.GA26613@flashbox>
From:   Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <0840a13f-bd9d-35d1-1bca-9fb0cda32317@amd.com>
Date:   Thu, 27 Sep 2018 06:03:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924222225.GA26613@flashbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.144.61.240]
X-ClientProxiedBy: AM0PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::17) To BY2PR12MB0179.namprd12.prod.outlook.com
 (2a01:111:e400:585a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fbeb400-4b89-47d4-c07f-08d6246092ac
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0179;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0179;3:ZDZABPSsXLBAd2+JHmjHDJjl+wBSRWPuycPj7Oqw7knpBZ9r1sgbaTXC450oB8tVRhLC+4w1rGewaMnRiiW+xxuboSbHB00LmTnucPjQbrIRJqPkD3rV+f25P+dgfPSMSTvYTiqUK3fVfN3l/W2r4ueS2jw/N29WcFUwcfm1czYx/8CCfc1aWTSCqwDq1uAlFeWYDhL/6nHwp0dLQkKT/1nEuHW9f8mUjSLmqvsHZZWt4nDVbXcrAWCx1oW04Ngq;25:uNL5fAfpoqIgd7lu6Y0E36qqsUkobZV086R5FW7bqnUXAgN9bo2gF7/zrWzNKxQzXGhsdaP8yImW0yp43sjFClr3xy6XiUbRPV35jlpHzM0zt9Zry7hzhns4CNAmjnT2EbV5usMA+c/f042D6Bgr87oFDrbUg5P6BXoBo+9AUjCiGYZKVp8BPzPDKdMjWgwrFIUbbwZEx3b2xcqCURjej++DQ7KxNevX5OYIS6vHwhZ29g35LUI6YvvXmG3nKF1h3HvNrNcVXC/z3k5rOq9KCNmZYCSUHcceNdZUF7UGzo3i790ri2gqxxk5wBKBCkf/CgdsOy3g4le2tFC1cd1cpC5BoEFlTOYS9Ha1CVgFi8g=;31:iUhclwLT/dZVQlVOxlqUAPyxBxo05obkRplQ0BzlnkThYaMtVs2HH0tu8tzQCgco9OITjbEOCAKogBeB7kK4f6tvgixRtDQV5TImoB0UTfMgpfCh153nyEmitI6P/ZQ+zdG61H6mBqdQQtZsbLJTxD5dele2J1IvKJfy0gE+qRvZkksb/kC/y4FlZq9XeDEE3sxQBxjpQ6CMFVlUmuL2BjuBkShv8B9QD9MNLWg2Rog=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0179:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0179;20:9xC7/UUs+asOA30kO+oUdZjKQfYGJ+YAvRwK2EZo7UoR6uNL7Fnlg5sX7Hs4YJrUSZEOuwq0ozJfJ1t37tFu8xJCRq3YmSOG7NI8FP6r6EgETwz8JVVokc0IlrG5XMKg/fDLPqmQh+pKvlE3vCe7tGbhdSvmmb8pqXyZa25odV9mfwlvOKSpXh3IbVKmVPHUPCfqmIxiGC0fbi+ZT9DMhZdHkH8so1wOCiuRJi+ZuB+yhms+ms6VrVm+YzV0S/kx9svOun574ESb5Q3gRwMFIa0HjINoDJQkWhyQC3FCmkIesiduvc/n7UmrINg96LqeM3XSCnaxMPoWX9l3/bUVYAVl9xxUYYUWHqal4NlGUe/9f/YXF6otLN1x/it8POj5cKGrkGzqMlxDRtK4suoPSjBcFJfNaq39YWUVeP5j9YooUuLMcmbUt+qq5E97fT41CW1Xt7ap0It34V3n+E2fzuoK4XuJFWwbjinof03Vngo5stya2T8c6US7M2W/srLq;4:CqkukTTvedZs3ABKnfacu0CmIvoH3HtocZV5xHXjfV9NRIvxnnMzuTBK6I0S6vwwXcVVzlHnNCWmABjgvGzxEw0WRsL3bqY90RvSdz54L0zw0COtRLq86Dj4VGUQMCWtYlPsK2Yx7CQHrYtlTcbFur1Ih06hciPL9ViVI1PiRQYSLfc+UAs7y6NPEXaik+9qjd/SlkhQUEzxfbizErw/6zwvSP9CgKC+cDwDDEfafkbTKjE2TRaLvy/hH6FCad32x0v7WlyxZ9UsgMhnX1gJwfg4DzV94xsbHJnW+29MoFxpPEFSBCXUmy0wCSCWPtiPT47aawd7HI4uSWIS24ktW9OWNw22Stv+sWDy/V6vJxNVXi4WlQ4Nn7OWKOZhoQnx
X-Microsoft-Antispam-PRVS: <BY2PR12MB01792C50E76E7B10284497B88C140@BY2PR12MB0179.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BY2PR12MB0179;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0179;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(51914003)(44832011)(476003)(52146003)(77096007)(305945005)(2486003)(66066001)(65956001)(50466002)(52116002)(47776003)(31686004)(64126003)(105586002)(106356001)(34290500001)(7736002)(72206003)(65806001)(76176011)(8676002)(23676004)(39060400002)(65826007)(25786009)(5660300001)(6486002)(6116002)(229853002)(316002)(6246003)(14444005)(97736004)(68736007)(53936002)(230700001)(2906002)(6666003)(81156014)(16526019)(551934003)(58126008)(478600001)(4326008)(26005)(186003)(2616005)(36756003)(31696002)(386003)(956004)(86362001)(11346002)(8936002)(110136005)(16576012)(3846002)(486006)(53546011)(446003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0179;H:[10.20.24.174];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTc5OzIzOlFFRUdyZkt5cnRyNm1HNHlFWUIwSWxzWEoz?=
 =?utf-8?B?NTZaVnZFbUtMeW92Ni9zUklFZmE2bVNERWZpQ1dBUTNKUWlrRTVJeXNVOVBo?=
 =?utf-8?B?M2RmRVh6M3BJek1ON21xakpCTEEzcFZsM2FmUEs1ZUdKWXFPaW9HUU45R1Ev?=
 =?utf-8?B?dW5wVnJUZldHYlE4NTZLd2p5MU5JZ1Jxc094UFdxNldNZGI1U2dSbE1SdjR2?=
 =?utf-8?B?UlNTcjdnZzN6R0k5ZWxaNWNpMXJNZitKSmVFU2wzS1BTRnVEblZIdmwydWlZ?=
 =?utf-8?B?K2RmbHlObGdHTFZyc0tSZDBjWlZPOWtBOTJCYkVBRVZETFRyTGpSd0oxZWlP?=
 =?utf-8?B?QlpWZDIwRzNxTzlXQlgrSlRhZm1WL2xQS1h1alJwTG5RWlVkZ3dnbEFvTmsx?=
 =?utf-8?B?WEh1S1JsdzdQTS95MWQ5RjJMQ0VtSUlOTW1kSE4wQ1A3ZGFWM0ZXdGt3dzhE?=
 =?utf-8?B?TEJ0czRiN01obUJ1UjZyNW02aWM0M09EdVdiQmRzRWtCMVZjWHhRVDB4bUx0?=
 =?utf-8?B?MEt3cXRoWStqOFcwaGxmM1lUZm1oTlpEcW1VYmVkdlVKeE5qWjJwTmZLRHNQ?=
 =?utf-8?B?NmFhTEgyYmhJQTJCdXFxU2hMTmNRNGRHRnZDclRYSWJBRUpXMDBDVWFrYXhP?=
 =?utf-8?B?N1l6R3pnRENlQmNTU25TQWJLYUFqV2poMXlIQWpHeG85UWhCYXdINWExaWpv?=
 =?utf-8?B?N2VWeTlSU2x4RkNsOEpYZnV2dzV2aXZtaGtzYmxEdmk3ekNXb0Zhck1FcW1t?=
 =?utf-8?B?T055M3hOUklSYlBCUHFDS3piY3o3OE1xTkZaVzNtbFFlb2JzdzJrZGFSaEZz?=
 =?utf-8?B?cTVxVVY3VkZGcGZSenkwZDdKcDNwaEorMWEwbXRJY0E2UVczbW9SZUxXV0N0?=
 =?utf-8?B?bkh3RjNYeHlYRlBFK3FKK21oYXduMldIM085TFo3c1R3U0ViTnBPb2hsYTh5?=
 =?utf-8?B?emFseVU1L2xJNEJyYzlqVCtvWXdYWERVQVdZQzlRRURNQjdkMjZDWks5bzA2?=
 =?utf-8?B?VERxREI3VzIxUDgwMjZmeWNLYXhGNVp5VlltZUlXRGxiV25wM21pczVsbyt4?=
 =?utf-8?B?Nyt6a2xSYklRckQzMUMzU2FXejdkcmFwdDNWbHo0YUpJZitmblpvYVozYThQ?=
 =?utf-8?B?NGcxcW04dGFmeUtoSE11dXdLWnd4SG13bGhCTE40SHdrbHpuaGRBTmVOb0Mw?=
 =?utf-8?B?b204WDQwSUNtc0lQM08xSlBNZzZEK2NyNksyRm0yVlZ4V25KZUg5TTBPK1h6?=
 =?utf-8?B?SExocXBSS29HTlF4RmZwRStrNzlneHhuMDk0Y0pGQzMvckkzZkk4aWVZSzc0?=
 =?utf-8?B?N3FBaDYrNUczN3ZhcE1RNVZ0cUVNVXUvWitaSVl2WUZObXd1YW9IRUxZekY2?=
 =?utf-8?B?WW1WS1lXQ2ZsRmp4cWpsb3FSQnB6Qk5yNWhCMjU1eEJQTllWSGlVd3plR1o0?=
 =?utf-8?B?bWhzcWlvMk40S0pqSWdyTVRoWE1zaFgyYmlpUzRXeFQwVzloL0lNaE5WRWsy?=
 =?utf-8?B?OTJlbmJyamdLVHBxZ0pDRGFXSW5Sc3dwcTNCUVpoK0R4SkN4RUdNdGxEM1hU?=
 =?utf-8?B?Um9JUTlZREVWVnUxbkVWWDIvVDV1N2ZYdm9uRk1sbXJXL1VBUEZiOTRuVFNx?=
 =?utf-8?B?WWU1VlZFYkI5NmVPbW1KMjc3d29vcEFXcHM2MWtBeUYwQ2pBYVpqTWpRNWp4?=
 =?utf-8?B?eExXM3Zudzk0cjgvUVFFejhIb1plSnkyZFVQNnMvVGk5RDlLU0pLbkxVaDFT?=
 =?utf-8?B?bGpXcFhaSzNkUlA5TmpTVHpzT1NKRWdRdGJEVlpCOWl4SUFNc2RQbS9OMWFt?=
 =?utf-8?B?QWFGYXM3cFZBakNTd2ZBaXVyNENUTjFOd0h5NzFEeFpuZGlXNllJWlg2dG5v?=
 =?utf-8?B?KzlPVW5XN0VFNndKeWZ1azB1bERGeXVZQUFocDl2ZVkvVk1IbWhLOUprOFM0?=
 =?utf-8?B?R0dYUGxoays4L01OZXBWYWpKUkRWcWE3ZWwvYmUzcWJ1K1laaWdWUXN3OE55?=
 =?utf-8?B?b3ZBU3BZRWQ2TmY1UVFLRkltUHcyaDdMaHBBRDVNakd5VHJrUzVDN2dHbnpq?=
 =?utf-8?B?Rmt0dmJ1U0pFT2wrNUFqYy9vdGVEeFVLTmJ3UHovaWFnZVpMNG9vejZGQm5z?=
 =?utf-8?Q?vL+W/jfpg+WAQ1xqETL2BNU=3D?=
X-Microsoft-Antispam-Message-Info: +24sKRKuqvwCi4xo/p9Hd5hv02jdyhV6R+5sQ7IfkHDqxHb/T72+ON4yZuiGGfSLfOkhOCBo6JrxllMcV4tEshR5RELQexv1HovC/tbNh8EZrNt94JXe6wUqwH/3CCLrOA0uZBx2yOueO/D8P6lZ+7PgRSxIx7V3usJ8+tduBTPUNW3qR1vTIy+fp886R/uvvSuRgNNJDprF9Kw7Ijl5KRjkAs0uKqht3Y1Y46U5Kw/Ndgl1lTkOiLWPHMAwyTnIFeyl4KS1ubmO3nMbkcs2atnfMP1tC2EdhhXsJiTugpRJdrPNGOY0CpUT18oXYVeEDHwSOTdvv+yGw3YA+3SqqI87jQsTddGxQ8Tz9EMDHG0=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0179;6:+T40Tnu56G7nJ4c+pEXkS6tr1Ffup2bfqSQGA46R9C97anTW5Ed/Fayxg9U8nA/mNWrRo5Q9BBrfPBgXCKhw2SGq7zS+LgVS1RbjUBKMr37E07ENnP5mIvOcI3LQTZgS69AswDxak07L1llMHWtWYhg90u4kelzYvZqcx3VNiOy/YrtSHWCD2mebKVINa9gu5WesRT9Z6D79FojhhYQLAF8mK6Il2/DjnYTlozOZ4VsaBQ+xmUVZ3zIm5RXf0w7e6QMkYLgzJ68h2tvDE5gAm3LBSBfRJuXVnCa2oayYeAK5FfDs0E3ozIJn1qOBFltvVFU79JlGzLsBHB4Gzf9bKVCViYmar32YPt5COef/4DaMAig0I0456DTAjTOH17lnTtGdJnUraS7Z9oB3smLxY1iWHgFE+O8dQYu4m8AFcS4LAyZD83rmfMyBjjawJG8TVOMLa31JncfWNR3tLm/4Og==;5:GPR8VuIp4eSAcit6JE3oVi/lNH135iTqw8YHTIfUTLknqB5iAjKLnT3Pf7LrpLJe4zBs+g+DGMb5VLJ4wlckRqFacfS71zGekH+WOoTGmWKMa6cVQ1sP0jKw9tvgMyGGuvjpmaGPW7BtAoA+AUi65tt7dzLGTGyUj4o8Qm4TdFs=;7:1A7ZV/Xj7pGALw74Dz7p0Rr/IxF35oSz20kiG1/LLs67YH6WvRp/5yAeZY1NNtsKmKdpN171pMsgVSvujBuujzBL+VH56o1w6kYedL0r5tA7JuA1eyJB2fPhbwwQxTwEZnF4CZWUTpKowu26MLr8W4/iVwoxIwYVGRfuXdVRL79QQTetUXBOeTI4oV0XFyvo67QQ56NBR6yyOG/gIfCEBK5uBYREuuUqibYCnwFvo1ERIwWaBOogwGHGhr9IBbPf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0179;20:x+FmgpNcp//4HLsp+G57eI4OaSvxq6HatUajufmp/b9w7R2gqTeAsM/4/uDhwGH8Ml/BfzUOYSizCdIjK35JI5mk0XMVZ+UD6sUnv0hLoZ6JWu5N34DbjIhg9DpPYvgu6BZ8T5DXoCfZXGy54ywpJa7QaxxknLI02rjg2wUpzjDkXxEYzrUy7Y5Cm1QaYUv/65glGGd9yTlH0vU8FnrWy2wCPJhJ0IVgfi0XlYNagmy3F3SENHJ/GvePviu4Q9TN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 10:04:09.1069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbeb400-4b89-47d4-c07f-08d6246092ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-24 06:22 PM, Nathan Chancellor wrote:
> On Mon, Sep 24, 2018 at 03:07:16PM -0700, Nick Desaulniers wrote:
>> On Fri, Sep 21, 2018 at 2:55 PM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>>>
>>> Clang warns when one enumerated type is implicitly converted to another.
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
>>> implicit conversion from enumeration type 'enum
>>> aux_channel_operation_result' to different enumeration type 'enum
>>> aux_transaction_reply' [-Wenum-conversion]
>>>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>>>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
>>> warning: implicit conversion from enumeration type 'enum
>>> aux_channel_operation_result' to different enumeration type 'enum
>>> aux_transaction_reply' [-Wenum-conversion]
>>>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>>>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> I think the enum is actually wrong here.  I think the correct fix would be:
>>
>> -                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>> +                 reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
>>
>> The identifiers are so similar, my guess was that it was easy to mix
>> them up.  This looks like an actual bug to me, since the identifiers
>> have different values between the 2 different enums.
>>
> 
> Hmmm interesting... I will be happy to send a v2 with your suggestion if
> one of the maintainers could confirm that to be the case (given DRM code
> is rather dense).
> 

Nick is correct. We should keep the enum but assign AUX_TRANSACTION_REPLY_HPD_DISCON in dce_aux.c and aux_engine_dce110.c.

Thanks for spotting this.

Harry

> Thanks for the review!
> Nathan
> 
>>>
>>> Instead of implicitly or explicitly converting between types, just
>>> change status to type uint8_t (since its max size is 255) which avoids
>>> this construct altogether.
>>>
>>> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
>>> index 05c8c31d8b31..97e1d4d19263 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
>>> @@ -79,7 +79,7 @@ enum aux_transaction_reply {
>>>  };
>>>
>>>  struct aux_reply_transaction_data {
>>> -       enum aux_transaction_reply status;
>>> +       uint8_t status;
>>>         uint32_t length;
>>>         uint8_t *data;
>>>  };
>>> --
>>> 2.19.0
>>>
>>
>>
>> -- 
>> Thanks,
>> ~Nick Desaulniers
