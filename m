Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeDFPJY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:09:24 -0400
Received: from mail-eopbgr00114.outbound.protection.outlook.com ([40.107.0.114]:7616
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751967AbeDFPJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:09:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH]
 mm-vmscan-dont-mess-with-pgdat-flags-in-memcg-reclaim-v2-fix
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
References: <CALvZod7P7cE38fDrWd=0caA2J6ZOmSzEuLGQH9VSaagCbo5O+A@mail.gmail.com>
 <20180406135215.10057-1-aryabinin@virtuozzo.com>
 <CALvZod7bGjx-fUKZ15oVAkXkeneZjtoRFiUSpKSZ1U0DA_e1BA@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <406e02a5-16d4-7cd3-de01-24bee60eab02@virtuozzo.com>
Date: Fri, 6 Apr 2018 18:09:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7bGjx-fUKZ15oVAkXkeneZjtoRFiUSpKSZ1U0DA_e1BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0025.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::11) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff625532-0a00-41e6-2da6-08d59bd055ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:AU2VaOa7e8QICCzGJ0c80P187lt26cjdJxLikkF6u5n9KP6VkVOpwWTa176cesYLmOFzmME/qyMWRJn3Qpfch6mCSrCcNfxyvTqRoRHkDvJlgWLP+HYROiAvApC7k7839ad1ZonVa09iFEHItcaqhckjYlyPZK7s5W8lpgwFz73MqWRnb82N5VKxb6Rgc4Eg+l7UQFPqbV78l9LfxKdP2QFjwMWWBTmNOG0LJLxwD0hcyH5S6m/gIHCUljKCxxz1;25:oAAhPIbomKisN5u9k62SlcWAcCbP6/3gW4fQG9NZJa4s0+IjDGf4cEhnBvFDBD0LeUNlDHICL6g1DtMz9ucNVM43d9s7xnSEdhzdIUFWmVZD6hLc0TXH5izje0gJ2XnM/FigavxsB4f79psRTyVNWNH9Bi71qnRDd5GTxUVqryI0XsOYwRrVsVZLGUhsPeYPAZm28uRQvhNFx6r7blq25dMUhvzTnn342O4Zk0Go7GX9ZEv6S3tPQS/wNQXvFMX9HdJraB2V75X7CL8+0JPkeM43dk8muQu1hNDhQPb0mIH9YVwUvzBfyqhqd5wx+hrFW1n1M/u4JXVkV57a04Pr0g==;31:YO6kKm8c61z2WVxDoUQehnJ03WHmI2ZkARwkGIKqdVVCuk4Uu4RwpIgmryJ7t8E/CtsH8CLuYC+lIs+pOi53QwKGqHRMDXEZSMl1s8mFrvoh2u5QOtxJgY7bvsmH0jtvruSNgIC5n0oKwTNClIecAd1d/l753mCtXAK95Vz+mM9ZDfuVu6MevVQ+b8fN45j/4C3MQ6ht+q4h3nLb1mIKyyKNF4o2g1yh7G6uHQfuNII=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:4ErJ4oYJYq2oJc53monPa5iDwjpw7TBIGwi4IxTQKMoqhc0ERFemDwnITwusfzGOXjwR33hcOq+gqqLl9/+eGUJmWmmOTN3IzgtJRb1+B9OEZt46sGCJxIOsDNtZcQpRpuIrx+szvS36eqTCaWVZfUlfCkGCLBxijKL4cWTe5VEm0d/Hocw6ovqY+guJcOUD0o0IxADZyTlmmJqpfY0iO7NSdSiroWYyERDF4fMvVn9ZjZe6dqjpDc4lWSX2RV3e0V37/ILNO37c0VSrQwgdvtHqctkUUwSvdg91rAAvG0DyZMPFfqDBK8TAzmRENO4wNtNeCrUG9i0JtiyASuA21HN8R6ma4bADEQpI1angxVLCpnD8k55G+/aNtx6eA37PiKGyT4uU7lljgDQ8UNPM4CL3Y3DfjHqlAIT/XJ1WDUQiZ2PqWChLNe5diXNuvaIVkyqjKZBT34vUbLoloNiBsmJsW75/4R4qX2gGpNkEk2OU8Io00t+HE0TDrofbcC3O;4:qaHBrwLzO2ZU4cjR8ftA0q+w3Of4hCOdO+Q0+80OP630Am1eNc6PkG28sciCxDEaznhSvGuSLVvaczvIfpNA7SngFhm1rHfMRcT9FYLcGOGxb+2VOhlESOZqAhDiKWCjEl+oIG/b7Dx8Zt25ZUZk3h0Cr7Jiz1ffVO42BlRsLbXF918IZTXCAhUDEIsh+A+TjhOepUGOu8/AQ9Fc1viS0uwS+mNPy/gCT18+OM+gS/e8Uvq9+uAyF90tEpbh0sVy1krVX1ZROYs3ncHnXyrV0A==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264DF876675F3C9B6BAF48CB0BA0@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39850400004)(396003)(366004)(39380400002)(189003)(199004)(305945005)(52116002)(65826007)(55236004)(316002)(76176011)(7736002)(476003)(2906002)(77096007)(58126008)(65956001)(956004)(11346002)(186003)(5660300001)(50466002)(446003)(486006)(36756003)(66066001)(64126003)(23676004)(68736007)(2616005)(47776003)(2486003)(16526019)(230700001)(81156014)(86362001)(8676002)(386003)(8936002)(3846002)(81166006)(31696002)(65806001)(53546011)(26005)(16576012)(53936002)(106356001)(4326008)(97736004)(31686004)(52146003)(6116002)(229853002)(25786009)(54906003)(6666003)(6486002)(6246003)(105586002)(6916009)(478600001)(192303002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjY0OzIzOllqSCtsWlNoVU93Rk5lR0haV1JFbjB1UTNt?=
 =?utf-8?B?SFJRWTRocnNxWURpT0xRYTdxdUZEOWFGakdwZWt6dnkzejU5T2EwV0JEZmxZ?=
 =?utf-8?B?ckpBVVpDSmpjMjF0WmxSQS9RclVWWmhrUmY5WmRMSnBQNTZLQjlTRnhmZU1w?=
 =?utf-8?B?amRqYkpHMmZOL3N2cU9LNTRCRmg2aExJSitVN0IwaUpTblNXV2xlM0Vta3Ez?=
 =?utf-8?B?eG5oNFoyTmowUldJVFFtbXdvdWFBYnRXMTdOeVV1Y3hEblMzRnBuVjBpMjAv?=
 =?utf-8?B?Tzc3UGpkZDFVQ3dvOWVuM3QzeE4xU3hocjFsZW4xSytOTjl0OVcvZFNJZk9m?=
 =?utf-8?B?aERMc2V6RjFVZXhjd2licm0yM2FtQU9NRGFpZ1FuMXJuTnVETW5DaTVNZUY2?=
 =?utf-8?B?Mk4xdjhodnJBS3RabnBQTFF4N0I3U2F5OEJCdEJNVjE2aXJUNE01QnIzTTBv?=
 =?utf-8?B?eXFCM0Zveld0OWdWeVFzeHI5Ym1HNEgyaGhVbUJQS2diVzRJeVZQWitaRUpO?=
 =?utf-8?B?SHVra1JtU2VWZmIyUUdrMzVYRE1zQTF6azc1eVFjOTMzejVHZk05a2pSWG1U?=
 =?utf-8?B?Nm9uMWxUYiszTFh0NWMvZjRRTjFDRDhtTk9FNk5qZ3REKzZnUnN1YjFMb3Fh?=
 =?utf-8?B?MU9vbzllTk1vTFlyL1J1QTFJcDd4Wndab0VMcHpNYkFyVjBIWEJiYzIyVWhp?=
 =?utf-8?B?V0Y3cHE2d3dkTk1iSmtrVVhtcGwxUWdtdXBqdUFPUkdtdGhNT2crdUtXNll2?=
 =?utf-8?B?a1hXQTJ2V0FxcFNhK3k3Z1h1YzlldDczeTZMeXIwTEt0MjRFNnpIUmVQWGtI?=
 =?utf-8?B?VHdocTJ5UXREK3NybGdSWnNyZy9NQVRDWVhqeUdXQ1lUS2RwOElTTkhMQm1m?=
 =?utf-8?B?V1RXcG9MT2xlek8yOGJxLzVzWWg4bHBEaTJCajRIWXB3MTdKY1huNStuTGZY?=
 =?utf-8?B?YjNPSGxzUzdMbmtQOU1ZSjlKZkRrYXBPdEs4aDhlRllvNVVpYmJ2ZC9nSzNr?=
 =?utf-8?B?U3VmLzN5cFVHUmdxQmgzWjhIaWFSaWJ0M295RjNjUU9wUU1ibkNtUnV5c0Jv?=
 =?utf-8?B?ZUREMEozQjJyZHB1VGtvUjU1bHU3REVrZVBPZzZjNGxmVHJKWTkxUTlOQ0xU?=
 =?utf-8?B?cEM5WkY2RzI3TTF0YitwMVgvVnVER2VjWTRpZkkrV1k3dWZjc3B5cEdrNlVK?=
 =?utf-8?B?LzMzVUE5VVFQdmpYSUEzbGtqNE8xcWd3MHpDLzFGbDZIMWZiU2M5Z3BLT2Fn?=
 =?utf-8?B?clNFVFRwY1JwaWR4YkNYZHNPVkFFdW9TeDcreXlUVWl6MlhoQzVYWjdpWVln?=
 =?utf-8?B?SmR0RS9DUkNvUGcva1A3QjhOVDRaTHBmVlNNejZxOTJwNnhpV2VDSXVYV1Ju?=
 =?utf-8?B?a0dNL3orcEI5eFhWWEd5b0RuZWI0cEdJUTV5TmdobzU2V3JtSENML2JpeFBW?=
 =?utf-8?B?N2hKQTBjUlBLKzhwNkxPR0prSVZ3UitqemRCY2k5dmcrNXhQV0JCOGtMbVEz?=
 =?utf-8?B?aWFxVENpVzlyd0lkSzR3L0FVYUJpenYxaTZGSDVlZitmcFc3SE1nYVZMWkJE?=
 =?utf-8?B?N3BhdkNOY0JYa2EvYWtCVWc0UHlJVUx0b0ovOUNxMk1IKzh1b01YalR5bXlG?=
 =?utf-8?B?ZHovWlZ5VGhJVEZFVXRMVWJmUFF3ckU3SEZIWW4rR3g2Vit4ZUJ6V3haOXVx?=
 =?utf-8?B?RnFzS3hYUWtUTUJNSXJvZnlBNXoydnhjM2FsOWNoVXlsbS9ET05JSkNXVkJq?=
 =?utf-8?B?Tk1TTlkyYm9QTExsSlVzeVNVV3VhbUZMY1hGUjhoOGdPaFVBeWM1aUlOaHZC?=
 =?utf-8?B?cG5MaDE2TGwyaHlwZUhwZU0yMW80NU9CeWFWNlBJR0FNcUl6MmU1VnNYUlJj?=
 =?utf-8?B?cXJ3US9RMkh0cG02bGJvT1MzdmVRemJRVGJwbTVFZDB5MmliWE9IY3A0L3pI?=
 =?utf-8?B?RHdDcmxoZEtTSjVLQnlMcWgzOGZGZzJHbXFYZ3MxNGpqdjhJSWNqQjhvSWpu?=
 =?utf-8?B?SDRTdTMvWXI0Y0xrL2dLV3laUEZxTHNJUEE3Zz09?=
X-Microsoft-Antispam-Message-Info: aMhs+GTnVUjvxvgSsdluERAvxMMBgw1TUQ4bPMKKK3AMbAU/u4XGVg92NfTixrzGlgmpFLIM59DCfWY+PrdxaDekGh9XPApCV95zksvUEu+4+aHfz1cP7V4tKhgpjlcgsn+JIdxU9vtPpuNvfjIsL2TC/cE1BLmlahUManBeqUr3wlnKdraN5E1ggDveMV10
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:aK7LwEi7n/eQZWoCPkEwrtOHmWymLR7pOm0LE882MwqsCNXU4fq7DJdnyNLZG2G4x3bUkx+czvYFlmLj2pAnSBMri3oPzw+8Zn0edlur1a8Qt8flM08nKfUXuV65oqK3FeruyFEMZCuv1OiCrmQALy6SqacFgsi9WsrKMqV5Tx20njWoDodQ+2ZD7NRHfu7S8HdepS7hnP88/0K0MD3vOG20Szmc6CzPp+tE7Dve5ZSs5nWjaN4EZxWbh6D1sQpVBHZpwXioyLXCEZz7QICZgwHfHeRyJ9axMls7lWtQ2pSftcRGJi/Ka/0ZddEy5A8Fu2LpmcrFv2+njoZjrsrfl23DkPCDPYTcMucXMlISObpkuCwHAbyVtmcCgm6uzVXYPItLPRBNR9TKLS2iv3+Z9GMG65H098KPzJ+qokCZHJ2sidbDGczxB2myMRWQN/m1d0Hzg7Bp7kVJGkRr8y733A==;5:gBshVcXvneng5pk4AdWCBkZKuBbG/uVybgPovpceC4w7WkcGtkj5l93NkKgsXUFcKPqaw+zEAszFtsUmBIHu+/JlUhT+53QXpxloPlAoOBakQN36nm85c9FGW3jDbssnbrOLj4nlIrehW4ff6ILUd0lMoy94TL6G6EZk/BznmEE=;24:KXVI13SKf1XIRXD+MtOFRwnum2lBDe5afvI1iVy2eCzhyIuljZ204pt9LY3Yn+bbK4fQ+Zi/5ewxChmDpLdi6gpiMkTjzhJMPe49ZXoEPvk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;7:oA2sJIb2AzP1/36MV8ZdRQ2Aat7X8jwMf8LF2cPvjHa9fnSKPr9B4Bfa7B5W730yfFrLaQrvtS4++WaUOocX3GJtgkBVPeS2RHC3gs4kz23Ci2gO7nc6BGN8vYEcDFvXpaMmastJDZsCaCqp584NEqCUTHm/D8dVeng+zCYSL/e15AO677zIOw7HdghaGSFbJSWmZEpHotyK/rhDDmlhAJrG8SY/2kxFbjLaOrluOHEJRu+OM+7K3KIIkVLTDV1B;20:WyqaO/EK9g/TqQWmZ+ZDsMJ9q6I+Kg4DdF7O/jlWZD3VHGErkaqBQCMW4Ks1nPufuwcHxPue2XZ5a6zQ77kR4pVoCrPv2P1RLFk75nNmePRWadG261lhhcItKBLFChZn4xG0GQaAVkgAZYA0eExOvHux5dM4y7g/W/8LIFxIbkE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 15:09:03.2246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff625532-0a00-41e6-2da6-08d59bd055ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2018 05:37 PM, Shakeel Butt wrote:

>>
>> @@ -2482,7 +2494,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>  static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>>  {
>>         return test_bit(PGDAT_CONGESTED, &pgdat->flags) ||
>> -               (memcg && test_memcg_bit(PGDAT_CONGESTED, memcg));
>> +               (memcg && memcg_congested(pgdat, memcg));
> 
> I am wondering if we should check all ancestors for congestion as
> well. Maybe a parallel memcg reclaimer might have set some ancestor of
> this memcg to congested.
> 

Why? If ancestor is congested but its child (the one we currently reclaim) is not,
it could mean only 2 things:
 - Either child use mostly anon and inactive file lru is small (file_lru >> priority == 0)
   so it's not congested.
 - Or the child was congested recently (at the time when ancestor scanned this group),
   but not anymore. So the information from ancestor is simply outdated.
