Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeD3LeV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:34:21 -0400
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:8992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751516AbeD3LeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:34:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, David.Panariti@amd.com, oleg@redhat.com,
        akpm@linux-foundation.org, ebiederm@xmission.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a5afc19c-ee93-685f-d208-b247caff9ab4@amd.com>
Date: Mon, 30 Apr 2018 13:34:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1P18901CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::21) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:P4Ok6X1dAQZMDtcAI0mFSZnwWV8/bDbFL/Rsc01I9ijI4r5Mc21W/SHDU0zOdd2To7gPFFh3GkpzOWqsgJBa0UOH/vaAsWScsVjmYswdMJHMFwRoLZqgf0nNFHCLNYSrdqPU2iXb9sSR5pi6EkxiWvzwSO3soV6O6fLlwYC87n9P6jIIfeYcGjU05FufyQTdjTwAEWzo6tpQwi3yD+m8Gz0mDN1BXDGx+EggXENPogeR3rawehTDTG9kxV1EeFCw;25:5ApkuA71lwSgIcLIKEfKp6se8EKmvWK0tX/5gYQe/r06N8sQ7IFk3jGIqENPl5hn/dSZytXas8Wg2PgZN/lPBf54vnH5PoikpjAb1M7Nsk9a4LEw4kptmp0TshC4EmkcAQw/TQ1El2HYxFDmvDGlP2Mb5NT7Km2iwEmyuXIa1yJ54CqCPnnIxVlAZSpwIFIgFs4gV1d9sfuXEd/0NUkMP31im1h0mwZ3Y+baWZcIdTlxYZar6UlXAQ4nMNn+/SQ+/M1qaTGSzArboQzIH7gSbiMouz+ZZP2FJ9sX8KdFQBB3aPAYIpQoXTAWqJQU/530gkt7yteFkV7MH04E05UqcA==;31:qKdXUN0A6AODbMRbRl+Jnjd/RKwbYDQ4TFNq9Qfq1+DKOWL7ADX9mr0ivzerrjYOUSgoFgzMCFAynEN4k+foSU7b9XfbHr+1pQih3FqMtpd9bOyiZHgJvqQjSFln7YNuqkyQELfTwXdqXSll/mfXOFUyd0vcNDmWhFK6A84qKlEoWb5DpJzvUpsFcR4srx9PHfLv/sqJTViAT6r2VPaW/ebhcU7sIfNtl4OkgLo1+Qo=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:3KdQB/1oUoy3DI0XV2oNd/w/MHENxzYtvIKooJb4/dT5vYVqSb2Z3G+RVj3q5cui4EWvTwFOJDhrHUmS85zhLJ8ibyoDcVpcPGTef7qSpc90RH+IypwEo7GOcrwyUvwoVoAmymtIQj9bZ2VniIJdh84kGmXM54ou3svaE32bM6mI8MzgwQ8hmsJE2Di6fzWxWhEYHkKjZHxqEmRPc2gPHA/050Ke+khB9fu7jnTv51tAugVIKYH/p4GX2gjqAvU1epTbrTSHR+dwhwAFQMxi3eN5TvxxMyd5ETIqcc4bvQj2Cc4RgQKMdbwmKOhOAkhUh4B6vZfKDPjmGiyUREOwCu0xLNtPYd7gocgfWVeIYj7tNltNECLav2xmMcLX65y+lpYFGRtUHNX1Eke4gZ8+vhX1gmVlNfl9ICW3TevogWtTmkyi7OcaL61bWrDOs2YzGi6qDDkWy8xzF5dO6E+wugo2dr7RI4KRjv4xDVcne57FHvGaazpcKznD2Wh7WMy2;4:6vG5uKLoPa1NtG2QKsd6/NUvAclFDKutw/sdsJXFMM/Xs5Ml72YQDW8XVaCWRvDn2G31UAdNaZRhg4Txb5/ernr5HrL5bDM5X20l0yXfbmn8njYn22uuNGYuLnEpZsau1oHnT4hy28qcm16j7ZRuTgsTqjKEijv2Gbt6Ltl/XBgyY7Hk1uemsGvgmrqwPogGMzeGBQR5qfyAsXGAczTU67MnTwlN4FRg2J0wsBjvHbG6M4WVAej3QheABo2a2Q9n2tG0i6kCpbBBJXlDrOyKs4eKuqEoc7zqAOZ6kxoeGzaz4Y3flqRC0dHmkeVkM7q5
X-Microsoft-Antispam-PRVS: <BN6PR12MB17144AEEB460F1797061CE5E83820@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(199004)(189003)(86362001)(72206003)(53936002)(16526019)(25786009)(76176011)(2616005)(68736007)(46003)(2906002)(31696002)(478600001)(50466002)(11346002)(1706002)(8936002)(65806001)(65956001)(6666003)(7736002)(64126003)(186003)(97736004)(229853002)(47776003)(6246003)(4326008)(230700001)(81166006)(476003)(6116002)(6486002)(8676002)(81156014)(316002)(23676004)(52146003)(65826007)(5660300001)(105586002)(2486003)(52396003)(486006)(106356001)(52116002)(58126008)(386003)(36756003)(446003)(31686004)(59450400001)(67846002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOmw3U2xzcm5Vd0hVTGtOc3VWWjdqNjk0T2Mr?=
 =?utf-8?B?TC8wZmRYWFBpV29tV2ZIMlNNaWFoMDEzdmJCSFNjajlkWWVnZWVXNVZDZ3Ay?=
 =?utf-8?B?THVSZDVzSS96dWN3UUQvUVVTWiswVEJveGhnTlJmL3BNd0dHQnk1RmEyMzBE?=
 =?utf-8?B?enhNcitRTUFVV2ZkUGl1WWpmUEozQ21MVGZrM1RHRnpraFY4cE9SalU2ZmJu?=
 =?utf-8?B?aGVNelM4RzJNOWdGSDY1V3piVWVTZm8xWG40Q21MV2FoU29QMkMzVlVhMzF4?=
 =?utf-8?B?MU9hcS9kdzZEbmVnT3M2T0NRSjNGMExjSzVNUVVIOElnVXBId2xhV0ErTXNJ?=
 =?utf-8?B?UG90RG91Um5jQ1h0U0x3M0lwODhQV25wRVpDMGdzcTFCQWxvNWUyM1JaNTBU?=
 =?utf-8?B?WDc1cjdXR2VaYXU3Q1gwUlRZcjNJa2tQK01yMm9qdVlMQU5JbjF0MVUvTzJV?=
 =?utf-8?B?MmRUa1BucVdLR3l6NC9MekcyNDczeUZGbWdIUGM3Nkx5R1VkenNGZk9uN05W?=
 =?utf-8?B?RFMweTVFbWZqVmcrNUNOTzhDbmR0UWZXOWZKcUxlcXRDRHgvcTA0bWdmVGJG?=
 =?utf-8?B?dkRVcFY1YmtJN1RDaTlLNkZLQjY0cmFsdmtCekJQeStoMnV4Qys1cndmK3lZ?=
 =?utf-8?B?TXZ1Z2ZPakdqd1ROT0hNTzFuWDY1M1FzQ0UyK2I0WmNDcVpiaDdHL1VWZGN4?=
 =?utf-8?B?N0VwS1BNRzRvcWJzMllhdWFVNzROaGd2N3JHTXVTa01tZzJlbFpSZkpSaFBa?=
 =?utf-8?B?WTJZbVBSSDBjVGZoUmNtVEhjV3hmbjIzajk5dFJOQ0JoVEU1S3I3b3p5RzUx?=
 =?utf-8?B?T1pLRXhFQ3Bia0l6UVBOU3drVlhXVWhnbnNyRUYxbHcxWVZDaWlmQnlYNCt5?=
 =?utf-8?B?TldQN2hxNVV5dHZuYmJKeWxJM2JER1M0VmlkQnJybjVHOFB4a1J3MkpVNHJs?=
 =?utf-8?B?THN0WndzRnllRVlmbWZGQXYwY2ovQWdzaWhmNzB2UDVJQklNbEplRWR4ZmRO?=
 =?utf-8?B?aXg5cTVuT0c3QWtwNzBneU5weVltZE5mdSt6TkhkOGxjRStSOUhlbUNTbGxX?=
 =?utf-8?B?cUtyWm9hUFZhaFJ4ME9HS0hxR2QwVlphdnVNaUFlN1ZzT0VLWDViSkFmbUJh?=
 =?utf-8?B?cmwrN3VyakFtZW44ZC9jU0tsRXRrSlFWbFVTN295eHlpaHlsR0FOSHBzRDQx?=
 =?utf-8?B?Q1ZXMXRpTVF4YVdUZ01SWGJiUVZyYnppRDNlOGU4ZUt4c2p2Ync0REoxSGZY?=
 =?utf-8?B?MHk2TWZJcy9FTjNxMUxlYjhucDduenM1WjNUc2V1czFwYTZ5WFlTdnFMOGgx?=
 =?utf-8?B?bm16Q2JQZlAyNkczUmZicEhUZ1dpcnhSdVJEeWZrTU5QdnplYkFoSXNXT24z?=
 =?utf-8?B?U0k3aktyU25tK3J4dC81am8xUzBCbmREcUZpSXlWMEU1cDNRbmFGRVpRZkVZ?=
 =?utf-8?B?T1U5MnZxVXpWQ0RlNldsZTdGaGpyMzRPVXdjY2huRTlTeis3V1BWREs5ZnNH?=
 =?utf-8?B?cGdwU3Z2Q3Y2bGNBQzdNcEdNZXlwTVNPWCtrQUFpMFVteGZ6NFliN2ZZb29w?=
 =?utf-8?B?aTJTWDQrb25PS3lubS9pUTdHcmpyM0JYZnMxSk95NGluNEUzOS94T1ExMElB?=
 =?utf-8?B?MUtSOU4rMEk3b05NV1hjVmtTUGRqUzl4YStNNjl3RXZmUGI3UmhLV2RxS1dj?=
 =?utf-8?B?ZVBLQjNHVUtYNzRXZmx5L011cmdpaW5yLzFJajRDSTU4ZUpMUlRQQzN5SzFq?=
 =?utf-8?B?MXVxV2orZ3RFN1BFMmZ0ZDhYY3F3akFZc1ZxN3oxcU1jc2NvZG1pbm0zNWUv?=
 =?utf-8?B?NEhCQW15VUpLYW5UNzV2UlNZaVhxN1BDRnZYU3NlMmp3Zmc9PQ==?=
X-Microsoft-Antispam-Message-Info: 4hKUXyX7LCtvmOSbp/zl/xvPPb6wErL3a7kc2/Zsewci49E8taDOTI+UBWscqTpfIpzjWtkKBuO/4+gbJYlCjqREAToDNsUbYiO7sJc7GfTgQ2NO29ziWatNgH6Eu0c2tUYOfGy5YA6bxmla8k50z5tfbIU0b9w/3f3THmSq88eeV/eqqYfGNJzs9LpMr9oK
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:iwP0c0S0iS8dcDliweWUlcnNF9tpT9Khcz59azLAmy1XBnf1wA3UEDaiTjm8wyIiUcSasZwS86IwwTXYZxhFyoz5F0GzH6NFOtPs4bhLeimqr+zUrylriuHp5EI+Waf0FB7KvQZSl6teDOgj2QXuVy/vOilJqHYNuvPB4QGK5krQfR6yVncrRaegzbfIfUOkTfGTU2VitBFHcg3TvIoTxIF3c45wc+Og543yjT2/jpnDBYDRRiwNFvkvrlqnXC0hz6FiPDLVWIKhmjhe2j+8/JzIABXbtuEo27Czya+vKzfNg/Xusv78nrI1bwcYQg05bG/0zIwGAlCHivwud0hKI52oVi3IjMogvVHgV9r1k1vhpzYZOdca6JxpdszGtZhnISj9aopxM4cnel8zDBP9KXrmCqYOHnGKO3TUFa1OrgW1dg9NTtoz7UPRJBnITOfzVXEIAwiIihTy9LT+p7hxIQ==;5:CvA2s6QDN95oy67H9D9JAk1bi2eLiJFjMp2aLDfNjj//lJ0veW8cp4i+7LuQNU7/0+ZO2haKAk2lJKEsFb/kCw7jgJ9f8qmweti/KOBArPX/0KE0BbKQV9qNi9XqHbLPUM3fqnTl8gQ/cRfjvWop1G1WNrXeOS6AUWdbG7y2kGY=;24:T5rEGY8xt4u59pvU8q+1SvjupJHgVYMz2804QVI65xSDjKTufRFCV4HG4RIlxZKWJrE1agc1WpbKCbiCO8+E+ybM9eW/WAduQUFXx7DG84w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:P+ey8kQvnWVAcuZFfie3RL+JRiRbwUEownouV05YcQibdji2QSCxK/yXwohZMI/M71TKjYNkKBMCvWYuyb7ofITpw6fT8vY1tnT54brqthDqT3+NLAo4AULg5E2rXrEzfqpiY/dfDYo6jGb6MVpK0zjrDV4gy1I3s4SnLmQbZGHMkDQU5wTZGlhKtB1xEpWY4r4mnQnvY3KlM7n7Ct6v9GjNEa4Nnrtm2SHhxhBqgw467HBY0Pwkm00wUn0b7NyV;20:rFW60ScRiQ9fj7hxUlDJUJpbK7oM3JgFh2b1jZxKv6jqvAi3yaEXN3vGFi9j2nKM6fgidCXJb60+M3k6a8wY5ZaPnDjwSl/4cXqSbph3QqiLrQ7SS2xYzbXHRZ6HAkJpDcPRxBMy+2AH/qkVB8DYzObtQsAsTTdJw7AgqCjmaP9/YruuI8JhkJ/TjzmU7Pa6FqH8j5Ovq50fz+mkvS7V2/7Ax1CRnHSum3iBqV7cvo4iduHT7wuiCDqnvgh6sLWv
X-MS-Office365-Filtering-Correlation-Id: 2245b09e-2158-4e44-39cf-08d5ae8e4e03
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 11:34:14.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2245b09e-2158-4e44-39cf-08d5ae8e4e03
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.04.2018 um 17:30 schrieb Andrey Grodzovsky:
> If the ring is hanging for some reason allow to recover the waiting
> by sending fatal signal.
>
> Originally-by: David Panariti <David.Panariti@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index eb80edf..37a36af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>   
>   	if (other) {
>   		signed long r;
> -		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
> -		if (r < 0) {
> -			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> -			return r;
> +
> +		while (true) {
> +			if ((r = dma_fence_wait_timeout(other, true,
> +					MAX_SCHEDULE_TIMEOUT)) >= 0)
> +				return 0;
> +
> +			if (fatal_signal_pending(current)) {
> +				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> +				return r;
> +			}

Please drop the whole extra handling. The caller is perfectly capable of 
dealing with interrupted waits.

So all we need to do here is change "dma_fence_wait_timeout(other, 
false, ..." into "dma_fence_wait_timeout(other, true, ..." and suppress 
the error message when the IOCTL was just interrupted by a signal.

Regards,
Christian.

>   		}
>   	}
>   
