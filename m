Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeCEWGz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:06:55 -0500
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:6707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753144AbeCEWGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:06:53 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 4/7] x86/microcode: Do not upload microcode if CPUs are
 offline
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-5-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <236a3244-c4df-0d40-72c0-583ca9f47fd6@amd.com>
Date: Mon, 5 Mar 2018 16:06:48 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228102846.13447-5-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0088.namprd05.prod.outlook.com
 (2603:10b6:803:22::26) To DM5PR12MB1147.namprd12.prod.outlook.com
 (2603:10b6:3:73::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2a3f9ae-640a-4148-7f1e-08d582e5666b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603324)(7153060)(7193020);SRVR:DM5PR12MB1147;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;3:0Ezp5N6JHIKAt3BUoktjXtKsPCp6i9LlnY5ARR7+svu+bqBWKumqWtrlfX/wk63NXBpdKAz+aFFhStQDPbZT+5fbr6k4u0QYcackvuNhFbsrhWy/UOOf+vMKB3LjMHd6joFVLhqnRY0lFNdulr5ZPasn0AfFgClGJ/9AnSapl1syeqPFfpjK5ZK9V7ru56jn5P+VO3AXRR/8c9LgyZ753fuocIjvnHEDID3Kd+J8dS4aLM5gYPx3hTvNaHAPiw78;25:svgXGASrobdkgJmfocYVV6/b8Focd7ieu9pjf7REETzn6zMPVE4AAYBtowpX6tUbII8k7CPifTPP688iI+zKio7SCdiCd0AH+NnrOf+34z2Z7/hv8Ov4hVVB/TR+F24tqu3hU7M5exZebruvHhh3e5oMVGC7JbYnAT0xvS8gWduJNYkX1X/mCC8VDlv8JG3n+Ojs9DWicLCHsoZoT5ePXnTIEiVOcI6v3dtgFyhCwJFsR809g03rCsn5dM5o3BAuKqGI9DVlz0FzFRumQ+VrxW4SbJopGXWUhcx0v4195WaHsZH0AyoMvn4bW7uPW0jtkzOJKvVn9oRfkvlsVyJPkQ==;31:QswMYc3mwX+O9qrkGXB4sY3JrpwAnhFNkr1sjcZOXIM3uANXzmbnhP1SQVAlYS5QDCo2Ml+o/HGeIBiJMeVY8SAG8KuYAx4wY8Lsqv3ZlDQeqX2CNnoc/dO5VmokCUIwrHdzcsL+81QAhzdsDPpp6Y7B9hOFv7r38SRa1q7ZR/aCa6ht7JegwtATzQaVZSYpTslpWUzuCtupP+pJY897mXxChZ6KODmY4ewzjOzeEpE=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;20:6M5/MJ7s4DZqd+ggNlfEJBHKTf1Qu4XZJNTUDgel0F8Usgp4OwylZRqQ8IHr/oeEYGYiE72ez4HX9K0NbyZ9X5AGKZo6j7kLGFdfvSZXUzZmij1G7DrMXAznn6lZ8sbtc4aicl+YKXw3DHEfBhvfo6nITjQ/2d5SN9OS1wS8svPEVyek0bYEjVvO3RWS5oWnikM/J32D8R0id3jaf3HgnW4J8a/YqBu77o1jAjIse80JtAnIkkTVI8ltOrp5lHwfdjoZC7LvqaMrC4zg2r9Md5f3AEUJfHIoocXWY5FxY2SHt81fqJkXgGZ8O/D28dNk1zlkE8MyAIPS4EIzLaYD61/SbbxG1XHuCdAaRaplxnWS7D6F4WDVUUU9znUlWslP8Fg/SYTC1x9dKO4vHtFwh43L0pqFgmMhOgt8JKD4oUZ7BaQbVnAW9G/9Hpk6tWemPxQQZxXj3omKO1SNL4oa1seK8+dU/Y/mL2ntVqT+qCyQnXjLkvPk08ks/Jei2mB3;4:Kd1wS22yzxZ7mzlzTeHKkvM3s+a4VYyW0EkqIqbxxng3uogeN3ekkKqs6fh4MQ0JmnLKmavbNSWuKZaoPmB/4WUB05BmF87uysemrZxt+DE6LdsAPAlD12XKCr8xK1oVg7zQdz6VGsCEP1n1KSHA6RLcbbuF2ZtoOkcdYaGCjD7S4W6DHklgPOsFNWFyWDPBKrC8aY8vlihmwzDcKIjmdSUWWb86/Y663GgX+3Wbs/40OgOAQM4NTZp2RxKAflABjPvvQdfKmVOYkjmHox+aZxHdBIujIQNOUNUweGfZaCMdSyUZRNQZpujjjkalqnwRAWVtS6OyDRhXpJWxSRtlyCrCiz5KVeTChr0RvPc/R0B10SMul/R7nZttVHJLL5BZ8qbcCiX5fXElVdGIJilLpCPS90o1FpvF3yiuwBgx4Js=
X-Microsoft-Antispam-PRVS: <DM5PR12MB1147B732B9C447C3678073F2ECDA0@DM5PR12MB1147.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(767451399110)(42068640409301)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1147;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1147;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(189003)(199004)(8936002)(186003)(72206003)(6666003)(16526019)(6246003)(77096007)(2950100002)(97736004)(4326008)(106356001)(25786009)(58126008)(3260700006)(31696002)(65826007)(16576012)(966005)(26005)(2906002)(110136005)(86362001)(31686004)(229853002)(53936002)(47776003)(53546011)(386003)(59450400001)(230700001)(105586002)(5660300001)(65806001)(6486002)(52116002)(54906003)(6116002)(2486003)(23676004)(52146003)(36756003)(68736007)(8676002)(316002)(3846002)(76176011)(305945005)(65956001)(66066001)(81166006)(81156014)(64126003)(50466002)(7736002)(478600001)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1147;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ3OzIzOjM1ZFFIQTJPRFZKN0hyYVVybGpNQWFqVGxV?=
 =?utf-8?B?bWRtVllYMml0U1pKWVlrMUd0K1ZLMUEzRjZodm1qbkQwMWd0alJPM3JHVUs3?=
 =?utf-8?B?OXgwaGkzUjFxV1VZbmpkVy9OZ2JnNWpNOUZPRzBwVkh5and4RW85SVArVGdU?=
 =?utf-8?B?NkRENWFFNEJhRENkZ2dRUWJSSXlSa1BoTzBlQ1llQnZQMkMzRUFWN2p0b2Fx?=
 =?utf-8?B?KzQvRFF4NEkxR2JzVHVRbE01aWtBUGsyakw1OVM3ZHc5Mnk5Ujk4bmJBN0o2?=
 =?utf-8?B?ZTM2TE43VVpma2xJY1BXN3VLZkplNVRuQkhTSUlVT3oyUnYxQW56UTVhTklM?=
 =?utf-8?B?WE4xQmI2K2c0TFdpYytpT29UeGthMmVrdEVuQzUzZklUUkVNMmhNQzFOWHk3?=
 =?utf-8?B?Sll5SG16V1lseUtSQnA2OTNzZGtydkU2SmVMMU15SzlWRmZTVkRqQUo3bHRN?=
 =?utf-8?B?QW5MY3hSMTFIZDdZU1pvVHZKeFJrVmR0TkxLK1dVcW92NldnK3VaNVJCTkZl?=
 =?utf-8?B?ZHV6alZRSlVYcE96ZVZ6T1dkdWNyT3hYNlJVVHpTS3ExSHdna1RvQThZcXZI?=
 =?utf-8?B?S0VSaVh3dml6THUzcmZPbjQxRFZ2dElIYW1pSi9XWWZmN2FNSVJZK2w2MTcr?=
 =?utf-8?B?R0JUeWVSdHk4cVRRUUJPeFhZeTN4Z0t6ZVlqZm1mRWU1Y25pSmM1N2hRMHVo?=
 =?utf-8?B?eDc4QXFGbTJMeUw3NHVGQ2J2M0J4L1VNTFR3K2g5SG82RVJMSEo3S2x5QjBE?=
 =?utf-8?B?THV1RjE3YlpQTHVMdU1PVWpjZ0ZHY08wVWx5bmdKTXdNQnZmN2ZHczFIOGdT?=
 =?utf-8?B?aW1hZytNalpLU1pCN29tV25CMzVMRXROYzdMWXRnSURyc0tSOGJ3Q1lGeUpq?=
 =?utf-8?B?dFBreDlDcnlXQ2h0b3RoYytSNkx1eHBRWVBzalVZWTNocGt0bU5JbVQzTlVI?=
 =?utf-8?B?VmVXV01uTHRUd3Z1UnZhcFE0R2srNDg3SXVvNmgvZDhmdnFxNGgzUGJEcmND?=
 =?utf-8?B?czZIWFh4dE1nTm9LNlpydWdocjlNeVYzTGVFS0tWY2JRTElWMTRzQ29kNVdy?=
 =?utf-8?B?ZzFEbHR6TkhTWTJLaSsrT2QwNFFrc2NSL01iaW1OUEd3YTdjZUpGNE1oeXRD?=
 =?utf-8?B?eFRWUDRzbGhlQnJMSVBhWFlnbUx5TElVZ1Y1dDhZZE82YzhhT09KZWhZTG50?=
 =?utf-8?B?emgvaVh1UkRFOFVnMFN0ckhlbEcyUWEyQUMrZTRxNXJIZjZmb0JPb3V6ZUFF?=
 =?utf-8?B?dFhUNG1pNlZjbUt3SlIvZkIrZTFaZkhBNHNXMVFlUW9LK243QkNoZXhFMTdV?=
 =?utf-8?B?NXFHNXhJSitiM0FSWlhLaTV4VkhKV0g2azlMMHRuTVdVV3VsaHJEcEk0TXFq?=
 =?utf-8?B?SkNFL3hwTkt1V3FlSTBySElReWRNT3BqRjRORnpmNFNEMHNOdldrbUNvdm45?=
 =?utf-8?B?cHZXM3daUkllVUY3dTFOQ0xUU1pqRHZFOUppaVMrcDl6NFRQV0R6eGlscXlx?=
 =?utf-8?B?ZElEVXpjcTZaWHVpRnhNTmhOblBsZXJXTEdzOU1HRWd0MXl5VHVvTzFxQXVE?=
 =?utf-8?B?L0UrcjFTcC9UMk5jdFFEZEorMGNaWTdnL09ZMStHUjlvMEd0QTZiUEdNdE0r?=
 =?utf-8?B?dWxGWWpzcVNIZGpvSDhyTWRPSm5WWXdjcnBUMnlaOTdqRWVOaVYxN2xudkVp?=
 =?utf-8?B?QzR4b2g2WWpQaTlra0czdmFMdG1HTzdRS01ETHVwR1hpYXJiSWNRSktBZFd2?=
 =?utf-8?B?eW5CVFlxeDhSYklINXhLb3BLUFBlQVVFWEVVSHJiNDlPZDZQdkRkUjBDaVpp?=
 =?utf-8?B?R3J6TlFXOHQzYmtSakdyTmd4SnZLYlFudVd3emhFSnU4di9HRUFQd0RGZ1lL?=
 =?utf-8?B?WlZObVRhZ1RyRjJORDlpZkJDVEs4ZllPWmFYeWxrTTE1aDhOY2FXZmZYaEV0?=
 =?utf-8?B?OVNYODZGZUcxYk5KbFVnWkVuOUd4SG5keGI0YVlmem5rT0RVb0RVdHFZSlhl?=
 =?utf-8?Q?osFLNy?=
X-Microsoft-Antispam-Message-Info: vz8uEb7Aw5aQdqAabOzBHxBTUVxbmWJhRcNNN7N1RA6MvLKQMw4aYHB/9lyuwPYI1yEW6PRbkil2ymamBO5WWa24A9L4UQd04XvoXUEBABADRiPQ9wrtAVa1eLpzpiY0CU/AWJ+DCChTRSpTwVQk0glr/zl9x5jgQdPuLe9iNvmgNWK/uQoK/xJM10EID0sv
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;6:hv/nwyROFHHb8fZhrdjTT1UMO6Cwg+GsY0K/c84txBauPk33o8nn8rVQvPre8PRS0cTFzH4CbE5pTX2P2PTW7rrF2gclA6qssMSJi5x3CDsw/0xY7EGBjmcS/26sDCawoZQJ/b7/H60SAF0UeSgdQaa/wR9F/Gg28DuThPlQOKDS0qcaH5/3gIhsq6TWYAJiIQ4OGK6+qxx5H5493sb/0muQf/FimayONvmoHsJKL71SRir2WU4fDu0lP5NX81RlzuOSTdW/ilcEUvgUl9iSxBsg9nrbCB/mafuAaOFNwVI/vOg3JL2iIb63FygMY0mMFl5jZa94lF8/6CD3eg6YvtabOaymOml5KIWuaOFs5LM=;5:6bfXPW2A5Xn43pLYCnY1B0jJSPF1NaHracjZ2vqG2frAdE2UwpQl0YAS7Ffjuicyln+gCTqbDrbHyqww8IkwpgXg6MZqx/1kIwChUP2p5NtcfKGgj2dv7mP7SlJsUGa/k6ipxcakgi9HPgtMO5qPD+30yyRT6p0VMeHlzWT0pyI=;24:hO6kxnXpe6A4iVPR6OzMwvoHQ+TSdR+xCDoBVNFRReFL8X9txT7x+30tHNz+A6D0fZ0MO+jB5dxPQkGOho0FJLKGGYY0NZUIgYRxEWB2pY8=;7:71W59UKFEHNpUYwsymcoDKiCDoWfjA/fYTvPOQnv+Bwx+hhcd27lvK+Fr7SsrgcVZQuPUMQVm5sxk79OHh71lLbFon9+eqWCPZo36OvSnxJhghXm0vL/iegxLrAEnqmyoLjjVApCB7o+OXPy6ZkBqB5cdHUYSZigP9/bRMcjx3KzwJFGZEVivTrA6yyLn3bGebJiGnwfKb9A3lgN4M8qpO+U6YVelwKNJKZCoS9mabbiI28zDIMkGHX9DZG3h4P7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;20:u5IIlOhrF8o3pWV5GHs8xpvj/fud/ikYWmZ4hTG4q7QRQlD8scbZCjpqnUvAStlll4Iik7uGXtfF8/QvTZ6RyMqJecxK+FtJAVKsICGCvzw/pDGEHI0wE9UdDBV6etjn6hqLSiAPm7KmTnpxFAXZuan66zZqGVnHVjK0I0wpuZLXudUTPYH/aUw4KJJ4HNl9aKFJVDLFj3S2IOYLbIjPesMLl3tZZlGLhU2d84XApD+R+s1i9X+t3TLwrtV/k75x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 22:06:51.7110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a3f9ae-640a-4148-7f1e-08d582e5666b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 4:28 AM, Borislav Petkov wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> Avoid loading microcode if any of the CPUs are offline, and issue a
> warning. Having different microcode revisions on the system at any time
> is outright dangerous.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: x86-ml <x86@kernel.org>
> Link: http://lkml.kernel.org/r/1519352533-15992-4-git-send-email-ashok.raj@intel.com
> [ Massage it. ]
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 63370651e376..fa32cb3dcca5 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -486,6 +486,16 @@ static void __exit microcode_dev_exit(void)
>  /* fake device for request_firmware */
>  static struct platform_device	*microcode_pdev;
>  
> +static int check_online_cpus(void)
> +{
> +	if (num_online_cpus() == num_present_cpus())
> +		return 0;
> +
> +	pr_err("Not all CPUs online, aborting microcode update.\n");
> +
> +	return -EINVAL;
> +}
> +
>  static enum ucode_state reload_for_cpu(int cpu)
>  {
>  	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
> @@ -519,7 +529,13 @@ static ssize_t reload_store(struct device *dev,
>  		return size;
>  
>  	get_online_cpus();
> +
> +	ret = check_online_cpus();
> +	if (ret)
> +		goto put;
> +
>  	mutex_lock(&microcode_mutex);
> +
>  	for_each_online_cpu(cpu) {
>  		tmp_ret = reload_for_cpu(cpu);
>  		if (tmp_ret > UCODE_NFOUND) {
> @@ -538,6 +554,8 @@ static ssize_t reload_store(struct device *dev,
>  		microcode_check();
>  
>  	mutex_unlock(&microcode_mutex);
> +
> +put:
>  	put_online_cpus();
>  
>  	if (!ret)
> 
