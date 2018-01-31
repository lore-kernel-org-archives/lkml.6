Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeAaOgu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:36:50 -0500
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com ([104.47.32.49]:45984
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751447AbeAaOgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:36:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH] hwrng: Explicitly drop current_rng when unregistering rng
 device
To: Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20180130232627.3014-1-keithp@keithp.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <3f489790-dbfd-e726-e957-7bc7af0745bb@amd.com>
Date: Wed, 31 Jan 2018 08:36:42 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130232627.3014-1-keithp@keithp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1101CA0020.namprd11.prod.outlook.com (10.174.237.30)
 To CY4PR12MB1141.namprd12.prod.outlook.com (10.168.163.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 209666a5-cd1d-4fc1-5723-08d568b80ec0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:WyqF2Pi1vVKnVECsV5sBFY0dD8WFHRwrcAs09/h+g44mpZwm6grBTcep9pxspgc1Xkxl5uGQ4M13BNv+AqecYPvx8Tr3jHluxA+PlPwRbtiROYuL4EOq9kSSl0l3lEAIhCIRvBTLwDW5NueeVNHHSj3TzFj+Gh+KaeRQCPatMsOOdk1YFC4Xuw48Ai1JARmKoPq+RD4tyLkyV6IIdZ+FyI0gonKpNGAhyeXgLU15Z73JaEpPZgIeOtivgwIdsBRS;25:Yk8e10VDpuwvXIT2YHOinyOmkN04ypfJYLr/VwQI4jhId2xEseGqXa1f09GSYafkIST6jdp09dTXtsyLWE6OVVmhhq2dX9/rkl1Cel0L5nBSswhlOkH83d3x/7fQNk/NCh1FwJ7sR573CwqVFfjpTsnpsotDLFBQFMkXXB6nhIbfwEAlWvaIQFPDSXQDGUCl29ZT1uB+HOYaesZUQf6G9+o9fTX/BbPnGh9ikwULhGFkbaJMgVhz2LkrxrRvgCJ6Ezt77XECSDsEvPnTRO6vhJ1eAgr3wkg6y5p4ML3IVUwl13DxSGHMOthtGj4IUv6kKizdj6DyEUKwOlTi20c7VQ==;31:3tcjuC61CYDM3dr/ahZ7Ywfz77zMn99o8pCQ7WHEGk5MU/mxUGrznAsSQ256o/zy2vFA8rP2JSJ01xBzKMQuR35Aggk0vXRAfNpqxkHk9bIQVTiVtcXVK+Xs+HvmkThoEFC7X/8CY66QOmEk1jFYNa3iRjVQW+wMiU18ug8nwhpuFDN4R1lFnbZ/qM+q5HXt6yjPOpBJ2xDKsNXAlCNkNRDWzvyuVjpdPRgfNV7dDUg=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:JesHr0q+ZegPYdqnaJHRmastan2QbM03K72Mp36zyXI8YHEd8kggrwqpsClNpFqaHJ3VUPEwFR0ve7nROjwgr4s5PC3KXvqjMyGer36EEmzFsXwGr2wbA3FYyA6Rfcj/yVPTbPstMkaywoyzr+7/CkqYKWBTo3vP0ZgbGii0xAeqCm45o/Dfom6QXpJ6+S9UPLPkPJdQ5gaxAwlRVoEzTvXVtY0ARNaq4jJqzm7x/doWgHLzdPv1o95og8wl/6djk61RGZFcappFxEbr6paFMHubrKCeNmUIQsos1nGkIAp5cRMEKQOh06phnqaey+upcWUAUFZ49vDjtg5qJoZitaLWq5r8zOKi7E7RnV0Y7f8EXH47NdWZMbIj/Vs8pmW1IFO47iCE7UYta6tDSGHkRYR9sVdcDWSLIeWyk8pkCj6vUFw56B+CSqNzp2y48Iu6ABz2rP/5JVFwr8QdxT19hnsjXwGZ2Ivmah+HxCgM8bsPZADT5/Ht1nCnKV0b9+hU;4:rw89ljWUpv+MZk71l0kymTXxCDk74IBk5kBP7VNrQsU7W2Oo9GdDVTiqgOrXRk2aAdbbB0da/iVJ80EVGllcuyYxs1M0kcU/1hAR295PogVqmx21aONncTAbI7kV3DcmQjW+8Sa80SHkRDyfx/PdlmNku+W9rbZOEMN/iRtH/ckR+OOd10NUuqLWDmUOzpBmJcO0agsVdwmqD/nja+pcYc3HPqKFvnNBAbZWQQfruNc7nZrM0WmLDnYn59wu7OpJ8QgY1SlQe9faldyT9R5MmA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB11410A59B44C71F8F501237FECFB0@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(39380400002)(346002)(376002)(199004)(189003)(50466002)(23676004)(52116002)(53546011)(31686004)(77096007)(58126008)(52146003)(2486003)(65806001)(66066001)(6246003)(59450400001)(64126003)(25786009)(83506002)(65956001)(47776003)(16576012)(81166006)(76176011)(386003)(86362001)(106356001)(3260700006)(316002)(68736007)(81156014)(26005)(230700001)(8676002)(97736004)(72206003)(36756003)(2906002)(6666003)(54906003)(65826007)(16526019)(53936002)(2950100002)(186003)(305945005)(5660300001)(7736002)(105586002)(3846002)(90366009)(4326008)(229853002)(6486002)(31696002)(6116002)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOjdSTWZuK2NsajNzQTVSSGxDTnhyTEVpaFhM?=
 =?utf-8?B?dXJRQ1VvdVcwL3dTcHlpTXpqU3Y0UGx3Mnp5aEJrMkpwRFhoUVB3eHNUSVFr?=
 =?utf-8?B?MjhKSmMzZEcvWXE3VkI0clN2cU1vQU5xeXZBRER6ajlVenFnQUVJdzhlMU90?=
 =?utf-8?B?eWN1K090NklhdlRpMVRucVV4cGNNL2w4OUlVU2NOb24zd0xVVHlYRE1WUklU?=
 =?utf-8?B?aXdHeVNyVEN0d080cWJmTUVWVVZpMm94T2I3RlhBNUg1TmlhNWYwaTRXSmd5?=
 =?utf-8?B?dmxham5MNHZBOGhNR2xCZHNKY2ZoMnE3YUJNdjRPTCt3VTh1Zk8wT2NGMWI2?=
 =?utf-8?B?aFE5ZHR5T2NrWGJSeE1JakNORkxkKzZoVWtESC9BY2lkQitvT3RFOS9IYW4r?=
 =?utf-8?B?VE9WY2w1cjBmdUNxV0IzcHpCWVNxNE1iSkthaHVNOTZrYW1zOFZyVFVxaWtx?=
 =?utf-8?B?Sm9pYXBxK1l1d2RvTUw5cFNxVTVlQUs5NVVUWXZPVmtLZGlUWG00aENzTldv?=
 =?utf-8?B?cGdNWERDQ0Z4cXRmT3JTNVcvc2gybFVZOG14dkdDMWlzYzFYWm5JTlc3UHBl?=
 =?utf-8?B?VE1MSEJxbGVhd2Fhd2tTTEdPT0NDaXZwbTlCZUxNZmZKQ1NXRmhOdmV4ZEFa?=
 =?utf-8?B?bDBJQjBHSFRISEdFcDJoWG9tc2FGSmxxSm05S0ZDRjdxN1RXeUNUYkRsSFhX?=
 =?utf-8?B?Qnd0YXRObm5PaTVieGxVclhpdEhoVk45MTVFYzRYM1VPSktWZVk1aXorU2ZQ?=
 =?utf-8?B?eFRvWXRGTXhaNWtkRkRMdHlSWmhXajdpRHhMdmU5bGRsY3dkb05WV0s3cWRR?=
 =?utf-8?B?QVBHY043cmlBN0xFdnhKcUxGWEZQUzNWdFcwdXAxdGdHc3Z6WkNaN3ozd21t?=
 =?utf-8?B?anVDTjJhOXJlVDdNaW9DL3RFWnJzWEQ1bi9MZ2ZuNExwOGZ6djh4Szh4Ui9a?=
 =?utf-8?B?Q0oxUHczbEtNOEZaK3hyd1dJZU1vTjZJVGFpZ1VVSDlpU2dTVGRPVmR1WHhq?=
 =?utf-8?B?U2FWZFE5T2t2SzZqZTdPWHp6VGVJRy9IYWdQazdzUW51OUpjQTYyQitJd0NU?=
 =?utf-8?B?WVI3dTFzdllnemV2OTBMZkwySm92WnN0R3pNVjRQaS9lNUJZU2x4Wk1IbU04?=
 =?utf-8?B?VTdJaVJNdWtuTTYzZ3M3NlhQNVFYQ1VwaDdOV1JiYWhIOG52TDRrZVc0Umoy?=
 =?utf-8?B?M1FucGxOS1FLTUpGeEVtTHZUbWNhdkJGSkQ5OWJNRzJ0UXIzU2ZpL1JHcmZi?=
 =?utf-8?B?UUdpaDFDcEpiN1dEY0F6VmxaK2ZGWjdZWkdIRkZzRDJSdmVTdDdlWk16cEd1?=
 =?utf-8?B?amhiZU0wcWZuOGd5QU9vcm1teGZrTVdXSnJCUEpPRDhwaVVwcUQ5bjBUVktI?=
 =?utf-8?B?b3IzbkFCbi9LOGFFNGlzalJXaTU5cFFnaUlBNVBQQW00Ky90WFRXMnNWTUR0?=
 =?utf-8?B?dWdIWGl3bHcxMmswYWZhVUMxMDVIYzRTeTJxV1I0cFM0RHk2ZkZFSzU5UXNR?=
 =?utf-8?B?WE0vS1g3b3B4UlVYeHpDZ3dmeUZuVTMvcGQwWTZvbjNMYS96MzJZbnNnaUx5?=
 =?utf-8?B?NHNDTU53RFptV2VWOU80NmMzUEFFQVJ6SU1wcUVLc0xhbGllZHoybUdDVnVR?=
 =?utf-8?B?ejlnbzd4NWtZTy9tMXc4SDZVWG1jNlU4dlRBTzE4a1dEOVVRRzJJTDVWYjRu?=
 =?utf-8?B?TnFJelZPK3A3cjFiWVFwcFA3UUR1bGZCYjdlTlc4V09leDdFK21lMi9vZndz?=
 =?utf-8?B?bG5wTUJYejBSbC9WOUdrcEtQUFFCczhBZnVtZitnTkMwd1hZbGsxeTZacWZH?=
 =?utf-8?B?cHU1QXRXcUwvSFJnOHhiWkNYalRJcWdkQXFJOURVNVl6aTVtVXVmQnBNR0hi?=
 =?utf-8?B?MzNManlOR3hNSWxwUDZzQUgwTEV3Rlg0LzM1ckgxelQyZjc3OVM0dDVmK1Bm?=
 =?utf-8?Q?06omsgiWj7rdUXP8K146dx7WEc2LT4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:W1rcyB4CmrGk4azDF8inBVBzjasvoEDsXuRU7dNaEj71jpeaFzmkz16ZvHTPQvRQmQmFH0Vp6my2A+Q34qwUadSw2UzNZlUXA1IhaE+s51GdtmB4SLnw4UDlN/StLnRQ/98osmLcOC4oXA6dn/8sqqZTYfbkAoAUk2Xv9eYX7eG6ix0eCJLhegjUEPCANGDPDfyas0LdjYrgSI3RRorvZYHQnVdb9sdCypw9CA0KFjuAGoNs42QnWGqCoQ3tpukPR4iqrn7pRyYud3OhZc3X8W7vtz3iDl1rCSG4/MWMT0afdthgsa+Mo4jIVdR6fqsTZnCaEyHFy/Z/UU3HtSyYbH+qKcKNNV8lgNqMmgqWsh0=;5:d4CQgOO2oHUfEo199fJaKvHeUnHcEn3suIPEdey3ILcYTHms4vZ3Rly+q5RjQH23sX9tousObg4A/Jl2gr84wCAc4T/c9SqdKD9UytkiUeqf1HlBbuN6vhFTliFxpY8QQvo+kVpCZBsDzxFsmJZb0DazZ0UV/dHzsN+dUQmXMZ4=;24:vjfnhZZKtMxOy+oI2t0hx1qrvMNT2ZZjhu55jch2AFuRBIF449D30fL/8ljYRYPSZ5WOXTTSTEoWa7X63I3Y+N8bsTUrSA2QF+AWUOt5l9k=;7:n3jzqdZpcEpyvpPBWSDE7PvRpAQQ54pmmJVdWn4t5KVKKEDeTnqAppUKOQzp+2Eswv+2yErrUTCsReWSNQbsA4CiQ/7phmSd0+FMUOyucdFBFjoqKpSZRg48tY77+urJklIjwCAdvR+VYxOWfLWk0cgsIaglJ0aPNfjVF0QFORzgu0e4oVvm5YvTaj8cAhyi+7s8lvl+j0DOH9DBbEsRGSkjDOCCSklOOsTihL6uhv5BszrKf03k72cjAXmRqpCD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:cDlNzjRhFLMxNlPGBcMdALtLlgiU68BYc6m4jASUG0mJ1dwWBbDbcQmOALOqgKH2MYRIVOOLGw1B2DquryYM0JnFfcCNjX8ZHOIwto2s0sgYMP/xU37vcHJqFRjWeK024JI48kO9TIp3dYNmjmvcLcXeEuOKadXhfbfont0gswyacKLAVXJX7UEmf3B9rqR+9uBu3u1TcgtFAgDjSKalejYEQsCeM+ZMeUpLohKamiUJ37zYtTKXY4eD7yU4G3CI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 14:36:46.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209666a5-cd1d-4fc1-5723-08d568b80ec0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2018 5:26 PM, Keith Packard wrote:
> When the currently in-use hw rng is being removed from the system,
> explicitly drop it before using enable_best_rng as enable_best_rng
> will not do anything if the list of avaialble RNGs is empty.
> 
> Without this, the last RNG removed from the system will never get
> cleaned up and hwrng_unregister will hang.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  drivers/char/hw_random/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 657b8770b6b9..8df3f9f147e2 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -515,8 +515,10 @@ void hwrng_unregister(struct hwrng *rng)
>  	mutex_lock(&rng_mutex);
>  
>  	list_del(&rng->list);
> -	if (current_rng == rng)
> +	if (current_rng == rng) {
> +		drop_current_rng();
>  		enable_best_rng();
> +	}

A similar fix was already in the cryptodev tree and I thought was part of
a recent pull request.

Thanks,
Tom

>  
>  	if (list_empty(&rng_list)) {
>  		mutex_unlock(&rng_mutex);
> 
