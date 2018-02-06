Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeBFUKv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:10:51 -0500
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:6904
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752481AbeBFUKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:10:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] kasan: remove redundant initialization of variable
 'real_size'
To: Colin King <colin.king@canonical.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180206144950.32457-1-colin.king@canonical.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e86dcb38-d00e-d5d8-ca66-9ff4013a786c@virtuozzo.com>
Date: Tue, 6 Feb 2018 23:10:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206144950.32457-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.47.128.244]
X-ClientProxiedBy: VI1PR0202CA0029.eurprd02.prod.outlook.com
 (2603:10a6:803:14::42) To HE1PR08MB2825.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24993ecc-f821-4124-1391-08d56d9db498
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2825;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;3:rtiy1AErYwxwMJ03JqJ8SfVuCGO7Ja9Vgx74PeXfigc0OSXBqsGbsqjA/u5lbDUhBbS0DVsEF0+avIC1NZ6TcMLvvf9h8y3xcoHWLiDjQC6wS273Ud+2w32k5ShYeBH/SaQ9XlmMlKVMzfBK34vDBwKBHd1TXGVvksKagXiO7ZF/3Row6+pGm47BR8EJH/1XgaGjN9SoZ+6cXGuSX4WgIsmgwxmjK0zmbz7Kiy0kcm5xgB0/+fJgXV4x2fG26qCX;25:kEiygPF9VaaxCkit9gRvRY3T7PYoKCJqge6cIL0GI6FEXx5xqzsKpO3MsJXds79bViNG1rdJFa0E0Ez/jI1HX3SZbJ19O6AtMhCSbO8Mfp1BoXSQSPMP4yOrHBsGN/rxt6LTuE1eJiCb2oYaw39u6XzTglQA2hSbf0XUzAuWhJvyFHDMrEF9VJ8j8KuQyYMBdcj4ECip9XPwN68uf4XMDNFdFE2x+UKFQRlAhNCdpvnIsaLlFiU3MmU+FqOpSD56Y4Vvke+zFXVK2aOl6WTL0ERNaKRvC59/KNApGsFF4OVfH34sOLpCHTwu+I+q/hGY4JPTd4BC9TIOud3E/J0xrw==;31:SMOjm80sWVN+LEybIcOQy+4Cdx7Na/KlWmM8vTaGRoZJs0TuJMpoeMDyWBKw7vdNuMQFBJedSG3NxVtqdhpc7p0zhAEVkULhG4eNsr4RiMY0sBjFFZPrDXth/oGC1Y45SB8vlOZCyct7pELXhJCroUOKiHytMmtpvMAweVFWIjrMfyyJptADRvuJZN6NEyW7Z694kFOtiWl+AMvBB4HD2uNwgZCYWrhp6Oe7XzhqbdI=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2825:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;20:gAHW/LmXuSyycW47gFn5yPwvFfdSQ/Rqsw3VUMinUXiJiRKfXWpQ8MV5BhKOWk3C9L1xL1/mEFQeHM8al/G3+yh9aVBXrpzYjY73FoAiHyzhyh5syUjaStFe0qmQDbQtPojGVWXg7ZJRtKA2/zJIFfG5yF0zBoYLA2wssukFv+6tpV+AzF7tqnGttQQRLNAzE43MP7LRTL8slOstbUgesMHAaW5IRf2YFKbnHD+Nc0LnHeGVT7hjunZOwEbTLXk1bl1F+KDgH5fyHf1kxZiDkE+hvGlye3MRHy+eBKPpdzuQbxPRN8kVBpjmEA8x+JtKqcA08x656OC6DEbgG6++R2d/yWXe1n3pqWm9TvQSrtODWsZKn833Ctp475rwvfWm9BoS3qNoFP1rzTxGxtpUvDdd/lEVlr8GUJQhGGN/iwk=;4:jfEmdEAwgS2gCucF6xJfoclKvmiDBvmo1L+IEV2jUSuTBrdyVZh8tQKDY61QcnNg5mb6fm4CS/MLONsconoqy+BAeQ/cejo3kGZZA+CmEiQqwAjqsBg6xwFkj8y3TY/zr+IpAb3Z/M/XROyDQvOfXK1k27Kk0ruv967o3HHU8Q9WyI8CTFNO9Aeasev0u64Rd0ZmXPg9Kn4pD1xgJIJhmd3uK4/t/8WcdsdyUmL/RRCM+Y88kEI7a+sE5JN8jlNMfHOQhTpTY557o0vZfn7pVjlPlUlmgf+eQJxczxFHjB/gxzGiK8+rzrioYCtNQ9zx
X-Microsoft-Antispam-PRVS: <HE1PR08MB28253D3E0E5AF1B4D4481109B0FD0@HE1PR08MB2825.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR08MB2825;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2825;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(58126008)(59450400001)(5660300001)(66066001)(68736007)(7736002)(305945005)(3846002)(65956001)(65806001)(53936002)(478600001)(64126003)(31696002)(6116002)(76176011)(6666003)(50466002)(47776003)(65826007)(6486002)(230700001)(2906002)(31686004)(106356001)(105586002)(4326008)(8676002)(81166006)(81156014)(26005)(575784001)(86362001)(8936002)(36756003)(2950100002)(97736004)(386003)(2486003)(23676004)(110136005)(16576012)(53546011)(316002)(16526019)(83506002)(229853002)(52146003)(77096007)(52116002)(186003)(25786009)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2825;H:[10.52.82.104];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4TUIyODI1OzIzOkhsRHRTelErcXAyZG5aL0xQSGpRSW1rclRI?=
 =?utf-8?B?SWFZc1dQZjNzRW5vOSt0dkkxcjhkZHdZUDgwZngvd2EyOW1pNkFTQXhVazBU?=
 =?utf-8?B?RjZReUp0elFvWlFoQlRFemVpbE9peXY5NWF0ZXRrYWprWmdrVDhnVGg5cU1R?=
 =?utf-8?B?eXhuMzFxdWZjRSs0ZzlKVUhvZ1BkNkZpTUZidlo5U09DRHp6WW43SHVFYUIw?=
 =?utf-8?B?cDlLdlZsUXRsT2lXektOdmRjNHNwRkZNNTNUU2pSTGtOSDVPMkx0TU8wMHdl?=
 =?utf-8?B?TGlla0NMdWUyL1NSU0hLNkVzYlcrcUU0SHAyZ00xK3BPdzVIM1FXNUZjbWRx?=
 =?utf-8?B?MWYyVFRzVWk1NnE4Q0VoQms2MlAvTjVlN0Q4bzd4YmhIMU9kQ0JqQS9GK0px?=
 =?utf-8?B?Tjc1M2JnTmZkMFc0S0FMSExZS01EWHZKNjJTN0tIYTh1QmJ5OWZ4cU1vNzFw?=
 =?utf-8?B?dnVUcFloSVhNL2JjTWVKQ3RHbEpKN24zVEZMNkZXWlpvb2pWejltWGVEdWY1?=
 =?utf-8?B?bGpteDN1ajh2WFNSTW5DVjNBRFRVaEkxYUZaUCsvTERjTStjMElUMjFOLzcw?=
 =?utf-8?B?SldmczdrWVRRSXNvbWJvTGhSQXBNOTlhdXBGaDZMdGhqMmtyNGVYRlg0aTFk?=
 =?utf-8?B?dDI0WC8xczRPOEFNUzJ0dHpsNkp2R3JNUmJUd0Y2NHpMRkMrZXVCV3g3QjZH?=
 =?utf-8?B?emczMTBpZ1N3UXRtMmswMkRRR1BYeFpHeitCZ3p6N0NoWlRud0JsbG1RWU9u?=
 =?utf-8?B?OTFJcm5hNXEzRFlqTFhSQm1BYWtBMllTRFBIdDlFZ0lJcWpWRVkxME81UTJU?=
 =?utf-8?B?Y01OU1c5TWV5UG96WENadnQwbkovOXRuQitIMEhUZXNpUkp2Zm5OOTlPSDhm?=
 =?utf-8?B?a2gwek8yZzhXaEtYME5Wek1zUGR0aXoyTGtxVDJleDVrZFdXengzOGJ0b2pj?=
 =?utf-8?B?dFNYZ2ZRaGFjcFI2eE1VV1FBOWtiT2dXTnZBMlVob215cGgwWTVpNlJVckpH?=
 =?utf-8?B?dkJXR2E3M0lWMTZkS1lXcDZrTzNqN0JLRXJZdzhDWnljQXpzNEM4amEwWHhC?=
 =?utf-8?B?SWFxWnc2VUhyYjFSWmZSTFhpMHk0bHZuT3BTQzVLRVdIMnU3RitQdDJMdnM5?=
 =?utf-8?B?LzJORFJGV2JjUkUvTGh3WUtQNXg5b1lqNkZvK3pWV2VvSUloYzZ0L005QzBa?=
 =?utf-8?B?NUtYZU1rWVFsMDhBbEkzNGVNMndsamJUME5IUXBMcyswYlFFa0lXQnAxMzhP?=
 =?utf-8?B?K1BJalpzVURUZWY2STQwR0dkUnJQdlR5TEx4V0dUNjhSVER6UDdEeDFkc1pz?=
 =?utf-8?B?bHpuOXhxamhzd3NmL2sxMzVpU1ZabGROcEJHTStkVEtVOVRJaHZaOG10M0hi?=
 =?utf-8?B?cGp1YTEyN0sxRjZ2Ymljd1F0VUJrbzJCdHR3WXhEV2g2V2lnV29LcGlJeXk5?=
 =?utf-8?B?VXgrbmhLMHNCZERBYjJCNFAwL0tiQWFtb3c3ODh5V3dreFozNUNRamJMTHFn?=
 =?utf-8?B?SVpzUzgwNTZ0MFhlb2Y5RlhRSkRybTQzWmdaRERzSVE2RkNFSFNzN1ZGb05n?=
 =?utf-8?B?bDBWSUdLQUZ5MVlGUmlMME5oK09EN3IxNkRDYU9CcUJ2L1lkYk1DZTNGMmhq?=
 =?utf-8?B?OUlvRVI0KzFYMzFOeFZ1b3dmMzcwcVhSYzBVMUI1bU5mMDVhamtVY0ZqTW1P?=
 =?utf-8?B?MTBaMTZ0QnJjM1kyTldqc0dSNzdQMllHTFVjTjg3WG44VWFoZlRBYlNsZFBm?=
 =?utf-8?B?NHJGYkxKTFMvUHZTVGo0YVVkdmVLNTZmTXptZXBnWnd0UWl2NWRucUNZRjRk?=
 =?utf-8?B?cStOZFBjc0twUXBEL1plNFJtRmRuOTVaQlMrMGMxdXZqZVk0WVdnUm4zbWw2?=
 =?utf-8?Q?NG+Lc38XlFEJxpvbsqMaquo8B0oQi3pp?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;6:v+PDGt7wfCFCSVsdYf2ncwx14vV4NcjuhsEGBMqVpA0sYCH9BcnTD2FLWiUVSFO/M/zGxBHpcyaZU3b4FoeZhT1cno5Z7gQsNINn+PGFQz+140zxRRu7RyJYra+mDMGFQe9mtEuV99SKADsVp2Ll3mR155xQGTJDzunxFYxt8BFAIdlv+Q8uXaYLWuGX9Ke0Lnng1Y8YxkAa6Yi2ieddKDHhtsFZgtPls2PGTUWxz7ANWM5MKOr7gByGXe7/y93UqjnBWcU31Eu/vTeWbwHDOOWG0kgYuY0OExfmyF3sz5kpeySw5C7J0NNNszDjUGgmzl0V3S/Fp/uhuJ76M/JSax8dtHISq3gEPtPKYDuluYU=;5:pjS33n3ZRWTJOBdRLXS1fp9jp0PdT0TvEUJjSFHierQjVZLENqi7uKLU3WniuH2Oe5H/W/6bmPmcvcHSQen45waHcxLh89P1tpyH6dIhTLW/0hFBcvmDaKX+6hfUuv/DCNyfrANlbUwo2m8CK/Xrygv1hXr39WiY87Cp9qap9tA=;24:RLpHzwn9W8HXH57AK6h0b9VNQK2Sev60tq+3wOZBumjknwYNsoD78Ggaq2Jqle7vy9+LH/60OjUjyUA4NcnnrlWJdL8qOuQ+QfCxJvaVDHo=;7:dH6oqHGr5prOV1DjFAL3za/rnz0Ds6ae2AZRoPNd5PCh6OtNsgS9SM0kCf1Go/zEpHxNrZAL0auz9Hn3ENnVTlCt4CK9mfEqe1lJGZkDpS45o9z6efu/1nU9moE2IewwRPMWW10HYxMSU5g0v3SaOlOhVMelX5gtOWaL/nuLXzH5YdoIpsYRr5JINVGyDH5D4TPd8W9HpJxKNPHjtWtAFos8PnNOkatakwC7CcRDlJ89R6lEEGEW8ehJ6ZO7Qy7/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;20:TT9FzQh/AZ/ukbmyMbvYd851Gh9dtjBzeZ/DjaJ86blofr/4vUklgaE3aNssXh+0VQ4zhsYz1IM6i5wXVEppR03GxFKwZ6/TXVAHWTQ9rs3tQPQMOJRdvoIDzz3nDEZCUBfTKh+pbduOChn59GUBnnyfIegEXttr20maV2xXbqo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 20:10:43.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24993ecc-f821-4124-1391-08d56d9db498
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2825
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2018 05:49 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable real_size is initialized with a value that is never read,
> it is re-assigned a new value later on, hence the initialization is
> redundant and can be removed.
> 
> Cleans up clang warning:
> lib/test_kasan.c:422:21: warning: Value stored to 'real_size' during
> its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

> ---
>  lib/test_kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index a808d81b409d..dba0ffd45fd7 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -419,7 +419,7 @@ static noinline void __init kasan_stack_oob(void)
>  static noinline void __init ksize_unpoisons_memory(void)
>  {
>  	char *ptr;
> -	size_t size = 123, real_size = size;
> +	size_t size = 123, real_size;
>  
>  	pr_info("ksize() unpoisons the whole allocated chunk\n");
>  	ptr = kmalloc(size, GFP_KERNEL);
> 
