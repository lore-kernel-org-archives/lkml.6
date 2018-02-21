Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeBUHGR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:06:17 -0500
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com ([104.47.33.64]:32013
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeBUHGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:06:15 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH v3] iommu/amd: Add support for fast IOTLB flushing
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de
References: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20180213132959.kkavgzt37hm7n2tt@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <2e9a6834-36b2-8f65-ab07-914b8e3d5671@amd.com>
Date: Wed, 21 Feb 2018 14:05:57 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213132959.kkavgzt37hm7n2tt@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: SG2PR0601CA0011.apcprd06.prod.outlook.com (10.170.128.21)
 To BN6PR12MB1732.namprd12.prod.outlook.com (10.175.101.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38fbc848-89eb-40d0-853d-08d578f997b7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1732;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;3:E9aPXcXGLY/OLBTbl6dxctcLgRrvCuNEr46r7mebZkrula5limaGX4kk9DjV2ZGeHCNfHMwJ+Zxc/ffJYTnKnX6GZUFsBgzvS3RkkKS0AceyOOxI8KBs2m0bRSGTdU4qidzbOh7dg4SCvM6/KJzmE3SQPuP8qTdAQ8Bv19NaNDhU76MCm6KvyAEGe16C/fqXy4pmWNBYzNpRhukIXww7Ko6h4KnbvydfZh+zvA/zhI1ix9ACj4+dKjVgbaOXBTju;25:lHBOWZjdnO6GnSyT3wWmlDCo88xJo62oNOwCSC+JPa7ALGWJUAytPy+2752TxRRHqhSAOo9vtNmbFctqkPJMtxp0fErJ+9uoR7/7rcn0EQ/cHdYOUgsTd6i1b2uIgxCetmB2WbhR826vvQ5szuIAl/bfIPXuwCH7P+ETLDNdHoMAm2PzYIKMme+OF0S40PGcFMQSZNdHVhDD8R5IYHBW6NGVc2CG2dnYm9msnsbCNp4m7K/KmNU06+eK+gSUeW+7OU4bHDuFwp2pSki6BH8rACz6Y7OMnQ53JKFAXy6KTXDPDfoMA8R6ZmUDLo+RNEKtvG6lmOkvLVGF9zLDo25s4w==;31:cksSqhxV0C6rxJmVOmeOO2gtFJFJTYDcFJOlLbvVmyioPTDmTtMLi/7mFGhqzcQiUZ61ixRgLWlXsc/xytcNnkDPswBmR9XXRlymtvKIqQuwAM4uLHTD0tUV0uOiStEy58Y9M0SJRkoclBplpMzSrCsDegnOInCnGdSJUPh5jmk3RzL93Tv0U4K8fntRg8X8RGkrYjZ28wPBvGJSm5Tie5Cb1zh7ufEj9+2FFEQ9BfA=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1732:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;20:iOlKEnse+lNz3tmu+ImdFO54CbzKofyXYvuTaRtkEF2ayiKE5k3qWU/JSJBO2N31LsfLuE/R8UeshNjF2ra0D0g4d1KNEXvKNTiioorAvRGOgOJDPx3G2sMKfVNZEZqYvV7ksCp4oQ9NYqaMTnzfPy56dbdlujUX7RLxFZy7PJat6ktYK9HcW9irsFQO4MDkSHgxZZXygVu1JKgs9JE6kClacTPTnEBd8wub6b+mAt9P0nFTlr+nC+jYHMxZ3x7fjD0InE5aoAa4nvn7H2xP3YL8ZRxqp4ystmIUaHAJHMywM3DgESv0W7oG/gqBTRetVnmprggdpkX9hg7HmNmGWJNM1cRSvzjjIAGbJRCNwY6flzLiobRl+G0e9srow/tw/+gSWI6t6Ck6I+3LE2K6qkiaX5fsZkq3pbENzy/xCtPSU4Va3IBDkjKg3Dh4NkpoQkNhPxQem8nhb+i5yXzP1N8C1faggo/CkvFkrSCz19QHnRYSzd78Wt209L/8vyXi;4:axUDiJi8BInzspSKXlijQ4Fl0tuZhxsR4J+ZkK5G8K/vRh5llERksDdxPRjYb7nGGEUZZk5uOMzFL9iDhYq+x2zNYJ/I6Tq4INNvbdcpKsuTjvhmhPsl5IPn8BxID+ZWUh7K/0S83ZG+R72nD6BONIvMLkiRmFlHdG5nGuIfepi/6E1WK2Mp7Ed4UnVojEvU+p2rB5FB+YyFDkG7pQhhwbZgpmrXmEb6X/rLBVuRvaiLAV6UNIZqMXLCLIFPLdj2l6WjJQuwS2FBQwTtIccMHg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB173235F059CD5AE4B019B90EF3CE0@BN6PR12MB1732.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1732;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1732;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(81156014)(26005)(6506007)(6486002)(230700001)(4326008)(53546011)(386003)(58126008)(2950100002)(6916009)(72206003)(6666003)(8676002)(81166006)(6116002)(3846002)(16526019)(316002)(36756003)(6512007)(50466002)(31696002)(186003)(31686004)(68736007)(67846002)(52116002)(2486003)(23676004)(52146003)(59450400001)(478600001)(76176011)(229853002)(64126003)(8936002)(105586002)(65956001)(66066001)(65806001)(6246003)(53936002)(2906002)(86362001)(25786009)(5660300001)(7736002)(97736004)(47776003)(65826007)(106356001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1732;H:Suravees-MacBook-Pro-15.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzMyOzIzOjh3M1ZNc3pOdjU2QjhkYm5MdTJNMk1mM2ha?=
 =?utf-8?B?Y2JtaVFvQkVHRWpMMTZXM2JRNHBWMElRYnFvd3RvM21EY3I1bzgwbXZ1cEdD?=
 =?utf-8?B?c3NRRG56eGdxWU5rSzFodjUwQmVoZ2VNbExWdmpCY2hOOUdCWjFScTZIKzdU?=
 =?utf-8?B?cUkySlQyQTd0Y1V3UWs4dTlzeFRUN0d6OTJRVW1iOG1MSDNJcTNCZDZqdzFW?=
 =?utf-8?B?MVFFaXVWdmhjY202WmFIbUF3dUxqcWlVNGw3aVIvcmdBdlh6WE15ZklUUzNC?=
 =?utf-8?B?YzFwaUdJRzNNTldROGwvdVBhSXU0TTdqeDQ0dnFrMlladFk4TnFBRFZ0VXl2?=
 =?utf-8?B?cFU4cHpyNUFRUXYweXhDNXBDUjZnOGFPU0VGSUpmR1ZqaGdHaUdadzFtcGpi?=
 =?utf-8?B?WnNrbnllWHBZT2srWnk5YWlVbHhOUTk0V1NrdWhrU3J4N1VmbTVlRldQSGI5?=
 =?utf-8?B?Ym1HejB3UHg4NXFsWmRMcXRrRUUxcWdIN1dVYXY0QlpEcXMvb29IU3pWNkdr?=
 =?utf-8?B?U21GU3M3MDIybllWMnJGcWUwenAwTXhOaEtTZEw4VzFnKzF0aExycm9ESjQw?=
 =?utf-8?B?MVh3aHU5Rk5pbU1PVlhsQnk5aVNIWHI0QmFROSt1U2J1VEI5QnBXWVRFMEl4?=
 =?utf-8?B?WklKNEZYUmFva0x1ampzQUtTNHZ1VjF1dldHNEkrQ21VbTF6OUVnQ21WQi9i?=
 =?utf-8?B?bDVzL1lUcGdUMnpPTCtyb0h6bWNlTTF6dzVuc3NMSWlnTjNvaWRQdkhadVZL?=
 =?utf-8?B?QzYxRzhqV1R2bmN4N1lNamNLYTEwdnRsV2Z3OTlJYzdrMWR5UDZ2UGQ2ZFRo?=
 =?utf-8?B?U3NuRXhsWjgwakhSN2dLQ1BRL3pEUlpja05pUmVNb0p3aWdNQVdnQXVNNkpE?=
 =?utf-8?B?Qm9McWJaRkpuOHUvYVpST29wdmNMckgweHoxSlh4cFdKbndxL0ZndS82UXZu?=
 =?utf-8?B?SWRGTkw4WDlvWDlFbXZuNk1aRk8vN1BuU1JSMjg1ekRYY2duTEhhdVc2a0pM?=
 =?utf-8?B?TjZ4ZVdNMzBLd21pWEt0OXdScUVsaTFXZHNHMXJhSUFRVUt0MmViK3Q5M3pF?=
 =?utf-8?B?S0w2Qy94a2I1WFBSMnJpT2plQStMWDdXN0trMnRqK1pFNVhRNmUzYTRNVGNB?=
 =?utf-8?B?RWEvdWJPVFdqR2FqL1NlL1NkOVg4QmZQdVRFT2g1M1NsdWpmU0gvZk0zbTNQ?=
 =?utf-8?B?dXhGemhSTnlqK21LeXFuMWZHQ3VJcHNhRHRtL3VJV2xid1FuajY0eGM5cVc5?=
 =?utf-8?B?UVlSV211M2JLenkxUjNRZUsyVmpsaFRFMEJuZ3BhemxMVFI5dWRpbEh2Qno3?=
 =?utf-8?B?UnFoc0k2SjdIbEVycEF0dzMyYW0vMEJYSjJJbklDLzE3cnd3MmFJNEVXWU5E?=
 =?utf-8?B?aGpHaGxKZ3k0T2E4NEtaaTZWWDI5dENyUlRVQW0wa1RMRm5CNVBXMG5PRzdm?=
 =?utf-8?B?MVIwWnZzTEFza1JyMERLUUY1ME0rdFgxMlQ5QnZ6MXVETk5SN1lJdm1oL3Bh?=
 =?utf-8?B?dTVPT0hENXhSR3RSWFp6bHUrLzhkdEZkNVNWd0JuWVQwcnFIRXBmWHYvdUdE?=
 =?utf-8?B?M3ZhMGNqU3ZQUmtFSTMrMjNwdFIvT1hXTjlpNTc0WE5pc2pKN1U5c2xyOU8y?=
 =?utf-8?B?Z0xGZzlPTnhLRC9GVFY4VUhZQUxiTGY5OFNGcFc4YWtxWXhaY1NzVUpTZ1J5?=
 =?utf-8?B?TlVlMXRoWW9WcS9GV3lGaEplR1hzeVU3RU5XYjY5Qnp1Nzc5V0dlYjdTZlBO?=
 =?utf-8?B?YWVyU0JrZVVsWVZoMjduWFRHMm80a3lSRXVLMmxBUmtwMzd6Z29nbXlkL3JC?=
 =?utf-8?B?UkhIeVYzUHpvUmMwaTJ1SklNRFJSYVZwR3cyWUpWUTc1UUZiWFNaU1pRR3Zp?=
 =?utf-8?Q?xHsp43CaLzU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;6:8Ktmbb+PZ/haa1t364pZTYqcfiTQ5haUBB5lXnfKM4vIPtd0Y2rmcayGeAmJK9i0G0/J7vYSkETCtmdnU48J3F+XHrTh5Ir3SpllqYNqdaH6th9a8MOrcbqFc3lhoJOpI4tAJ79rQntwdm69GwINDOyiroqROHSf7vEZDJFTp+r0f6Mp4EmUid7KfvT/DuSCMuZX5GU2N3I6VnUOHdqaAgUggiTto2WD+LN+HbGv8N+MHvDKAsFFuaAMeouoFLxcvcp5Tg/Nx8XpfnyzCrFx8fIh6L2CrwsUixQ8oUDAVwKmErTbt40cyFKE/NvqGgZpBaQcMy3tXnqvrhsL7sVJGBIkMwnhiUUh7PfYVW82gmQ=;5:YjZbxJoBZMJPHrVnjRQae1r36nuatrb4oMx3vxd4QGSF7FSRfXdaTxakdZkf92C3vyZ7s1MQSWptH1X6O8SIwuGYLGj/djOSK6fTgnXoWwfspsucxDej/Y/wQl+ct3oEe1RbyMbi8ko6Tr7pRYFRm0vMiNx+MV4JqQM7MRA7R0E=;24:WgBJVjJPaqgYSqrj6cN0eXFSpQNjraUdIMujgUTjujEfzpQd0JWqs3I3twO0Gbt7ZZgqXjT9FIWZgEy4JQyIUaU5+UAKoQhIg26caXwpxZk=;7:NDdwd6n1OVDp578Q61H/QGuBTfWe/GU2V+JxtjvYTpfzHqI4xA0a0mmCFaG36zbL7xwAh0tcsEG5nhFJxLdrKnvO7GNhJqCpZYu/La9G0SEgm77zSKVl7leM7yPJZ1HptS1kjZ9rWesghrmA8WA2n2d+qVYQ+sNxEsGnu44AAzHUp9UZ3+JGkZYSMHl3yQZXjkjseo/cSzvnQYVycQX/L/lNSlYGSCYt6IrHXm4CQ0y5rSz63acoObOlLLdN+dgC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1732;20:a+/vLbP0tnO7LUnCt+fhvw1PHJmX2VrJ1i/slVeD6pzeu7K+xqmSK9li4BhEz2eqvmQHxtmwONDlaKiRRghLE6tujSqd9Ju1agW7EPxWF+hnx42WxIAwF3DpBHqnThWoTtr/GUPLvhieuVYiuebO0kmP6phXe+vSb+NIB4r1LMzG2JjqYbNWqAP7GPT41gKxDmJGmFuG9isqYEq+GiapUQkowzyXb0F/XzsbGEBpppVvXAwMANFrMx0LR3cnG7CM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 07:06:11.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fbc848-89eb-40d0-853d-08d578f997b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1732
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2/13/18 8:29 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> thanks for working on this.
> 
> On Wed, Jan 31, 2018 at 12:01:14AM -0500, Suravee Suthikulpanit wrote:
>> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
>> +				      unsigned long iova, size_t size)
>> +{
>> +	struct amd_iommu_flush_entries *entry, *p;
>> +	unsigned long flags;
>> +	bool found = false;
>> +
>> +	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
> 
> I am not happy with introducing or using global locks when they are not
> necessary. Can this be a per-domain lock?
> 
> Besides, did you check it makes sense to actually keep track of the
> ranges here? My approach would be to just make iotlb_range_add() an noop
> and do a full domain flush in iotlb_sync(). But maybe you did
> measurements you can share here to show there is a benefit.
> 
> 
> 
> 	Joerg
> 

Alright, I'll send out v4 w/ iotlb_range_add() as no-op, and iotlb_sync()
as full domain flush. This should be sufficient to get start with adopting
the fast TLB flushing interface.

I'll submit support for fine-grain TLB invalidation as a separate series.

Thanks,
Suravee
