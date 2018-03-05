Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeCEK5G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:57:06 -0500
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com ([104.47.1.111]:26370
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934443AbeCEK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com;
Subject: Re: [PATCH v8 0/8] livepatch: Atomic replace feature
To: Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180221132914.4809-1-pmladek@suse.com>
From: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <5c956014-b717-aed8-de1b-58967ef835c6@virtuozzo.com>
Date: Mon, 5 Mar 2018 13:56:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221132914.4809-1-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0901CA0057.eurprd09.prod.outlook.com
 (2603:10a6:3:45::25) To VI1PR0802MB2446.eurprd08.prod.outlook.com
 (2603:10a6:800:bb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a1a5248-e8b5-4fe3-41f2-08d58287c916
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0802MB2446;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0802MB2446;3:OHscexwXLgxLBpKSnUu+PajwIIpEfGtpLtaVPjcjfMivk6qyNNm+gI5Fw9PN8vkxqvSJibxdMRKhARa0hXowx3S9ve4Gx2/eS/WZS1/Yb8/39B7rc5cNkbpMTnISlSSZckhWJbT//prhpQLsBCwJRZ7PZSYeyPufrj46Xrnj6FhD2qFC/C/2RYj5/2yGc8OZhpXY15pVjMdqHJRqnVjYYud3VMvTwtLLKhNusWBbSl1hW4V6mvA1t473wpmH1/Ep;25:5+XGiB9tKJDNrUvZQKoHn2gqaRTvB5Hp0b4KicBN3dEMErvvbveWVlvWd3HyacpM+F4c+qtAWjd0cuzvfgXXc6L60JnyFQU24Iy3Y/soaggXuFoa7veWlmYggNsav8YPZizDdRQb/Q23p1KP+9obSGsbPGZE0HIcGyHVI28ApBz8yHYvc7maJlb4UtwhHVSBItl68vOrz6mGS79Qb+xc1He8O3D5fZNFXsW9uKzMbgGXfu2J/lDyigUo1jPde4lyDotC6qARx4JBLENjPO9BYCWmi/DNRTynq49tvIA3zMAfSAkH9GLwesSTNn+jqa/Aw2mHW2YqsV5iPEDN9v7xUA==;31:aGgF8ovuVTeQ1Uh4F1DhbMa7XgWiQOHi8rSNurDfUVoAiiQIQL22qvFjJgmd0Y15N8yK9J15D+Kb9FEVRIP7AYaAqEV5MkZ/Wh4EcHmbki1mRhXsY7B9puJ6m+kg42/u3+TbZoUhtx+Iq8TFVfoFaSwXdHrnTT1S+ib5cg78TEZwo5hzpckUMib1M/e6+zqAnk4QJF3Dgv0ix4/uzvu/03kXVzF6cd8vGNp+1Hi0kjc=
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2446:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0802MB2446;20:NNqshVua7yg21Db2DJFaYxTttYR3MZdl2KEoZpRlL581Fxl+j9HVaWFINXphV5G1KMXHjfQmypqld1Gbac5beMqSxLuPz3PQg4AKY4q+Gw5QwDy2smBw6MblIiZ7wC6axZ19KThKTHHIrnvwP2xi0ctjs3W/7gqpPu2YKLOaNlSk8yRbvEP3bl+yUISXqWx1u9m0GUbYlyJAu4D3iX0EHnxxw4penh+UUDQibNVPMspe5p8xOLDM9fdX+xMVcuQIOyMT9y7yTE3yDwe6elnJWcP8VjO+occijJJQvitfm2wPmq32TI3XbJ7stnbOMxjFmXDIu17LEeVFsD09vcxZRAffnbPY86GFuhGR9r1N8mXImJ5ZcMC15ZFluV4r6Xk96rIvfnx3hOcgXm1iVyTh+R6IqxmlzHum49BHl2Q1KVGctVWJsrFOpCW4z3GvU7SGLZe8HJe/tYpMla8NvurHFt9IywGT6TyPJQsdu2LRnsPH4Lft5qfrF3h0E7LvRCLx;4:DwR7qkWxf3z7+wTzfohJXBw3dyFiXZ6yVWICRcHvGOifgZFPRrnvJP/fAHdB54FyS8OOPUkLj0UauW/pfY9aEMpR89RDCJRkQ2031BCgcQSuU+MIJ7lIkuV0+IngwrAnls7C+/zYLmShsMC1XvvyWNS8cKb1twrw4w2H46WsAI8QeGkVrxdNg65rw/egpBt+wOw/YvMLEj+dKdLG1oLBa+uvB5f0BVnzeu+da253yGoRz6eqHE2ImlprL2RhbHutwhEUUxcoLbjNOalt7vzBSlOjpmZ+AqAh/m+onRDR6WEvu6JmzVG8+5fnuLebwqVD
X-Microsoft-Antispam-PRVS: <VI1PR0802MB24461F77ED846D34D27E3FE6D9DA0@VI1PR0802MB2446.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0802MB2446;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2446;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39840400004)(366004)(346002)(376002)(39380400002)(199004)(189003)(4326008)(478600001)(5660300001)(31696002)(55236004)(64126003)(53546011)(386003)(25786009)(65806001)(65826007)(186003)(86362001)(66066001)(16576012)(106356001)(16526019)(36756003)(77096007)(59450400001)(2950100002)(6666003)(316002)(26005)(67846002)(47776003)(65956001)(50466002)(97736004)(230700001)(6246003)(7736002)(3846002)(8936002)(6116002)(81166006)(81156014)(8676002)(305945005)(6486002)(31686004)(58126008)(23676004)(68736007)(53936002)(2486003)(52146003)(76176011)(2906002)(105586002)(52116002)(54906003)(229853002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0802MB2446;H:[172.16.45.27];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDJNQjI0NDY7MjM6MTFSc2tTMlMzREdHZTBRUW5KVFpZeHha?=
 =?utf-8?B?QWtsd0lWeGNmUVEvYmtuN3FtYmppeG1xYTZaWWE0M1djUFBkcCtOd0RHeG52?=
 =?utf-8?B?L0RZQUtaTXY3NWFJRktucmdpbXZ3WmhTK2NzOFgrNTNqRXh4YitCOUpwVENM?=
 =?utf-8?B?elJ6MG1hOVhNaDF2blZ1REs4ZUdBMDlzVUdid3liK0lHWFBlbUJBUjFRRkRp?=
 =?utf-8?B?emc1V09OSW5SQ2pSM0F1ZS9tcDBMTVlzcmpXVEM3M3R4Y3c5WllLWXRBUzhL?=
 =?utf-8?B?OXIwMHBCblZpNVZ2RUpiL2g1L2oxRUw1NFM2NDNXTzV2OHpDVlhRRHFweXd1?=
 =?utf-8?B?bGVxSHE0R2VVWEdVa3pWTkpjK082azlBcEoxSzR2eWRkTm1HNFI1K0d6RCth?=
 =?utf-8?B?QzM1ZUl6SzdOZEVxYWRWay9IWGdySTFaMUNNcytjd2Q3Q09CeHY2S1c5RmJH?=
 =?utf-8?B?V2QyVFJzL21xZmtoaUdvclN6N0ROSDhWSnZacTNLUUQrUndjWkgzZUxGR3RG?=
 =?utf-8?B?NExWT1RVdHFMc2pYbnZmaDFQRzBEOFpRSE5PSWFBN1JkbU45YU40djZDZzcr?=
 =?utf-8?B?VkJuS0RSV2Fha1lGZUMvWTNHalluZWwyTXdXc1FJc0VMWlgySFByVGVYdXhw?=
 =?utf-8?B?aUp0NHpaYWI3d2xjY2ZMQ0hBSmp2ZUYvVndvL2xZZllVUkxFMUJ6V08rRzFy?=
 =?utf-8?B?b3ZyWmNIeDludTFUYng2Y2FHOTlyVkUyb1NsZHo0OWV4SkZxaUYyN3RhVVpH?=
 =?utf-8?B?TEFieWNPSU4yazUxczNGZlM5MlF3T3V6eFRuTDAyL3JoL2tSM2h5Ym9RbG03?=
 =?utf-8?B?ZzFhRVFvalBHR2NPS2VRQVJ2NHIyY1ZYZ2ZRRFB2YVZjQWlacDVxL2J6VEpy?=
 =?utf-8?B?MWd6V2RsaFhvTG5ySHgrelFuY3drY2hNQzVrbnNuejJ0S1NiOUxXa0I4QVh6?=
 =?utf-8?B?NWV6NENqazV5aEEyeHZzMmEyU0ExQXAza3o2WWZPNE5aWS9qOCtPYmJkUmVu?=
 =?utf-8?B?Z1B6S0lEVzBlRGFvZHRUQ3lBNFB6akIraE9lTkFISytaRkgxd2xYcWlzbEww?=
 =?utf-8?B?WjZWNnBYSkpYdGRYYWZmQWIzRjdxYUNNdis3dXBDaENCMUU5U0daYXp4S1NN?=
 =?utf-8?B?RGFuZlZDaFV3RUJnY2RNZTg1SGpSSWQ5QkZUZ1BTZ1l1Tk8vdmRVS0cxR3RC?=
 =?utf-8?B?cGw4dHlhTmlXTGpMYnh5d05sVUFSZ012ekpXdlFYblNPSVZ6Nlo2UndRVGxF?=
 =?utf-8?B?UFFzeEliYWJjSkRUaWcrOGsyVFNCZUV0eGJFN1M1R2FDMjd3TTVvT1lLaUhl?=
 =?utf-8?B?eExaZldnaTNFb1lXbXcrNkZTZjZSb0grelllbjNQSXJwNlJ4ZlEySE9kbFNK?=
 =?utf-8?B?RzJvTmtpSGZjTHVSU0w4Um1yRzJWd2phR0dLclc4UDlPSk5EZWRHQkU4ZVZs?=
 =?utf-8?B?RzhRR0tqYkd1MVpZellkUmhjNFgwaGdTNEFQMEI5VGdMWDU3OFkvS05XcWxQ?=
 =?utf-8?B?WlQ0Q0NRMEd4aDBFbUpzdVFSTEdaRVQ5NGlHbXVuaXBlcTl6ejZzOGRxWFls?=
 =?utf-8?B?bURTZDk2bDBHMEFPWGRIaS9XM01kZmk1Ujk5YXFDQWtNV0YrbytWN2RlSWl6?=
 =?utf-8?B?ei9USkJwcWVvQVhMM05KYVB2eHVLTXNmNHNVUFBLQzQ2WUN4VXZPQ2djYkdj?=
 =?utf-8?B?a0NpMlFvOE1nSjhxeFo3M3dvaUFDTlBjRVJIRE1XNjJPT0c3MStYR1V5S3gv?=
 =?utf-8?B?YmdySHp6QmZtQVN3UjRSUTJMVFg5bGNycTAvQXJqSjR0dTliNm81VDFNQWVZ?=
 =?utf-8?B?bWtrU3h0Tk9iNFJaTE1yU0lvTDRlRFJIY1VxY1QrMnZ1ZXNDbzY1T1NQRGhO?=
 =?utf-8?B?WFBxeEkzMUh6VG1KRFpVOXFvOWxFR05BRjlpSTI1NXBBNDJaY3RldEh2eW9I?=
 =?utf-8?B?eGRLTThDZjZsSkE9PQ==?=
X-Microsoft-Antispam-Message-Info: J6/nbElu482Gr/RUKp3MNEyGKdmraNGjnlwVp6PeObJYn63i+hPcwnnYIu8lySZM1cy6LufEW0DAzImhxvKX2K1Tv1rt1F5sEdfG8+CA3BJsyZe4Xb3nDyl9LF8oaWCWSKPgtQbrJIeTsBZG3dQEsrdrTMrn1rRTt/4RvS/JEF+gDDS0+cc0xLoplRNDcb4D
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0802MB2446;6:dL29Oy19JhrLcSlgtqNfOHhmwnFFNAPzt40jmmUVyFJD41rLNX0DI63OSNVeh63u0keW3djRYYSTin0gG3Uo4/Waa3WFqfw5fb5c2Eo9Hpf003BKTkUItTIXOF9668OEQilYrR30tSnjWXqR1N6UZ7pzg4t/u9h8HoqL6jQnGmvXY/hW5kE60IkfnD1ghJ6Fz5Yk5W5zQREF/38HXC1tfy1cod2o53rGy90JgoxoJ6YusicYGdjHBvc5sSrpA8JCZykbW00dVihJErO6wx23s+t+H1ag4NHax5nU1oqJNy3rJkgM76LtbMlk9MSeY3eKgytyrsGvhXTd19ozlsF3+f1NaQcx3KCuQcPUSSgnLio=;5:y2and4ToRhAqn36k9uEFVgHULY9RhtIcigz/rSRV9mjiDCekf3/43QJc4ink6O/A8nDPNfPM4RP84EDrcPfbkOkUIx87I38yKeIOW4CSpP9HCyXaIKrxDmMxDQLZEWkZExecfqHcrG+dLzU1gzbQCMGtHXzpDygQ9gqbXsJnS9I=;24:GGsaQifhg8DZzwUfuh4+CiMLRtB4XTxAdBxzTRSTDzkJq19Xr4jRZ1XtHl+wHpcv+SaYh9Ynu2738vCYYs+/80N7M5yaPRMyWWDU4yvWbSc=;7:c1Jdcf78FGjCQ8CiQ/Sbt0CgfJM1aAbsfi+FyhU41aLKoGo/HGfJe+j6afXZW1ypQTfrNOHjzs8SjULvw2k6M1k0f99SD5Caa3cVgIRyiawR79KCGzYXEn3T80sH1FqdXjFhEPT3i0rCc+tYm/l5jm8YP+MR8g0hmXeLSyXakc3zI9gLhvZK7BGWG9QXFA1RqEzVQlREGFcXIk8pevx2ENPP3b9G1zce2GUWck0jDkywqSSIORvRtiVkifo4VEE9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0802MB2446;20:RpROCy4UPfxMMtZceZUBi3Wg/KiOEVzzIVmqTMPthfFVUW0GrS64+LXw2nQaZtZrpzSxmYgz67ymjpJum8aEPIeC1ZN39ylhF6MYyaztGfnJ5UaXCYVtIYBzRauEqvtP9Bv1oJEVcD9p/EDi3AANVmFeYjeWwy53zSwex4QCNPI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 10:56:44.1324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1a5248-e8b5-4fe3-41f2-08d58287c916
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2446
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Petr, Jason - thanks a lot for working on this series, first of all! And 
especially for your patience.

On 21.02.2018 16:29, Petr Mladek wrote:
> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.

I have experimented with this updated patchset a bit.
It looks like replace operation fails if there is a loaded but disabled 
patch.

Suppose there are 2 binary patches changing the same kernel functions. 
Load patch1, then disable it (echo 0 > 
/sys/kernel/livepatch/patch1/enabled), then try load patch2 with atomic 
replace. I get "Device or resource busy" error at this point.

It seems, __klp_enable_patch() returns -EBUSY for some reason. I haven't 
dug deeper into that code yet.

A workaround is simple: just unload all disabled patches before trying 
to load patch2 with replace. Still, the behavior is quite strange.

> 
> I have found one bug in v7. We were not able to initialize NOP
> struct klp_func when the patches module is not loaded. It was
> because func->new_func was NULL. I have fixed it in separate patch
> for an easier review.
> 
> Note that the original Jason's patch did not have this problem
> because func->new_func was always NULL there. But this required
> NOP-specific handling also on other locations, namely
> klp_ftrace_handler() and klp_check_stack_func().
> 
> Changes against v7:
> 
>    + Fixed handling of NOPs for not-yet-loaded modules
>    + Made klp_replaced_patches list static [Mirek]
>    + Made klp_free_object() public later [Mirek]
>    + Fixed several reported typos [Mirek, Joe]
>    + Updated documentation according to the feedback [Joe]
>    + Added some Acks [Mirek]
> 
> Changes against v6:
> 
>    + used list_move when disabling replaced patches [Jason]
>    + renamed KLP_FUNC_ORIGINAL -> KLP_FUNC_STATIC [Mirek]
>    + used klp_is_func_type() in klp_unpatch_object() [Mirek]
>    + moved static definition of klp_get_or_add_object() [Mirek]
>    + updated comment about synchronization in forced mode [Mirek]
>    + added user documentation
>    + fixed several typos
> 
> Jason Baron (5):
>    livepatch: Use lists to manage patches, objects and functions
>    livepatch: Initial support for dynamic structures
>    livepatch: Allow to unpatch only functions of the given type
>    livepatch: Support separate list for replaced patches.
>    livepatch: Add atomic replace
> 
> Petr Mladek (3):
>    livepatch: Free only structures with initialized kobject
>    livepatch: Correctly handle atomic replace for not yet loaded modules
>    livepatch: Atomic replace and cumulative patches documentation
> 
>   Documentation/livepatch/cumulative-patches.txt |  83 ++++++
>   include/linux/livepatch.h                      |  59 +++-
>   kernel/livepatch/core.c                        | 394 ++++++++++++++++++++++---
>   kernel/livepatch/core.h                        |   4 +
>   kernel/livepatch/patch.c                       |  31 +-
>   kernel/livepatch/patch.h                       |   4 +-
>   kernel/livepatch/transition.c                  |  41 ++-
>   7 files changed, 566 insertions(+), 50 deletions(-)
>   create mode 100644 Documentation/livepatch/cumulative-patches.txt
> 

Regards,
Evgenii
