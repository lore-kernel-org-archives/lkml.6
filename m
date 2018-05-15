Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeEOGCV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:02:21 -0400
Received: from mail-ve1eur01on0041.outbound.protection.outlook.com ([104.47.1.41]:49856
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752054AbeEOGCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:02:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH v3 4/6] ALSA: xen-front: Implement handling of shared
 buffers
To: Takashi Iwai <tiwai@suse.de>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-5-andr2000@gmail.com> <s5ho9hi56ds.wl-tiwai@suse.de>
 <e37b5170-4fab-0c06-8902-730e57118ceb@gmail.com>
 <s5h8t8l5ufq.wl-tiwai@suse.de>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <19a2c003-6730-265a-29aa-1eedd37147b9@epam.com>
Date: Tue, 15 May 2018 09:02:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5h8t8l5ufq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.54]
X-ClientProxiedBy: AM6PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:209:15::31) To AM6PR0302MB3206.eurprd03.prod.outlook.com
 (2603:10a6:209:16::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0302MB3206;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3206;3:/Ie4aOHceksPshKBEv1DPQzmbV9j4osLJcafcpHQZwneMr/h8qt330X6U0fy40MqRVUvl6BgCHVKcz1/ebhnpueSX++JtLNu9JDnnCCSESMbp0JEYpyy3CY9Vy1pmGXzkrt6KAOe+HCvVNS5WvwUyAw/5pBBEzp2SBKwfe6QH1vwvP65DReOoDQkmBfKXnEiKfYsKHyPhnltRT7I4F607mB4E1UA85Y3KyCDiethvfNxztoc6Xxmn9gn1eWIoSil;25:+6Pt1aJTD5Fw2J+phI5j8USHKf+25o2YxksR7kuEm+TSdvoO5LyEvNA70ZxjxslfZgy9SLEuxcxvivArDa2ojsvWvTwhfa33g1S9jSHzksO3QSrDSQ8C98g2Q8mw4R3E4d6fwSlGmOtSQCsguUxTQCc5Qtp5Fub4SQ3d9dGV1+937HEdnGgwDVNU8k+cgpYNR+fTkVYLS4Rz0W1s5yQcMPliF+S2Qc7MDJqXBuFZQRCVb+H/7DHo3Y8lLTEauStg9SAZ5FokZm/ceC+KU9dFcvZxRsCSSwmX3EtN7dGu/N53K4+wfUh3uNSwhwoz1Z5BG7OeXhGTYj8Qj8IbHRqmPw==;31:Zhcmj+IYS/sofabnHr4z9xvzt0HzT2Y0TbSbvgpfUk9KfHhQivATPZLulmdp62Rkk+OsLqE9RCOrJf81kf0xmsLViFABlJX5vUWcbIgn5Wwilj0pbZqZLKwbP4uw6IfdeEe8bNrtf7PoN/b/p58kL6SNFeCmhbR6BwcBaT01LQmnwYtcsQWokO8Ijd6k+LwIrbiBKZ5UXKWiH357ejAvAewhYlyLqmym2giAZNxV4s4=
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3206:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3206;20:7mseBpivdtU5cLWuD2J1j8F5Qk/OiNSEGeSsOwVq4+aVEfYp4qHxalfyMNiHTs+BLlHIxyfeTnsTd6rFwvcG3fuOneoXzNSqcIurcPeRMzrXCFV7MWeVpeY2ev8yjUJ71UWY/LfrXGU+QXcBIBliIFSn3i4XZhMrLEFfhMXQe/bIrXF9xHKtmSM0S2oq61mlpk7t2U/ejE+DsDsc2Hiztv4i76f7qyTCgVqFPQftbydB3CVpYDLYPOvoMvBGltKfYXCM6t6DMK07zKr2lNXYp6eJgspBmoxqmaIWR2uGMnT7odSHaDF0TQLgbTu7btl8OvZlxMZc/xv5StJE1Y1qu0jUZK5JvDFYbxiaZA8gG8vgIhk1jakKRFts7HbVKgjd/adUUiP4erNVdWCOGbx+y8FwnOIUgTm11ZP1U8k16CBRXDgMTPTdmTERjpT45lbqR7lBBf3iQ02ZFCVlHhHetVIDxzksHALGA0eVF4cXtzuB3NLcftC6DKHiDqgXE+IC;4:3ad8PUwKiQZhbwxm0oMcMRaoXk3YFIgmCYuti8BaJQdjUfFFe2s5BBt/REJv9vGZOD8RjUqj5r6Zv4+mQU9dkd9vJJqV4pddlWcdN3lJ/OSfSrVEigAO/QiAZMqgFbYZ+XS1vsA/nBk3Jr1U32KR0pGXPsbA7X32hX4vOKGpQsGOMithl31jCEYEplBbMmE+nCor7TUnH0lHzc5tAWZU9ESfaM/FwfgiVx7zmNpA4fzRtFrcI8Mskl6YANskUVoSb4E+bvqlnZhtjLRKozuIbY2njSlU5KPsnBjjtOoJwB0yuCJo9dLPZg7Rltw7nvoT
X-Microsoft-Antispam-PRVS: <AM6PR0302MB32065858F1F049CA2F4BA4AFE7930@AM6PR0302MB3206.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM6PR0302MB3206;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0302MB3206;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(189003)(199004)(305945005)(31696002)(86362001)(53936002)(6246003)(11346002)(446003)(476003)(64126003)(50466002)(2870700001)(956004)(31686004)(386003)(53546011)(316002)(39060400002)(486006)(3846002)(72206003)(93886005)(8676002)(2906002)(25786009)(478600001)(47776003)(77096007)(65806001)(26005)(65956001)(66066001)(58126008)(16576012)(2486003)(23676004)(52146003)(5660300001)(105586002)(4326008)(80792005)(6486002)(6666003)(55236004)(8936002)(65826007)(7736002)(52116002)(229853002)(97736004)(81156014)(81166006)(76176011)(186003)(2616005)(110136005)(36756003)(67846002)(106356001)(16526019)(68736007)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0302MB3206;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjAzMDJNQjMyMDY7MjM6OGorZzBTaEo1Y1BPZWJUVFJGZmdoa2tv?=
 =?utf-8?B?SjRSNUNmTzB4Z0JuRk4yaGJGVXR2MFJEVDMrVzhnTU5yaFgweG1rOURMd3M3?=
 =?utf-8?B?Z2JlMDBBWXhRZ21NeHlObzVQZmhwSW01NTU3RlBZZERhVGN6amc4R1RaNE9p?=
 =?utf-8?B?K1RXK1dXSUxrMFNKcEFhRitxNHcxL2J2MWZ0eTRuc0x6MDZnQ3FIUjgrTmZJ?=
 =?utf-8?B?Z3BDQ0lOOEx3M1FEalVKNElEQk5Fd0k4MDNXVHFaRkhmZThEbjdILzYwVWVH?=
 =?utf-8?B?YlVFbXZuQkRZeU5wVEdkcmJmQ2VRMi9teWtreHRzeU1wQnczRE5QK2cxdUZO?=
 =?utf-8?B?YVUzdHAxTG83VVYvdU5QalR0TW0yNDUwWnFFOWFpRUc1QVBjZnYrQ016dmRx?=
 =?utf-8?B?dEh2aC84bzRZUmhtUmRSOTBhVS9TUVV6SytoLzZPQUE4ajlJNk9mZDduVVQr?=
 =?utf-8?B?SUZoaDhDN2RzL3NJc0VXSXE5ODY1UksxVksveXhpSFhRODdiTDhtL1IxYUt3?=
 =?utf-8?B?SHBPai9FWnlsZHJJc3lHaXlZejFPaCtZYVZrZFpOQmIwSVBiRkNZOU92Z1Mr?=
 =?utf-8?B?UTZKM3NZbDJEY0M4TENDK2J3RTZvdTMzVDlBdjdqbEVlZFZtS0lVQjFtdzZh?=
 =?utf-8?B?bFpZeHlmem5zZGVHSmVjZ3JYVlN2cWphdU1RZUxRbjhVc0hRVUllc3dFeXR0?=
 =?utf-8?B?NklNSklZYVZqc3h5OTdzSkNhbENnanNOZVBrbjg3c3cvWVNQTmczVjNaRXdy?=
 =?utf-8?B?UVJXWW03cnJJZ3FLWWZtRTVkbEwzWmpkd3VTS0FTTTVNbjZGbWV5T09WYUpP?=
 =?utf-8?B?N015a2x5YWxXVnQzOW12N3BHMlBKc1NyWUdqQitYTXQzTlpPWjFRRGkwRDF4?=
 =?utf-8?B?N2FERENUSkNpMnJWT0hJVEdFdVZkVVMvWWRSV1h3Rmd3ZzBWUzRIVTU5ZUUw?=
 =?utf-8?B?YnhYK3JDVHNYSUVJWjFrRVNndDNsRmpqRjQwOG5VK3NXUXc1NnNnYjBDcWQ3?=
 =?utf-8?B?VFlnaFFDanlvaVVBQUlxaG1QZldiZXp1RWFWZ3VCcVF3RVl2eXUzeS9XY09m?=
 =?utf-8?B?dGY1S3IwVFZkSGhUQlQxVWI5OEJJcmd3VmJLVERGSldYQkZsZnBWU1crc0Qy?=
 =?utf-8?B?bEVEOStZa2FSNE84U3dmaHZLVTdZajYvTkJUeWFvSWV3UzBiUitTaEtWS1hC?=
 =?utf-8?B?UjVCdElVOXh3Si9uanJNTm1QNmNTajhxMDFZcEZpdUZFY0xQcytyZUVyU3hF?=
 =?utf-8?B?Ym5xMzVPbXQzWkpaazNDaFg3QXdDbmcya3dUREJ6VGNFakkxLzhwZ1lCZzVJ?=
 =?utf-8?B?SitLUjdHUFpIUWMzT1dDMVdzcTBOY2lhdTdzbjdLQzVTMm13TDY3OWhrUnVV?=
 =?utf-8?B?WXBqQ0tqVFZsY1U3RUFxZVAvRUdubXpIN2wwcFJwMm81eWNyejhZL0E3SSsv?=
 =?utf-8?B?UHpWNlhwNU9tT0t5UW45ZlU0OU42N0lxZ1BSeURGa0FBT1g4azJjbU9raGF1?=
 =?utf-8?B?OWU0WElUM0FwYzRYTWVSZzhzUVBmQmJZOFlob3ZaR1VxWGtGYUhLUnRwVW9h?=
 =?utf-8?B?UHJydjlaQWZXUVprSUNUODA4anl1VUFaWk5kMjRML2dQdUh5dmxCeVg0Zldr?=
 =?utf-8?B?OGM4RHFaclkweW5NL3ZxdHZCaWV0WXFxVEphY3ZjZ01wbDdpRExNekp6ZWZa?=
 =?utf-8?B?RTVRZjFtYWlVWmpkckFSN25vTnRxaG9VRjU0ZnNqMGJoUDJnWjJCc0poZWlT?=
 =?utf-8?B?dkdvdGUrNGtGdmE4MUppNU0zNjJsTnNvWWxPZ1pVbThDdXREdVQrS1VXNHNQ?=
 =?utf-8?B?d1pMc1hsVjNSWGJZQjd0Qjh4K1ErTnZ1OXpmVkNoeitvZ204L1BhVCtlejFl?=
 =?utf-8?B?U3RxblJvNUVJSmdjSnNxdklkSHJpY3BIaWdWV2VaOHJCbms2Q2lrT1E4dVlo?=
 =?utf-8?B?ZXlTY3ZLLytuVnpVa1RrZmNvWVNkaytYQU5CVWp1SHlCcGJWT1E3UUczTzNE?=
 =?utf-8?B?RjJpbDBuSTRjOTdOSWNLM3pCZ3FTQzhCR1N4YzQwbVFzMmZ4aWVIc1FmZVZW?=
 =?utf-8?B?Nmh3aWRySlVRc29jMW9RRTM2TkNKUy9pUExWNk5XdmJBNmdOS0R4WXlDNkVI?=
 =?utf-8?B?U3Yydz09?=
X-Microsoft-Antispam-Message-Info: 8BTOo/r3vSONIABAVR645b486la/QO/vc+dfiUgA6BkF1p19bUtFJTjt/n2mk3IP0jzDLp4FhG+AH+XI28jVSaIWR4KoMiXpmJNPE4eLyFSyUDUe7+P53Q4BezNE0zojaAmmpHZEaA+62NJrP13QFO/sbs/A9OtlKxM8ZraXODAggEG/3Tl9qeNCtv0t3tAS
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3206;6:DnmIl9BphkNT7nNuDYfLCpbt3/imIFrvh2lSbP2oJ94id/KlfEY7V74SDI2yySKvluBJXXcWlYAvUizSH0wgMz0icuqrc9CVminoURxgwOVQTMyJhG82qq7IW32efEYelmiNcb0H2U8MtfDiJlhHl4Rjd9pZLKNxAvdfAoKzYroLbl36GzzVW/k5aD6W+lPiTJal2Q5g9EexUuekEXpCf2CAcHeRf5l9xc6ntGoY4lsCSOpijxYMQ5ZENawBESXyqA4HA8RI/YdsOV+FYgfRdHAOPQ3Yx/oWU1d3PcftCPK2QdWcoHsiyk38GtTefp6VythOmZUWzNOf4MR7tEEJ5xNMME4L/vjaSYLwSLxE/aaEHoDh1q2a2IOazjv9E/j8mFwItOK+kTpJuaE5/tOFwJnQqm8oJg9RFSyIIbGFltJefB3A1g+WZldoZ9XgZcirsYKdpWGbyfMzkuJ2jq85KQ==;5:YEltNZmyMZiu1jRAMwqCQvJC0eMmlqlFf/K9n5msgTp9baRKlllNz5uUqzENI/So3m4pNPFE0ViJ5HujLrH1HGz0XA6pVuKECUMKUARwwcIolqGldHpI2kQK7MgPz6baBqYx8SnEOoXudVHXi6p2YiUNHoKi3eRXI99hssS/h6U=;24:uW4kUyg4Ok5S/0N6KxkYMlm7RJTt9gS9sEqwNekFqt2+B8t6c9ZOXgZFVz40gvhKDtf/DXrY+2xaLqAnJ6kZEYphcVxlzZZqIguezRIKSf4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3206;7:QQALUD0swheStfK5oortiGGZ7bM/bzbTwh2FRzWFeIXnzUOaqZ+1pwmqCwlcoXWiEhMFTwYnedqQa3Nys6yt75yQB7OKBI4CVgr9+xAnanZTC5xTh36AlLs4UCEtydK+NlLIvytczP6At8ycPzqtCQbVNV5bXNISLJUkndbbqp8qzQXSiVUeBr/1az+Vx4kmxvb7dMhvFJtCG6SloNozFEFc2ZNF5nw3quC/IKYMymtywy++Ot/nON24ApcjGyEO
X-MS-Office365-Filtering-Correlation-Id: 3182fa50-d542-4602-ac6f-08d5ba2968c4
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 06:02:15.2250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3182fa50-d542-4602-ac6f-08d5ba2968c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 09:01 AM, Takashi Iwai wrote:
> On Tue, 15 May 2018 07:46:38 +0200,
> Oleksandr Andrushchenko wrote:
>> On 05/14/2018 11:28 PM, Takashi Iwai wrote:
>>> On Mon, 14 May 2018 08:27:40 +0200,
>>> Oleksandr Andrushchenko wrote:
>>>> --- /dev/null
>>>> +++ b/sound/xen/xen_snd_front_shbuf.c
>>>> @@ -0,0 +1,193 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>> +
>>>> +/*
>>>> + * Xen para-virtual sound device
>>>> + *
>>>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>>>> + *
>>>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>> + */
>>>> +
>>>> +#include <xen/xen.h>
>>>> +#include <xen/xenbus.h>
>>>> +
>>>> +#include "xen_snd_front_shbuf.h"
>>> Hm, with the local build test, I get the following error:
>>>
>>>     CC [M]  sound/xen/xen_snd_front_shbuf.o
>>>     In file included from sound/xen/xen_snd_front_shbuf.c:11:0:
>>>     ./include/xen/xen.h:18:8: error: unknown type name ‘bool’
>>>      extern bool xen_pvh;
>>>              ^~~~
>>>      In file included from ./include/xen/interface/xen.h:30:0,
>>>                       from ./include/xen/xen.h:29,
>>>                       from sound/xen/xen_snd_front_shbuf.c:11:
>>>     ./arch/x86/include/asm/xen/interface.h:92:21: error: unknown type name ‘uint64_t’
>>>      DEFINE_GUEST_HANDLE(uint64_t);
>>>                          ^
>>> 			
>>> Adding #include <linux/kernel.h> fixed the issue.
>>>
>>> Did you really test your patches with the latest Linus tree?
>> My bad, it does build for ARM (which is my target), but also does
>> need "#include <linux/kernel.h>" for x86 which I didn't build this time.
>> Sorry about that.
>>
>> Do you want me to resend this single patch or you can make the change
>> while applying?
> Yes, it's fine.
Thank you
>
> thanks,
>
> Takashi
