Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeCMS3A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:29:00 -0400
Received: from mail-ve1eur01on0138.outbound.protection.outlook.com ([104.47.1.138]:21728
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751556AbeCMS25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:28:57 -0400
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nokia.com;
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
 <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <ead0216b-d270-dc1f-162e-872ec956c729@nokia.com>
Date: Tue, 13 Mar 2018 19:28:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(22756006)(64126003)(26005)(77096007)(5660300001)(4326008)(6246003)(186003)(53936002)(65956001)(65806001)(229853002)(230700001)(6916009)(58126008)(47776003)(2950100002)(305945005)(53546011)(316002)(68736007)(26826003)(65826007)(356003)(81166006)(93886005)(8676002)(81156014)(76176011)(31696002)(478600001)(106002)(2486003)(23676004)(8936002)(86362001)(2906002)(54906003)(97736004)(336012)(106466001)(50466002)(36756003)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2395;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT023;1:hufdDIufZD8fzommiEKsRLKNUR2Dbcb3vKNEa6RQCBuCw60RvguAS2eYzEcWGeta/3fKPmZYSAGPUl5IioTXjc6y4xoMrBbObrXTeHKTxyLnR6UN7uCHcfDLdnlo8Tn2
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cdd4fc3-a8d3-4d55-fa9e-08d5891046ee
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:HE1PR0701MB2395;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2395;3:cFizQkEH+ZzkKrUO+TAiMatPRE1tF84AFDBmbjRe11GLVNDYHPqPSN7Pc0AwCpVoCJtcO8wRIA5hfwuN2lCU37uPuwzO0ce3rHf7+cFjYK/VFKqSLplGONVBXKyuKtgiJAzGwNcda6rozzRYwAA4PjcU+NZJfzoZOVcATA/0fDR4od83n3d1sS5pqtL+hMK3NCOdcT5kB11EkVku99lRSOv15LSWktm0xWh1ChM29u00REys6cBz+almIODPZnPTkgPEMxTmkcJPUSkbkWZCuG5BxSmJ20Xm3XR5LVR26Ei4wEjE9aeS9rXwr45GLLFXyRAjFirBCOA/IvUUEOM89KWAVPu9gdEUW/XSuJyFTQU=;25:rrvAnMPpQG37GiL8vkAE++4lKO7TC4BpuPGHKrFrX5fxBfZbdt8WSKL00FuO5wYwIkfbsrk59pSU3yBcDMCGA5K4tc5Nvc/CZu9gW+xYuh1BuaXMLUnjzufPP2JVsMHn8eO79CFECPCnTofLGoZJtDeKlyYjPFP7CK8In5AFHa2tQviSaZ7gN63Vv6na2nXuEXud+fjAASda9rAolD67c6+HlpixMA6X/X0Fz+eMfxqpvzw/91c91HLw4qvh33hSnR3uGkheNh5MtPmJWJPWAOyGtJA71Zz+C6dGPRm/MyKAtjfw4+/2lItNZbvPhZz4Wmo0Y6kdRZCmlUgI7Ao01Q==
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2395:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2395;31:W+m4GLNVDgqmcolp5ZxXezPijifDi3BwM6XubMKCBrH9aXFODjQ/cVW6DU9dqu0fsLTIFKaL2iV9qMVAZjLb7UEI/IFy6V8lTd016+onixbi/w2HMRRbUX8/KhnI+z0SX8CHixCuzsPAGrrwYpvOWmgxlm1MIwe2g5Ad9fOBeOkJNs+hwjNfBoC7KEHhBOEWXiCRyAB3Ed65lCMznHgkYJqqh0MManvEvoPBNeEMVuE=;20:jMKb7c9wCGQRHMu3FTQFapOvSpZ2aHS9DI4iLu33jBrUJyQx3yH/wnGcile+udqXLLOiLhSJnsTtFZhSitgqudP+3M2XhGSNqIUJSd0a6ID8G33vdPFCWe6R0IEfnwmNu895Ctf0zPAAoKFFS7WGxy/pUFKThuiZAGuE8jgb6wBG9ZJYQQxDZ9385galnjmU/0MI+KiOTmuyG7nHNNTKpoUB4gTCWBnd1wfeKU0Gtq5WxePGnQ+lT35vXEMeR1XRlosMfmEDF0FCt78CczMDpIN+Q2U68OwqQUiFOqM7aKfX7bD/8avF20laYj7uV5G+viWneuWJ6s5G0kf88XpnOKnvPVOzrxITkOJL1mw+/GwA95XiaGTs1frXLkgjpGQVHCH6pKrTqD/QWgTzDsiLOM93msoS27v2wxd0bhcBjpUR13FwAkOXyA+Eml5oQksvDFB5BKdHh1mcCDje+KRY1zhotJjv1P9TMlqDOwu1P7d0C5Llj5uH6SrtIo40RzZl/eQns4/9B8KJDmsgOMBgUUbECm1E+6T+B5ac7EiqooFtfYd587WKME4fkDKi2DoE8Qh3eppRsgeepKC6SD0Z5hkUNzPMntox1f54Im1VX20=
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2395C0F006D520A4B4406EEF88D20@HE1PR0701MB2395.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231221)(11241501184)(806099)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0701MB2395;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2395;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2395;4:8QEV8QkvKgi8T+Sx0K5cFX22l+1NvkfD1kqRz83usIRqJ8sHyLYtCYe0Llyert1+WV19B9dMErLWs4reXNty6yw9jht9GeDKNBKjfQ+f9ogNPDrhKId5UL2H+AQrUhLbi0zKU8NkH2EDB8fji1y6JByHpUjtUMnB5XLtHrGC/NEr4BKRdGYHBNGK7UJ4pK/Yvhxe3HoCdjCyefKWgqTbZSNe8sXiFwe5N2uhqm3nnvTg9t34xu9CYnX6p9sb8jzNbn7QsnZI8epFBU//fwqKmw==
X-Forefront-PRVS: 0610D16BBE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3MDFNQjIzOTU7MjM6blprdXhuRXdOQlVKRzBCd1I2bEs1SmFa?=
 =?utf-8?B?a3ovWlRrRHpmUEw1QUgyM0tOa01pbkZHemRDQXhHam13dXJ0ZW02bWJDdGhG?=
 =?utf-8?B?RjAyVDJxaEhxSjRUUmNpUE9UNG5QblRHcWM5WWFaT0EzRURTRHErQmt3dE56?=
 =?utf-8?B?T1R3NFZNYXZ6WDZ2TTVPQTkzOTRNMUUxYWtxeXQ5K0I2bnkvVUc0OHZXQ2U3?=
 =?utf-8?B?SkpPUEgwekVObEpQRmJ6VFAyRlNVVmxQcnVWcXpGVUxObTYwSm5BWlorbUxu?=
 =?utf-8?B?S3BzV1NNRkszMWpEVTh1d2MydGx6VkxzNUdMWWJ3V3J3T2p5NXN0RTJ3VW9C?=
 =?utf-8?B?Y0NqYlV5OTd4YXJ1T09jMTdBL05VYVNyYkVRSEM5alIrbVhHeVBNZklnM3hl?=
 =?utf-8?B?LzFMWkFWMW1UNytSaFpueDNqc2xHMmhkanErRmVkVXJRWksxaUZ1dmtObWFU?=
 =?utf-8?B?UHBvMjFmOUF5TlZBRUhlYmlkR3k3YlhHU21PbFk5VnRCdzJBOG1pT2QxbkFO?=
 =?utf-8?B?SUwyNXdMaTdTTE1OYVkwZ21lTTNpUzJPcWtaRVU4TWU4bGhheVVlWTdaVUUr?=
 =?utf-8?B?U2o4T3VYNHhweVp5djVUeU1sU0kwZ2RSNE1FenhqdHBFR0l4bTZMb1p6b2U0?=
 =?utf-8?B?bXU5bWZVQ0ZzNEtnVkZuUTdVaFR3S1V0ZHkvTmhMVXpHRVJkMGhZWDc0ZXMz?=
 =?utf-8?B?VmQ0VllDVlA4YXl2T3R0SjY5SXdOSTFXUG9mYlAvL1hOTE5mTU1TdTZIZXIy?=
 =?utf-8?B?K3lTMFA4YVJScHFHOVVtQVhBYkk0Tm1MY2VHZkhYVHZKUzdnSyt5SWY5cmtZ?=
 =?utf-8?B?WC8wUC9NRERLTnZwN0lSS09vMzF1NWptS0QyNTl2N0hseDBnK2FydnUxYkVL?=
 =?utf-8?B?dllJaXhCR2VaVUkweXp1UGM5dnExYzQ4enJkMU4vUVhGYitXTXY2c0xjR0VB?=
 =?utf-8?B?SjQ5QitueW9Md0xUTWNuQmdSb05RbkFzTnpzMU5HRi9uS3V1cThPdFhpQlBE?=
 =?utf-8?B?bGZNOGVxbFFBWFJhcjY0NGdoMWJyTDNoczdrZHRGTE04R3U5Z1pyNHdMNGo1?=
 =?utf-8?B?QlY4a3Baek96eVZKZTRvOHNFaXpSeUNSZGkvaXJOMWpUeUhsTXZjRTR3blo1?=
 =?utf-8?B?UjJ2Rmd5T1FVa1AyRGh5S1dLd29RVy9lWWdpaTFlVkhTNmhxR1k1eFA1a1lh?=
 =?utf-8?B?S0Q2bGphM1RVbGNUNGNPVmI5M2xOUEd3bUttRzNtUFdRVGRZZGh2b3lrWHNR?=
 =?utf-8?B?bXlNRnIxaHF5azBySWdtUHFQNmVwUWo1RkdWbm83bnpQTlRnMUxzdWlKQmxl?=
 =?utf-8?B?Q1B3WGJLVEZqanJxTmgrckg5UGFPMS82VHM1S2xmOWNZMFIrZEVwb1FEMjFj?=
 =?utf-8?B?WVNKbjJpNWYwT0hobkVvUnpici91dWl4dVpUWGlrSnJYNHRQck16VnpBdldH?=
 =?utf-8?B?SFJ5N2Nja2lxMWNjcDhacHhTRWt4dSs0RXozUnVEUm5XMkZQSWkwdE1rc212?=
 =?utf-8?B?ejZLOTBORmRPMnMra1JMSHcxNTNjK1R4eXIzMWUrejdjRUt5VlBGL2ZGTlp6?=
 =?utf-8?B?R3g4Y00yS0dPR2ptWHduNlRaV3lOanl6bzAvNGNIaUxIY2NuN3M1eXhDRU9M?=
 =?utf-8?B?U3RrRDNzVFY0cUw3ZjdXTzFTMFVaZEYrZXA2NmtzcDhZOFJkeXFIOFk4anc9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: VLIGAWcIXF9RUUUuAPf4I/EEmdAOCOF75FQCiHGeR550KkIczRnVNOaWu4Su+wjOV89TtwEp8Qmtw+0zbsx0+EI1/FWf85J7ELmqlFEaAWpdw8rVrrHNg1qVU4yNA5iXs5JEZ2cy+OqOsMQpyM9F5bdib0RGzeF9AEgcdQbBu6hAI4FZHqmhCJN4yIncFxCq0+AsH3x7smU54dTqhC0ubUERolM8aHtiMnQ7J5J6j7vaIJ87GlZ1yA1lh8XCpPLSbNIKRcUDo4DRGpIE+qOs2ulZRk9a3zD0w4uuHM6ceoFPWi6+wnuENTZKwhKBTEh+/71pEYy4XXfwumK0Du+3UKizzwt/lemV4h/CRfuqpX79mQnOmPM7uUyi7TYSOe7y
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2395;6:M0bzmNOa5+gSOYgGI71xPXbrUzXIH/QxWhvDVvzzcp36WNcMN+culhDTlv9F5oJ0EaXD2/ZaJpbKsj093MryzbI2wpZjLnPLWON9vX4kVI1z4zg7XCYHqFMZj2b+F7AHJcU4kopeCSnd+hHIlb3wVfCDEdHd5c9m85fja9xC2OhGdUcA1OxE0ZB3GuY0GJVoeAK37CE8WlXkY/ubA2MXMFfwgWS4kGQy2OwyTKdHKVptH4HyBchV4w2K5Z7jULBU5FOMP+1qc7LfpRu/PKijUv81109iXDVBRlr/o4/pl0uLiSbmg14GL6RxvIglyXOROLdAe7VTaCMLXmIk/j2nBKS3RPktyf18v+/cbLY6t17K//0u22FvUKYyOa9Hik1vqvWHw6bxiXCCaW16L5t8EQ==;5:hfL8DYhxeLcgqaWp/uOyyDzdSX21OytSYBsfJJvDLPT9SwE4uQgBvws7qdgXpliyMKQgdNuwoQTVoUr5hbTY3HKmrWOrgPC4i3TS0FeDVRTk38KwrHjqNd5OhXFhIWkoPwr0TJNz2JCORV7EJekRd0xW/E73i/fRmh2ITtqk/y4=;24:xVt9O/rcY8j+xdTjgU7h5XLt7xj/ZhzcCocME7yBO2NZjr4UcrRnPogsR51SZJy6VVLdlbGCwHRDcS9lWS8ZaJTLM2u3EBWOsSTLk89NsNw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2395;7:qmFvaeLQIxB78aDMsUXRyzKrF7X5r3WLryUgDstee7cJTl28KlvVVe5nemwaawdlne/AXCqivovEW5zpKFIlI3pLBHZHwvymeBEt4ehKbUZJzMFWQNd+0AtzjzxRk4Ki50I6306Uu24sDY0uO86x9J+RFp06QPvHlEUycG38xEAAWIkkciW5Qi6VEat/bQZV7rgeTrv7bofNv1+3txfdij2ZsDwy1kXHhfmY8Z9h4LBAHCHRK1BF6TfFyCshXLTV
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 18:28:54.3467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdd4fc3-a8d3-4d55-fa9e-08d5891046ee
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2395
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 13/03/18 18:39, Ard Biesheuvel wrote:
>>>>>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>>>>  {
>>>>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>>>>                                                           &mod->arch.init;
>>>>>> +       struct plt_entries *plt;
>>>>>> +       int idx;
>>>>>>
>>>>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>>>                                                            ^^^^^^^^^^^ (*)
>>>>
>>>>>> -       int idx = 0;
>>>>>> +       /* cache the address, ELF header is available only during module load */
>>>>>> +       if (!pltsec->plt_ent)
>>>>>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>>>>>> +       plt = pltsec->plt_ent;
>>>>>> +
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
(*)

>>>>> Where is plt_ent ever used?
>>>> Above is exactly the place it's used.
>>>> I need to cache it because after the module load is finished the ELF header is freed,
>>>> pltsec->plt pointer (*) is not valid any more.
>>>> With the above modification it's possible to call the function during the whole life
>>>> time of the module.
>>>>
>>> Right, ok. That's a problem.
>>>
>>> This means that you are relying on get_module_plt() being called at
>>> least once at module load time, which is not guaranteed.
>> This is indeed guaranteed. For FTRACE use case. If it's being called from FTRACE in
>> run time, this would mean there were long calls in this module section, which in
>> turn means, get_module_plt() was called at least once for this module and this
>> section.
>>
>> This doesn't hold in general, though.
>>
>> In any case, if you insist, I can try to rework the whole stuff implementing module_finalize().
>>
> I think it would be much better to use the module_finalize() hook for
> this, given that it is only called once already, and all the data you
> need is still available.

No problem, but some kind of (*) block would still be required, because
get_module_plt() has to work after module_finalize() as well as *before* it.
So before module_finalize() we would have to dereference pltsec->plt->sh_addr conditionally.
 
> Note that ARM already has such a function, so you'll need to add a
> call there, i.e.,
> 
> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>     module_plt_alloc_fixed();
> 
> or something like that. The CONFIG_FTRACE dependency can be kept local
> to module-plts.c
> 

-- 
Best regards,
Alexander Sverdlin.
