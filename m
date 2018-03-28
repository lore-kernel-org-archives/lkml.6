Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeC1QEz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:04:55 -0400
Received: from mail-co1nam03on0045.outbound.protection.outlook.com ([104.47.40.45]:50580
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752453AbeC1QEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:04:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
To: Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180328155340.2253343-1-arnd@arndb.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
Date: Wed, 28 Mar 2018 18:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328155340.2253343-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:8109:500:e1c:fc63:9264:3a5e:4920]
X-ClientProxiedBy: AM6PR0402CA0014.eurprd04.prod.outlook.com (52.133.16.27) To
 BN6PR12MB1713.namprd12.prod.outlook.com (10.175.101.10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4439e0a3-d1d2-4a61-3831-08d594c5a2f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;3:1wojgyPLgeEx/s1686m7x+gJtC0864ml1HCUS0fLTJ3dkoS5UCvKAhRR72RM6WsjIHI9muAJRSL/QDW9NfBIHY2/QQskrbGi1tAQFfkvk5xuUO7h90P30dK8QdbsLtAMEp7prYAa8PSmLY6hq5WjKpiuSuMkcpefkupG8L+X6+fKT0uXga9DdtiEWmg0nIkMU4qvWfYJL+PefC8MfQx/kzz++T1l1IFek1v0j2H/o6JTRVbRnAoigeA0H4564GzN;25:JjlqL54+h9isBCdUOZJugZBy7qPr/riRHXdTSBKHnTGh7CU5JwXHVeKLKWcSKTK91fx4dGcRzFOTILLkTLMVXEd+z+Fx03ywwXlxNuai3jtMu+jSSymJ+TjAl9MtXYraD3bLyLlqHYnIfI5S6s795QeIr5TLByAFqHEer3EB7tLRWjFPBj/PBLLnd4X3X2BubIhrhPkBY7X9kID0GomISi2NpvWkKtIWsLBSi7vTI5xOjkVGNvWkVwuzb9hzBesTaT1cux7CWQmzJ7mtuF2iSnsKDoh6DjTz1BC8OZOisDYJ1n7RHDyCNqlaOCjDQtBfGsM9teA/tfkn3cXQsWWqMg==;31:CViZ9YvkbfisQ8FHY1ni54aRhUnpTSnCgRTgYG+6uxG5+tcI3hhEkz8onvEIZ1q3ozjjFT7SxnaWJchA3ySDghqzL/Ywfy6VcgcVPcUufbYKaMncQTUmgwbxJUJhlAQrRc32rfbddjMxtzPdJJvPLO7/IEh+8dBxQb60eDIsO10nvfiWQKGwx5xJKt8rKxqBOZEuZhnOULkkzrrYTzCanUeXwgwav2OZSv5/rH6TEmg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;20:7LCmiy2sO3cge4E+7yVcsHtZvCJNcXGUOtO17vRHTIdxn8t8M74/yGcPZQAd3aowJVWfQ9F9QvHDzUVjEybgywUCj80YD3z0P/y/ggaQl2HxbM5fJq3JIvP5q84pQEkESNfAake5FusOr9/qSnwYTzhr+qxby8epoirx3U6bBhImtPo06bJ0v2GYvoQi0M54KnGIPlJi1314olYwlgkXSYdg7qM0vHT3XgY5A8I13CgM20liO6QGtfsSRSrROaJ6kurBf2Pka8NHauL/LI/I/piWv3gM9t5xWN87VR9A5fpE270l299OulqoADUgMtepRWLHg1TPdPvbT+k5jwcSdfMbL0gdKxJdyfozq99DwCY92WB2cG+FgBXliNZ/ghKxDqcE8mCQgIqYKUoZJgwt5jnwW0dVx63rJIyRTzqWuUHt37sqPUVYr0uH1tb+ub+72Muws3Q51zR7v5A5ZoIWJnTDFzFvcEFD91rilbAqtieNRIJd/GC7o+S8wmSwpF3t;4:j5YlZyLORgvxDQ8A7IFDUFQ5wVwxsA+8SZuBKgoS8MecjqhPlHrRHtCdMzzF2oHIDuVHwhM9yrWbJrsNjNhzShq+HQRP0fhv+cA+vwuL3eiTtlHaa2X+mro321aV/1vjht9BrdL5JsFKYTV8FuWO+anHi9fLcTsukzV8StxgP1rBT61GWvETnoFn5a6ykz9YzAPTaKyDBVi3jn+qIbHQQ9uq2GgAlugbUQ4//DhHruYIcRdItfgo6Jf0N9CD/UHRvqpQFVbX4RheB2D9qbrw3CwG7k7soSqQGP20GeoGKSdEA1MaV6qh+nBaH6W3+AiI
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713B355EEB891C051D2E6BF83A30@BN6PR12MB1713.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1713;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1713;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(199004)(189003)(65826007)(6666003)(6246003)(8936002)(11346002)(5660300001)(386003)(81166006)(7736002)(36756003)(47776003)(2616005)(305945005)(81156014)(76176011)(446003)(486005)(486005)(476003)(50466002)(478600001)(86362001)(229853002)(65806001)(97736004)(72206003)(65956001)(316002)(53936002)(31696002)(64126003)(1706002)(6486002)(68736007)(6116002)(110136005)(4326008)(186003)(58126008)(2870700001)(105586002)(106356001)(2906002)(31686004)(2486003)(67846002)(23676004)(52396003)(16526019)(52116002)(46003)(25786009)(39060400002)(8676002)(52146003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1713;H:[IPv6:2a02:8109:500:e1c:fc63:9264:3a5e:4920];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzEzOzIzOnN3NXFqWENHSksvR2llT3lxaHk1VkUxbzE4?=
 =?utf-8?B?dVlkdU5PMFpKS0Vna3NZMGJNYURobWI1NlljTmxWdjBNNHdXdzIxSWVmaGg1?=
 =?utf-8?B?SEtabkxQdlpTSkFqVi9qQkJVTTFmTHhZRC9oSGxTR2VvRWEzVVB1Z1FPOFdw?=
 =?utf-8?B?K2JEbnhUUzNoaWtwRGxSZFFCN2FyU0wzVDRpeHNGQ3gyM3h1eWhJUGowMFZh?=
 =?utf-8?B?UmFrY0dQdHhyUlhleEJEWDlnbGJqN21hQVhmcjgweEhXaUs5ZkN4cUMyRmlx?=
 =?utf-8?B?akV2d21aaHZwYnVmamdycXlDRTVuZHVvbG1VOXNJczRzSXJtRVA5UGdtS0lT?=
 =?utf-8?B?Myswd2xqM0NZMVZNTEg2dEFNTWRiZUZmenVCZzVqSm8yZkhSdmZ2WDlMWThl?=
 =?utf-8?B?TE1aWWZWeTJleitOSndjYmNLZzh0cmVoR3VXa3lOOWpid2NVeVZYWWxuOHFy?=
 =?utf-8?B?OU13RnBXSTMzNWYxUy9SdEVWclN6cHRGL29ocitBSGhjWVFVRnVHSFZ6SFh1?=
 =?utf-8?B?eUpUcURJVmxldkxaaG80Mis1VUhrb0wxNGxiYTh1ZVhzeW1vUWNMTmVKUjgw?=
 =?utf-8?B?VnZpL1YydzBFQm10ZEFFb3ZSaGYwbTlERm1YNTNkTzBSWVJWOHp1UjltcDli?=
 =?utf-8?B?K0h3RDBwQ2hDakE2NTZSNWMyYndOek1yUmxNU1AvandvTFhsT2syR084cFZ1?=
 =?utf-8?B?SStaTi9wTFBYUWVCYmhOdDRSZ2syUVBuMXJ2NW5HOVVyc05HTmM1SEtuOEl1?=
 =?utf-8?B?RDNsNUFjOHpNQUdFckF2ck1qK0Q2ZUZpcTNHNVdjWWl6eEkrRHdhZXhpZUw1?=
 =?utf-8?B?RzVvd0ZpZkxjdmtQSUtSZWFVNWJhUWNqN2lCb0NkUjZPYWtGT2MydWlFSC83?=
 =?utf-8?B?T1UyODQycCt2VjUvTHJSTUFRZ1A5UEFqNHpqQi9MVjFkSGp2aDNMNUZhS1Zl?=
 =?utf-8?B?a0lYYko3TnBKY0VzUEFNVU9QOCtIWGVYMS8vS1B6Sm04N1dYNVdDWFdtd3VO?=
 =?utf-8?B?eVIxU2grZGZIWEM1VEFmdmErMVhPdFhxNGJjMWpQdW9NSWtuUTJLWEszZHBn?=
 =?utf-8?B?VnZxS0U3Njh3cDRCL1ZEcndFMld1bU9LV0tubUhRelRKeXlaRDV2RytCOWpJ?=
 =?utf-8?B?Q2NPS05LQXRLVGd2QWlHM1U5RGtuVjZxQWFRTGErUTJNbktydDFQdWRWMnZ6?=
 =?utf-8?B?R1FIcTVvUnhIUEhvSC9IM0JWSTUwV0JpSlJDSHdlNk13MFZpanQ4ODh2a0FN?=
 =?utf-8?B?RXNyY0tBSzE1cXZrR2Z5dForV3FoTCtxZklLb2RUM0pjRkZSSjFlZ1Q0SEEz?=
 =?utf-8?B?VnVhMDRYbWcrVUVTRko1RlZzZjRJMTF0UFNnRGlvSlBkdElOK0tpODJqWUg4?=
 =?utf-8?B?ZWZpOStreXhnbVRlSVg0TmxWa285a0ZaK3RZOTRXWnVaRFpGdFZuUXlCK05T?=
 =?utf-8?B?YTZ1N2dzbTFEVlFIRWZIK2VvY3EyMWNqeXpwc2hReU5KcnJZWkxvb2srNjNB?=
 =?utf-8?B?MjRjUnVNMTAzUG9yS2ZuUGx4dFRxTTZEQ1lYSXpIQmpjbGJsd0N1RE0zVG1X?=
 =?utf-8?B?UU1MTmh5ZDQ5bllGQzN0MFZ3RlFTOWYrYzZDRktaQUV0TWdEalF5QUlJZGI4?=
 =?utf-8?B?OUlvNVYyZnNpTGZobVFpS3FaNDA2K3Uyck5hSXNQNEw1NEVveStlVE4rTmlh?=
 =?utf-8?B?R3p0SVphcEQrSTBzTEVXdFErcldQdm05N0VidFpFK21ld0VyNGNZUW9aY2p1?=
 =?utf-8?B?RTFVNW9oTmRQaE9GMnlFUHZ6WE9mdmFzbytCK2l3djFabTAvUE9oeEJWbjJU?=
 =?utf-8?B?QVM5VkxvUlBxQ0d1aWQ4S3JkdENjYWhVcmRDcGJueGcwTnFRV2VqMXdQK1V2?=
 =?utf-8?Q?xEjhL8DHor+4zVSF6HYRomIyLxmhEJM1?=
X-Microsoft-Antispam-Message-Info: ga1YJPk1E+4qR+b2u4eflG8WwVy8NVyazODJrzlWRGdNxQXpEQgrv1EK6PlFzUJ1gY9NpGjAPJz3bs2HHb1I31n+pTs+ssgKUI6nCDqNjn0jq0vdd5YgJMaYCiX3warEXvqFMbSuVgk6QufhRPojPXdUvjcHTmAPZ/OjJw4Y0p6VbnjUsu6HT5QMkf4lSBx3
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;6:jt9Sc7LT90d3XRhpFdSh9bGY40sQ7DvRG5EhERwayYxR3v/NvKjBBBVXijXk6ODoDjn93E8ZnHZphNN+zu1DHNVXnR8i1mz59hvKNT2ehJlqq3t8j0gOhkeQZL9WMVHDaf4eog/C3AOTfNzJSx4cE/Fl4eJVPn6FRK6u6oXqfNTMXt/euj09tsByKgrW5wAKLedrgJcaJryCZ1u7y7USQes1wTs3xksdfMtXfvBOp+VakhCQ+Ywt783UTN4yMe0mFSqp9Lz8FSGF42R5e7SqePdzFzvrvmKa/8EcAUi3isd7lbcDmqmMbg1oD2Ee6os++vwboFvLgWY8lfegcvW6XNMn2ptimqcmjsRyZ7R/kclUA4/p29MDDfHOm3KCvY5MA5rq1TtjKvreXpEgidR0FPCpFxFol56ZDJiCNXTyjWhBynOKd2sIIglg9J3DL3v3JiJTPyWeE18SS9sVW0uCBg==;5:yWBFqx0yPI1tIEqA1Iuzi+uUOY5z1BE/FPh8RJOX4cPQFTpSl6JQ5Sb4OMV4qYJDUq+mhlNShRzW61qTyqlfODqchxYMwNYDv89bhfBqrvBtNPbGxxFj/sCjL81GNQk+jDVikWdopAuHrVRpIcKQiMl7XpIdQALiaf7Gj6lixa0=;24:zhIfnRaTv932yiNSre/A/4ZZ643eRXtSvGrNfHhg8a8io+5/4YERSLpPhFZeDydCPwpsPKmmUUVnCmexJaCMTiVNaT6Lbq20bVbsMaL6ay4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;7:acaEJ5tmqmpSTFMIzcAA7yDTk19aq09ZNfTdfF2HRseh1ceG9HfagSQ4yA9Rzs4o01O/yXoCTT+zXPmyUgd0eibCmJt9vGrolAJdwzlnohMktS1/91boW9BgD1rqNul+lOJ4A2OMZgyWzzrAmQUyI1cIsI8gZtJiiOiZlabpQNW/ZuGfonzu62qAiY1MyI3FL1fMKyK8kpPf10+Hhk9ntbCv4iUGcelp0YqlE5r5FNyZB4mb0ThzCRzP1JbF04xM;20:h6KCWpiP6xTN/T+CCsEUXP57BIwappvYrRKV3A2zqVtiuFJ61cUtm8GJTz0Tg6HNBu2ixs4DsQQLfWgmZc31PPngTN3spKGHx/UW2luAv70fYN3n8mC4xnox61kiTLMsnnHhoI5imBNAN/jwPJfHS8LjUjUhbK45rUJF0o8004unqd7H6WlOUJQGuZR+xxlCDBBxiOSWVDJclS8TnmNeNObEpwczA8iYdBUx6rc/LqirzO3mG0X3/NKXrVbVTC9T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 16:04:47.9255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4439e0a3-d1d2-4a61-3831-08d594c5a2f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.03.2018 um 17:53 schrieb Arnd Bergmann:
> Building amdkfd without MMU notifiers is broken:
>
> In file included from drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c:28:
> drivers/gpu/drm/amd/amdkfd/kfd_priv.h:584:22: error: field 'mmu_notifier' has incomplete type
>
> This adds the missing 'select MMU_NOTIFIER' line to make it build
> cleanly all the time.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Christian König <christian.koenig@amd.com>, but I would wait 
on what Felix says to that.

> ---
>   drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index ed2f06c9f346..5a26acb90e19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -4,6 +4,7 @@
>   
>   config HSA_AMD
>   	tristate "HSA kernel driver for AMD GPU devices"
> +	select MMU_NOTIFIER
>   	depends on DRM_AMDGPU && X86_64
>   	imply AMD_IOMMU_V2
>   	help
