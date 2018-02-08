Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBHVEI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:04:08 -0500
Received: from mail-co1nam03on0064.outbound.protection.outlook.com ([104.47.40.64]:2496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752054AbeBHVEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:04:06 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH v3 4/4] amdgpu/dc/calcs: Support clang option for stack
 alignment
To: Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
 <20180208205316.93330-4-mka@chromium.org>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <953daf8c-b195-e983-ecc4-4b369515e9ac@amd.com>
Date: Thu, 8 Feb 2018 16:03:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208205316.93330-4-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: MWHPR1401CA0003.namprd14.prod.outlook.com (10.174.253.141)
 To DM5PR1201MB2474.namprd12.prod.outlook.com (10.172.87.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24b6fcf4-6cf5-4d0d-ca86-08d56f377c44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR1201MB2474;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;3:n5GuSvao5eiroAXhgPnpBzSku4I9b9yUGMFryFDdASSBr2aCH3KuOEDCzurHh7zKddLCM8xSO4IBTAVeAcrw8aTCydbFr6v2drPwSi2Vt8T5pHMIvs8s/uaYSHUb6GiZk0oEUxchETlp7E6Mx9/ut5+fEU1XVP/gQHJDPLGkb5sFKK4BkuPrRcS79iO5UVvTb4+ne5xWqVAVMEYJG+M9pCzE37LKVTJsV7tYnhSyjEhc3BaVtl2Sk+Am6xiri/R6;25:sT5aPyLlAYuLEn6LSb48XSm+9T1o7vkNT7KMXTHM25iCzhtHk3rf1hXxwTCioX2IU39IHPpI1eFFkj/ipapFKKKKLMptT2GSgg26oY+8nPEqJ3JpVvN8mGPC3fskzKQpyVbW+JHgsxlEYN8v71vp0gFcfqQ+41kEnbrw/y432rFcNhEx3krj7OkHk0CEYfVQuUhO60fPgYGDcdl3CROPXpqx7bT2uYHyGfxLc/SNoIJh+kMx1vr67ZsRukb0r/fqWCjXF+8iR8hRz4nxjP9x1D+hi/w2vglPc4sBDmfQufsXgTUk80ynXJRjDegSfA6rZC7pv78Fxtkn+fJId+hP9Q==;31:yNmEmedFGr+9AaT1VYEnpvnUnMw+Epvb2Q7jxeYCrc7O7lHgAHsO3M03KNh0HAChtiU3eMpm+VAgpNODdOigvpemwVOCNchHMZIK3wX2s5rVzaP00N3n3UwQSDyVgy9Vn552kiSXtFt4e7tcQZNp5fIMyQ59wX2bL+0dfbyDuS8b94mPT6v/j45cYs3clgZYFSC+g7YMX+XKpvsv2PAsMgsIV76JmJjG3OY2E1P4xxc=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2474:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;20:tXVlZi1ur/8RbYRoTJxOUM6fOjFs5BXi6SlE1NjhGEI1etCy4IjSgtSdDdjDPDKLF6GHC7M2pI9yAl/B1gJjB2XXvz4zu/FZdQCcDI7xkislxwcLe+S8Gao25qpg+T6Sa43XUWY2+2OegU3sQZWaXtOsxiz1OXhcAawEClABn6X56yX0V9dqsJ1QGCrSUn3zQt3UlSqjmt9sb93oJP+RjcOa5A/ziYCFKLgrkSXT+y4JdUJ9Bf5oI4YUQi+aCQuh4ycXNniinOYyqoGFBGLKm17QN8qZyfT+dvnY/r7DyQMFtXUNiIhJBJ2YzcS3XoX8+p3MWQLIqgSFALaFwwXG5NVImkjL0WcZ3kjAAXiPT+C78U0adVEgE5qOjhDn/1B6mDBeg2ZTN+AUcWu5OlVFY9nXZmLyOMNw65rkNQ/YPUPufTqZ/ovuFQY7Ahxm5AmsxoxdzFE6jQZ8cZxdmNKJpG18jI3atAwrIG1j2WCHa5x0tiW0IsSEJfATsuIoWaXK;4:/ry9vqTnpiII4tMvkNVYIT77vtfPyYxJdqPijBexG7F8TwQGxWeNoZ14cdvUKBZlQUAYbetpUlUZu0ityEKmCkmDLhxaZanmVcqztA1bHpAOsMjq8kfCGkN5duSoFy1lYfvqx3JLxsx/ZyoueeoyPjE+C4nRgsZMAXddCFB9pxRoQQ35UQr1eRvvX62nzNyIAfPJy/P6H8fWcbsyOg0SjVuuWdHJKbNyT3y0x40yzZYM9o6grBXvfg4BbVfo0knEFvH8FQJhcahB96b6dPCtOChvuZyCS1A639TmeAZGbZ19Rd9iqF2Vca0dfMkwLSVJ
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24742B41F34F40CE72C7DD988CF30@DM5PR1201MB2474.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR1201MB2474;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB2474;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(199004)(189003)(377424004)(575784001)(86362001)(4326008)(3846002)(6116002)(54906003)(6636002)(110136005)(6666003)(2950100002)(68736007)(58126008)(36756003)(83506002)(7736002)(316002)(31686004)(16576012)(6246003)(305945005)(81156014)(97736004)(8676002)(81166006)(2906002)(105586002)(90366009)(8936002)(65826007)(6486002)(106356001)(229853002)(76176011)(53936002)(72206003)(5660300001)(478600001)(52116002)(65806001)(77096007)(23676004)(386003)(230700001)(53546011)(26005)(59450400001)(186003)(25786009)(52146003)(50466002)(2486003)(16526019)(31696002)(47776003)(64126003)(65956001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB2474;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjI0NzQ7MjM6dGtzTllzdTM0YjNTa2ZPdXBaN3VBM1o3?=
 =?utf-8?B?NDV3RG90dGM3K3Z0YkY3NmdCRUpqc29KUmhwbUx4QlBackRCZ25xVnpac2xM?=
 =?utf-8?B?TkwwZ2lBZSs4Y2s1QkNvTklmdjFhaG5ZZ2dyTkV5RU9YcXZTSVlwQjI0cVVv?=
 =?utf-8?B?UkQ3ZGpDL0dJK0JUVitVL0JWN2dqcWJRWnBuMkpvUTkrUEZ5M3lWUE0xWkJC?=
 =?utf-8?B?TmFwenFJUHpDbk42Ync3Uk44WGlndnpZRE5RTjBuUUc3bDcwTTBmMzN4M25m?=
 =?utf-8?B?TWc2amJkQXI3V1NaRnlMMmN3UmVSTDJrQ2VKTFNDazQ5SWI3TWJCYjNzT1dR?=
 =?utf-8?B?VGErK3Eyd1VtSjZZeE8yMS9PbFhqcEdNNXRqZ0xyTnBGc2VnWkRid0twRHZz?=
 =?utf-8?B?WlgzaGdYenJqSkRoY2l4VTM2MVJsanlmMXR2SG00SjUwQnUwS2V4amx4VllH?=
 =?utf-8?B?WDN3RHZ5VElIS0s2L2JpaDVsK2cxZ2puYnF4Wk03T3V5b3ZvQ1o0MVNqd2Vx?=
 =?utf-8?B?ZFcrT1RrVUxOaEh2RWFka0lIS3VCanZIcHFLWlZRbTFxSlg0aFdETHphcGZm?=
 =?utf-8?B?dU9UeFZrMk4rZ3JFVkJuSDlDQzF0SHk0QVp5Q1dEejhLTy84MW1ubGtZTDlZ?=
 =?utf-8?B?cm0vajdFcitkZ3AvbmViUGR2WllzaTlITzEvRnhYQ2g1V2lnRUx6bHovdzhP?=
 =?utf-8?B?MXYvVTZuUXowK2VxRU9mNkVjRVNmMEhMSENZb1V2dzlFdjJqSWdvcmhCV0RJ?=
 =?utf-8?B?TktsZGk3d2Q3Wmp5enVGbm1IS2NOR3BQYTZNWitVd3prWjlVejhDTzhtbUNh?=
 =?utf-8?B?bUVHKzc1SXNyY1BZYVdMbTloazlidDRDUk1Za3JJME8zRTAwWk9ldFQrNXkv?=
 =?utf-8?B?SVU5T2xDSlJFL2JYZlVrMU5XdWlIdmMyTjlCT0FPYkZzSG9mUkJaTC9QVWI5?=
 =?utf-8?B?cUhZcEhGaFVlTUYySVYyWEdqSFQrUVZHWUl0aytibEl2UHRncDhvd0xRUnJ5?=
 =?utf-8?B?VXNEU3ltcEFkWmxEQ1c1RWU4TGtLaHFpT3diSUt5TGhwS3l0MUVMOW1oRmxK?=
 =?utf-8?B?cGZFN25QcVl4OXk1U3Y2cE5OOXFyckd2UVIzTmZWenc2TVBLbEg4MmJhT1VN?=
 =?utf-8?B?bE1QMG9KSjZXbGpZUlhqSmRqMklSWVVFUzdGdVJmcys3Uk9IRzU1UkcrTUxE?=
 =?utf-8?B?VmdGdFFGYnQvbko2aTdFVjVSRkxiYmpwUkZjaDB5UDRrM0E4Rjd2Zi80VEtF?=
 =?utf-8?B?UkdkUGNlTG5iK2pmMklwUkEvOFlmZEV0anJrTXQxR3RpV2xCU3BYM1Q5cEND?=
 =?utf-8?B?WGRRU2poZVhJOVBScXRrcUlZUFMzR3NIR0ZBbWprbGplT1ZZeEhzZUdFclRs?=
 =?utf-8?B?RzBIQ3lTT0p0K3hxZ1djRHAycnY0aHhSWThLOGVpYWpLMVRremJySDA2RDc0?=
 =?utf-8?B?TjRtS1VDSjlKM3pOdnBtOUNsMVN3Q2pRSTdUWm56ZmNSL0FSVkJ6MnhzZmRP?=
 =?utf-8?B?bDI1VjJ0T0Y5TTR4bWhTb1Q3Kzd5VXZPbnhCL0NFWUZWazUva0kxQTFpOTV6?=
 =?utf-8?B?bVhEZXZrVFU4WE9CaXlBM242ZUtVelpDN1V3WXhDUE1YdnRJbWU5UWpLbDZo?=
 =?utf-8?B?ZVA0WHBDUHBwVFhiaWMvNjFXeFdtQmtzM2pLYnR3UUJNZWdqajkya2IwK2hF?=
 =?utf-8?B?aUFDYzVUZ3BtT0ZBcGU3SEZnUmVveFdSY1BaMnBNT2pNbnBZK1hkR3MxQ2dT?=
 =?utf-8?B?b2NSVy9LZ2FKR3EvYzdtWDdrOVl0czBEbmNORmg2aDh2aC95S2pJVUR3RTVw?=
 =?utf-8?B?d3BHS29HMUlkY05RQktxNVRXZWdCVEhiV0VwR1J3YVlScUtBYVlwNndiWlRl?=
 =?utf-8?B?ZCtFVWpabzdqNS80ZzUxdCtnYjdCM3lRMG9zM0k4eVlSM1lPamlHQnhmblk0?=
 =?utf-8?B?bG5SOUxtLzBPSVBzRGRVZUhLUVB4bW5pVS9JWjIzQjlHOHA1QzhYZmpBT1g2?=
 =?utf-8?B?dUxaQU13Y294Zk05TWhNR3pZZTRUamFaekpManV2elBwRVFONzhSYmVqRFlr?=
 =?utf-8?Q?6X3r4RAn7+OfgkKdWSOphG4TLZp?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;6:eoGnWOfl1QhKaD5O4fdvbLLWJaaTceTPmDkYaXbhykdhJxZZMS2j8nH996KQEI4aTBLp4wi4Qw+X5EcnyAa4cP9XKsJiep3hKum5ctP//5WUPjWJQ9lYQVEyHo8A8K9cxS3iqEwTEyJAUHeZ2JqmD5UtP2X7Jm8/MOWWEaWMN2FkqDfzBCHkbACVv8oIJBZcDWSeyz5CsLN8b4FF+l1HPVCggZUlVRxJDyYIe5Na9V7giL2Q3WTpkVbDZikfKYXDTSilrIkCYhsiQZz24Z1EP/72A37KqXsPZzLkXAqDCZMNLLA4zTEJ/6vQE0kqJ+M7JG2V+cyqPNT56GUPZWyA9aCg05iRHob80zAwvEHvixw=;5:DvnOjdk740jBGR6VBhYq/8L9aGvbGXDb1bOjlIjrDJ0T0lxWerpz5l0dubi2knIrFCxR3bakJnmiAVDHsOKD+sQyDyE25mWk7MIh2D5oe3EShDK16/6WVkr6Imt/oa9dMM1FCljv7PEU8MhMCOuERSfTYWIYtZM6ply5Hs+qVss=;24:CGqm0AYsHynaAKKWGxS57AihgKMuBSnGuY0kuw7MRF0obEsW1Qwd2Jt7VhfxbdMdZkebq+1EdRViuc6IQrhkTOZsqLCO7trUI1w/j0F0G8E=;7:uvMvSL+fjz2a37xi6XbEhrPEWN/yx2Yc0QBG1JaQMf4Y71CPvRh5382KsxxW8DE+uHx+8MjM8hiIz9qsxZNRvND/DwC2dwTpf/8XCdF9Tiao2/KwHC3G2bH0R7eQsU8NAi3pDGjeLZ1Ud5qKojCs5Gy7FDgZwzz5oVYL2PxEw1TmX014ibWDjtskKj9+vzIewtpRL0Uf6G64jX5MSiYQq4qJbEXIojbK2PaDsGenC10t+oJEo5Zm37rMOgeTy8/r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;20:DeRWE7ZVcy9J6gl+Q4tGx+jp85eSgJH2sP3JeEMsoIoPyIgRg2b+hSC8AfWnvfRMXDzkN6344uYeBin0m6H9pX5nTkbktjRNEBf/HRyJxdniX/5T1tW+COmZaJYLJLSeiMve/AfPR3lkNzPZICL8A+IxhK7e5DlfGdDa+aCZXij9j85l/G2jCf7+1r8COD28HCXff+4JgLJ9crJi/EVOlX7Oy3xugdi9AOdnpEYghrOZ/J3u2lP2sUs7zbhWhprx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 21:04:01.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b6fcf4-6cf5-4d0d-ca86-08d56f377c44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2474
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-08 03:53 PM, Matthias Kaehlcke wrote:
> calcs uses the compiler option -mpreferred-stack-boundary=4 to configure
> a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
> instead, which expects as parameter the alignment in bytes, and not a
> power of two like -mpreferred-stack-boundary.
> 
> Probe for both compiler options and use the correct one, similar to
> what is done in arch/x86/Makefile.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> Changes in v3:
> - patch added
> 
> Note to self: if this patterns proliferates further we probably want to
> put the evaluation of the correct compiler flag in some common place.
> 
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index af0f452f3c9f..95f332ee3e7e 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -24,7 +24,13 @@
>  # It calculates Bandwidth and Watermarks values for HW programming
>  #
>  
> -calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +	cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +	cc_stack_align := -mstack-alignment=16
> +endif
> +
> +calcs_ccflags := -mhard-float -msse $(cc_stack_align)
>  
>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> 
