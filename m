Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeCTM3z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:29:55 -0400
Received: from mail-db5eur01on0127.outbound.protection.outlook.com ([104.47.2.127]:18362
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752815AbeCTM3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:29:49 -0400
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
 <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <bc085586-457e-5c0c-181c-0c908ba17c9a@nokia.com>
Date: Tue, 20 Mar 2018 13:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(2980300002)(438002)(199004)(189003)(6916009)(229853002)(31696002)(81166006)(2486003)(53936002)(86362001)(93886005)(23676004)(6246003)(81156014)(2950100002)(8676002)(76176011)(65826007)(2906002)(31686004)(26826003)(47776003)(65956001)(77096007)(356003)(54906003)(36756003)(305945005)(106002)(53546011)(4326008)(230700001)(65806001)(478600001)(336012)(50466002)(68736007)(26005)(6346003)(5660300001)(316002)(186003)(106466001)(58126008)(64126003)(22756006)(8936002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2393;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT036;1:RVrWV+CV0rk4nED+wzTlgfYeT+LRFqIzanpE9PlNT+NyRXpTnIymS2czODG03cAAZ+w7NHKMbbLY2EF78LiSkfef79tzKpkdpN5uDp45V8gOwfBarLaPKdxE9h7S1QIn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1cb233a-ec71-425a-c049-08d58e5e43e3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:HE1PR0701MB2393;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;3:t2uGrVNUl3s4S6PnbbVIAG1ONDef9hozt5CfxVq0418IFRakSblbW7grVqBvxFT5ghp3SViuJx6jrnTfazVcwZQhxVZS0GmlRLe5xVFyaPuHlrMOGQZ5bTipESWicRbsHrgEj8nMK5IgKgAIoPUfFJ7scwV1bJb10IVN9+7DsMjXVrhzOHbvJsVHXIeY8J9niqLdhFud9E88RzDaCV35LrhHYk8+xKddNPrFkrcw0z6S5FF1NEqVo2VdDrkXel0ZRqPQbmUjhbBX6TpT7YB971TlXa7UrqLZZJCE1TXcmXEE1ATbtWemZU9vtTgnBqZD3rkIYSesylu5rxjiFjhlu7F8dWEfyGG2bo4EYAk0huw=;25:fPpfZQVaHUzNWOBsVA/F7OgwmlD3N+aN3wdVsMWaMUkR6t138YnJAD+Sbromz65T58YONcu/+DblkYrzD+T2LI30RJDB7mmSXD0ydIJGWbV/JYqBcj+1SgURJ3W9ajlf2rM3YgG/rgZRf1joyVojQ/6VEftt18H6ib4dyxa6BvolYyhiVzFraBIZIzkT40ENrryfJo9OvI1pmxaxbV2O+tv/FPeVw9dHCcZP1memkgvaMEppBrJvJaXbFq00R0i5muqy+kSNf0rX+z5EkSUZSEv8UZzatszqWmCrSjB4nbqluCeUzyAFAhktWgM7ItKwfE5CnHWbLbyurDmE5xKZBg==
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2393:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;31:1JRoxHZImOuILwxXC1Mw+PDDaA7OXBh86lHpV8lm/1oKr3hpvyqZfRfYvEpHoOt+NxRpCMAYdcq5D+KS2qV26Z7SyP1YqBo0BMTZosRORDsXXuUPnpnon+KkRw3zTj29kKetEeFR7PA/i7qqJnUQwGyHH2A8Lmf+dewWAXff3TbYgx6NQ5Zjjgoh6qzlWsfjYP+mPZ0lfA8xkh/9ECA3ebowUGX9xm0vj+gyK6p7vxI=;20:VcbkBAmSRTLpU6jA9WhOcbnkSkUEeWSS+2Jd6GuExn1Qhz20utdIocQVcDqbgJgdJkcdKTivvCSa6aRNPhDsVJ22QXMGzX+KSiZRN74FnRJr7iTiCDKps7GRxUtY2lo2Bz7dBcKW3rJfjqdXymQLC420N1RhLmQKYmjL3BUcFLTIK3wBn4GyaORqamJXWuuk0VVMtJ7fgXg+k/ZLzu4eTmKVLqOiNIHhcES/q3e6O2ylNSXqiFT4Wwq1/P/L4EohWO6Yod9bcLdS/U7FJCLDU+RAjdrx3eIVJ4TAdvNeGWOJR/xr8zg3pH+xAf4xAHVbXa33k/bfv/qQcinPiHFRWnERk0sMYGz+VwgdiQiNaxD4sfweqkI/1Fa35R4h+LBhvynWmYM1Zop6u1lWb9I7xMsKXNgTaA5j/1M6JE1TTsH6VTOPrf+0j9u8aD1TNKGMaRKSkXKihATJyPSZYhZT7R/zSBAgalWuNUBT21834/G9dIyn6fm/96RySh4wgcavNGqqNY/HSfrxuumSr67VMM/A++7RMxD3ISpENwDGgC5Nnd3WxpumVBnNjUye/LQtTCfCHu334wPvx6H/9d57qK8vpFFYK0C/63j71NWdzNg=
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2393CD92111054262C40EFCE88AB0@HE1PR0701MB2393.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(11241501184)(806099)(944501310)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0701MB2393;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2393;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;4:DaYlKAyTwGgU2z+E13d7Obz4EWpF4TTUY6xWhbfD8h5uN/0uHUieAiF4SozM6orA7pmd39c6dK3vYyq5QH285wx9sFmedwtCgpYG1lmOTbZUDeerIC/zCMGMlT7jTyWt0uvNlig/Ul8vQa2gSrO1wn7RTQdqAkXLl8CZ8LKvyECioJqyk/EDxgJkT6Cqh10f4u7qpHnCCC3VcoxV5XSHkW2Mnp5/Eki2geDqTDev/JBsEWgnjH/Su09PeG/lqqAN/QWjv50cLj9n0CBsvjETOXT2a/qVs3Hlh73EL/1UlHwiUA7LEA9jSY51Jv37RAZH
X-Forefront-PRVS: 061725F016
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3MDFNQjIzOTM7MjM6ZkhLY2htN1RZeitNZGRPZDMxZ2hLN0FI?=
 =?utf-8?B?VXMwRXY1Tm45K3RqcG9KTEVYRE5heXhJWTRpU01scEVQV29Jc1dBT091QXBy?=
 =?utf-8?B?QmpybzMzVHlMaCt3MllQQjlsUHNCY3JhRDlpb0wyNUFaZFhna25yakdoOE1R?=
 =?utf-8?B?bHlCYlJWREN3TFduc1ZqZDlTNTNUSnR5UUZuNjc5ZGN4YWdKUGdiRmxkMWxl?=
 =?utf-8?B?L1JFdnorRzd1OFhHcDFKQlhtT0p4a0R6OW1CaXloaDB4enB4SE5NMXd3S3FP?=
 =?utf-8?B?cGZkL3BKNzVscWtZQWNwOEZMcVRpb0cyWnRXbGI4K280YXpHd3YzcEs0ckt0?=
 =?utf-8?B?Y1Jxenk3UnIrdEpZZ3pqSEY5ZFhJelh1WitiblJQY2VtdVN6bld5bDl3MFR3?=
 =?utf-8?B?L25SWktsYXgwRElSazZ3KzJrSUdzVHdrNlkxaUptRW1mb21Vd25Zc2UxbDlH?=
 =?utf-8?B?Yzh4QmRsSVhpV3VkcnFWS2txR3RNU1MyNVlOVFJBZzBTNWNVTE1GLzZnUWFC?=
 =?utf-8?B?V3ExdEZnYnhUQXZDdVo2ak5HcGVkMDdlWHNTenVOVVFTRWhQcnU4emJVK1Ax?=
 =?utf-8?B?Qm5xTEFvdzRQUHJzYm9vWGRiYlAyRDZiODRLNi9iS2ZBVG4yVEZuenA4ZHpP?=
 =?utf-8?B?UnV0ZE5KN2pJa3NtOXpTQ3NlU0lVQ1E3TmFjMzhqZ3M2dm9qRTBFazBEYkMx?=
 =?utf-8?B?Qkh1STJGMzl0R08ySzdXQVpHVWZqV25pWXlPVHhVVDkxOC9DWnJvQWRkVU1Z?=
 =?utf-8?B?RHU1aHp4QklWRDNXSmg5MFFNcHU5S0FpOUxKRm9uRlhjdXYwdlNFSmJ1MzIv?=
 =?utf-8?B?VUk4TmQ2M2ZhZGJXajRvY0xrSjB6dUxRazlDN2Y5Mlp1ZFh4ekJBQ2haQzRT?=
 =?utf-8?B?YzFXSHNzT09ZNFJGNEExcFVNcnFWWnBsUmhuUGpiR0NMTC9ONC9RSkxXVkNn?=
 =?utf-8?B?ZmdYdE10aGhtYXkwVGVPVDEwRnhYY0M3eTlDaVNlRTZQU0dlVjY0enVPTWNr?=
 =?utf-8?B?NzlyRzVJMy9pSFRJZTNHT0V1MHQ4YjBVRDM1MEZKMVBOZHZvUHFubzNJdE5N?=
 =?utf-8?B?NitBUnVsSWk1VWFoYTdSRDRZcjBtU2ZKY1NqelN4SHhKd3VwVEN1L1BTNW92?=
 =?utf-8?B?S0daRGFSbDJBcDlQaVlJM1RYN2pwellIWGNJVGdIcDJlYmI0UkZIUFU4Q0Vr?=
 =?utf-8?B?aUJwWi9LQXlrSG5FNWZCZnRod3ZIZUlZaWVYQUNBY25jQ2dFWGFPc1JmazhP?=
 =?utf-8?B?a2JSbExPZmFvNCtzNU9lNGJYM0JNalV6RTZseTBnbWxIMGpmODRFZHYxVEEw?=
 =?utf-8?B?OStTWmJoZnlMNktjRnltV1p6bStEWDNoTUJsbHRpS0lCbUl2TEFXNUVUVmd0?=
 =?utf-8?B?VThjZHpRL0REbk9NNHZ1b3h6TEt3ZEorTmN4YWEzZXBCUnNiMVYrRUlodG1u?=
 =?utf-8?B?ajhEV1VPRnNLUDE1SHJvRjB3SHQ4bFMyZDJqKzhsNFlBbllBaVhoZGk0S2k3?=
 =?utf-8?B?aXRFeVVMbURaUndyVGxjVUs5Vmt4M1F3cnVPY2tWSnFPaDRmYUt5dVdFNktl?=
 =?utf-8?B?YnVKWEQ1RUsyQTNOampQRDhiTHIvOW45KzA2cHd4Y1V1OUF2KzZ1MGhVTUJF?=
 =?utf-8?B?U1VmSUJkZkc0ZzFBUGd2RWZRMS84WEJMTGN1MTNHSXdTbE5IVGZxMjZiSmc9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 7riKKnjfcgryj+swYqNSyr3cjIzVYfbgmsmqbULZwP84i38Jhp9ZZq+qw4PNYzSJFxpcKVlqIxcpmwkNZi7Ms6AIgKiVaM4+snuu/728cnF7c0jBNaKW8+84eHeHIPxKn0cnj7BXdUQOvIMwb07iw81Yv207Su5Tz1LunGdf/drutGb3vXEBzCDc5/Fp2TDGvKoNzUOYopxlZuTQVHEDeRvlQJPNt1vgxF31NXyZ/LRfDIRH9qHzjQNFfhKuiZpj92ByypKI8JGSNoqHXd+YP8zrFP/yYquDELYUTF+ioP3r9imRUDzDvjAYDF7LPS7W3N2O/ywyN4SYpE0UIP4O3qbEh4IDoK2f/F11DD15o/eCbAQ80GTCxzwpF7Hcc9xo
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;6:eB+RGKI9kDwZE7VbsuQhSXmoDET9XmPyLCmPxdznmgwCiF88O2bFzJmRWsb9hVA3AViLROpQMujCNYamkPrjzNnF4dSlf+BKc2qgWzYUxPUSbUjbgYV12VKTXAHrZoQx7m5ACR1rpDpOTr8KMpSKBlav+eeeTHNsk3qF1nRifyEhowZdYbSb/Pp+IrzOjUIeP2ja2ksHWWjls1UK4nwm/nVb1zla8wSRaMJP72kfTVk4bPZSM7mndGBGOPAdF90XT5AAkGBzOWeO890jopw7wAQUNs2IomEQO2CRcr1GrGURYYPn7vANnSIURp19hVtckzBMjBejqnFmoE5X+0nJ6o7GRg/pTYeAwZBxlc0GeAy5aMAiDC4bMhecMrXs3sBKtKxhsfAKhNK0QQqY4vVdwNgxflGf1yzvwsyNc8XmSAbLued5I1AZpgjwPSljTyAWD/A6vzp6h6zYWY99byhy5golpw9enVuaQN2Z48YY8Fiyfl4C9+f9g0/EPzQHWmUk;5:bpaJUJWMHEXrgv9tAc6XfINEatE3hff9ayIVviXhFkmwgYKbnZFHmN1qQytL7zBkkDoXdUJ0Sqg3z7OGyAKgEiF6pmf2y1ZwxPn8ALDI5mc3u+Po3ka7oo5I1s1ZXWIP05JqyWTxJK0jXqN8d2a5JJ9HOBBefZc/DTbEuKhj+70=;24:H+oBU3KaKTgZZYaMGwerZPrBCKZJCYj/Z7TY67zRTz7tlKnQ3glTb3h/CK5LcHYDd1iU/kK/9KJKYnvuBRWJzZqXpMhi/OjPFPSTsmYDcbo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;7:MQuqZEXV+ARQMJrVUg3yZOjhLYjxQRigGQBgLXA/XrkBFg9uvdRn4AHQdvsieUs5st66g/oxK7wgj00hiHdlH43cOQ7t+0M5mLKlsb7eRfLdGptxkkXFxZXXzOL00dYlxqxKtMsN1d7nx75dC7Z3XS/HW6YUElPVb4zguYZ3P6dNlWAk1Wjy8jVY6yEnS/gGqqB1NfMxNO9I1GiiVM6IvjpzcHzYrEHu6vCQwKgNJAMVQ5TcrRErE+D1hJei148t
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 12:29:45.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cb233a-ec71-425a-c049-08d58e5e43e3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2393
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard,

On 13/03/18 18:32, Alexander Sverdlin wrote:
>>>>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>>>  {
>>>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>>>                                                           &mod->arch.init;
>>>>> +       struct plt_entries *plt;
>>>>> +       int idx;
>>>>>
>>>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>>                                                            ^^^^^^^^^^^ (*)
>>>
>>>>> -       int idx = 0;
>>>>> +       /* cache the address, ELF header is available only during module load */
>>>>> +       if (!pltsec->plt_ent)
>>>>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>>>>> +       plt = pltsec->plt_ent;
>>>>> +
>>>> Where is plt_ent ever used?
>>> Above is exactly the place it's used.
>>> I need to cache it because after the module load is finished the ELF header is freed,
>>> pltsec->plt pointer (*) is not valid any more.
>>> With the above modification it's possible to call the function during the whole life
>>> time of the module.
>>>
>> Right, ok. That's a problem.
>>
>> This means that you are relying on get_module_plt() being called at
>> least once at module load time, which is not guaranteed.
> This is indeed guaranteed. For FTRACE use case. If it's being called from FTRACE in
> run time, this would mean there were long calls in this module section, which in
> turn means, get_module_plt() was called at least once for this module and this
> section.
> 
> This doesn't hold in general, though.
> 
> In any case, if you insist, I can try to rework the whole stuff implementing module_finalize().

now when I have a new implementation via module_finalize(), I must admit it's not possible to
do it sanely this way.

module_finalize() can only add entries at the end of PLT, which means, they will be different
from the entries module loader/relocator has created before, which means, FTRACE will not
be able to replace these entries with NOPs.
As I don't want to do O(N) search on every dynamic ftrace operation, seems this is not an
option.
Either v4 has to be accepted, or I cannot propose a solution for upstream FTRACE+MODULES_PLT
combination.

-- 
Best regards,
Alexander Sverdlin.
