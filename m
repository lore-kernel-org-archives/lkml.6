Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeDML3U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:29:20 -0400
Received: from mail-ve1eur01on0112.outbound.protection.outlook.com ([104.47.1.112]:34736
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754208AbeDML3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:29:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <152354470916.22460.14397070748001974638.stgit@localhost.localdomain>
 <20180413085553.GF17484@dhcp22.suse.cz>
 <ed75d18c-f516-2feb-53a8-6d2836e1da59@virtuozzo.com>
 <20180413110200.GG17484@dhcp22.suse.cz>
 <06931a83-91d2-3dcf-31cf-0b98d82e957f@virtuozzo.com>
 <20180413112036.GH17484@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
Date: Fri, 13 Apr 2018 14:29:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413112036.GH17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM3PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:207::13)
 To AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:OF1NV7pk4beKxHPbjRTXt+euFlC2c+rqzMaUt65i11BJS7fdU21HoOAn/6rkyZ9dT450mn2b/hZYctKRlCa0IENX94IEASJAg4AZneHlSMOO8OLXoAF5gg0DWHZycvKQkHoEjvfYSSPhQKjRG/Ef/GqzKWEVWt71RhUs0NzsOa+86nIvmHENVttiqcqSEI6uPHc0ljcNTcJXauOsot/yYs0bZdfLL5lTKh0Cp81zfGuTj9KnFwsIQAxh4OrpzLo/;25:iB76NMZEichQ7LmOMJqy55BNRU8K8xq1w+QDKqXRu/Q82aYh/NDf9BTCoEYioL8TWs259aCybIELe/AhCKnxq9UQMXf2a4cRCqXTrELgHTPFUGKLVh7eXKz2ZgvSsE08T2j4ZCmNzPmqWpnRRpsjn030S/iPIcQLruXdcGJwKaenyPZRAMXWFVDMJK2CGCdfImmx7ELFiNci3IxtMz4J31F0SyAnjdm5UsCA5FpP4nseNZvgmG1QL1kWm8LYylg+fXkHXPfPdwBiJ+4b/XyvAuMP1KR7Wk2oPQioBp4FdVud3rBKmgttZBOT6POUfKosEGfVyMmz+7Sd+fJYDA6eoA==;31:46tIgNVJysKDye++XhLRvn/A/PQ2dTz3TTv3SOD3cUkSTGo3El9PSQhAHOdhlOTfzz8tBWRj0mfOrdnTWU/q/5bLRE7mvV/h7dedpGrG0Nnpv5TXG1Oi4O8MwRWMjBcSzBuV+mswRXcpUlgnfpLFXkhHOVy/BO69Y3xLEsQ+js3PitK8O8bL+2bbFtPaef8NRWU1sn8F+/JVQKQUJ2buTEyKtw76kAlfLvcZo9F3u6Q=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:6ZKy/2Nr8NxYg/+w7NjpJgLOfHXc9Dz3eOn6GM2jdFuPW59rEhZF2wMU9ylm2YcXZGFn9XCFPcPoAFrr0Bl/L6bxIqNg8/4J3uF6e04bvp9Bx77Pwj7WB1wvp8imCosm+hvNdbDSyFtxPpusHVOzT2/Z3+S2FEFem3iXn9mbUAZF2BnKkz3bkRlIJ9J9Sg2NXCQMh+ZnuNRGTKye5n5fVbQ90U9t1wF1zhxb07p2zKEPFhFwo5tTEiYEJBzMeIk98Qko1tEzl+ifhcjlDYYmM+pJ7qYBtKJLtHhbGzP3XcINXLgrftNEhiXgniX8gQpSEIts054iDKu55SRE3JkZlUQIxsSOeIZyQhOxX/0IklAOPdrDKicd9uCpmQd6SFBodz7ZVSM1jvy8MPabmhmCFkdgNPDlI6z1X5bZHQ8XBIeSVI0Uz5s+JmeyE0khUEWvCPL0i4fOwDZpQzMc12plBMXLkjEaVndIAx9mrebXhnwwfzyq7drqQtMYghu2ZBkj;4:XfFAawHfzfICV0WNnizw2xt07bCx3tVQ4Voy5OjuFsW/KzVc7HSCrHwp2YEdX6BO4zOqTn4LV/x8rlLZpDYztAhzmSbPTm+u8fc+daZLypSGMsnjMcKVz354jY6sG5glMid5kKRzO4tPB/cSSOTqOhgW18136+vX8kXk/fCKAh5D7CZPQgzaXrt3ITaJcBzo7eygOGbrOZiOSRT47u3/2pSitFmTG3qrQm5C8PV+6RbJlWhKHVbvNVnYXH59HuGun+89fZObVOCX/a7j3OHQtg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13296B5DEFA0FF2C6C8218BDCDB30@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(346002)(376002)(396003)(39380400002)(366004)(199004)(189003)(377424004)(52314003)(3846002)(31696002)(316002)(86362001)(478600001)(8936002)(58126008)(16576012)(50466002)(6246003)(55236004)(53546011)(11346002)(230700001)(229853002)(59450400001)(386003)(956004)(446003)(31686004)(6666003)(476003)(64126003)(4326008)(6916009)(105586002)(39060400002)(68736007)(81156014)(5660300001)(2616005)(81166006)(47776003)(2906002)(6486002)(2486003)(53936002)(66066001)(486006)(305945005)(52116002)(52146003)(6116002)(23676004)(65956001)(65806001)(7736002)(8676002)(76176011)(65826007)(16526019)(106356001)(26005)(36756003)(186003)(77096007)(25786009)(93886005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6eXpCbXJjQklNS0I1eVNwL0hDR1o5Ykg5?=
 =?utf-8?B?MFlqVEtxZDBtSTk1TGtlQW9BdFpZQzQ2blpvZVpYVnhOZzZ2a3l5R25sanBa?=
 =?utf-8?B?amN6QmlqQ3A5T2xIVVFOdFZ3SkVYK1F5SXlLQXF0S0MzWVhSN0NZZzV5Rk5L?=
 =?utf-8?B?YlhLN3lodHR0WTI5RndTTFlpNm9EVmh5cnpZRklLdTQ1amJ1Y2k1OEtUQW9S?=
 =?utf-8?B?eFBJaklHaE4wME1lZkdUaVlFaHhHcC9xdWtjc0dia3lYR2x3a1FoZURRWXc2?=
 =?utf-8?B?TUg5MWtobmpsMy9HcTVCQmdRaUhwY0kxZm1PUndOK1pGMjlIYklFeG92ZjhC?=
 =?utf-8?B?Y0VENU1pOG1qbWNVMThIY01XY2xKZkd6QnZjVHVSWlVOc204TmVvUlZBUW5j?=
 =?utf-8?B?MElnMGhvWVN0V2NrbXRCYTFDLzhPazZWTFIzNHpOL2FVWFVqL0dvOWpPRFQx?=
 =?utf-8?B?MFFHQ0d3TDB6U2hVTndWekFJZ01nbkFROHh1RUFQUVZUR0VmVmFRYlNkWVRB?=
 =?utf-8?B?OXN2OU5yaWJYS21HRXQ1elNRdWZQeGhNT09lWityS1BaQWcySHlSVStqUGNU?=
 =?utf-8?B?dUpxUDUrTXl5K0l2SGZUM202TFdzaExCUXBFcCt6VXFxZzgxVFNoMGxyNi9n?=
 =?utf-8?B?M3g1dXZBYVNCcmppckZrZU5takl3dk80N0MvTTEwaHoyTXpnbUdQMHlpZ3pK?=
 =?utf-8?B?SThIczNDL1FWQ3pQdmx5TnFjMG91OGdZME9sYnZuQ2Y0NnZOVFZTMnF0c2M2?=
 =?utf-8?B?bklhaGorNDFnZUFlck1LNmFzcGpQeG1MQkt4ZXdFdXJmUjEwVXlPZWcwb2hC?=
 =?utf-8?B?NElJUjlvcGJUVzQ0eXdCQ1EzRk1RUTd6K0tTQzRLM0xUaVZCSFhsTGZ0RFo1?=
 =?utf-8?B?dUEvbHJ1eEJpai83WHJSZXFGcldsKzVrZ09PcHRVNGxMcThuZi9aRm45Mkd5?=
 =?utf-8?B?T24rQklIWXVLKytxdkRmb2k3OEkyWWk1TGVpQW1GQjVGbC9xRlhNckkrSHJC?=
 =?utf-8?B?a25ZN3ZDcnRnRWE3NU1tTjVTZFoxR0xrV0pJOGZWcnE3czVxYTVDTHpOd0FV?=
 =?utf-8?B?ajd6eE00dWc1K2ttOXQ4MGdyZXJDbkRxTDI5cTVjUForVW1nTFZLa0pGVCs0?=
 =?utf-8?B?U3NVZmtJaE9DUTRUYnExZXV1bGZkMzVjbTgvSmN0SVhpN2p5c3crYXlhbENp?=
 =?utf-8?B?ZWhuNi95REpnV3NjNEFQZlpxZnU2dVpNSWtYVStmM1dSWmwrZVFoa2NKQ1Nw?=
 =?utf-8?B?cXhCdEhjbGZYTlVpTnVsdUo3dDczZis0c2ZSdFBmbVRKNGhIZklUYkt3Wk5y?=
 =?utf-8?B?UzRJWG5pckg2QXg1ek9rTmkyRUNuVXFmWDNqdWhybk92ck1UTmRWb2NWSjh4?=
 =?utf-8?B?ek9GZG5jNHplQlhydU1NLzdyMVRLelE1cmhtUmd2QkM0NXJSNkk5K280SG5y?=
 =?utf-8?B?ak5sNysraHB4LzNYNTZicHRiNEhvbDFTd0xQVlcxZHRhQTZLeTRLQzhqcmhQ?=
 =?utf-8?B?dTJ6RTM0LzR6NjIrZ0pIODRUUzROSFRxU3o0dzJFQ1d6YVJuVDZiYnhwaGdu?=
 =?utf-8?B?aUJsWGcyWThMVStkRXpaSVhSZkIrelA1WVcyenk5amk4Z2NVRFg1Ykh1Ym82?=
 =?utf-8?B?L0tlY25zYnlVNW14RGxtQ1R0YndlYWFVeTFjWTJiVERlUnhMNm5ETjlLalJN?=
 =?utf-8?B?NFJWQmVndTJ3Vy9xSjdGMkFsOHQ1aXBQSzZnYlhvc2JBVVdHRDZQVlBwM3hP?=
 =?utf-8?B?T3h3Wno2aVh0c1I3MVY4K24zcFRhM3BYNGVNU2xrdGNYdVBuTC83bmQxR3hv?=
 =?utf-8?B?VkNLZ3VRVHhOeVZhTXZXR0wvSVJGK3ZqeHJDN1J6eHAzTnk3OXpZYUpVdVov?=
 =?utf-8?B?UnlyMzROUVJ4WnFlcE4wSjNZZmhZU3g5U1IxcWNocXZXYzRGQ0M3L2J2ZnRP?=
 =?utf-8?B?eFM0TW1YWERpYnZCZG5ndm8wU21rclhzR0ZWQzY3RmhIVTFvRkVMTUdiVWov?=
 =?utf-8?B?Vng5LytscG9GWm9xWVZmQVR3MzhEd2t0SHBFYTVSWHg4Y1pVOHpzMXpxdUI0?=
 =?utf-8?B?WjhFakp5WlNlV3kwUitjNTJtVFJ0YjFVaWlPSVU0ZEQ0MnRyUXAveUZKYWZH?=
 =?utf-8?B?TU1EZz09?=
X-Microsoft-Antispam-Message-Info: gu6llnul9j/iSO+W8K+xqi8zk20qFhMtT08OLDI37uQOhg74T25oiHiy93TjQYHQWpgHMepnJE9dKMF/tR4opv6v53fBEG5GHpDvf3dbOMLTW5NaARHNwj6xZaep/cjvrr1GxEuxq90eb5cqzMtxOxWfGJxgCJ5USfuNtsUkfY1o1+fUhfrUmabApbd85UiZ
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:VB3gsb+G4tTsNL13N259DLImRGK+ffcC1STOpAgKaeVUpys2S2UMvVvF9Oov/NMdZ1iCJRZC2xUXTu7FAf/G1NExKuZTQDZ8tNJH/F2+/P5YG/cap4W7E14k7RHacZwKKFBjetYIcU32BLkeGUygP5OMoH6IUnTCazuNyTH/k6kQ1058plnkUZ+4+o9Wva5kF0bUjZKgcYnEfmfGYQbHhphsRdXJ8rp8OGt4m5WUOkpA6Wl7VCeJRre4kt1hqDGOVjcOL1hAnL0GAso9HrjanRmUZ2n2UNQyAzLpHV/MRX5pe9eZeCvFpvM+OqFdQRJgJO0qZvWMe2tabcAG5YWPqzrMu/iaGlLnMmS3zJReg6VlDHpAgA6cHm6f3J0VG3SRI5+P2+pIN43kigIQhoXW92Mi2IKEDQVvauoiTVzn8JzizJpLvPTGF9Z6RGWkb6OfVxBX38KHvmAF2FYnoHIIfg==;5:Z7UpuJPN7OHxORzjsO9nXtG5mD4C7DwbgQr/gKNl5AZs7jq64Y77obO8KfkgdmkBcO4vOcvOzNT7CM/+iS2MNGbmL9k5sX9R14K1Kgrw9DOtPW+whU91AKkmux62yAaxYJznh7L/v1+popDQU+WEHCGAYCiLPwZNmjn+PS13Tjw=;24:uDOUcplzW3MIigpL19VOH898U/stdKQOwigAoaYdLjIkOkWa3txO+25MVjVm2P8oYYyKJHjzeP0MHUUOHHCtIwHrIRSvY5FHoxuW712v+Nw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:S6kc7khpgBWolKcBD5z4aMp38YV+MqFQTHSzI7GEabDvRqZ/bZGfXoOzvg1Lf8GitojVAPSTl88BO0aeug5YagVqrAreB+5uFqiA9wpbHXBVp9TTciy+XGoQyWAAqhrSXMvcIvKh8X81ybuvW8ldigbM4Ltow8ETeSHjQsfIgB6kSpy7YGPuRmTkzYLZxL2YgcXk6Jr9tlDwP2C3Z9o7DoC4BxRWB023ZIYUxp6WGGuTcnLBXnFISubT1g5xi4JC;20:EweuQ7pIeBRqpbpzxXqZxSPmLP+rhTgy3AAiGnEqI10XewM92vN9aSqGHqlsTPVIH1S2swML9N0XiFUiipuwWStwZJpjLLRafcQ7qyfKBSREm31GlMQQDg+mFIFQEDOYMDiN9BQ/+OmdmTdsghfS77NKfyJX8QnwfV0Bydvjg90=
X-MS-Office365-Filtering-Correlation-Id: 9b79f09f-e807-437b-1845-08d5a131c999
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 11:29:14.6202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b79f09f-e807-437b-1845-08d5a131c999
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 14:20, Michal Hocko wrote:
> On Fri 13-04-18 14:06:40, Kirill Tkhai wrote:
>> On 13.04.2018 14:02, Michal Hocko wrote:
>>> On Fri 13-04-18 12:35:22, Kirill Tkhai wrote:
>>>> On 13.04.2018 11:55, Michal Hocko wrote:
>>>>> On Thu 12-04-18 17:52:04, Kirill Tkhai wrote:
>>>>> [...]
>>>>>> @@ -4471,6 +4477,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>>>>>>  
>>>>>>  	return &memcg->css;
>>>>>>  fail:
>>>>>> +	mem_cgroup_id_remove(memcg);
>>>>>>  	mem_cgroup_free(memcg);
>>>>>>  	return ERR_PTR(-ENOMEM);
>>>>>>  }
>>>>>
>>>>> The only path which jumps to fail: here (in the current mmotm tree) is 
>>>>> 	error = memcg_online_kmem(memcg);
>>>>> 	if (error)
>>>>> 		goto fail;
>>>>>
>>>>> AFAICS and the only failure path in memcg_online_kmem
>>>>> 	memcg_id = memcg_alloc_cache_id();
>>>>> 	if (memcg_id < 0)
>>>>> 		return memcg_id;
>>>>>
>>>>> I am not entirely clear on memcg_alloc_cache_id but it seems we do clean
>>>>> up properly. Or am I missing something?
>>>>
>>>> memcg_alloc_cache_id() may allocate a lot of memory, in case of the system reached
>>>> memcg_nr_cache_ids cgroups. In this case it iterates over all LRU lists, and double
>>>> size of every of them. In case of memory pressure it can fail. If this occurs,
>>>> mem_cgroup::id is not unhashed from IDR and we leak this id.
>>>
>>> OK, my bad I was looking at the bad code path. So you want to clean up
>>> after mem_cgroup_alloc not memcg_online_kmem. Now it makes much more
>>> sense. Sorry for the confusion on my end.
>>>
>>> Anyway, shouldn't we do the thing in mem_cgroup_free() to be symmetric
>>> to mem_cgroup_alloc?
>>
>> We can't, since it's called from mem_cgroup_css_free(), which doesn't have a deal
>> with idr freeing. All the asymmetry, we see, is because of the trick to unhash ID
>> earlier, then from mem_cgroup_css_free().
> 
> Are you sure. It's been some time since I've looked at the quite complex
> cgroup tear down code but from what I remember, css_free is called on
> the css release (aka when the reference count drops to zero). mem_cgroup_id_put_many
> seems to unpin the css reference so we should have idr_remove by the
> time when css_free is called. Or am I still wrong and should go over the
> brain hurting cgroup removal code again?

mem_cgroup_id_put_many() unpins css, but this may be not the last reference to the css.
Thus, we release ID earlier, then all references to css are freed.

You may look at the commit 73f576c04b94, and it describes the reason we do that earlier:

Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed Jul 20 15:44:57 2016 -0700

    mm: memcontrol: fix cgroup creation failure after many small jobs
    
    The memory controller has quite a bit of state that usually outlives the
    cgroup and pins its CSS until said state disappears.  At the same time
    it imposes a 16-bit limit on the CSS ID space to economically store IDs
    in the wild.  Consequently, when we use cgroups to contain frequent but
    small and short-lived jobs that leave behind some page cache, we quickly
    run into the 64k limitations of outstanding CSSs.  Creating a new cgroup
    fails with -ENOSPC while there are only a few, or even no user-visible
    cgroups in existence.
    ...

Kirill
