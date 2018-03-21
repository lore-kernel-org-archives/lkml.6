Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeCUKj5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:39:57 -0400
Received: from mail-he1eur01on0105.outbound.protection.outlook.com ([104.47.0.105]:27136
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeCUKjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:39:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 5/6] mm/vmscan: Don't change pgdat state on base of a
 single LRU list state.
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
 <20180315164553.17856-5-aryabinin@virtuozzo.com>
 <20180320152550.GZ23100@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <232175b6-4cb0-1123-66cb-b9acafdcd660@virtuozzo.com>
Date: Wed, 21 Mar 2018 13:40:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320152550.GZ23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0058.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::26) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4f4abab-85ba-4c25-33f2-08d58f181247
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:0TkekhPjbTBdz2u3sfEqmiuFR8RaFvKxuiBrFPZkteBqWtY4yBtMsjcGWqIjLQUfoQbXq0zbkMNRQfVqRhkxpZADq93RTpguCgabOx+wvW6pnbe1G+g7IWtN5pj6ASbq0kMh1aBI2Rcz7dRJ5yex1ZM9X8qT92iLCqN809neWpKW+Zr5So7u4EPPt16K0j+lBd3AKuNRUs+dHDaFyko9rusQjmv+KLzGBH4YEHkLKOUpROHwCYsVpj+cMOLY7TmT;25:sii7Ke1LgVaNDyBUmVQmFfgKaKgruXEvF4NO4E0rxQgWJs5r8cxXXYylGZDZxlg2EX/5reyqDrIOEMJDDRQJYRt8ETmTAv/UkL1mRI/Mu/I/6U1dlVBAzZ2wsj9GO3LEXfcHByHSQH9IzyG3+UsSv64MTiCclJbXIgywQ04Z4ceGZQsKfPqq92u5o2qUz64BR7xyeLbPer1f8Ru0kx5aVa3Tyl9cmBa82uHbFAZUIzdN2cysoHZXXNI9hsiMuVMX81PYRo7E+qw5oeIvU4gF+IpzMMddAlIiEgoqGOt2T3UReJZdM1tjPHydD1r1z9NiBjoD9AcIgw8Fj6uaMBeC3Q==;31:Apmq/dicaaoGkJ8FS7lgxS7aWa1RW7fpbYVZR+Rv4Yk/QbmsjCvDTNX7vMaXzaDJL5Kq8ULpvM6sjr7tTI/FmkCrl1pKdTcujtg1nN9mmKRV51OyoDSG4ZY2eupdV4MvQ152wgmZXkA0nHgrSjYmf2OOmzZ5x5CQjRSX7P57BgWf6Db0bHf2LJJeEZ7OVadb8RXc6YqhK1Nl3KsFSj1WkInAlVNQuRGhAWiseg8DqwY=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:cm1XAgIci4iY3USEIUPIPQCUtXmDCpSmxfEHydLOnxOGn1Uk2sJFQkHOdCp6P7pjmr1Wi9Vd997FvsJDVEnbWCH/T9hR02tSPX7tcN7xAkzdked9UAkEKONF0CvJ2RWuCdOefako3SEh+NCz3nVIgy+V6qYFBVPTfbGN1yG0bCFkGc0Dq9jDX2pu7sLdcMm88+s54yeo+cIatyMQkFvH4mnKiE+6FbgdAFtv4Zzq95tcYm2tvWWBpKPXfzpt4cJQeUX+0vtaW1fjGOCcHgSCXDE0W2X4HucTlPjIMCPQmmBlqgoYnDw33BAvMhgTbrJbxgieNl+knLMFMqBLUPlFlX6xCPPBmBZDK0fGMYnzSw75sedq2LHNuqfkUP/KaqH7o0Y86ETgg3+CWPfm5mqMft4yXYTwssQLS70FQIdVnBtinVzO/qUFuyghNi0Mw2jfGYdX2vI0HodaU+2QpNX4NvcOQ79W8oH5+KsuMbs2urrl1ZmSfV+0rbguxMoZPg5Z;4:oQXFzjwEs/hvV22S5pAHxLD65FkMvPBgaTrJlk+QHPd8M6K7t3rrG2mtryr1PAf/GSYjqoF7vULYUAgjQV6rp3tCaCPD1n6cAjtpXQI5UX5Dr3ufr/VR3rsvfC2x/G2cttD7dO4NJKt0tneQwZ0do4ZbBQ/NnMi9wyJw7/41pn1BvY+lyY5Nu1HmC0ad39+NVD9z644mftaOpX1U+wTgsBzltrti+0lfofUkakggFhjk9tRHlbDZeOrcVKfX41t9lJ35Q4076L6YzI/l7MJaig==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258207B4D1BD174C8104CBBB0AA0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501321)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(52314003)(377424004)(66066001)(65806001)(65956001)(6666003)(2906002)(478600001)(6246003)(23676004)(52146003)(2950100002)(2486003)(52116002)(6916009)(31696002)(76176011)(47776003)(386003)(6116002)(53546011)(53936002)(64126003)(59450400001)(3846002)(229853002)(106356001)(186003)(16526019)(77096007)(26005)(97736004)(105586002)(81166006)(8936002)(4326008)(55236004)(50466002)(81156014)(8676002)(5660300001)(65826007)(58126008)(230700001)(54906003)(6486002)(16576012)(316002)(86362001)(36756003)(31686004)(25786009)(305945005)(68736007)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOkx5YkgvdS9GRTZMYkh1QlB2RUxnR1czUThB?=
 =?utf-8?B?T2l3aWU1ZmN6NkpwOWgzejRSNW85alovUTV3dFBJaUdxcEJidzhlSFpXOUVi?=
 =?utf-8?B?MXZkVW1NUGtyOWZiMC9raFZDbUdFeVBoK3Zub3FLeHAyMVppREY5TVBBMFdN?=
 =?utf-8?B?VEFLV3YxY1A4V3ZFdFFCR3BBMTZMeXFBVHRNQkYvNFRpL3dITGdha3I5dVRN?=
 =?utf-8?B?b0RwaUx6dTNGdEYvWHhXNDUzekVHV2NhS1ZtZmVKSGpGNk9HYUhoaHo0akcx?=
 =?utf-8?B?bjB2REVQRGdlOGhhd0g5cVVqZFpDMVFoUHdIZTkzSldra2MwU1Z5MjBpSVE0?=
 =?utf-8?B?Rlh6MlNBK0ZyQ3Z4Y1dJbnViOEQ5R3FNdlZzU29yUFpMS3NreW1ldytPdjJS?=
 =?utf-8?B?ZzZ1Q1pOOUoxYkZJOWxlTEJncURaTnZLSmlwbUZIaVI0Kzh0ZVNpZTRUbWJ3?=
 =?utf-8?B?ZktsNVJvLzNGNVVMSC9lZlV4eDFEWko4OUtCbFBRb1luNDR0S1ZSUHBNc3Ni?=
 =?utf-8?B?Vk9acFhTbGViYS9nZFQ4NDlEQ1VNMHFSOFYyeTU4TUlDUHBQZTFKQWxROVl6?=
 =?utf-8?B?SnJWRTlGK1A4T1Fxem5DaVh0Wm01bmcveDBUK1I3OGJSN0wwSnhKQkREeElE?=
 =?utf-8?B?N2V3cXNnbldtUGQxWXJaZ0g0bEp3MlpNbi84c1VsRmRBaDZlckM4QjhWNmhq?=
 =?utf-8?B?dmFFemhudmdQMXlEK2dGYnZjUllJMXZOS1VhV0pNNldDR1VBcmdzQ3FsOWsy?=
 =?utf-8?B?YnpOVXRJQjhjZ0U3NE5YVHkyYndJQUhnRG9CZS9kMEhsS2xZL09ZS2dKZTA3?=
 =?utf-8?B?NEZjd3plS1JZZWxZQnViYkZNdG9PdmJNYzM5Wm96S1VsRjlqR2F4VXFqWEdj?=
 =?utf-8?B?cmt0a2RveWZFRUFvejBRcXE4L09PUXQwQXFFZDJHaDlVYnc4YldJS2J3Q0sz?=
 =?utf-8?B?eHhwb0FrUmZsYVcvN0xpOFZWSXpoU1luSjBGcXZONFlVU2dPdUM2UCtwYWNJ?=
 =?utf-8?B?SFk4aEtoYXU2SzJHNS84MEZBS1U4RThudXAvamlvNWJmdTBCK2FvMnNTMGxx?=
 =?utf-8?B?TVhoZHI5YjJHNWhLSjlYTjFtRUhMdElXRURXRlJUM0pCaExPMlZpdlY0dDkw?=
 =?utf-8?B?MTl4bWVUNkpRU2gycncwVXJFKzd1UG1xQlJvS0V2OTNtQVY2MFA1bzRUd3Nu?=
 =?utf-8?B?NkxGS0ZtYW96QksycHUrNG1ER3R2dFJ1NFBOUkFzMGUwR2NONmR0dTF2S283?=
 =?utf-8?B?ZlptaWtxbElTVW9uSkViaGk2UWNoMis1akV3L3J1MitxcXljSk0vM0l2ZjNH?=
 =?utf-8?B?MDFSNTdjMmtIaGpYeDhVUVVuYVRvRHBMTURIbXU5K0ZRMkV5S3IyWFpTUDN0?=
 =?utf-8?B?cmJBOVlZeE9Zdy9ySnd0aXA0VXA0M3VGcnNnT1V5MXg5YTlia1ptV1dVR3Zl?=
 =?utf-8?B?bGRBS096ODFRRzlvUjRFTVVvMjdxTTF1OWhIVDBvVnE3cHJNZDRCb2N1SWRG?=
 =?utf-8?B?blhhb2FqSW1iUkFaNU8rRU1kVWRZNWdUSFd4SFZVcWJ4dFk5OGZ6S0NQRERr?=
 =?utf-8?B?Z1FDRWJwaWNNcktHaTYxT2NqU1VBbDM4aklsWk5LSGlSc3I5akl6eHZKZFVj?=
 =?utf-8?B?aGM2MnJPN2NoMElqazdyeHlEZis1VHZPaFJhb0xiNGRWVjJiRUMyYVZaM2Z3?=
 =?utf-8?B?ZE9qbGhwd3lFNmlaNk1NVzJPeTdCdTVyNVBYZEtZcjc1cUNUMlNWL0lzVkhy?=
 =?utf-8?B?ZkszUXgzTVE4T25Dc2Q1RGkxRlIxbjZaYy9vK0VnRTh2NUxjdy9hVERPTyt5?=
 =?utf-8?B?cm1wRjdGdmtoK1JZTjdIWTRBS3d2d2NvdzdtbDBabFB4TVVuVGEyZnNZdXNh?=
 =?utf-8?B?M3pMRVNmOHlld2lvMTAxa1Qxdldwd1VlUVY2Nkpyb0JWWUl2RVpLaEhQaSsw?=
 =?utf-8?Q?/R1VDv546aO0fF31oLeTdC+fokKeJE=3D?=
X-Microsoft-Antispam-Message-Info: JwWvp9LbHMLtuCA+9/LU1bEoebsYEGj/EF1KbHNj0qdtYEnU4i4Cf4aLK9khJjB3Uv6eVKl6OVXxqgGvsQNlfXHV2y/D6yob1TXkV71OfC+EyhsPLn2A4khVYHUM8bLWX963ysPemMehavLwEtm6B2NAVtanIpWy/7KM/g22lhwavwSZG6K78l5WkqALPCte
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:kpr7epvWFJux+ur2MyzW8tz0A0VhEMhPsZBLgtt+ohrm1aMB491F6Z9Q8E/3RluEWz6BzUZxKjFBzE81xKd6bSLIWIYZiaSk8ob/TvYauHwIXw+AbV6Pca4uc2EIU9FpoeyVnk32Gh1Nh9UNlUGsmt09Jk6TPth9mEgtk+YkruxK7fddVmC6bph6gkMwK1Y+fcEBOEZchdm2Vu6QozF4yD+vqjwy7lZV4sZb8xHXN+OdwrdKwFoUepkS1hsDEKviPKHVvtdFw/BgI69xepRgndN8HkVXBfmEKuQOYMcyrwS0NxRSKxlPfX/L8E3LOl+AsgS2GEEaWS3et4Rq48QtqueHREJPqQGtHZqDTVm11k0=;5:+0V8k9HRt/F6EqJKRXyQ8d+IxUvfdamWG9I4e4H74NFeGjFW1rgHNgZgxYa+9wmYjGma4SdK8Ss4G5CCssXfbltpi+TwH4Mf8VM6iFjjLHVJ0ZyTmo857cWF1Lu7tL+O0gm2p3Pb7dAYz+arvfhTrPbNwDQ26wiEzXmuGi9UMKE=;24:vKbtJP6aHG+iXJqCGKnF9KDgy7GBzmKnbLlGAo5ZjH+SweKuIvIJt1A/y3T6qCi5u3XYgWl1lzJ3mHW4XQp1WwmaVkqqqdDQ5iQWqrgWkRQ=;7:N6FbxeJpXRoqEoa4uOT21T1fmxGRH7hoUGYgmZpdbJU9sl4dUQ4jW4hJn/WChAgF5ImYVRUWd2lueQIT45DBsMI+cJJlreh9UVW7zo28JlEhLc1P6aqTmgnceV5IlgyH2g3c0ta92uCxfcQ7rK/C2KB4wtShplOCdoztr7dbrc1hy9Eh7ynVfr9AmymkJEN4Jtya+busUzhjPujz74aux6q0IIPT4OcvA1YkGIBJpbQnHX7LuFDqoSU82FYzMAYI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:nMjE5tZf+82XztWK400FOe4gmmDro1TkEhxdNM+KWf09eUmKWxbHIDSyZyXnhdZ/j4Wz3l8683r85j1rVAav5ZO6U2wPhGi9g17yzxVxinCR+DQ1FjUgRFYh6kvGqRfVPLJia8GAmCoFLnPCfkVmOONhJ70kVjVdvgdBOEBQ17o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 10:39:48.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f4abab-85ba-4c25-33f2-08d58f181247
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 06:25 PM, Michal Hocko wrote:
> On Thu 15-03-18 19:45:52, Andrey Ryabinin wrote:
>> We have separate LRU list for each memory cgroup. Memory reclaim iterates
>> over cgroups and calls shrink_inactive_list() every inactive LRU list.
>> Based on the state of a single LRU shrink_inactive_list() may flag
>> the whole node as dirty,congested or under writeback. This is obviously
>> wrong and hurtful. It's especially hurtful when we have possibly
>> small congested cgroup in system. Than *all* direct reclaims waste time
>> by sleeping in wait_iff_congested().
> 
> I assume you have seen this in real workloads. Could you be more
> specific about how you noticed the problem?
> 

Does it matter? One of our userspace processes have some sort of watchdog.
When it doesn't receive some event in time it complains that process stuck.
In this case in-kernel allocation stuck in wait_iff_congested.


>> Sum reclaim stats across all visited LRUs on node and flag node as dirty,
>> congested or under writeback based on that sum. This only fixes the
>> problem for global reclaim case. Per-cgroup reclaim will be addressed
>> separately by the next patch.
>>
>> This change will also affect systems with no memory cgroups. Reclaimer
>> now makes decision based on reclaim stats of the both anon and file LRU
>> lists. E.g. if the file list is in congested state and get_scan_count()
>> decided to reclaim some anon pages, reclaimer will start shrinking
>> anon without delay in wait_iff_congested() like it was before. It seems
>> to be a reasonable thing to do. Why waste time sleeping, before reclaiming
>> anon given that we going to try to reclaim it anyway?
> 
> Well, if we have few anon pages in the mix then we stop throttling the
> reclaim, I am afraid. I am worried this might get us kswapd hogging CPU
> problems back.
> 

Yeah, it's not ideal choice. If only few anon pages taken than *not* throttling is bad,
and if few file pages taken and many anon than *not* throttling is probably good.

Anyway, such requires more thought,research,justification, etc.
I'll change the patch to take into account file only pages, as it was before the patch.


> [...]

>> @@ -2579,6 +2542,58 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>  		if (sc->nr_reclaimed - nr_reclaimed)
>>  			reclaimable = true;
>>  
>> +		/*
>> +		 * If reclaim is isolating dirty pages under writeback, it implies
>> +		 * that the long-lived page allocation rate is exceeding the page
>> +		 * laundering rate. Either the global limits are not being effective
>> +		 * at throttling processes due to the page distribution throughout
>> +		 * zones or there is heavy usage of a slow backing device. The
>> +		 * only option is to throttle from reclaim context which is not ideal
>> +		 * as there is no guarantee the dirtying process is throttled in the
>> +		 * same way balance_dirty_pages() manages.
>> +		 *
>> +		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the number
>> +		 * of pages under pages flagged for immediate reclaim and stall if any
>> +		 * are encountered in the nr_immediate check below.
>> +		 */
>> +		if (stat.nr_writeback && stat.nr_writeback == stat.nr_taken)
>> +			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>> +
>> +		/*
>> +		 * Legacy memcg will stall in page writeback so avoid forcibly
>> +		 * stalling here.
>> +		 */
>> +		if (sane_reclaim(sc)) {
>> +			/*
>> +			 * Tag a node as congested if all the dirty pages scanned were
>> +			 * backed by a congested BDI and wait_iff_congested will stall.
>> +			 */
>> +			if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
>> +				set_bit(PGDAT_CONGESTED, &pgdat->flags);
>> +
>> +			/* Allow kswapd to start writing pages during reclaim. */
>> +			if (stat.nr_unqueued_dirty == stat.nr_taken)
>> +				set_bit(PGDAT_DIRTY, &pgdat->flags);
>> +
>> +			/*
>> +			 * If kswapd scans pages marked marked for immediate
>> +			 * reclaim and under writeback (nr_immediate), it implies
>> +			 * that pages are cycling through the LRU faster than
>> +			 * they are written so also forcibly stall.
>> +			 */
>> +			if (stat.nr_immediate)
>> +				congestion_wait(BLK_RW_ASYNC, HZ/10);
>> +		}
>> +
>> +		/*
>> +		 * Stall direct reclaim for IO completions if underlying BDIs and node
>> +		 * is congested. Allow kswapd to continue until it starts encountering
>> +		 * unqueued dirty pages or cycling through the LRU too quickly.
>> +		 */
>> +		if (!sc->hibernation_mode && !current_is_kswapd() &&
>> +		    current_may_throttle())
>> +			wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
>> +
>>  	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
>>  					 sc->nr_scanned - nr_scanned, sc));
> 
> Why didn't you put the whole thing after the loop?
> 

Why this should be put after the loop? Here we already scanned all LRUs on node and
can decide in what state the node is. If should_countinue_reclaim() decides to continue,
the reclaim will be continued in accordance to the state of the node.
