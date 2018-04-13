Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeDMMH0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:07:26 -0400
Received: from mail-ve1eur01on0138.outbound.protection.outlook.com ([104.47.1.138]:43552
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753941AbeDMMHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:07:23 -0400
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
 <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
 <20180413113855.GI17484@dhcp22.suse.cz>
 <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
 <20180413115454.GL17484@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
Date: Fri, 13 Apr 2018 15:07:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413115454.GL17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0003.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::13) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:CRs4ohyCyzsobEpV31Mhc0A7TcnlUf1AXVi9TNBsVkD4PJqRmDKOl5TzaIM3bExk1SimFh+goCcgeTZhd1WwAbOlOHFXuAOHv4jrFlQysKwc869Ki0rPE9unS1F7pVGe74YqB+8dYQPG/tklrJlGvNiKZQcrrvT3+PYbTc7hfhqM6/+se2+/UQxTIHoaZ8lAiHFsc1qz3P8MeVPVO35LP+7dG5xmQYUBXOCg0+kgoFm/44T6O6iEy35M3fR3XdgP;25:HhFHB6AU8PkXnar640OBzwbdELvBMZfg1UcQxBpoLS5EJMDcDa9N0CxIs8Iox4ul5guXZFc6yNfiCLAA/AzuTnNr+gC/J1voX4cI3rBY5eljVL8pY2ESlpZEyCHNeWsAUlVqcVreub6Uq/oKh3jyST16WNcYSymtdf80g6zySe5xBdx5VflEuRUb5TeVCYtMRzI6gSo9sX9zVJaDXkfZLILFsvHsiuFHsHlSZgphYzNFV4W5CF2FV8qyYh/p99thYVSI1Xs6PNuPYkR8C8xk835T7BQvS8p+oieujWv025aY+MaAjle8PNtEJ9CinRAw+knI4tnk03/2jleS4rmqnw==;31:Qocw3ExeSfKcRMQotCXUByBdmiZLmO98t/9yF9JyIA+RC/iS1SgyO7lNqBro6itBLmJSe4exyrue/VWaVxXScYKkzwwOxyq05Cuu2kuXlWi1EDcOCdyHp60zWOecT6hmJ4wOJYWY+GObWVyEQ23fZfvoswXHkgAFATrzJRlf2FnzkuGJA00dv52xPtlAlt02Ph9s0AKNmPclfLk14trQnLEVDV0DOOvkCCmFZgYxcdc=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:s7DapgyPiODT+bw2QnXBfdT3Pcqp0OvQaVYjibOdZxVvkanMTRKLOQDZQwZFfdOHMNIJ4TNZ6hVd16loTtM8RdNM01iJxytr9QUOFaydn4ZmSvPYqKIkj23dMl7b4iBcdw+Jud2QLteuwNAMMIy3TVx4Cfr5wAm4qO4AQMc5v6JNPPJO1uHywTe340bZV2IHEo0Mr0+t8OTLllUg9ZuWk1CKmT7/DzElRGOxTSlRdcd357j/CtLmfGtuNA3DxdZNv0LfhcKxtpUgM4hQRTAvyKUJocUeACRLjyLJvUfNSdAFt7IurPdnm+u5SX4T2o4E4u56isXYGAfzzOoKrtfQ3wxoC/+Mo4kEbP7Pkz89hvg8NqheB+VQkbn3rGsqo4OIjZudClETq8MGoU0DqkD9/JzqZszqI2S0Yklaxfha3wRIKW5Utb/V0wnENw021JRquchbTWH/XoLWtQCyoIlETj5oma4BAo1KcH0FKBD3Mi0U3j7zYDk9kQ5/h/OTB61E;4:n4a+kzsz60YHmOxqMEchf1VrZiKR7YYTvgpLY+/afzn+baxNvLBlfhudZ0UOTSZnsqGPc1HcyTbS0paHLzbCGgPOLw/xyRPWtKXuaR5ySL7FpQZHkzoyIcouFRX8fYKl5hwT8sU1fxqIawCZF+152h6kSa4tc/yXjG3K3X+DhI4GuknSMqVkrjjLuY7L7d0jxo3/RhvO2ZAAfaV6wPNbrb6ZA74aRjbZ3dm+5LxoCBa16uPUNCqjU5HLfSPmpUvKxGKR4FVxkp1Q1UYwQC0oyg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340FD01F845C0D9E6E305D4CDB30@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(377424004)(50466002)(23676004)(65806001)(486006)(5660300001)(6916009)(65956001)(2906002)(16576012)(53936002)(6246003)(65826007)(316002)(52116002)(52146003)(93886005)(77096007)(58126008)(36756003)(47776003)(66066001)(31696002)(97736004)(2486003)(86362001)(7736002)(6116002)(16526019)(8676002)(8936002)(39060400002)(386003)(31686004)(76176011)(6486002)(105586002)(305945005)(3846002)(53546011)(186003)(4326008)(64126003)(6666003)(55236004)(230700001)(446003)(11346002)(476003)(68736007)(81156014)(2616005)(478600001)(81166006)(25786009)(229853002)(26005)(956004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6cmJraTJVTzZHWll3ODkzOFRUaFZTR05p?=
 =?utf-8?B?aTdJTWdOaDBrYStOelBCK3BkUmR3UGVjT2duNThIU3E0RkNJMytEN29YSmtR?=
 =?utf-8?B?b3JEOUFTdGxTZW5pZG1udVNFWFNGanJYSTAyUXpXdHMvS25RWjVvK3psdVM5?=
 =?utf-8?B?ZHl5bzVmSml0Nld4L2Y0TXlZYm5EK0xVb2xvV0NpcVRxR3NTYU1jc1NmZG1F?=
 =?utf-8?B?MjczVUkwcXBuUlNRNkMxQVFyRzFlaEYvNmhLUmM2NVV5T2R3TUpYNjZsNUF1?=
 =?utf-8?B?YkJzK1RwWHZ5YWI5SUdEYkhaTGZDL0xhZDR3ZE41QUJFNHIrK1Q1c0hkR0I1?=
 =?utf-8?B?OTk0Sy9YMFNqS2d2TDlPRnZwY0o2OTEvQWJ1c2kvSXhSY2daUldLZkdTMGVI?=
 =?utf-8?B?YmVXMVZ2ajgxcXBkUnlZeWRIVWFIQ3NRUDZjOE1GT1QyU2xoRTd0bWg2RGtL?=
 =?utf-8?B?ZFFEaGFpRjY1MWFiTk1lSnBaald1d0JqaW0waDJ1TVZVRWMwNHJGek9mUjkz?=
 =?utf-8?B?bmtCZ2hES3lrcW81aHcyTi9OckVpN3RqTVJDUnBpVFFrNnMzV1Fzait2OUVx?=
 =?utf-8?B?RjdMZWx6RXg3SUlMMGNjVVNYUWhJdURXSEFTbm43NDVZODdGS0NNZ3pHRWVn?=
 =?utf-8?B?ME5kZkFJd0R0a2k5Q3U5TktaODZ1MElsV0RuUDJ5KzJIZHZ6ODBaNFNveDlY?=
 =?utf-8?B?Q1FqUG9uYzFDVUJLcFBOVVJ6VjNpd0xkanlDWU54WHZkZm1Xem0vSlJBaFE5?=
 =?utf-8?B?dDJSNWt3VHY4dzA2bEJoZ2FZV09VMzBjU0djdCtyQXZudnZVWm95TndSTWkv?=
 =?utf-8?B?eDFUN3h1ZUQxNXpWbEx1RHgzZjJ5REdaUjhFMVE4YXlxZ2NremVMOSs3R1Er?=
 =?utf-8?B?Zjd0bWRKbVBFUGFrR3JOUmlWZ2xVNkdZY0dSRmVpOVhFSHhSRmRndENmZWRX?=
 =?utf-8?B?ZldJcVBMNzUrMmNyQXRZQ2dITmhBc3RMSWQ4WWR3ekVpOTlSUDdoQ3M4R1BC?=
 =?utf-8?B?L2ZMb2xYN1V3cDBYRHlSRzF6RzRjVHlubmIrVTlHeHl3WEpKa0JsZ2tCU1A4?=
 =?utf-8?B?dWw2cE1OZ3pIRHdMS3RxWHVkTlp2MThzRVBTNmF4WUpkb3NKV1NwblQrR2dr?=
 =?utf-8?B?THhKVy95YUJQSzBrajJZM20zb0Via0pyc08vOWJnUkFjdlMraFRxZm8xWnR5?=
 =?utf-8?B?RjUyMmYxYzRoK1ZMSVdQMFk1eHpOYUFpU3E0dk9tVWZCc0hBTkRaR1k3bGdJ?=
 =?utf-8?B?cTlFU2NRMmJKU0krTVhibzNmOURjZ0xVTlQ2NHZLR0g4QXJhM1ZwMDRYMCtB?=
 =?utf-8?B?TWtVOUJSWWJqMlJzMVZrK2tPQy9OaVY0dEhZWU9FWTgxSVBFUStieU1xSUZM?=
 =?utf-8?B?N2JpdWF6bUdIamhEN2Z2WmorTzBCUnUrVjdPRTU2elJYS2FFU0NqZU1NU0xC?=
 =?utf-8?B?ZnFxZlJscFhGZDQ5aEV0VDdTZjRvWENqdVp0N3FzM1JRcTNiSGJMdFNyOVF0?=
 =?utf-8?B?SCtBU2VneTl0ZmZsMHhuWkVrSDkrdkpqUWpKWGcyWXppdE4rdWRMMlJlRDRG?=
 =?utf-8?B?QmpKYU9mVVp4NU96eGZ0VlI2bnlZWHhxT3E2VlQyb09ZS0ZNNlNocEJFZmpk?=
 =?utf-8?B?SGFZQVA0eTdUUFUvNTk3SEphQ2RWWmRqYnNpcXNvb2djU2Irc2xLT21QWTR2?=
 =?utf-8?B?REZJWk5hbzNESkUzRzFyWlV6ZjVXNHJCeC95QzJjWkZGQ0xETTIrbHdoT0hI?=
 =?utf-8?B?elhlR0ZrclJzZkV0T2lwSFRRdkJKazI2aXBXQlgwVU9sOFBBVEM2UkxhM3Fy?=
 =?utf-8?B?dXZmTFp1M2dvWmkwT2Zzd3dGbVd0cGhTSENhcDBzcEFOa1ZqQnpNdU94b1Fr?=
 =?utf-8?B?TEUxa2Uva24xZGhrVEx1TWI2emVOOVErWERROUVOYldpdjhHcGg1TjQ1ck12?=
 =?utf-8?B?RUdDVVJubE1OL1hoa0wvZHZTOEJKeit0WGlwUDdueWFvUlF6T1RuTDZOZVdu?=
 =?utf-8?B?QlJ0L2FEajI1aFI5aU1Ea2xOdFJwQVMwSkhEdmRwYklEQ24zS3pGc1hPQmdh?=
 =?utf-8?Q?d4KrUw=3D?=
X-Microsoft-Antispam-Message-Info: VG/tR3T5ruhtb6O1en+fOScg1Nafb5k9uBazZsc6Tk+Z5yzR98n7L9MDqSCBWX7e8O8TIQVZJHKLba+4sUOEEMBpV5I+ZUGonPUg0rQ+NDUu17dstqFRi+/9EFhO0T5UAhGGnFGo3fuFQo5AiAtBhVqRHrBJyVMBtSZujdyRw4YT7oNd+avs5j9J0tp9N21I
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:xfdANHi9VbY63ZoOmzRoeUIHJnP+CGu4iclCNp/eCK4j/fWdVKQOXZ8460hVkVzmAdQ86sQuyiKS9zD4p1/map1SOTRuzrHOwsij6zJfOGFG5pqtKhleQU704RkuhfpKNXBmaTPvWC0ENX3IqWubpNPRz7+9J6OGkBvQJ5600vMZJcCzviUPIQ5YdfD2Ucok6KUxI5HpO355nVvZ58VWuaK1U/bzZ4xHzuZb3A3RGYorfS5/m0TPB82bmJNkCSZUNBXhWcdad76NVaZD+SpHn4lwi6poakAt8DnYlZ/Cq414Tz/E9/igw58jD81g7geFAHocLDgznR3xugUT5XCAChd6V0J1Vsd0fws7VlZ8dB+u/+FPkt45RFNIcYciXPiLr2HIIMDiGczIV0U5d4giXFPOcW8ijxAtSVzns4aCsTjgU2Ozx/GLqgYhekAqRRCCi8SGjDFs+Qu2HXcYUPY1pg==;5:5dokTx+EM8uEyQbzlByq+MUhOlD0E68tf4lrgq17LBAZWHporE4upD0crKiv6/9mm1Vnz0KV8/TDMASynmQdjYc/9qh4Vps22tvwqAZIen6ttv4886A3LUexnDoFZxm46/1GiQnNpzoes9GYFG0lfO38FwKEnmUa2izc3qHWpGA=;24:cpyCSKbqDuB/D6rMzqV40vmglBry3BHGdLIYvGnpqzbO+oUljcC8mZk93siD2yPhr9l8w70EC9M790zz+VQhygXxc5ulvFx/N7xSolsPXdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:B2c2bowHH6TiVv1BgmL9qeNni6QkdovQvEF/7EuBHiW98bgKJ9FyRuckVbuZ3KyIapjUe+YZZ58aEdmPeacrr5c4pmysF+qP7qtDvyNu/Qvw2dp+vUDQL/7U+4a+OjupR0gD72p8XGyvoBQ4iXs2VTUh7mKu1z4d6xZgT/lv3x1nfO213z8jS5eUgWBXpMJzTLELqD8gJ/YrNLrOybGPQh3Bk6a6vfOREZR5qa70++hZ0FxlKfH2kHmMPHSyjuAJ;20:Ukj3WnZukR7he88PNgOJibl3XimuKEl/7mtYsAlN8714C4qlXpXlkSAg/AsPwlJeAc1RReBcB9+JKln5ppVPknhwDZfH8Rn+/xhgpB/LjjXjH8gTE1wW8CLdaT8WPqo/8bNlTlqT4TApIdwggzDsTY3A1yrWFcFfctpHv3C0cog=
X-MS-Office365-Filtering-Correlation-Id: 8380b537-6309-47a1-ecae-08d5a1371aa8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 12:07:18.2532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8380b537-6309-47a1-ecae-08d5a1371aa8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 14:54, Michal Hocko wrote:
> On Fri 13-04-18 14:49:32, Kirill Tkhai wrote:
>> On 13.04.2018 14:38, Michal Hocko wrote:
>>> On Fri 13-04-18 14:29:11, Kirill Tkhai wrote:
> [...]
>>>> mem_cgroup_id_put_many() unpins css, but this may be not the last reference to the css.
>>>> Thus, we release ID earlier, then all references to css are freed.
>>>
>>> Right and so what. If we have released the idr then we are not going to
>>> do that again in css_free. That is why we have that memcg->id.id > 0
>>> check before idr_remove and memcg->id.id = 0 for the last memcg ref.
>>> count. So again, why cannot we do the clean up in mem_cgroup_free and
>>> have a less confusing code? Or am I just not getting your point and
>>> being dense here?
>>
>> We can, but mem_cgroup_free() called from mem_cgroup_css_alloc() is unlikely case.
>> The likely case is mem_cgroup_free() is called from mem_cgroup_css_free(), where
>> this idr manipulations will be a noop. Noop in likely case looks more confusing
>> for me.
> 
> Well, I would really prefer to have _free being symmetric to _alloc so
> that you can rely that the full state is gone after _free is called.
> This confused the hell out of me. Because I _did_ expect that
> mem_cgroup_free would do that and so I was looking at completely
> different place.
>  
>> Less confusing will be to move
>>
>>         memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
>>                                  1, MEM_CGROUP_ID_MAX,
>>                                  GFP_KERNEL);
>>
>> into mem_cgroup_css_alloc(). How are you think about this?
> 
> I would have to double check. Maybe it can be done on top. But for the
> actual fix and a stable backport potentially should be as clear as
> possible. Your original patch would be just fine but if I would prefer 
> mem_cgroup_free for the symmetry.

We definitely can move id allocation to mem_cgroup_css_alloc(), but this
is really not for an easy fix, which will be backported to stable.

Moving idr destroy to mem_cgroup_free() hides IDR trick. My IMHO it's less
readable for a reader.

The main problem is allocation asymmetric, and we shouldn't handle it on free path...

Kirill
