Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCOTm1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:42:27 -0400
Received: from mail-ve1eur01on0092.outbound.protection.outlook.com ([104.47.1.92]:60774
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751414AbeCOTmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:42:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
To: Michal Hocko <mhocko@kernel.org>
Cc: darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
 <20180315174903.GM23100@dhcp22.suse.cz>
 <c6a9bf24-50e6-8e60-94af-28e99c51f516@virtuozzo.com>
 <20180315193224.GV23100@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4615a892-c179-9813-daff-ad371691731d@virtuozzo.com>
Date: Thu, 15 Mar 2018 22:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180315193224.GV23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: HE1PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:7:29::16) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9254281-ca7d-4b05-31fc-08d58aacdeae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:1x8INhk1boG8+u8fFAEjR1tC1PuNtaxv0pN7gf1ckac4XQ10jwIM3DEJE7DX4XkeJ8bVHPo3KO7HY4Hm2shg62GBkncd9g6+391ZP9Q4fOOocbILfdGBZHLNHSLlXP90ZNDELZrlB0fb6r98ZLG2emU8IzBi+peMU3+GlMigKcjKAN92ebOJsLm6G9LL0qwYkDhfH+8N1YvwZBexF1Q95yt3IVv5sJbZv4Vxh154imb7V3aQ0cKpxSaFbafemX6a;25:Vo/u1tgtN+Wz3oQ2UWb5AsgJKfTxDttUVD3TTe2jWu0xg4AzcBMxwSUvd3f0BTQRXpewsUgyhmbJ4RFPaWm77aLH7ldmoCyTI3uk+1HGM1goqfz8TxEsR44/4q06ubmn0oqRzc/9V4/9bddI0e6NjZ043PBY871LOSywpx/h0P16UFA0+XlAkcPXqzlcdQ5cjQMxszmTbApVFiuQYCbzvuVLwVMABX+z6Rxitg8mJdFSxpC6Hx7XJjLsIZ/Nj1ArVACPe8ZsL39QjZet+egxZVCbtqFtj/+ieHSi4kvYZOnn/R7JS8K8FZ3/GZJvAmxLnDh/568nDrQ5IHQPLqXEAQ==;31:lt/7oUbgEIHWvluJxUv0oO/Kwxu4pVw7p3+SitEecAey6RBB8wcGDJioVvEdlIobYj1OWW+po0MNvgJo3UyyIjLSRM1r+8GP2NWZk4nZliVexD5zWr2TxYLUCOeX78I414crceob94RZxbexer+FR1ODoIjvgQXhoThVgBVMlU6LKfdsm6CThx8SxeieVr/axMtTPURH7R+U13iMqF8SYfaQoMUsPRbbMCNhKl6Kj9s=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:wKXSyZ4t2WTR5ZXMXmaWCIjdDVCkukzfGL+Y0RR8jhrLc08bVrVF0dO7odTGEq15kLo5vPcgsvswHlXhLR1PqxMiTWNXJZ//IRgjzZygSoutgckdwPwh0UGS8DsyspNE7NMCDjUY+uZC0Ieo0Qp4otzJzavg64BsnYMu59r81SopHOgJ8geLZZ+IgEI9kolV9Y+6tXEw9z+RTOBcziZ/F9cjAPubBm5atZacHE0Xz80OznWnpRnZjvT2EQhdlzZGUkOCPry3rBZFLsyyDpaWKe1xWVdOm++bsImllra2EFNF/Jbbnx5lmErxYJYEWQIqi1EAivwcxlVuJ2ifjJmLc0YmYTOjS9lgJSWXyoORzCW0v+wXqXvGJwT38caQ55K+mlANw6NX3+CP4xRBglnmdEndmnCjpj3/sKo606xKId8sEf+TmY6+JIWbrluDf7PiXRUBhkPBR7KVjtbVOm9ARIsaK1NPhgRe2qPf3plsGVQwc4E8FgKeyDq8cCw/cWP5;4:LXzMzOvDcd7aW+lW4E4rp2kRRTJQRxxjCnVnnhYy6kadpPQAWqkCUZSITIdAQGjyYshnt0H8YtwYvDFaFzt+0Y5ZjklJDx6+V4UmSRc4yUctoudgoTxnyC47KC6rGemAW33iIF2IpvHwFcatG7ML+Ycr1BudFQCDgr5iexCNkgISpQA/GVJ5Vh50jFLo5bmWx2/uSaz6HH4vB8kjwLdxPvI/SHG2DK32C7NYqw0t+2ESYS5NE+iFhveb5/20GcXacuK9k2nApHdmL8hsuSkudp+KGTAIJKr8AQE8OrZkfbFIuB180sYGCfdgWQoiixes
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338F57C78CFB51250DAC744CDD00@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(396003)(346002)(376002)(39380400002)(189003)(199004)(377424004)(81166006)(229853002)(26005)(86362001)(8936002)(8676002)(81156014)(316002)(16526019)(7736002)(53546011)(386003)(6506007)(186003)(93886005)(305945005)(6512007)(53936002)(2950100002)(6916009)(6246003)(4326008)(58126008)(6486002)(2906002)(50466002)(105586002)(25786009)(6116002)(97736004)(3846002)(31686004)(66066001)(65806001)(65956001)(47776003)(106356001)(31696002)(64126003)(5660300001)(52116002)(478600001)(76176011)(52146003)(2486003)(23676004)(59450400001)(36756003)(230700001)(68736007)(65826007)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6RG4ybnJqekJUN3EzSStHQ2U3dklITDA5?=
 =?utf-8?B?SWo2V0JhdlBJN2NRYXlYaCtIY01WNmZHUk1lSGFQMDZPRjgzTm9sWFd4RkZO?=
 =?utf-8?B?dHdlV0VsYml2STAzOXp5ZkZzaG1uS08vZkllbXBObkJLLzZ0VTNYNThianhI?=
 =?utf-8?B?YzFWYitFdWJZeUtyRS9OVnNOZUlDMkpQbWhCK1RkSnJZTmFOMFVSbk9IT0tu?=
 =?utf-8?B?d1JyMmZDSGZyeVVseVpQMi8vU1MwTFB5cUlJS1I3SlltS1NwZTczdEwxUDk1?=
 =?utf-8?B?OTF6b2dycEtZZW1CTXI2NHEvWGQyc1FpRVYrVHVlOWtHZHB2eG1GVXdSaTdn?=
 =?utf-8?B?UXQ0TmtCUG90cWJNNjFQZ2U0WDVqVWt4RWFHckg5N2YxSGVFRjVzTkw2czJS?=
 =?utf-8?B?dlg2VVBndjd6amlXN3dHYWxsNzN5NTNIWFo3a0RlcWlNM0xTY1lsMERPTVhh?=
 =?utf-8?B?anhORFErQ1lwVTMydVBPSi9qQkloNlUrTGhHUVRzdEdBWnF5RkNmYkVBR1du?=
 =?utf-8?B?eXhXR2JtZkRDOHo1eFd2U0hBRzAvRmp4Ykk0anAyOGp1eHBBTDhLaER0TGNn?=
 =?utf-8?B?dHRQdGk4MDNmUGpJcmswZFBhNUowby9OL1RMaHV2LzVmZ3BWWkJTandkL0pl?=
 =?utf-8?B?aHk4WG15UGZJcWtwdU15NDlJYzNPWU5IVHllNjNUTkh6VDI1ZytKalJNSDNm?=
 =?utf-8?B?K2ZRWXZpU0g4a21Gc0xyTEdPbGU4ZVFRdE5yTjBzYjJZMEhCQ2NYYU5uN2NI?=
 =?utf-8?B?aHlMTEtGWE9FWG54NHkyamZOcy9ZZjNuMEZkK1IyeG54d2w2RzRreW5tMUtD?=
 =?utf-8?B?cWhhSkNXT1V6SUZYbURmeDVTK085T2hTNlo2aEs2VTRWT3FJeTB5MDJFaTFO?=
 =?utf-8?B?QXFwSHFpRjhnTFJ1OEtaTGtVbGY5Rzl0cXNFOXJCNk5DK2NQaXhqZ2FMejdF?=
 =?utf-8?B?bWJKL0lVUTkwMmtFSlJsR1o3TzMvSE9Qa2NHSCtZQ2FJQmNzSXRGMVkwR0lK?=
 =?utf-8?B?cmxPQk5zYldibng4dHAwc1Erb1FRQStEUGhuUzJEWHlZcFhQazFCUXRZQk1w?=
 =?utf-8?B?VFg2UVE3dXNQTERkbHNXL1VrUWpjWnJZUzRCcXh0K20wN3pLa1RqQVlDTmtp?=
 =?utf-8?B?RE5FcTI5Uk55QVJvbkVRVHJtR1BwOEJEZFRUbnJYUUNscEQ2c0t6ZWZ3clRw?=
 =?utf-8?B?Mi9tdHoveXF0OFZNNVc5YXpqVTNJT01LZ2dlMllCNWpFR05oZUQ4MDJPVUhn?=
 =?utf-8?B?ZHFDNXNOaHVvQVBHUVc5UG16VFQ2N2JIUGVPTXprUVUzZDhWOVErOXZVak1G?=
 =?utf-8?B?dmxVY3RRUEdURUhvZXNzeUlpa3hIOTdlRkVLamNEamxvbldwV0w2ejRIV1BC?=
 =?utf-8?B?Q2VmMHpnVFJ1MWhTbEdzTHFIS29uMkJnc2pSZG1GYXVPTnBCNTVkaDNlQWFq?=
 =?utf-8?B?Q2FWeWdOVit0amhMWVdQRFRZWFpaVEY3NzhtSnBxQ0pHckRSL1EvQkhSMmJv?=
 =?utf-8?B?S0tjc1RmNERhMi9hZXB5R2FsZjdScFNlaFZhTWlMTXlhVTNueHo4OXQrZEtt?=
 =?utf-8?B?Tk5ESFhGWVI4VUlLaXJmZk5PTEc4R1k1L3RnRnVXYzRLTXJ6RGlMdlJuL3Nh?=
 =?utf-8?B?QUh6bUJWSWZjeFZrcm1DdWpOdDFpQmZNaDl5c01WRjUvWFprTmlIMXRoZmIx?=
 =?utf-8?B?OGRhZTZkTnJaUGpLTEhYL0ZDTSsxVExLQ3lqVHVjZkZmZVF5OVhpOHRKem9q?=
 =?utf-8?B?Vit2ZHAxSG1PbjlKQURYc1RQeTRKZGEwNURIeEw0cVFkeVdWOHgxSk5ML1VV?=
 =?utf-8?B?OFk5dm9mUTNVdm4ramNOSUlxNjc5T0lncEFsUnFoRkJqYUpQL29lbGJhZWJk?=
 =?utf-8?Q?2Fkz0UG8Yfmcg32owGqKAo+O79lFORiYiK?=
X-Microsoft-Antispam-Message-Info: rx7DG/xpGj7JVoyZlvNJhWjOxToNAo+ODd80u2Mh+D9qR6gZMrGGi+WBaaIdLEiMEQqizSJHuFqf/GRvbxz5U00okZwebv3L0hmzFnjJPAppH269iB6lX+K6TAxIh/YzBjYkJynlwL1qSFubZiZMyD0boUOgmF+m6/HvqIQU25xexGZDYYamIHjUnfzW2YyI
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:RanuH3d8th04l9JAtfuPH1YCOwRE/AaKK08JHqrpaMZXG+/Gsk0gbJJ4trc6yhY5VCpXxlMuTuUb70XG0ACvY7J0e9NIzihpBhHQHSV/O2xa+uvDI6zFaw5soIWLsS85VQ+7b61P3783uF6Zj8tV1oYAqtz7sYeRepYUWm7pbdYjBs9JwKz+4hojuDJbDq/Hg9XLrapFiS8QCk8xylO+eXUwcEnjuNvIJnzWImRZm6s+gqNlvMvOEfxU1nP4JAndy/UsDv87N/bmddmg32nHA3bm/k1OUEFMLXaExIEyudow9j//jfn7v299YLJsyI3P1bKKLNX6SV6sqkcAKRbxheOhU/vNfJj6zTT0nX1fmV8=;5:FAc9bqD0pTILRokz43UdhvGtFZw3Wl8GhZuH/hz31k0YAnZWhdNKXTxMV11HDH9aXKLltIJVQCpRp02NkG+3CxS9xRzZUd9ylIJXLNQ+0L6rnLrpRQeII6Con6uJOQFg4N+NCkjscp306+LzxZjO0VXXmoO21k5pgzEuOGi4+9k=;24:zFLivWP4c7LfEe6qflvhGEZrBZB3CJay5MfshZmWTnY06LpmkaMs9ZW/A54FGrnszcPRkzUJT45WwjYrVxLjDLhq3OxaYrV1KAPNeZRHucE=;7:2orbbpXHvPa/PPKiSfN/hoRluuYQ7MJ5ln0mFzCOfkyA8unGNSCkcuX8fpVhfILol0FVNPbtAaAhmZLVatC3zrTLCtNeP99hywywXb32/tCrb8u3JYPqSf9qaFRnhN/l5qCxYKMK5hvSrLi+bE0IHmWT/PPZjXQzehL3KI790or+j46242VQP29h9ffhBCsy/bgz34H1qpWYwFTo7ypS+zNUsx7B35BbSYo+uFjMLOUE30y9km0vtaO99XxhZ5H9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:33hK3pOYOdg5dDrcMVUaD+3KJgJLq+xluAuKJTVCo+aZjqVQfgFB1zRb/xo6hoy2Ens8Ki/4TY8KPJuHsYliaK53DMjXPaIsfYYopyP7+22zbULvT8MJPIM2G+PftnGgGK9HyQJZ1I542RCMQC/NS0X5z7x2zWbAm7WNGIHU8xE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 19:42:21.5102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9254281-ca7d-4b05-31fc-08d58aacdeae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 22:32, Michal Hocko wrote:
> On Thu 15-03-18 22:28:43, Kirill Tkhai wrote:
>> On 15.03.2018 20:49, Michal Hocko wrote:
>>> On Thu 15-03-18 18:01:34, Kirill Tkhai wrote:
>>>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>>>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>>>> disproportionality to another lists.
>>>>
>>>> This looks confusing, so I'm reporting about this.
>>>> Consider this patch as RFC.
>>>
>>> Could you be more specific about the problem you are trying to solve?
>>> Because we do skip shrinkers which are not memcg aware by
>>> shrink_slab:
>>> 		/*
>>> 		 * If kernel memory accounting is disabled, we ignore
>>> 		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>>> 		 * passing NULL for memcg.
>>> 		 */
>>> 		if (memcg_kmem_enabled() &&
>>> 		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>> 			continue;
>>>
>>> Or am I missing something?
>>
>> sb->s_op->nr_cached_objects is a sub-method of generic super_cache_count().
>> super_cache_count() is owned and only called by superblock's shrinker,
>> which does have SHRINKER_MEMCG_AWARE flag.
> 
> Ohh, I see. I thought it was a standard "top-level" shrinker.

There are one more in addition (it has to go in this patch):

.free_cached_objects    = xfs_fs_free_cached_objects

which is not memcg aware. It also needs to have the same fix,
if xfs_reclaim_inodes_count() is need.

Kirill
