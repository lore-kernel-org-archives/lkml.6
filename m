Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754958AbeDZJ0w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:26:52 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com ([40.107.0.100]:52356
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754934AbeDZJ0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:26:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@gmail.com>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180425175535.GC4043@hirez.programming.kicks-ass.net>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <de7e4b40-b607-1536-0f63-241107ce5c03@virtuozzo.com>
Date: Thu, 26 Apr 2018 12:26:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425175535.GC4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:3:76::28) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:9L9+0tG1BhKde6FJkDM6KOKoKOZ4b+Rmo79FdtjUzIGGPITMz49RsxJ9AvdZHlsOkj0AqM6TeaTFdf9BnB23MoW0xZ4ECGShimdSR14xjtYUwYihlpSnRA36LBAvnZpiDmdbnkZqcxfAqXC0nPiNJTkmCg4xUVo3tppQIZ33pNVqnYsnOKhPMntVM4Ru3smu/2bpJoeETM9+QMcPbx9GGFSNre1wqGFQyp+82Wi3FOVR3Vjn+GVlTTAHQERPcH45;25:3NVTJgFOMLCY59jsFBlN9mzlvshotytHcr5vxKzg+mz/DLPHqVB30ntc/0DBssKfCIq8Ww+XA9ZuZuzSoHnc3dkC7e41TujPSFiCGiTeMTAMQIxT87DvSNd0NzTQZq7BQm2TdvUn8JrYW/LyWq60PG8bUAkaPlcL1U3shg/wDf8+Fd3ruNUGKGjEWUnS1PV5ZRm14Dkjgp9R7c0bj5Lqu8mOWFugnRi67iLO41xBU/vrbCWXcR6Zn2wZwqTlgecLmmSI1ALWcJvZO6073QS+bbJLVxQnItB6ncwU73dBmBgAPMtUK257fPW6cnIBgM5M7xVPcIBatNF6FZ+WM6AXPA==;31:EF9u3pegeZNSTk9rHgS2Ic2zc7naP12WN2Kioeqi//wGM56B5xV4T5n3z0+JtykDFZCxrEsZCgO7A3rBjIbYrGIMMGjn9KHqIfUnwHc5IHs39XKJMak19QvonfNWvgYMuBwgjURXJem1d4O/Gc1e3/o0dQmUw/fcE9ec79Lvp8IiJ4bcvUKjdzNkQju4M6JNRaY7lQz98UT66+oHhl1UlZhsBxYqYJ7uHkUYAh++J6A=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:g5RCWRXQ2G/lwUuuYUeOA/UUNg06C7Ar1o3jsyo2Zh2eU4hdllHGMTa7JBz4GWSV9IZeIBKydv9WIFDiZuckc7Y8OTq66nOiysKvJZnfUxeJXXxigjf/gKW263zBo9UDodHeuvDkPE5XvP8YM7kkJpygmdzjAAhf9inI1/Ejyf5cVP0GwatbMwZ4YaxG8BWuD8OtaEYtyrt94BhB0icPxVKdi6FeZZlEjjXsWWCFT97Df5qFZEtSousKCm5aLX20W3cBc8binsfaj8AqJ3EbcLA0qzXanK/vvDkY+xMi9i/rbZqMT7e3Dme6nH1MFNV2GGb22+jMY+Hlp9fBdK/Nkkf1x37tt6V5WnpI3n47UsfblDsXdRb/Epc50R22Rsh1f1gAj784tQteJiD1280LGQOkVpMKgjJ43TBOaLrpSjXT4cBOgZr2gK2Gw6pEkoxiyrNq1OcK+22and8Bt4tLU3hPHW86Jawruur6yuiYkXUo73KyL+94hj2ibfWJCzHn;4:6kOV3K0yzszZKcTXVbLBIQYzdhzInYRuuRgvzoY3VHuyMXkutTAMiIt+Ej5Pt1otScoQIz9sutGSfk0clP2bNVxH0pT4bbRbODmpnukLsJKyBwOkOzLFIqxEItT/JcwH+B5hfvN8wRx/6QWHFPlgnfrumw6J85xKYXlW+Adwz+tz82Nk/zgjtmWRj+pd3X7v2XQn1O7QVyEKjs3z2NPPNo6Neg4Ra9q4kza/ZhHmujDM8x1eUSnu6NxspnP1gYolnmZDNK14yg46ZyunUaUafQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338C37FA2C4EE9E673E9631CD8E0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39380400002)(39850400004)(396003)(366004)(199004)(189003)(5660300001)(186003)(97736004)(7736002)(230700001)(8936002)(106356001)(3846002)(956004)(6486002)(77096007)(86362001)(6116002)(81166006)(105586002)(305945005)(6666003)(55236004)(2616005)(50466002)(476003)(446003)(229853002)(31696002)(16526019)(23676004)(6916009)(486006)(52146003)(65826007)(6246003)(66066001)(39060400002)(65956001)(316002)(76176011)(52116002)(2486003)(81156014)(11346002)(58126008)(8676002)(47776003)(64126003)(26005)(386003)(68736007)(16576012)(478600001)(4326008)(36756003)(25786009)(53546011)(31686004)(53936002)(59450400001)(2906002)(65806001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6MVZkNGpBcml5cmI3ZjI5cWJITjFGWWlt?=
 =?utf-8?B?OUJQQXpJSHpudUxSZnhqRVQxcGdTVTEreDlMeXZRWWR6QWx6ZWQ5WVljYTZO?=
 =?utf-8?B?TlNNeXVtR0QrcnpaY3RHa0FTUFBGUERvOVJUUUlmSTRFYjJJbDdadktGZVp3?=
 =?utf-8?B?dXVHeGZiZ1B2dU43QTl2ZjZuZ3FiMDBWSmw0WVo5SStvdmsvRXVvWktRK1lx?=
 =?utf-8?B?YXZZdms2dGxxeklNRFRXL3lvT0g5c0NleVpFalEzc2lmTUNzaGlJeFBKa2VU?=
 =?utf-8?B?R3dFNkQzTS82dFc4d1BVSGNteWhRVG9nVGhwcE5VcTd0Zm8zbzFHdHNuY3k4?=
 =?utf-8?B?d3hJWkF3V0M3UDkzZVltSCtyMk1iKzJlUWJCU09XZFNSR3hnQlRPVDRpNnRE?=
 =?utf-8?B?R3htVHJHUHozTHF6czBlMkdRSUdxUWM1WWVBQTNDSFRDT0ZvQjZ4VzYyZXdT?=
 =?utf-8?B?S0tzNHZhdXJmbXYzVTVraXA0OEJwdWdrRnZDNGswVHZhNVYwODBZWXA2Ujlp?=
 =?utf-8?B?TWVlOUxjMnUxY2lBb3dMZy9jUUthd1BpaHFCdFNsYkM4dWtJbVJCbngxcW82?=
 =?utf-8?B?UGlaeG04ZXkxVVB1cUdoVE5kMnNZSW9yMjVoSnBINUZXQWJjdVlkYVoxL29O?=
 =?utf-8?B?c2o4YTFpVVA5THN6aERtZUVKc1VoczJmZTJZT1NnV1F5WE1IRm1rUWlQWVMw?=
 =?utf-8?B?emUrM1l3VEo3cmEvMnFNYnluRTNQYnphVkpMaHJTTzhoVDdSOENKVzlUdjc1?=
 =?utf-8?B?aUFOL1FzQ1ZvVVZ4cm1FU3dJc2VmbnVDQ29rWk5IR3F5OHR3K1Jod0RMNTZQ?=
 =?utf-8?B?K3k4dVA1aWQ2VWhndXErMVNBdkJrR21uSFR3amJvMEpYdUFSWm1TMTFOTENw?=
 =?utf-8?B?V3FSbVBxL3FjcUsrMldLK0h3NVZFZmNuSzh3VTVVU01DR1NJUmJqWjB4cUk0?=
 =?utf-8?B?VDBEQ0lqeXkyOW41VFNFOEl2TStFMjJNNXpRbklIQVZCNkttQ25HdzZnS21M?=
 =?utf-8?B?YU9oaVZIVmRHWURYUWN5YTBqSkM4NnplbStEaUcwcFFWRVZRM1I5eHhMVTMr?=
 =?utf-8?B?S0poMDlkSDltMUJGbGtJYm5vRWpHYThUNyt4VEF2ZDlwbjQxVkY0MXdzU0dQ?=
 =?utf-8?B?WTZBL2FHRndVZ2Z6SktzdU5RMCtTMzVzdG9oR0dndXM0VlpKbFBjeFBxSDBz?=
 =?utf-8?B?RnAyY2tldVdhdDBGSS9NSWFxVlFoVVF3OEd6N0JpcmVHL0JlZDZ0UzZWN0Vy?=
 =?utf-8?B?SklnaGhxMEFReHlFRHhabXhmWEpRQU0xblAyZmdPcXJUb3oyMlVsdXNPRWQv?=
 =?utf-8?B?VHV6MVlIcUZ5Z2pxL25FeHdqSTY3NEJEcWdFSDNYRENtcG05KzhpM09kZHE2?=
 =?utf-8?B?NWM5T3F3VmFXNGM2NUVDamJCWWNzTmgxQ2dvWk4vUWtXL2FlbzhZTjJtdVAv?=
 =?utf-8?B?NVVqS0tlUGV5ZlFneFlUdENIdlRBTVZncG1aVnZxb2FHcjk5TnhONm9Sbkla?=
 =?utf-8?B?V1lKTXJoaTd2VENWQUEycWJPNzRrWWt6OEcyL3kzMEFzbkx4VENoVlQ4OFlE?=
 =?utf-8?B?ZmZYeVhjRHhWSldZcTJ5YjZOcFVqY3hCNjByZWVlSWRXbVFVSGRRenJnazZU?=
 =?utf-8?B?d3JDL0c0RkxQZHpPNFk2aklGRk5IWkpjQjZsM1BXVFF2Y2taWnd3NjJOVGl2?=
 =?utf-8?B?SkdWUnhEWmhDdnNjTDI0L0VneXBRNFBjSG1TWGIyMEJIZVp1YkpSM0pRajNF?=
 =?utf-8?B?Rng5WG1UQXRRUFk5eC94OXNMQkVFZmdOU0JvOXhhRXdNMGdCNXRVaHJxOXVU?=
 =?utf-8?B?Z283V0lSa1F0eGhkVmpCc1pzZFQwem1tcTRHWmJMQXN6a0VTSW5ZOWppMTB5?=
 =?utf-8?B?TVJmbDJyb0VIbllnTlJHZEZ5VUNrMWc4NDNtM1c2SXF4Tyt5cmdYaUxKdHZU?=
 =?utf-8?B?TkthUFhobkxIdjlIMStqNUh2a3dBT241QXUxMHdEZWtxQjlzdmU0QWx6cXRh?=
 =?utf-8?B?WmJCcnNvT1ZWbzJRcXc2eGc1eU1oODZ4Mzk0aHRBPT0=?=
X-Microsoft-Antispam-Message-Info: BUR1E3n1GDKO1EtczGhpHKFumFwBgvgVtoYsTQk+/med50IKwYjgorZHPA0xK89s/ErGYIniIWTLTxf+1wrX8Ed3nHlkIQE4ZggJ0CNbDC6y2CbGldHEUjAVdu8mV3L3wNEoI7W3aMVQPFKCgAkL8TipMucYSM6brUvfckSDPpGW1jrIOfWhzv/A+cyD3zdG
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:uokI3Oy3TxcpTD91XsGc76Dc+YwW1rV6mgGC4+XD5fbzIMvsffzVYlt464+qoEMjs3Pbn0+MTHWN3dGwxwdmdz7vYzURj6bTD3lQFtgTHVvN2Dr2hU5y7SEb3jfccE/2ygWd3TWxbrX4RN7wzwOTwKDb4F/Q8yjQNueNZnu5r3o5+BZKtzagoNeIHIzzea66Cl60UF5peNVyevIdpfvbcChJyJ5DBTa1TBfwQBh9/c7YVt4piJVkvJyGJu5joq+PmsjTH//Z+QfzFvPng4mV3an/ibl0MRNYIoIfA8XonDRKgecH/i0Icmi8UNHuki1dC1C7grNR6LgKRoFvSXyBmBjAujWU8AVnCcSK+uHhi5gar4gj0s7LRjy5Jevfu4Xn9oXylGi37yz+QN1f4UV70fTYA6oxCmoSsPh4sHyUQ/StjnwRpK6ZMajZsQ55lL6V9zBp0UfTMZDHJzj/fRj6yA==;5:fnqP7vLLviLCFLIGI22O0EEz2BYHznEo3/oqANqZtSi5cBWoG05Ut67EijczOhC5Odfrxw6xNolFKD0e9XJz9EcjRnc396slNMe11n20VRD+ViXPVZA+GMesnQKy6ON5qad5Wv3SY9sr5ESipEfp1Qj/wbPHfYQ388HmFpZqs7k=;24:gUnFfgGLVXl8ewRi1NIa0MgEUr5bEP+Vg1fCpSeIDGk0DP2YM4NpvOkbmyCUhAUgwMUNUra8OmRzvmCbcjVXpUOHJjLEUOdguEkDtZFn0d0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:669ocTBBvq2qj/Wgbmkfl8Vh6vbOhUMAJ4TgyE861TcJKLcQt8+ZY5WsI9ehiiKzJQs4rPzQFCQIPBRTpimnQUTFxLycGCPDJbin4iBXTSTYoxB6CIApX9olEOQD8603C6TlzPwr+m0IwK2THGJPlNE0///KRQSOGOtronMbeWzkL5LUW0Y2laSwM9iVwTSSFzlkLLaBb3FqWWk3ZVLGFalkrF4vys3mlh+SH4NkqFucspHlKz68r5aM7P8GdsOu;20:rj5x+WWx6ewjK/4K39cQWa9988tDkpz9/ZQgzbBCWEEjfwWJ680PJ7asuyoqyENRh2ciIGy3zB5QOatUwLgM78oM7tdCbKf0oI4+f3VoOnCvEH4Wjrb2u3AAhaZkZltyG+CuMJZYNx6sgl9Vy5fWZfW85p8K9mmy9xM0U6LRRnc=
X-MS-Office365-Filtering-Correlation-Id: 409c95fa-3133-4bc6-00f8-08d5ab57d21d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 09:26:41.6538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409c95fa-3133-4bc6-00f8-08d5ab57d21d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.2018 20:55, Peter Zijlstra wrote:
> On Thu, Apr 19, 2018 at 08:29:01PM +0300, Kirill Tkhai wrote:
>> tg_rt_schedulable() iterates over all child task groups,
>> while tg_has_rt_tasks() iterates over all linked tasks.
>> In case of systems with big number of tasks, this may
>> take a lot of time.
> 
> So you're actually using RT cgroups?

I myself don't use them, but this goes from CRIU project. We try to dump and to restore
every configuration that people may use. Sometimes they configure RT parameters of cpu
cgroup, and criu has to restore them as they was at the moment of dump. So, this is the place,
where we met the hard lockup. I can't say, what forces people to use nested cpu cgroup
for RT...

> Some of us recently considered removing that thing entirely because most
> distro's don't actually use it at all -- and it's broken from a RT POV.
> 
> That would then clear the slate to try and implement something new.
> 
> But if you're actually using this stuff, that would complicate matters.

>From the point of criu project, if you delete them, this will decrease
the number of essence we need to support, so I'm not against that :D

Seriously speaking, it's a surprise for me, that they are broken. It seemed,
everything is nice from RT POV: throttling, boosting, PI...

Kirill
