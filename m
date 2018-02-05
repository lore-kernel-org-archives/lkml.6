Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeBEKbO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:31:14 -0500
Received: from mail-db5eur01on0107.outbound.protection.outlook.com ([104.47.2.107]:20514
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752324AbeBEKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:31:07 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] ubsan: don't mark __ubsan_handle_builtin_unreachable as
 noreturn
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180202154813.1625742-1-arnd@arndb.de>
 <d77f9a8a-0bb2-50a3-68e3-b4f4173645bc@virtuozzo.com>
 <CAK8P3a124Jdza9YbgOHECC2owpx_HmOuDMWtotxuC2-F9L9Cgg@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <00813389-daf0-a97f-8642-cb4e7a62fa27@virtuozzo.com>
Date: Mon, 5 Feb 2018 13:31:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a124Jdza9YbgOHECC2owpx_HmOuDMWtotxuC2-F9L9Cgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR1001CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:55::15) To AM4PR08MB2818.eurprd08.prod.outlook.com
 (2603:10a6:205:d::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a007c6-20f4-4f0f-1ee6-08d56c838fa7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR08MB2818;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2818;3:CrSWq4McBw9auS2PGBIXcwo2Q+WNyzmVEYhEtAEwa1cTqSUA33haJHH9DoDAsjqSNlm4koqrb/kxzcRfsdbt23/TGrTIvxm8VWcd2+zuJVnvNogdZkVCvmaSk8SXRgH5VkH14aFZKmJYDTrjFDt0Wz+Qi0Ju7hdff8lxxhZeuXV0BzeEhIh6e9Tg/LlZA8+N9gCErqiWsL92i2Bnpa2QKCdukprCjakRQxBDbw3kkrR2JQuy0MbXjOwp1lqOupIz;25:kObpZ20ntfJv2r6ikfGY4dEVBSCSSPtzkVtdLPN59EoQbPHepZOqRIADq3cKoGhj4XkVHMnFn/QqdlfTA2HWxGPbiJtC0mtOzS5GMNQKS4jUfMiab+spVxjfc6nJ96qG3jb9OHeb+cUQkvyq9a8myfKWACblJU1kT+R4q3NG+CtYTbDVeE4+tEdNj1TUs6AX499fM2BHAVkhD9Ac6xrbaTU4HpG/+b1oQZPtYGZOiwIc98zRcw6rl9mJBFUxB+KQY8v+VJzmPqkzf3Xqem2qkg4g9XTvlX9PY2veRXmIg9CQcl2q/AgGKZXr3b+8KyAqCeFrIYBesLHmeATqkEoHIA==;31:dL4fnLlg2nXZ8wuo2A6t2mUFzYZdjIAcMn0XKOIzUjEHKfMCEPlFxmgRp80i+KzB+WGRV5at5ClLMr4169n7KTToY39Clb59r5QY9nPXDziPT6K7JvB+RAQW3XPHj95Pw39BIL1YQbQzkZCPf0cnck9K0jN10S3zH/Vka1u+64sXhqYQgOpk7goA7oPC0j8UyaOlZIo/nAULt+5uAe6NhwZACpviWcNQc+DJIh3BGZ0=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2818:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2818;20:WvXtv1NYVvorPMxiJ340iqDhfgOZqQrhCAXmxPXUJVQg6KyOCf9U8Ud/9wOSzzaAm4HUy1APOP5dg8rlAzcB0jEFyWzYQL3dDnV6+FEPGlimwD6Hs5ky4DSrHCqdmQBDb/9mIZZabbKyFB9CSEh47B7piwcBcW59/0dxaaCXq0HhwDtGyOuPO6hKr143Z1PeTYKWijtTtpincLPjeaszNc2ysRRJIHBk26an3PVyHVJXXD8dUBu+Zthe5h/5L8+HrsCE7D+DCk3m7LPFgkLqWoPz6yoNiyZg4dehHcI3KI9wtQgXFdXh1yxJ1USkjAdL7qFTp7OkBnpCDgyrKdbXZ6Wp3ICuOzD0AvjdkOZue783H4qZKZHfRqdDXgbvEWj34kTyuyuEv/nNG/UVCGkhpAJVkS50BVAnAKmvZIduqQY=;4:xd8GrnhAZYI0PZZY9MBMyTxTCu6Mq9Ymqf8diI/Jb5nEDsF6s+XqrCaZ2+Tlz2rDzqH4VcM1yq4OjAHrUm+Uur+Amf3qnDIJbxcw1BzxoioDoY0E8H/yCav2cCc1ZFY0mjhV1j6IpX2qu6MQpOX+Z0iOJMYsW/+CBZW5CGbIHkJ1m2BWL/dAtTX00wm+F1MXXwwHmQaN00Tr2rXXWEcpJvWWmsOoZiexAgT4KibaQ5iD1XT2AZdQcG6se1+gM/qoS/Ojb/ttykkU52baaLqHGKC7yuh2GY3vg17mUUqacvaF/hveJKvQ/+HM4mPgc2kE9ceeDwxrNICeiPH6SZnvlYRo5IPvSIoQD9wHw7/xbfs=
X-Microsoft-Antispam-PRVS: <AM4PR08MB2818EC083E0B36295AF9C153B0FE0@AM4PR08MB2818.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR08MB2818;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2818;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39380400002)(39840400004)(346002)(376002)(43544003)(199004)(189003)(229853002)(106356001)(31686004)(23676004)(55236004)(2486003)(68736007)(76176011)(6486002)(52116002)(52146003)(53546011)(386003)(31696002)(53936002)(7736002)(316002)(54906003)(58126008)(305945005)(36756003)(105586002)(16576012)(50466002)(478600001)(64126003)(83506002)(6666003)(6916009)(2950100002)(5660300001)(66066001)(65826007)(65956001)(65806001)(6306002)(47776003)(26005)(230700001)(966005)(8936002)(86362001)(97736004)(4326008)(81166006)(81156014)(186003)(6246003)(25786009)(16526019)(3846002)(6116002)(77096007)(8676002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB2818;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA4TUIyODE4OzIzOk9wZlpNTmtQRnBNdENnVFVva21FcFFkVWVm?=
 =?utf-8?B?eGxYTkN4MVhnNnJEVkJGL0lFS1Bzbjgwbk95ZWhCNmpEUHdkT2tWVzIyWWZa?=
 =?utf-8?B?eUdnWko0Q0tveVR6NnhqYVFhS29CYTZqNU5DQ1BVSzRGcW5EcTlMdGZRaktI?=
 =?utf-8?B?aE8wZDBjQWsvbDkyZmdESEV0cnZYZDNiTUtCVXNGZ1kwS2IyMHVnbnhkVW5C?=
 =?utf-8?B?UzdwRkVhRnpaM0czanZINXJGdEFaaDI2U3MwYVIxV1RXY3Ryd0tjQkdkMisw?=
 =?utf-8?B?bDFaYy85UnBRWEZ3a0JIVndGUGRDQ25sZGhyWC84ajJMN0kvOG1sNXhDbEtT?=
 =?utf-8?B?RDBSdFNZaFNsWVFFMkZzWXEwRlFmbGpyb3NqZS9YUTVYSVhBUlkvY3FJemx5?=
 =?utf-8?B?TmRNTWVSenJ1Z29vQzJsU1JoYTJmeVZHSU1JbC8vVExVbVVDUmJyYW5YVWg1?=
 =?utf-8?B?QjBWMEl5WmFqaW16Mm1maVZVN1FUN1M5UmUvM2tpWk15bjFnLzRsaTg2WUlL?=
 =?utf-8?B?ejZNQ1d6OWtrcHVHTTR5V3loREYvM2JMN3NjdlZlZE91YmhwYWpQeG03TTVJ?=
 =?utf-8?B?RmlLL2tOZVRqdHh5anJoZzNFSnA5WHBpSzQ1ZHljaUlIRkYxbmExS3BmKy9M?=
 =?utf-8?B?SUl3WDZsQ0xzTk5pZjl2ZWIxbTFIVFZ4dXBQYU56SkdJaE1Hei9la0s4NWxs?=
 =?utf-8?B?ejE2SXpKam9YS0M3TVJPRk1kMkxVRU9qUEFpL3JwdEtlWTBQQ21uV0Q4V1J1?=
 =?utf-8?B?MjBRQW9KcGd2bVJsY2dQM3FOZGZXTHZubUZTSGhBVm53b08zbHg5ZlNOTjZT?=
 =?utf-8?B?a1liYzJtcDBwZnVhTDdTTHlReGdnVVVIb1ZCcmEyOHdiTmRKcnRjdkc2ZnAz?=
 =?utf-8?B?Qkg5MTJydm0vZ3BlM2xKa2k5aVpIZzNhNE5vcnhpYVJDalh2YXozVlB3b3Np?=
 =?utf-8?B?Z1VXNUVpWVZJVE5SK2RDdnFjSTdwbnlNSndqTGxUT0Nrb3UwSTQxbE1hSWpP?=
 =?utf-8?B?TU1NUTFicUk0c1BIRm9EME95Z1kxNzNpVCtMYWJGVG42S3NkZjREcVF1bkky?=
 =?utf-8?B?cWY3dzdEdXVzS0RYcTVlb0FURnAyY21EcXY0ckJJaXJiays3NEwrc08zSTFJ?=
 =?utf-8?B?Yi9EV0hmRi92WTd0TDA4OWdkUkI5YnpqWXhlUGRSNU01Yzk3MEhQU0w4THg1?=
 =?utf-8?B?Yy95OXp0dDYrcGo4TldRQnpyM2l6S0daQ2VwNFN1OHhQSXhhTUtCUS9iRTE2?=
 =?utf-8?B?a3NXajA4SXgwSitja09Pa3l1WVpBMVFvQlM5dmJuam9aQ0IyYW82VldpaWdW?=
 =?utf-8?B?VFl1d1ZCMVJzSHdnZllnK0VmN1BVUkExQjVybndZR3B6MWNnWDdnMS9vS2to?=
 =?utf-8?B?TDd2aGpzd2puK0VPN0tOdkdwc1pGZEVxRjZnY3lrY3l2ZldmMDBMc0RZdlBm?=
 =?utf-8?B?aU91dzluM1JNb0NCajdjd0tubFczMFlMaHJCNGFMOGNmOXdNM1Z5M1liMjIw?=
 =?utf-8?B?UERNMXVWYmJSdHN3YXc1VXZYNW1XWWpYM2g3MmV1OVJSdXhtemlBVEVKZ09p?=
 =?utf-8?B?alZBM0I1clVoSklGYlgyamg5MFk3RllES2VnMnZseksxUG95TGg0WnBSUytH?=
 =?utf-8?B?NDhUUmJDWjNVM1I1N0NSM2h3cmVYSnJ1R0RUSTBndk9RZTl4U3hRSEhKN0Nt?=
 =?utf-8?B?dlFQSzJPcE5XVDJ2SEV5SEhlL0xrTE0xQjhVWDBWSmFlOXF6bTRWY1VLSkpv?=
 =?utf-8?B?U0Vwb2dDZWt6dkp0VytCaUZnZFFYWk1LcjdWQk5iWWFMVDZQekpaZ2FLbFBq?=
 =?utf-8?B?VXdiQkZ5cVp5bTEweElVbWkxMTF2N2NHWHhiaDVVL0tCQkluWHZQb1pWUEZw?=
 =?utf-8?B?b05oK25MeGlvZG0zT21IWE9Ob0tnSWVRdG9uV2NBZ3BTb0N5YlU1SnVwKzNo?=
 =?utf-8?B?bWI1dVFxNjdnUkg1MlgzZXNCQ21tdytlMWs3RlIrZ3MzTTljeUpOTDFIZk9J?=
 =?utf-8?Q?vVSQEH?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2818;6:fSB+dgl5f/E+J2Y8llqNBCwOIW4wOMVIwvX5syiczE44NuP9qv4o2z1XE2GuL6xrfEqVg7LlavflDhQoQw9LSfczwwXgY2u/0Ek/JHblqog3kqPn15ASz9suu/8izWti4/dkZQhOxFbHX1Bd/G/y224hTjqc3Nk5/HxzTl1B6WNmCbdx6HaZMnQhuRBVXPHWPDc2/E2niuQieeHtUgmP3bv5fb/tAStVF5GtS4KEZ15/Esr7gAbuTBmwX9MCb3sGXb0oeO/mS/h1SoPO621PbETiz2bU3/JvpCV8TIp63dZSR22BrPpSnpifc4ovHMm6GEjwlHY8N+4arJeBf25MU+CdbJc0TkKwGwceFHqDuJo=;5:AbbUPLgNySV9vJTt5wqBgKbFfm8UE4uIFeHZlpYC7i5wfMS6v04fPWhVzFeI5BddxSm39KAU+1LCVSjOEuAfz/hjN+E4uzPbA/kDEiIV+6JPv9Fpn2LKZya4C40QLS+V12rjLPZit9TBL3mLW2Uu9TlqZCaFQAdUJi2c4Iv82sk=;24:vVNFh5oAbjkXn8KxoJubK7Db8J4wSkGlmZzSbDrlDPr1fDskhIhMhdIgm8lkedBzuCMEn4gLH0v1PqqVVisEa1wIzAYsLpfn1EWWDQI/cAc=;7:z/TV7t/yfIwv/hkFU8gilyQ07dmtw5K34o6obbJFoV9NOX+mPHsfT/GG9323WpFJlHLdcp6sffa/Y2a9PVGRYhyp3C0nwfIVsPWtTIY1CffXEesytTarDIQlDz49AHXJJRWCpm904oxCjDb/Nsmw/+QM81Nwd4gZtXKlGdnG2fbGsgLDvZxr+qA2jxqnHDKf4scz+3DetjR6GkHFjpciTZVJ89hAwEr/PPipKn+QWHqtSgoWOnrj6CfVZUnUvjTj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2818;20:gD/7g+h9lQbOS656Me7MLx4uqlJ6qMRgC871P1lf/T4g2L+6qE30R1eHILdld49ajtepkAL/EguY5GAWqJ2PYxpZH2ZnCK3zQXrM2gNoilirTDCX4Yvo/VjniersBFJvx/dznjznGP7HlhUpRG0WiG9ByB7FTljZx6WJMdFPnno=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 10:31:04.2528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a007c6-20f4-4f0f-1ee6-08d56c838fa7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2818
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 01:15 PM, Arnd Bergmann wrote:
> On Mon, Feb 5, 2018 at 10:02 AM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>>
>>
>> On 02/02/2018 06:47 PM, Arnd Bergmann wrote:
>>> gcc-8 complains about the prototype for this function:
>>>
>>> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
>>>
>>
>> That's actually a bug in GCC. In GCC __ubsan_handle_builtin_unreachable declared
>> with 'noreturn' and 'const' attributes:
>>
>> DEF_SANITIZER_BUILTIN(BUILT_IN_UBSAN_HANDLE_BUILTIN_UNREACHABLE,
>>                       "__ubsan_handle_builtin_unreachable",
>>                       BT_FN_VOID_PTR,
>>                       ATTR_COLD_CONST_NORETURN_NOTHROW_LEAF_LIST)
>>
>>
>> But const attribute doesn't make any sense for function that returns void or doesn't return at all.
>> Given that gcc-8 has not released yet, it would be better to fix this bug there.
> 
> Ok. Should I open a gcc bug, or will you take care of it?
> 

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210

>        Arnd
> 
