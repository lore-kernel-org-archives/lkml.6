Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeCMRdY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:33:24 -0400
Received: from mail-ve1eur01on0103.outbound.protection.outlook.com ([104.47.1.103]:15232
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750855AbeCMRdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:33:21 -0400
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
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
Date: Tue, 13 Mar 2018 18:32:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(438002)(199004)(189003)(76176011)(93886005)(2486003)(97736004)(86362001)(356003)(77096007)(26826003)(53546011)(31686004)(478600001)(26005)(186003)(23676004)(305945005)(336012)(54906003)(31696002)(6916009)(65956001)(6246003)(8676002)(230700001)(81166006)(53936002)(106002)(8936002)(81156014)(47776003)(229853002)(68736007)(58126008)(106466001)(2950100002)(316002)(65806001)(4326008)(65826007)(50466002)(64126003)(22756006)(2906002)(5660300001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1128;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT027;1:vCUP5OVfWDM85o1RywRPRVR+tcqR9GhhoXdQWGhT96IQ11kzwTkcZteTAvMixDH0jW+NqkpRyCjRyRa6XNnPbtlLjsFTzwxL5z8sbDcMsdjuMRPvUSVdtKrcahKy1bup
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d09e3b-64cb-462a-0b81-08d5890881f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:DB5PR07MB1128;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1128;3:9PljmNHbPcvu6TVddZJtJImq3sq3qlOMwZN1RTo6NtAd0u0LiXunQIyyIkdnmAXjcnX1/d7mhdiWHaP4AfP5TIgVfxQqJ78wi56isbytI4El1f/O5dfggPyhE9LKA70SMqJjPk9caRR+RbvxaaPisFA2dSgvst9mrJvWk4R0EKcY9ifYl336mag0jSWtiOvmrr2ZKOprzu9dqk2h6gIWf+PMTud42gg06OxkdRX/XXLj0r3w/lycCeqj9uaL63zQgnczkgQmfEeBFLrRwi5DzOsNI4TtnhXokCYJ98TraKK9NFXrp8+UA1jFMpi1qWGezSiPlftTRg5lLL/4mPeczv8kVTs1S2fyDN4JMn+MXHQ=;25:9nP+z6ksqn3Zo/+/WAd8ReYY3wlSv+hPC7JicEZIHPuhSJO7UJKCp8AODegRI6Vl5eIJ6bwRzdMTcjf0HO8Vi9UXq0O/Fd+OSeu5KWhxDow1NCrO4xJFih0dI7kOkDhxy2mOOXAm9MkGC4qpPFEjnpDv93U1WgoBDwZZZVX3BWNKhbtDMQbADFv+rIQp87Qren/r9Kq+j2GU+mleB1mHAnsnLi8q6Es57zhH6BnMr8GTssoiZ9zYr83DWtij0UpbCZQpJI/caKAdljRyqfecwWleWdRz5z/Yndsqn/u0ip91MW5eSV2ab1mCyx5kYWbTMtWxuAm5f3BwYT/bEuDJcQ==
X-MS-TrafficTypeDiagnostic: DB5PR07MB1128:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1128;31:5emFIF+9YtjvgOUTmxFoy3foir0tG5t8n2Bc6JlRdxvQDV+6RlwkFfXAZUx0SCnW7OHDiUnyJgma4XnWcxE4w0avKqrBpOq4SkNk8W71omA7OmdQVffr3iGPr9LW6l9N2pAvSye3U07KFUbqLRrC+UU37CycAHkY99NQhm0Nq1fRCDjuXz9lFckl5142QAbFMOGGUNupWJZ+Evovkp/DVFmulXMvMbKuxZK44Uw/YIE=;20:GoODXRvQSMty9CTNTV1BKbzTrKyPJN6ki9Vf/tI/q1gEtsTkbj2WmMSJ1IxfXOij3+af0Ed6epAH/iQ0PiozSUBU3S/FlHHv8eySEqtFHc506xRgwCe4KQDB1pFogdmhmqi5jE5eIsyI3eNdE+cCXdYz9gpkMaGZuHtswtkyJR8k7VJD1idK2G5LKltZEqWn8d9vFgtocKORLsgcPz8j8U70OPcw8PdVDTMV0ihjoPnzAkQvRczbK70ESAUkqFHoZXMlw2NX3rH3rikwoT9/zyJpp863JEErfZcnkwORKwmCfxy0OyYS3m4Ij1ho5CzzJfPjH2ED4DY0sFHQjjzcryKpcVJRxiguJqWedUrPpg01ZzxbGOk4lttV2qE39BTy7yQ2yrCR5L9Xw0VWMORLG9oskLF9MN8C7qXmesbnBgE0V/mHCa8Bu45SJRS7D3gbx045DGlkMs8Y1Q5A+EScFbgrVJKIn8WX+VbhCFOPHPwxQ5/iObwNBqROc3GjG6gL/ll0aT9CieA/1rIOqLrJmANmx3xcXCYhoyttaVtiVlRfZAqGT1F10Oh+s/2yNix03iAfjV7qCR4WK08RN83+A1/7LmH/kLMd6m1RdFjObuI=
X-Microsoft-Antispam-PRVS: <DB5PR07MB1128BBC45F45A00AB198298F88D20@DB5PR07MB1128.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(806099)(944501244)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1128;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1128;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1128;4:+nvwkrIiEi10DX1iLnntrENhjUspHxsvDnN17lFs3O7iD2sXMho6iWHb73yYrq8phmEScQm4OqI3Hal2BNprjAloq4OvP3ltgASAsEu90P1UCvMwinh/J5uwfVgE3K77LY+aq59a21cazb8lGnMo+amlPOXlgoGj1Y3kryzkocfRq3VStRP1kJe57HVOx3m1fzyhjktr3dx+8Qnbot0quLjjd6RCUh4n4euRYs9ofgJFp8ShsS3qU44b3JCiIgGfkcHJpidceuf/C+GbcUCt4Q==
X-Forefront-PRVS: 0610D16BBE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjA3TUIxMTI4OzIzOlZZSFFVbFlRRS9XSHcxNmxVRlFWVVdZRXFG?=
 =?utf-8?B?OVZwZ3BLOUxNRXdiV0NWYzE2ZHdWRkFWOXlGUklZeGFORWhUQ3h4ZHk5V283?=
 =?utf-8?B?Uy9LdU9jL1R5YWpHalZTWFpuQytNMmlqWVU2VWIwQ1VRQVYxZTZhbXVKMDJ6?=
 =?utf-8?B?aGV6WUh1SldXdlh6SUk0QWEzdHBKdVdrWE91UTIyOHZ1dFV1dmRrL0VEZENr?=
 =?utf-8?B?R2hzQktOMWRLbWhZMHZZdTNSci9OMVV0MHM5WTJ5M3lGeFRycjI5amE2ZHBW?=
 =?utf-8?B?STBOWlNmZjhLYmlQSVU4SXI3R2lKR0k5MXQ0Vm9xWVl0YW9jYVVlcEJGUStX?=
 =?utf-8?B?cE1uMU9GUGZIc2JRNDFLakJyYjE5Z1hJSVQ1TGVZK3ljRnZadWNBb2ZSVXVX?=
 =?utf-8?B?Y28wYzV2Q1pVYnNXNjZwK2JFZjJoNUxxc0RhSkNKQVc4bENtazZZNmtBSEth?=
 =?utf-8?B?cUc2L0JHenJSaUlIUS9hcDhNbXpvc0lrdmRyM2F6bUZsaVVtc0w4ekJYUEg5?=
 =?utf-8?B?WS9FbjU3M2dvc3ZxQ0x1c0FIS3dWQU5hOERUWkJUR0Y0TndzMTVsNDRPbjEx?=
 =?utf-8?B?aTBpY01JVW9OdzR0NWtFZk1jUHRSWXA3cHlkSGN0ZzJ2UkR4a2dhbkFDcUFF?=
 =?utf-8?B?SjJ3MmVEbzFFT01YOVIzNXlpaGFGbFI4QTBGV2FsaWpQbXpSTGI2UkNZUURu?=
 =?utf-8?B?MnhQWjdYcURvdWRmTUdsS1ZSV1VOeDRsSEZYQ2ZwdVRZZnRqN05PeFFId1h3?=
 =?utf-8?B?THppQ0dYK3lGY1RtMjlRUXBIdFlhOS9VV3pnT2wyZ0hlcXRyR25nYWtwMHM5?=
 =?utf-8?B?U2lobVU2U083VUJIdUZVdzgrR2VITmVpem1CdS9kSG9PTGNKeHdKTVEwZGMy?=
 =?utf-8?B?RzZDcVcyaEZFUnhyQzdKZFJ4NkxGWnFtTlh2TEZuVkxERHpXYVpzM2c1aHp4?=
 =?utf-8?B?T0ROcGkxSXFvcGpUVVNIQ04wbHNyTkxKQ1FMRjRZWFR0S1JlTzJlUEV2VGh4?=
 =?utf-8?B?a1ZGV3FNLzYxN3UvaW0vZVlySVE5RHhrdHhUVXNnOGk5NmxXY2xFMnpDZXpR?=
 =?utf-8?B?T09lQVlDbUpSNStLUU1FZG9NRmoyNi8yZUQ5NVFobi84eVZ0bkZUalQxZjdQ?=
 =?utf-8?B?UUVMRXRzZFB0bkpOY0s2dXZidmg0Y3hmYm1ZdlJkOTRMcGUxdlVHM1UxcWM2?=
 =?utf-8?B?NGNhS05vTGErYXlzMHJHUGMyMkY4TEZxbnhNWGNMUERsS29WTVRYNUVoVG91?=
 =?utf-8?B?YnRhV3VpQWtmUk9DcHFpTHIzanZ5M2V5M0JOemo3eThwdGhCOXJnQmp2Sk11?=
 =?utf-8?B?NnRldGhRbHp2TUczSGhLV09PQ3FlMk82ajNrcEdQUkMvWDhzRnBJQWlRL3V1?=
 =?utf-8?B?MVpOQVVxUld5UnFxTmRIdjh5SGovek5kaUd4ekIzNnRHTU5ma2FhNWp6V0Vo?=
 =?utf-8?B?dTk1MkVzb3YzYVROQ0xSMVYxSjUzRnRpYmhIMXdFaEdmVjFmQkNWVm5jYk5y?=
 =?utf-8?B?UmNJbWsvVHd0MHE2dHIyb2tsd3c2YjZRY2lDU2EveWpkckhVc29haUt4clRr?=
 =?utf-8?B?SmR1aDBJRUE1dkMyb3hVMTZoY1Q5dEJicFg1RjNPa0dzT1lodlBvcWtyNDlX?=
 =?utf-8?B?VEorMkN6ZTF6NDdPM3ZEbXlHTWZLR0RQdTVCME1lbituSVJiNXlpUEZRPT0=?=
X-Microsoft-Antispam-Message-Info: JvOaZ09++fmP5p/3F6XwInSgb6QNrewB1+t9xe7iOYuU1TO1GqxR99jHcIMHI/n+JwaLxznGY/Jl81FMaG5iMaglOaThBFjeQsQEFEUulPlwOios/XUf0yLotVm6xPRPXPJ/kZrWKRGzQohwpAO0/Ajgnge0dl9wX7Mi4lmrbW1eRc1qdkv33YcNNYDaY2Z4+w5WIpbGcMekNkh0lG9EnUmDxA9OUxGDdmdT0MDFhA/URU+cfQ4Kp3l95metG569CF1FUk+D3tBBXqkmIuvHEXLv0VHct92ERuCW0vOgSywBFuDJ9TA9sztxsKlc7/fNjlPDybCIfY3kNFiVDcSFu3aGID82qhLqJWallkTwOxyIwQXvv3d8bcNV87mCjiTB
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1128;6:7TIKD1ecasuFeZpke7BBIUTuXSBJSODyzfQa78eC3+yM35dcwBKWlmajP4gD1Jeh/Xu7zV4ySheoWA/tjLoOCdb+oTvG8oXPRtXlQZJMuKiwSixqIihiS2KXIKbgH2588srtc4knSFe2dTHTxMbDfjzivtm9cC3WOpz0QhMZfmh9ZNxUjwwfTmhPLtkZjONGroaq+4lQDnTJ9KvqYoYF5O27h9tprWa+PUYao5mJWUagdtGzLZxrruVAHZ5fztIZRRxl5C5+Cy2hlsDah/MtT3Ww7SSr4jhX0mdz+MXFy7ZDEzUrt4tCeUVZT2qfZoQHbT9sRnloMaA17Uxla3RhtnE8jZX3gvcbuVDO7W08Zw1Z4EhXOobBaRQFgvwVuiU59rRQWhDX+QKbdwMyo8N27A==;5:lAffQojuMH7f3kmvLrb+mXRoaDmmYscC2CbK/HKtdT9D/pkKsTvgOqh80U6yFtb/3oy+SKqgHFnaHyRcDlxTb939iiH+iHTQ6Au3lnykOWkh0I5S6ASo7mfRm6Q9+FDWKx93j/xEC2pNRyoZJ+9qWkgveBqIrQ4VHhFx4h2nqVg=;24:vUCuG6Kg/OISbfZ2Iqq+wrUykFpSrNaV0hNMKuUe7hGhcJZciZGgtz5Zr1kYTu+t3SOzSSjac5q/VP5DiHRLO2o7DMLIZTPlPscDK8MbGoU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1128;7:guT233Q0Pak/rhTYQ8GUbM/M5LVC36RevBlgprNMvY8v1Wmv32BZtwK2HOHcUAUYRfhTjXfLgPdlTnMNLkgjmPwjfGHCNiWXe3UcyGyYSDdBXxS+kBYR55JbOSn9ysUgRYoSfBZovkQxYDOzd5x6E6M7hn8l48nR+oGr/waM5ObaP81QK1Jj0v4yCnvZ9LbU3eS0qqIdME4dQ4KbkLpW9cKE6+fDDA5KtCZx+QT9XGMjbnpeHg877aN19WHrEDGE
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 17:33:17.4113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d09e3b-64cb-462a-0b81-08d5890881f7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard!

On 13/03/18 18:18, Ard Biesheuvel wrote:
>>>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>>  {
>>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>>                                                           &mod->arch.init;
>>>> +       struct plt_entries *plt;
>>>> +       int idx;
>>>>
>>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>                                                            ^^^^^^^^^^^ (*)
>>
>>>> -       int idx = 0;
>>>> +       /* cache the address, ELF header is available only during module load */
>>>> +       if (!pltsec->plt_ent)
>>>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>>>> +       plt = pltsec->plt_ent;
>>>> +
>>> Where is plt_ent ever used?
>> Above is exactly the place it's used.
>> I need to cache it because after the module load is finished the ELF header is freed,
>> pltsec->plt pointer (*) is not valid any more.
>> With the above modification it's possible to call the function during the whole life
>> time of the module.
>>
> Right, ok. That's a problem.
> 
> This means that you are relying on get_module_plt() being called at
> least once at module load time, which is not guaranteed.

This is indeed guaranteed. For FTRACE use case. If it's being called from FTRACE in
run time, this would mean there were long calls in this module section, which in
turn means, get_module_plt() was called at least once for this module and this
section.

This doesn't hold in general, though.

In any case, if you insist, I can try to rework the whole stuff implementing module_finalize().

-- 
Best regards,
Alexander Sverdlin.
