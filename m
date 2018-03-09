Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeCIIz6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:55:58 -0500
Received: from mail-ve1eur01on0118.outbound.protection.outlook.com ([104.47.1.118]:58688
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751026AbeCIIzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:55:55 -0500
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH v3 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <linux@armlinux.org.uk>
References: <20180309084151.2379-1-alexander.sverdlin@nokia.com>
 <20180309084151.2379-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu87oP4Bxn_XkQkc2zf8GXLhoRkWBkUr5N0KMdyMfq1GMg@mail.gmail.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <93864477-75bb-3f73-1d06-03d128b04f94@nokia.com>
Date: Fri, 9 Mar 2018 09:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu87oP4Bxn_XkQkc2zf8GXLhoRkWBkUr5N0KMdyMfq1GMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(57704003)(199004)(189003)(59450400001)(81166006)(77096007)(26005)(68736007)(53936002)(81156014)(186003)(8936002)(8676002)(6346003)(336012)(2486003)(2906002)(76176011)(4326008)(23676004)(356003)(106002)(106466001)(22756006)(50466002)(58126008)(31696002)(86362001)(6246003)(305945005)(316002)(97736004)(6666003)(5660300001)(64126003)(478600001)(229853002)(2950100002)(36756003)(65806001)(31686004)(230700001)(65956001)(47776003)(6916009)(26826003)(54906003)(53546011)(65826007)(21356005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1054;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT019;1:h288wCVwVcHMcgEs87zHtijyDb1IwcpX5HWKmZ82JIPCim3h+JLWXp/8F0rzY4vCgLJsgB1Z+nsQpOkrGXgfBruxjApxkCpyGHNMlbqn4cBIBWcv+oGqDS9lnlQSryI4
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d9899b5-ae82-4388-e199-08d5859b8fb2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:VI1PR07MB1054;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1054;3:3NH6WZr2W90ilWgzrzVKa9N3d5c2mygCyEtXU6XqRcXho5QdxFb6YpjSYlDu9iQ+l4W4Ov6RrhTkGobn3KJkRPvv5BwS+DyeuwB0QKsi8xxz3/vaD1ffF+q/+j+s6CoNPOWcBWd5so47Qf4dDyctJr9hlpY0VusSNEw/fjCAe8oluKkwkMENb8pkbtJwfExl//W4wWBR43qimuWm5NqZfldTQ+VPXxsWuHIRaArfB5tGYmidZzFlr9H1tUjSgRBy+1pZKAPTLp9jofoxVPxJ64+CL8Phnu9+dgH8SzYKnZBwIc1mMFIf97dCJYDengPYrmRoy72ZNGHCf4cC7Ix2HL8LTMfzyrjR3NO2tubxq3g=;25:c9DFgIeqGwuMM5LiZ+ZS/dkPtnWfMeiUCho6GQw0gL1CvDf2N+wZHELbKGtgd3KmPgiwAmsaLIfTE/+1F712d7A8KSxkUlOEkFDqfBFgrgWYD1vJoJqnyRVkc2WwQmQXm+Dr9G6Vfuu7PvJw+vYoVGVZN8LU2FowbFHpFAuzCWESfOVCqUEw74noNgQRXumyRNG+hOhTa07+uoucojtAVQ+/HpGnSM+97+UykngUUcN+WtBVY3C5ZWGh/n/6CEjcfjW4u5W5wsHL20Euu+mpSJMaYB3t2xSVqw1AudeU3tGY3xGKQoZXZ73w/b6uGjEA4X/y2IdJsvlx9XSzYH+qoA==
X-MS-TrafficTypeDiagnostic: VI1PR07MB1054:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1054;31:AO8kciBbmrygtzU2pbqmyBCMSw23bnVPYwWEuH+Ef3jYvbF+4TXS/V34HnGo7mD1J53xyFckbfsuKTvi+ZOUiHfbqnZ3GKg0t3hSIulMSYRc4FXNOVbdnjY5dZL6SrjIEB7EuZ0OZPFubsE6pLpAjNrhhOv7q0d9AKJerzaRTmyWWUkCTxAlaKt2Wqgtaig3g04M6rwjdYhPstidN08w7lab+fqAK5jKeqhpjEAcVzI=;20:fBAKVf8QfzabW3K/eJdW1CqnSB9KX6JtbflAuDTuK+m59UeaGweRj0rwQ7nkLuYa19djuKypFFSviPWfQmK5ddYafuECqQr8/2VoyLcvPGZ3OOu6TP7N5LPWO1f8UsMMiu9/er2CyDuUxpjc3I3fqyK69IfDErF7k7dsd6r8xMkzm3WcjkMO+39pgABhr4hz+JWfLZ4pUYcCsTTsGkkvIqwbsJmcEEoUOzBr0xmcPW9cT/v6hRcIjDpiddzM8F5qcCZNrbTMn7FcUyXPPkOG6OW61KpZl5z0J7kxsssmkCFh7U1AWI99KvUysnLH4+oSUQPnqJN1COeYhm8af0L42/8BPo8QJ0d48tbH+vy3iBcy2WZfTj7e2Zdqv3EZWxHo0MDX6P3158A1Ewcx/pMxLLgfw0rXYgwuC3GRySFBcngT4HsliChVIb0NJOfADgr5Dv/y5lYrDGFaLp9aJ7La4CGgb6rHD+N7w9ym7bnKqWuZiFp5MymDeXNmXPjHbFtrkA/mlUdv7gAWvZM4oC+hjTPVDHpewhUxqG5NSoam8OkcgGg8HOFzfF7+Nb9RVAZaqzlU2fZceCh3Xemre/ew3avQsAmeq6d6bM34zPt9Jps=
X-Microsoft-Antispam-PRVS: <VI1PR07MB1054C89FEDE26C972EA101E288DE0@VI1PR07MB1054.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231220)(11241501184)(806099)(944501244)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR07MB1054;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1054;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1054;4:rO8feXRx7VstA/OAmV1E9WriCSkxpZ+IE1+9qZyb+3x66u3EFxg6PYY1q2ngJUOXLVCP9NFRFHwftUW4TXSMi9oRp7n+MqaRoLEXjPDO33z4fQiamLNLbyytTcxmB7fUfQiCH4eqOQFW2uLwJZ2WwzJ+ekguQPfl0PkaFgfpN9yRAmMy8h/7J0e9wKSF6dFx/TNChtsxdxl5gkqS++GD2jsPJHKpR2SSUq35ydH/grlQHp+V2HPY6qT/mcSBtK6MJblnw7xFqmeS298Y6R2oug==
X-Forefront-PRVS: 0606BBEB39
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIxMDU0OzIzOkFObm9WUTRxMHBWdjZEaDFOckZTTlZjcWFU?=
 =?utf-8?B?K24vR1phSnYweHdzQnNVQ2JETGlzS24yOTNKZjVNVjg1QXlqL0o1Tk43TjNr?=
 =?utf-8?B?U0JKS3BibXhINDV4QzJNNXhjV2p4VitDSFFUQVBDN1V1LzJZOUZzWmJZYitM?=
 =?utf-8?B?anBkWjA3d3B6MlF6Z2tCTnNEYzlVcVNENmRPZXRnaUxFcUxTTHJ1aHo1ditZ?=
 =?utf-8?B?WWE4L0RIMFc0K0RmM0JZUGp3NWpCSmZySGtmSXk2WnZMaVpzckJuZ0JlM2Zo?=
 =?utf-8?B?ZWVaWXp3SEVvTUhGYkVIQkpvRnhhRGxibXJWQUovTDdsY0pzL0srcStWU3ZU?=
 =?utf-8?B?NE5pSmhVenYxUExva3U5UFN0K3o3WnBMUXlndVRiaHZ5ZlRyZ3k4SE1MSUlG?=
 =?utf-8?B?eXluOFFYNjdaQ0RESGVFSndJREN0RGJJdEdFSlAxcTFQN2xEMTNtTS9aa1Y0?=
 =?utf-8?B?QXBJTGVBbkJ6SW5pdm9PQy92WlEyK3VXdG1IRnhZbk1ZMkp5ZDlNWlZMUGJC?=
 =?utf-8?B?d0lOTTlGd2dYWnRBbUxsUTB6aXFlalVJRCt2V1lhQ21ETFF3TWtpbTJuS1Vu?=
 =?utf-8?B?U1VEMmNsQ0VEUm9jbWxvK1phZWFuR0tFbjdFWnRaOURZQjZXeUVudUxkZzNn?=
 =?utf-8?B?MkF1b2xrcXlNcEVBVFNqSXZiaGlMUXZiYU5uRWg2TkhMdzNzY2JmaWpUdWxY?=
 =?utf-8?B?RkI2Zk1mbFB5dGNud0xZZ2dlZHlKdXZ1WG41MjJFNVc2bEY3OEREdkpobW5M?=
 =?utf-8?B?RVRqci9GaENTeFJ4ZXA0bUVkOXVEK2Q3Y29lMVJhWWJaSUErUmpCU0Fyd3RD?=
 =?utf-8?B?UlU4cFNzYXBYTG1Lb2poS0RDSFlrN1NDRUVLNUdNeTRyaU0vWlhuUURMSDdC?=
 =?utf-8?B?M0ZZcGZOUlV5SVBUUWNSNW1oMFl6M2RLSjlGWlNPSVRnZm9iSTFWMlR4ZFhx?=
 =?utf-8?B?UFlBUWQ0dENyK0JwNmdjdUxwYnpaZXlnL2JmVjVmMHdEMnJpb1pKdFVrbGpl?=
 =?utf-8?B?UW1vbU1KWU1CWGZUVGxlNTFETXcwWlZ1K1VhRG00VmpmdXFONFVWcjh2Z21Y?=
 =?utf-8?B?eGVkOFloa2FBb3hTNzV6dWJsUytGTWlvVU8zQUFEbk45SjB0SDdHVlZCVmVo?=
 =?utf-8?B?OEU5dE9VeFVLSGo3NFAxOTcxVG93OGVUb3RSZXQrbkVHY25GR2RWc2QrZ01x?=
 =?utf-8?B?UmcwdXg0UDZCcFF0WXd4TURINmdYTlovM2NSZCsvWlRELzlzTWFiRml2Y0RI?=
 =?utf-8?B?VURuUW9ZanVKamdadkNIVm54TWlEU00yYU5sQmE0RVFXOFRsZHphOXZsaktq?=
 =?utf-8?B?Rk9SWUpNMTM3RW4vbklSWG5yU2FhR2tyZ0ZuWXcwem5NZERRNDlHS3pGZjAv?=
 =?utf-8?B?Z3doa3c5elc5WVM1ckdxbC9hbk1wcXphS1V6S2VwVTBSdFowSmlUOFJJNXFa?=
 =?utf-8?B?T21ST2dVaS9udE02dXA3dzl6NHFtTHhqcGJiRVFhdkdEK0l6ZXdVQmttSGkr?=
 =?utf-8?B?ZnpLRFg0azhtMjdWRHlYUFI2eGcxTkxIOHBlZllUN2kyeHF2ZjBrZlRhcWMw?=
 =?utf-8?B?d0h5cTFTRHAveEpHVmVnUzcxNUMyWGN6OEpWWnlYOC9hS3BXSDdMTVN0blND?=
 =?utf-8?B?RkFRQjJ2WDQ3RExQdTRwRTdxdmtaQ05mRG4wQXVvWVovU3h0UmlNZVVLWUJT?=
 =?utf-8?B?a3Y1ck1WTGh2TlY0TkVXK1NoUXJ5bXh6d2k0bFNVRFJjMzlxOTZuUk9wMHVh?=
 =?utf-8?Q?Jklxp2FqLhTTB7eBTdE3TH9VTOPxXwJ4jw41Y=3D?=
X-Microsoft-Antispam-Message-Info: TMQ/raEK8q5sM/uJc2OzDnfUTts2DAEYdYtbr57eea7bveGV5IayM/hvJf+8+1LE134c8a8BVf2Ks/u0JruxwtXEHdvpaJo2NJJoRYZ3IM/UTu05uvto9boXZhAGOH3m0vByCin24/JH8jzN5yYDWWOAITWQeSpW6chrOLPQiP6Xmt9LBgE1AF44f8sAqMhqsQX6QtFiv2TUlaz5e4Nrz6YqhUHdmzIPjc9EVUWoESv3i5J4OHwSsxDV3zsIz71qHXG/cqLzMi34SVKUP1Ct4Aw0zehkt7Spi6rA94KMHc6+DVEJbNBAzCfYcCk6zVil4LBrH65wL7QCmkN5KQbDQJMDV/YWlEhPvUZ8qM0vv3WGCXSqxd48wvN/gbh07PZo
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1054;6:pTEqFds0weoxp4/eNHyolSMf+XlDvtnDWaZtm85A4vI8wcMK0ryS1lryPZcG6Y6Z4bmv2UjFFuNwpZvirh48fGnUiuofc9JxIwd0+Aqn7Cj8JwnLxrqAigGxtDKJ0aEwqTGwxhBCG+NUiuNVv9yQfPmK/f1k4CCMUWGMMTuTwZ8zqF6ImTk7wAEoHyC/njDxeHmhQtJwhGXMveENnLaXpCzCS7gnnEi7RohwLCJIQxJhU9FHsnm+nBW3qadRxJNLjY16yUQPqPhTv2xQVw6JwDZLn9nbdXPljvnB0353njZu7QlzwdbFziBaiq/d943JZwbUB1K9LG4pehdddWh9eEICfXSGWKh79qMqxcgEyDzsgzs1pWs1JZRG6lAAHH1CchxzV+iCcbriTnEv7B5CGQ==;5:OTzSvczBX3ctgBloVO1USyGfFRds/9GxWgfBN/FVB8FEPjNYIBav+MgFJpRS4lbTvA35uVAUInp+LnYOO6D9LFZN7UFpOmiz5sKgOU93kSrK3W0ifSgBA3BrcWv0m+ltsdCVneKBjqR2ld0mfaF3/zpQXqPyCwarQ5P0XBWnOAU=;24:CcHSUd5pZgdAAabe5Ey1EWUAxtqtm9uq7dFdjMj9BCblTfIGsJiFKGFySmyO4OX9TKg6X+zWSB2QEGciTlvFI8m3vb8myPuow1FH7T8tfvc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1054;7:jX/uyJM8gq0J9WT2SztZtcsPrYB6xMb4qfTcSBUQlH+76skuaCTncTNCGLbKfuQaseLq5YslZBT2vhy3KC5AzP1A0Z3Cn7+eWZqqug3gAv5B19tbkDk5kitx6QAOr9nZ96wyCiAoXA107P1ndhZLULAAsb2ADj4hBnQDDUGG098nJUuF0ZYWoLwbdLRAZXpublBSxS0dKxhH7QYensIMZFIaa/C0yvwopDCKJ5rt6KrHnQOhZyWHRgEhbEsL//S+
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 08:55:51.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9899b5-ae82-4388-e199-08d5859b8fb2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard!

On 09/03/18 09:50, Ard Biesheuvel wrote:
>> +static u32 fixed_plts[] = {
>> +       FTRACE_ADDR,
>> +       MCOUNT_ADDR,
>> +#ifdef CONFIG_OLD_MCOUNT
>> +       (unsigned long)ftrace_caller_old,
>> +       (unsigned long)mcount,
>> +#endif
>> +};
>> +
> Do we need this stuff in the PLT loader if ftrace is disabled?

You are right, it probably would not even build w/o FTRACE.
I'll fix it, thanks for looking into this!

>>  static bool in_init(const struct module *mod, unsigned long loc)
>>  {
>>         return loc - (u32)mod->init_layout.base < mod->init_layout.size;
>> @@ -31,26 +41,43 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>  {
>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>                                                           &mod->arch.init;
>> +       int idx;
>> +       struct plt_entries *plt;
>> +
>> +       /* Pre-allocate entries in the first plt */
>> +       if (!pltsec->plt_count) {
>> +               plt = (struct plt_entries *)pltsec->plt->sh_addr;
>> +               for (idx = 0; idx < ARRAY_SIZE(plt->ldr); ++idx)
>> +                       plt->ldr[idx] = PLT_ENT_LDR;
>> +               memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
>> +               pltsec->plt_count = ARRAY_SIZE(fixed_plts);
>> +               /*
>> +                * cache the address,
>> +                * ELF header is available only during module load
>> +                */
>> +               pltsec->plt_ent = plt;
>> +       }
>> +       plt = pltsec->plt_ent;
>>
>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>> -       int idx = 0;
>> +       idx = ARRAY_SIZE(fixed_plts);
>> +       while (idx)
>> +               if (plt->lit[--idx] == val)
>> +                       return (u32)&plt->ldr[idx];
>>
> Same here.

-- 
Best regards,
Alexander Sverdlin.
