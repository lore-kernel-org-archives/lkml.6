Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeBYJvD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 04:51:03 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:1332
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751505AbeBYJvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 04:51:01 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>,
        Tariq Toukan <tariqt@mellanox.com>
Cc: linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802201917200.24268@nanos.tec.linutronix.de>
 <1e79eaa9-202d-b48c-4463-ae195a4fc891@mellanox.com>
 <alpine.DEB.2.21.1802222227440.1612@nanos.tec.linutronix.de>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <cf380377-40da-66ec-9913-1c5e3a748a7f@mellanox.com>
Date: Sun, 25 Feb 2018 11:50:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802222227440.1612@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::26) To AM4PR05MB3250.eurprd05.prod.outlook.com
 (2603:10a6:205:4::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35b165ac-f878-4579-b861-08d57c354505
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR05MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;3:ftkscy7LZ594FadYpkLhYLZ7DD5pHUgQ51zh6zLd97B1VbIdhQzS86/jVaSkzPqgPDFUstx+XwapICENZbXlVGv4Dk5FpCsnKLMi2laHpwdT7pAQY2uDLjBTOTDihiX4mUVxfC+nbTkQN8aM+cBykEcXIgIwTd0jsOh1PsC9E0vaUbAH8BZC3ypxKaSkMBA4N8FW6/8nK0XkCfXM3PDOEz2xCP6+ianHxDqL/5KQHA23MRg2ApKhOxvF1yRGKuyv;25:bajKGdL2TdbTjriSXCc2KKaBZBssalVCy6oQsuoauE9vsnJgmwfyYFVUqSZb++Xha5AgNZ3ycEZEMwx7mKB0pLijh0TIBzqT5GPweuy+L6G8XAkMgvwbCR+YYwPZ4+HoVmbDBE5eClQiAM+v0XcVMy+FN+j+Qf01xx3yp/c3VmCjI7mY4JU/xI/2GI+eMCcujZc01szzYnHCiVrjq6CzjEmiWIMsnC3ANw2pA78zIldeDqN9+008W22dt10hcoHuESBFvc1FQ6hnQXQvtRK5Z+idKWSaHfpQFQRTs4BCXq2aRPctdRPlNwJuoc7y4S67IyO5cCvGWqTE3l3v6pvTPg==;31:PjWo8Ii9Zmc1gVCPTs5N3BwJvR4I8Tw3KbWea6tEKoVao0u4X+U4vQTfRv0lsSSvPOt8yq54YOgyh+7SsKW/M4CAw4bsDzcoNuiGhpSG2jmYAmtLNt8MTQLiA1hldRGpvLXu8Ud8qtkwimN3HnEfYqDAZJ17Ce018pG5x4Z7p9muz1/5899EYO2esW4Ypdx/PXmgLsk6gq7ze9ygVqmS3fo0tc62zcxLxBWzhatFDts=
X-MS-TrafficTypeDiagnostic: AM4PR05MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;20:6X44MlwOS5rDVDBW0h6jTBaxIGZK7ZRNnN6/BZgRqS5u7WdZjaWL7BxI7tnLQgkKA72W4Y3vn/gAh9zeGnjqVopux29aD4I6bp24tMHCJ9C5vizUT0ph0KCREEFO2JQq5hquhcYUqLuVMbyueUg+ijeoXOclmX8iB1VrPEWvl06RW5g6bpQSEZsZUSgyQo6rkigIpr9jG+ZNtR4wKCnH+SeoTeWmsBSqKMjJJDtp3TPXfJ/CNVaaqPCHMyjfh1+veXqvBgfitVxuFhdP5ed0BK0MPFyYPhAgozlDeLbEYRRXSK7PoiH7yKsZDIfrzhTeZ1e7p7kZpHAmmREi/OmT+RIItHiOJKmgSrSorrjh9xrCUCwjvvzDbq6uW0SidYZ863xGDP+K9uuKlCbTv851n6hFTdiX6KsRxO93lxVYwx8FE7VqprzWaL+gZ8uIuXXifCaadmHuB+2Y0Ola4+NUWbQ75x7cMW/NHUPzlLG/fGArrm/yTMcSTleye4F/ASD+;4:gyvrNW4/XfndKaBt3I7L+d2qMAjhqhdLui7JamLv1HRsQ6ig4YCIou/aNvkAQDnYpB8dtdn84sk93NN7k81KDz1aIsDaNJDPTyH5ZjGSx0blCpdHu+SdUsdSRENk6TUVAbPjW/6lke30eau55m+Ndy0sv9dFFbh30RcJ8mhhVohFraUbDknTHy0R5q/c3dFuVFrDAOAA8IAJFtmaa+oMJcxQc8qLXIjyY9L6TCLEeYkiuM0A23JCm86IvjiC6w2+fOnf+wBvxYpelXlWHElwXHreU6cK+gX6Nr/Vw5i87T7w/xhy9yYr2qbe7m8gbJ9O
X-Microsoft-Antispam-PRVS: <AM4PR05MB32507D3DEBDBABE380D1CA05AEC20@AM4PR05MB3250.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155532106045638);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR05MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB3250;
X-Forefront-PRVS: 05947791E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(26005)(2950100002)(107886003)(6246003)(4326008)(16526019)(25786009)(6666003)(58126008)(66066001)(65956001)(105586002)(76176011)(110136005)(93886005)(77096007)(36756003)(8676002)(16576012)(53936002)(8936002)(65826007)(81166006)(5660300001)(229853002)(2906002)(86362001)(97736004)(50466002)(386003)(316002)(53546011)(31696002)(59450400001)(67846002)(106356001)(3846002)(81156014)(65806001)(6116002)(6486002)(47776003)(64126003)(478600001)(23676004)(230700001)(2486003)(52146003)(7736002)(31686004)(305945005)(68736007)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3250;H:[10.8.0.245];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA1TUIzMjUwOzIzOjJSVVprUDhWSUlHMjU4bjl1eVZNMHlZYSt2?=
 =?utf-8?B?OHcrc2NBVGNVYldkU1hTMWovUkE2WnFXTzdWa0xlT2FnTDB1S3FZRlJoNmRV?=
 =?utf-8?B?bkpGOVRvd1ozWjFvcWJNOUlsY1NkTkRocFJlZFFuYXBzUVJqdWtXZURTT0JW?=
 =?utf-8?B?ZVMyY01YRGpPM1J2d0x2TGdsQ2lzT1JCMHIwcVhOUk9iTm1RQXdXeWZVRlJB?=
 =?utf-8?B?U0lvbkNWQXRwbTVTUnpraVpQd3ZuNnZJalIxNDdxdlpadXJUUlB6cWJ5RE04?=
 =?utf-8?B?MHVHMEo1TnY0b0Q5ai9OeXRNbHhGN3J4NnkrdU5GUGNJSVgwYllhcjJKQlF2?=
 =?utf-8?B?amhKdDFlSnNYcXREU0ZYVXpGVk9hYmpaRDRhRS9jRFdXSFp1WGs2NEZWWUpC?=
 =?utf-8?B?RUZFZ2Q5UFFnMGpZNks2bTR4VWhrdDZmTytwQ0NUVEtkVms5WTlsaHQ4Zm5J?=
 =?utf-8?B?MHFkaHBnUUZ1dG9NdzFYRGxhWndZTWlvckZCR2RDUEhWQkEzcWxKZXZCSEgy?=
 =?utf-8?B?RVBDcjJ2YTJINFc2Vm9MTVYxbzY3dXI5dkg4V3N0VWFkUW14VytmWmlEOHI3?=
 =?utf-8?B?VG9hZDFObml1OHEwNGExRm9hQmNodFRCQVp5NXR0OWxDOTNuV0V3NjNJeVZt?=
 =?utf-8?B?cE9DODRnRFFzUTNjUmNOamEycGhlVUJvNjE1VjgzSS91MW5RM1JhZWswcjhk?=
 =?utf-8?B?N3piYmZjNGJRaGgvQ0FjZGpXUDlPR2VNOW4va2JidXdOQ24wOTFFeWlPZ2tM?=
 =?utf-8?B?TEtNZDJKVENHTGhwU0JBUzJRbDI4N2FaUmRsbnZCc25ZWXJqU3hES0hxOUZq?=
 =?utf-8?B?eVFPM0UyajZHY0pMSFpsdzd1M0g4em0xUjdNeTRLNmhQclRXZ0Ixc0ZwYURQ?=
 =?utf-8?B?ZmpnNFczb1hLRnIvNllmb2N5UHZ3bG1DZVVtTCtDVVhUS1RmR0x5c1BWb05o?=
 =?utf-8?B?YnRRTGZCVFF6dkdNdmswMnVUaHd4aVhVdkpTWGlsS1NENmQzdGg3aGwyZjBX?=
 =?utf-8?B?aHVYbGNQYklMU0k5VVZKZzUyczlhaUZVbUphdFBId0UvZEY0L3Z2M3ZGZFJW?=
 =?utf-8?B?NFFxdlExSS9HcWlNKy8xZjdUcDNzcnYyL2N1dkkzUjVHbnU3SkpnanZBajJ4?=
 =?utf-8?B?SGl1S0NwRS9zcWlsOTdoSEY4RHVSSVJkc1R4QVp0YjNhWm53WWxmcjVDR2RS?=
 =?utf-8?B?UFRWdmZFTXNmSkUvN0p4K0ZsSTBRK1dmMHJuWlBQZzFGUHlIYUx4N0RWSjRi?=
 =?utf-8?B?UTlVeUMyampCUEpVR1hBSkdSTXFpd0NmUHhPMzV6YVpkdHFwRDBaNVBWOVVp?=
 =?utf-8?B?UGt2SHdNUS9EVEZBVFYrQkJHeEJhUFBOTXdlN1pKcWtZanByQktpNE5mQ1Vz?=
 =?utf-8?B?SDN0czRKTUcydmJhN2xvTmVYYSs3TVNDRkQvVm41YlBja0syQXdEV2tXbGwz?=
 =?utf-8?B?WEpLRGZIYVVqZkpLZ1A2ajZQYVBiNkJ1VmVlZTFtL0pQaUQ0Sjgwb0hybWRi?=
 =?utf-8?B?eEo4T2h4QU9BNFhLb0ptK0RDSSthZU9WQURnVHgwb3IvS0dFWWdxS3JUQ1ha?=
 =?utf-8?B?K2VUM2tFRURhZ3BZSlJ4WGc5cWJtWXowUHBWQnVjTlR0dStHMldvOVI4UjVV?=
 =?utf-8?B?ZktxNWpZcjNYcERwRWhuM1RiRFdPbnRrNnJDWE9NNVZxWnExL0tBMG5Kbm50?=
 =?utf-8?B?QWVMdStkNlVrRk53MVF4UTIyQ2lHUEt2S1VHUjh1bzQrZ01uMmw0T3lobHlu?=
 =?utf-8?B?SVIwRkkwUE8rSVhibjVUVjk1dm9Bc0Q4R1FjQlE1cENBZHI0NjNHY1hIZmhB?=
 =?utf-8?B?bU9EaWl1VFZtSzNMSE44WVo5ekNOV0JicVRCdDVjQUJkTWNhOFUyOXZELzlv?=
 =?utf-8?B?Nndwd2RjZytHQUtYQ1Q5TkJGY0tzYW1DTUFFRkxyQXVSblNjSnNNaUV3QmdI?=
 =?utf-8?B?cHdNNUZTMzlRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3250;6:KlkUwG9nwli2KVS9e5ESNsWIcSknUg1ZE/CfnXSvki1eFikeW38mEnYCpyDAgHKrgCuctKVUkzOMD/yy5YuGrAeEBfSIFTK+M4E6kGuBXOcX/5edDBcmnOaqRT8ItOL+NVrl2uGSVHsTkTaWfSVEvZankmz+itCZbWXs+ejPeKmskvd76yO/QA+IAAgz9qKWaIYNNVRDdyM0fbqB09oLRVkH1yugVHLy7irj5XUPPgoshPIxyBpZM0o8TWCmhZsotmGEWjZZezYFdsxJ9MDIt1gaOeypKS5q/yk9q+f1seAA/NyQ6CilfKCMYb+2wa/oTmj79Xmc7JVeKHNdbzrwba+EF1ieC9HQGi/zpLh8l2k=;5:BisX8P2yZJCgI8CtNA0WVRnK9kdj6lrA97X4pDGES1yroJN4kZDFvUoP6Odlp1PW4Ge3C5cfI35sh/L3mFMrmpUIRu0rNpkGvmTWt5joMBt2S2fWMRHZ7LIHL00eSE7J0SyPn11F2L0Qb2H0YVEsWazJWvZf5RaHrCQ7I2S0xF8=;24:D40Mg/sDYtT/PypCLjaFAwXbLSi4SfKZOTQxoUDsXl3kDkVRho8dW7ZqsnDx8Z1+v+ECtOjz2fgOZzdg8P/PYr6Lwo5z2A1W6oaRmhnVtyw=;7:l1vFUWjqKATV+jIVvODOQP+8AlvBai0cTOmTi8Cn0mainIyoSfoVy2AOnzZAAmz7twfXm/mHGxoJeZL6F+lR+PUT+30lfJjr+MEK52eBxeB1GrZOH8essM9fvQfMt+3xNIMGyi6qQj+ABH4Q1DSsbM8L3aT/fcL0ajKKbfzOe9XoKAozTWa22fOByYKmX9ykslp56EsnsIt+j9zQtNTfXQOobJZaKmD4jWu74zo3NJN8PaxUwQf8Om958kcQQkCI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2018 09:50:56.9969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b165ac-f878-4579-b861-08d57c354505
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2018 11:38 PM, Thomas Gleixner wrote:
> On Wed, 21 Feb 2018, Tariq Toukan wrote:
>> On 20/02/2018 8:18 PM, Thomas Gleixner wrote:
>>> On Tue, 20 Feb 2018, Thomas Gleixner wrote:
>>>> On Tue, 20 Feb 2018, Tariq Toukan wrote:
>>>>
>>>> Is there CPU hotplugging in play?
>>
>> No.
> 
> Ok.
> 
>>>>
>>>> I'll come back to you tomorrow with a plan how to debug that after staring
>>>> into the code some more.
>>>
>>> Do you have a rough idea what the test case is doing?
>>>
>>
>> It arbitrary appears in different flows, like sending traffic or interface
>> configuration changes.
> 
> Hmm. Looks like memory corruption, but I can't pin point it.
> 
> Find below a debug patch which should prevent the crash and might give us
> some insight into the type of corruption.
> 
> Please enable the irq_matrix and vector allocation trace points.
> 
> echo 1 >/sys/kernel/debug/tracing/events/irq_matrix/enable
> echo 1 >/sys/kernel/debug/tracing/events/irq_vectors/vector*/enable
> 
> When the problem triggers the bogus vector is printed and the trace is
> frozen. Please provide dmesg and the tracebuffer output.
> 

OK, I'm temporarily adding this to the regression internal branch. I'll 
let you know once we have a repro.

Thanks,
Tariq

> Thanks,
> 
> 	tglx
> 
> 8<--------------
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -822,6 +822,12 @@ static void free_moved_vector(struct api
>   	unsigned int cpu = apicd->prev_cpu;
>   	bool managed = apicd->is_managed;
>   
> +	if (vector < FIRST_EXTERNAL_VECTOR || vector >= FIRST_SYSTEM_VECTOR) {
> +		tracing_off();
> +		pr_err("Trying to clear prev_vector: %u\n", vector);
> +		goto out;
> +	}
> +
>   	/*
>   	 * This should never happen. Managed interrupts are not
>   	 * migrated except on CPU down, which does not involve the
> @@ -833,6 +839,7 @@ static void free_moved_vector(struct api
>   	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
>   	irq_matrix_free(vector_matrix, cpu, vector, managed);
>   	per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
> +out:
>   	hlist_del_init(&apicd->clist);
>   	apicd->prev_vector = 0;
>   	apicd->move_in_progress = 0;
> 
