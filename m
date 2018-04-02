Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeDBSDC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:03:02 -0400
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:61952
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753163AbeDBSDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:03:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: [PATCH -next] drm/amdkfd: Fix the error return code in
 kfd_ioctl_unmap_memory_from_gpu()
To: Wei Yongjun <weiyongjun1@huawei.com>, oded.gabbay@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1522376717-136486-1-git-send-email-weiyongjun1@huawei.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4aac97a5-4efa-8667-3a87-d6f4182dd1e7@amd.com>
Date: Mon, 2 Apr 2018 14:02:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522376717-136486-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bac1ce2f-e234-4525-d8b5-08d598c3f7bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1707;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;3:GcJaEe7s6SpS+URR+fQGkQIMi2vnvh18inHxQIVhIZn8ld+ZVhegY5QsnvRcFKXOa7H84gjuD9atttLQBpoHw+lgprYMae+cPxitZZABKwZ38rqzOQjJMMladBCsXlNVmP39F83vFKjtAptjddcSwOH9NYlNvlDzt1xFpHIs6sEfTQ+WYX9L9NutAg1zL8paJ8G8CUFRnUUqiJi5IsUAIal6vSsAmZnlMp8xEfnEJUv73Ohc+Ri/SEKR0lHi8QTd;25:nYXF9NGHsZK2lPQj4y6roEgXmAiB6f9wEvU7PTjv1IRUFR0/6VNbmy1cKZB9kaeBirFkE2NMB+HRvPbskoHsUmxpnqoDqUrvRh+6t5Apy/Hu8BrK5qLe+OHkJHnDMUsMoeM5TX5fMtzqNET2mXXgLY0fPKiVq+dXmK9aFsHV2l/LCjMKRAOwjRmroDh6FfcNeA68qSDw8EeIrB3XWQokmWdOsuryssnC159d0NopEscGtdfH4J7V4GqqAgBcNLqtD/a2X1N9XC10dQ0URUgT/TtJAxrp983ONNz+Xg+rHEMWgDf2CGM3DfBChSSvJ3JYOElkjgEepkqMv4wLkyVrDg==;31:ZOtSyIMJBjSzoJ50WNO7VsiWEbWrcNaY30d05oTJFTPYlGg5ezJ19bzLOsDjcnesUuH9zbF4XaucFtPJvga7Iu6QXcaTRMYvLl0+VDdG9nn5fQxpy3LH8wiShfgCSWJgp1OqY8nqDeV3hg9vSfb/W11xdUNpgw+grJDWaceQ/jmsPXm4UE6iFPrXbq+mLV2CnkI1Nb6ksCTDoKid47Ns5ev0RT7FdSMcRoGTb4uf0aE=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1707:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;20:DqAyiLc7mYqWBB8OCqkYFmV/OY1KysR9wzyLrduM3Qa4CGKRNByANsELjq5Yn1CWZ32crqu/nPWNJSV+v1XO95PN3WqYeTb5j0j3d3csVqVVZP5dPLlQq5NpyDFvMDG+liGrrIoTuQuIWtSVOKbfwaOzqFVwxD+aa/F+yhkCn/wlW5vjnrylu4Ew0hLxZfd1aFbP7EO/l9W7iOgbArJ0oUSCF+Bo+qc5KrYFKSiBh4d1+5QkkBhQJY2zkYkLwsfjIoSiBY98Uu97Flphw/+BZJGZZoFlB/X8oNNajvK7WfEK89EswDWhsyY/uCTXJOpaFR7ZJOOIrqskw+UykgnHZBfpJI9RBojOFc7OMIWSFLSRmZe8Wh3XtazQ80Lms386t/5Ef74WvrUU4G6kqQ/Bu5uy72r+u85UljmUc3TXHM+EeycTQX7RRONTOoX6VEdhiNkPBiDKDuoIfgQmjK3Bn21VltCJXNtqxHIrrWk7v+KoNeKgoeVW9jxTaUBQSEhI;4:S5amafqdjpYpfa3fN1V6392PHU3g12P/BME8NZjlzHlGqoXAthhTqCC89UYQMdKyDlJTbFR1RRi2tOjn0hEGVuLxgph3tuqtA0ndDVSN6hnWa5mcce6aWImYM1ijAESbtMsgn2hr/oVx9vjM2G6y2BE01bgubllKOd8teW/eQ0NY6Jbqjfhlz0xfOMSU4WZG40jqe1ZwHX2/LHfh81Enj8UHCq8UOCNQwez107COE9XstvFddTZDKwdXzEnEZkXdPvBj2mmHAQY5wJM/WZIj52oe1+ZaOtxq2HXlpw91hLtd0bLWXtz/SUdKbFyqiPZMsPVzpZm+08ICpsBk0p6+vDuobGavPKzVYKy4eJIc9uQ=
X-Microsoft-Antispam-PRVS: <DM5PR12MB17076CD4EB171A456CC0AF3D92A60@DM5PR12MB1707.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1707;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1707;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(199004)(377424004)(189003)(36916002)(23676004)(97736004)(76176011)(2870700001)(52146003)(2486003)(386003)(305945005)(6486002)(229853002)(6246003)(486005)(476003)(81156014)(52116002)(53546011)(7736002)(8676002)(486005)(81166006)(59450400001)(8936002)(39060400002)(58126008)(478600001)(2906002)(53936002)(186003)(16526019)(26005)(77096007)(106356001)(316002)(86362001)(16576012)(68736007)(31696002)(50466002)(47776003)(36756003)(6666003)(4326008)(65826007)(6116002)(105586002)(25786009)(5660300001)(446003)(3846002)(956004)(11346002)(72206003)(65806001)(64126003)(66066001)(65956001)(2616005)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1707;H:[172.27.225.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzA3OzIzOkhHdkZMeHlEODRTUUFDczAwTk9sQWR5M0kr?=
 =?utf-8?B?UkxFMUJQN2lma2JlK2MrRXRLRTlueFkrMjNLcWU0Wms0VjZJMDJJREs0Vkky?=
 =?utf-8?B?MzU0ZGkwNExDRzYrakhiWFpuWnlBWXVQZjBGOFpodDVXREJJNjhoSjVIY01w?=
 =?utf-8?B?ZXJXMnA5Q0Vhd294WHZrMTVJSVozL2RqZ2llNXVIZmdobFFLQVQ5dTZwVWFP?=
 =?utf-8?B?bEhwbHpqL2lHMi9QcCtLYXJZU01KU1BjdXk3cS85dzFLQWo3bUNacVFPTFVG?=
 =?utf-8?B?bGkzbzU1UHcvd0dieUNEY1ZManNqVHdudk1pMWdMUm45aGxZSzFPRS93aGJ4?=
 =?utf-8?B?L04zVlpCMXhHd25zNGRMakVjNHJSMkxZaFBjUktPRkZtSmZpdG1zaTRyOThw?=
 =?utf-8?B?RmlPbFVtZFpTcVB1Q3ZwREErSjdxaWtxYVVyYVJwQjJwWDlWengwUlFwYS9T?=
 =?utf-8?B?Qk5nSFpPdkNHTU9EQ2RETzBUUTV3RllkVTVFbUR5aEpWWW1xVEVGZXppLzd6?=
 =?utf-8?B?TzRkby82TVVFQWdkbzA2N05xY3dQM0xMa2p0R0RYRExoOUhwMzluR3QwMzQ3?=
 =?utf-8?B?cnpyaFlTRElRQUdmbFYzL3lDaUM4d2VOMktZVlE3R1ZrZzVVdlpRL1VVbEF6?=
 =?utf-8?B?S3JWSkRHTmhZWXJXaW4wV0EwbWxzNGZaaWpqajRJUTgvQ1NaOThLeGVIK21n?=
 =?utf-8?B?cC9aVTAzWFA2dWJUdnJYMVNnRjRJbXF4K1pPQ2REWVRMenpMNTRvZ1BxRnpO?=
 =?utf-8?B?K2tSazFZcnJiVURHYUN0eG1WTlBTeTJuMmU0RGdDUkdveHc4N1AybTViMG9P?=
 =?utf-8?B?NFJlOXQ5RXRKQVBWbHl5eG1OdCt1QTd4U2pEWE5PY3FlTGlNdEVjUTBodW04?=
 =?utf-8?B?MURqS2NKZEViZHpWT0lmV01NYjQxVjU4L1IzM2IxUHBQeHhzMkFSMUtnTG5l?=
 =?utf-8?B?dzFBYncyc29maEpJQjlTdmdNcTJlQm42dWxOYlhuTVVScmtUKzRGOHFoMUZE?=
 =?utf-8?B?eDlHaWJEcjc3T05vOHZybkQwOXFicmovd1haSjRwWVE0alRtakROcTdTcTBN?=
 =?utf-8?B?aHdQeXlXOUFndmJEQTdNOXA0Vlk5OXRkbnliZThLanhMeGNSZEFOUFRUNWpr?=
 =?utf-8?B?TGtLOVZBaGE4d29oVVZNZ3d1ZnJtNUIwbXIzQ2c1cUNkUWNCWjZjcEJZZUFa?=
 =?utf-8?B?Q2RTdXozT2xUeUNwMTB6cER3elBLMnFMZVRtbUhodFNkbm1PY2x5NU9nOWJR?=
 =?utf-8?B?UkZUQjU5QjM1aHB4L0hGKzNqSXZJaUNrTzdwN2tRZnNsWEk2c2l5WjFYRkh5?=
 =?utf-8?B?MGxhSzkvQmlWK1ZvUGxLbFBpd3ZkMnp0VmN0ZmgzckFaR1dCZUdLdURocis0?=
 =?utf-8?B?TXFWbkRkcHNFcXNQOGc2Q1FLaks5SldZUFhkVWJCR0FhemdJeUUzZktVR2JX?=
 =?utf-8?B?UDgzbEZOOW9MbGZqWkluNUhGWEY4ZUZjTksya084bkRSZnRvZXVzc3lvYVFH?=
 =?utf-8?B?dmpTOFkwV2pRVkVBVUZvSTJ2V0o3V3laYnpBcU5LTWkwM2VRbE9hYSt1aXBG?=
 =?utf-8?B?bWpEc1R2TEU3WWY1VmtZN2ZwemVBcFhlYXFVTEhFTkt3eDBVWkdPR0pTeEhP?=
 =?utf-8?B?MDJxbWwzSktaTDhSUm44aW5aTVVvYi9KUVYrRkxMdmdjTlU1S2FTNDVlRFpy?=
 =?utf-8?B?b25yVUlyd0FWTzh5K1NFVzFpNmdXTjAvVUsvWUdjK0R1a0J2akJHamFFWENC?=
 =?utf-8?B?d1ZLVWlUbHVVRGFXQkhlYXh6ekpFMExZUFhNMmFyQXdXQ0VkaHJ4UUgyWnUz?=
 =?utf-8?B?ZytPSkFiRDdFUFRYMStvTDlTSGxZSG9JSXNIWGJKanJzencwOGpNNjlsMWFK?=
 =?utf-8?B?aU9KVUoyOVN4RTVwTDVEL2FNNlhwOFE4Y0FUNDZGd0lZWnJlNzQ1d1pnaTh1?=
 =?utf-8?B?VEdGMXFjbWtodmVseGU2aWhUT1RIY2NpWDYreEJnTVZzL04welVWK2ZxUEQw?=
 =?utf-8?B?eHF3aFNYVDJWSXJwL2pXemg5K2N5NHpiaS9tZm1QVmtlcHN5WVI1c3pZNnIv?=
 =?utf-8?Q?q9W7EK/mKGhab+rcS1KBXZ24y?=
X-Microsoft-Antispam-Message-Info: ANJkPfSYsXvxF9gJwYrRyIwjGiKj7xgqhlUA5zEhwlCPS0/5GH54M5b4253ddS56D96ln01Wx0cb/Km+BjRcxAwz395mzzA7dhmMXBUuEYpqq5hUAhMcdFJtdRSmHzi16hwqbiDCARReDruxu/zcE54NVMeAD6S3eo7J6p3eTMtE5Y+WcWYgdzOCKqVZMxGc
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;6:0XuQTR9WQZgSStmbW5EILDU8WM+xxbra5NfO/emkrRDtjO/qJZ4mp1cxclAtanEYSBO9W7Q9rb6WGVmQGHN6YyXRQvBBThT7VIjDvUNC8hcSTihVGCauSee49i35J+MkVhm9qJlhPGjgjDlunOlMCG5zKjr8R3DttI6FUhz1W26Hxs31Yjjp7yDsBFSWHkTH7D0n4Qexzy09Z4YL/vF2WJT+OSSOcUhrfL3m9eGZPJc2iY7H/Dv0+hKGPccFKetfYAD7+5fuC3H+X4b8mzbwMVp5nZl2Fw34uy+nVLT4+Hvoy/prAB9rEAx9TZWV1hcTb1cmkyY8pzMKvFLfxVyjgauJYxnHV+JtAD9QFp1a3yK+wIUMhTvUmKAqKZDoqMcEqt1QykGRtp0v7DYgYQJiAsclafEQEtfV6f/9U08cFSrA/9V2RFULLEQ9ZpFXnxwjo/7AIKtFVzIh7MjFzASlpg==;5:Thzyc6lC2b8aO0ccf7ggb40hnCtlyR8pjCyN38A5u+kEP9/MrQYeNDe8XwxbG50AZUu2anMbc9X5vgEE/tZzhBm4448ndtRejrdZUFYW0VCyj99gQ9grGnhWRs4GC1p7dFpp5y52z4xW5jY1V9u0UQsz24Rjnsx0D6Bgv60vJc4=;24:YAVhNYj2kQ7Hu1mTD6770SuiSVYvOBIj6YEKUehcjzj2D6ebQo9RrSoGcXYM7ux87x/4edGUhUJRP+lcYJRuNeG6EhIGzikMffILtgGJTUk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;7:o/+57hV0fI1A0PK32nAp2jbnq9iIxe8KuXFcYgW4g4Fz9TihFUHr+/XnAVpjyBEYxC/HR4bd+5Z8DeoFzUrlOISE0R91Ef5CPPDDePtm8H2W41hcqq0Bxa8nRaktXDPWLdyZCe7R6p31gn6amol7pBX/oRg1w8F1+xzTGORobYPQj05yOetY8ygMRs9r1wRTSG8f70037ewwq+JeSmBB92xo/S90ErTVUW/uVLbQzeSSvO60K19U7KzdYeb7hFcl;20:00tQEPH4x3Wr4J3orDtfHsWk4R2fjMbVm4qFykGkqVRMH+a7VEIwsvB9s2TDqznhpyektzAoGPKYBuBl4ID2cp4ByohxRBCYRSotscgha/I6tlbxpH/lnvypg3EcQ9P79W8NTOYht6cKdCgH1pT643kh1w29+wOgDB6qQi+NVXHW3j32qFiRbcEn9lK2NxflLNVusGn5Vj7fuW4/+6C2p4xSFDNhI+4KSVzkxqxVXHdXigscCpeqrHRkQwv/4sQZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 18:02:58.1189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac1ce2f-e234-4525-d8b5-08d598c3f7bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching that. I'd use -ENODEV to match what is done a few
lines below for peer_pdd. With that fixed, this patch is Reviewed-by:
Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
  Felix


On 2018-03-29 10:25 PM, Wei Yongjun wrote:
> Passing NULL pointer to PTR_ERR will result in return value of 0
> indicating success which is clearly not what it is intended here.
> This patch returns -EINVAL instead.
>
> Fixes: 5ec7e02854b3 ("drm/amdkfd: Add ioctls for GPUVM memory management")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cd679cf..c32a341 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1421,7 +1421,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  
>  	pdd = kfd_get_process_device_data(dev, p);
>  	if (!pdd) {
> -		err = PTR_ERR(pdd);
> +		err = -EINVAL;
>  		goto bind_process_to_device_failed;
>  	}
>
