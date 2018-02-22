Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933622AbeBVSKh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:10:37 -0500
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:9673
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933441AbeBVSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:10:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
Subject: Re: [PATCH] MIPS: OCTEON: irq: check for null return on kzalloc
 allocation
To: Colin King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180222180853.11505-1-colin.king@canonical.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <dba1d5b6-d568-c1a1-5e6c-7a00da3d1e01@caviumnetworks.com>
Date: Thu, 22 Feb 2018 10:10:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180222180853.11505-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR07CA0018.namprd07.prod.outlook.com (52.135.222.31) To
 BN6PR07MB3169.namprd07.prod.outlook.com (10.172.105.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb65caf-91d8-49a8-0984-08d57a1f90f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR07MB3169;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3169;3:oZoA+VlX6MvGPmq2H4ElBxyGBMRMWuFC1B++aJFLiD75rtS5uOO7pneAiopbTPXYzgIGtwpNM2JVAu57oSp2ddghQjOTS8uurgqEst+b7sDTgWPS1STBne+AkbdgBr+onr2LdeuLCJJ9QllqKWwqR6BSMBpMSU/uykSrD9NIGgLdAxAaGwHEe8P3VphYQ6gwPwXhlOsAni+eYIQf4zxwCxTIA1WrOCL/uS57HReBokbu5TSo3tSNwOe5TKax5DZF;25:8cVl1RVsv4SwGCepGL1bpiLixwOocdMltJNPxbhqbOWdLee4kbYFbwG24rgWJvVqIKx7q2GKarsF4orcLsj9FG07yveqGbmOaBeO3Mi5QJrOMaCLyfNzWgPTnnGTinZvUEe4ZxGrnprRaatVgzvcVhVAk96/p7zSLORAE4EYWxrOgPsfXe26lln7IxKM8WJ+GBNXfTBsoHmcYAGvDKG2ccub+aFG7MaTnK68c4IYCaxzGF6ZAyPBi5cbzpfLaZBTGLp5WlEz4haZGlM0UjI4u2WXN+hwlGYnYrS5XtDOqohCHdbdnZDJAW2f1AKHupS+vu9FvoLroriNIt/5Qzi7eQ==;31:v9ZoxUw+IK1HWvuKP+2esfzcLfp77FY4z/dMbs4eS/vQ7Id31wCunHDt/i1u9xCFyGjF+2SbDzeGPoXn8XDPhL3+o7POWxWlnl/tYWn9pNQ5grwv9Ptng9xmYAwK5THLh5t4coSYWhXY0iXMRA0sxN3l0dvKsugvV1uLd43m7xV/UBoqOLiKVoRGp0/2JdrXUhqw+pvjHMOy+UPPV/Idahv8tQrW10qOaB0hRCu1htc=
X-MS-TrafficTypeDiagnostic: BN6PR07MB3169:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3169;20:/FBLbMaKS5N9NrAROtfaPeDZnA7ufzLeJqnqxFQeFpHJiXBFQmzMXXCLXcHnfmUE66jT5/rRG7DEiKA8OBsGxzCfJau+AKd4U31p1njykpnQMW/yPq9clfoFnuh0tcXB9mTzHnbM15Wu5HBh8HvtBOgc2C7QnavZjQSgynqCEW2sAhL0ThHsYy9lhF0Lp6JHApswQd40cRDt3BN8X59U93Kh6ThchBUyZ2xbb23GQjJoxL2wsN+wrnyKrs8M6rcl2r8jKKJsIwfoyjS6C/SalK9U2mbzHbtFPsGQBi4uKJ5AKOolro27CQ08FHrft8b1JjJ5O+rYoYtAtGazpur842eVoZ6DodcpRexC9aTjbEyTfAUmCR9YvlhTMi3c7hmqkSL9LwcuFYQtD6DOV1sxV/Wd1eNROXjBAzzuWZW4QuiybWyAI/dy/iG6a4cQePbav+jbujdGq30mAjJD3yLGv0MuKP6o2gF8KFYCkBWCMJj46ZanC4IXpSaChST5QLHEsLKjRZ8DV6H37wBZEi1ZO0tofToQZ86WMkl+qWR2G423wY4R9aozkxT2iIaBNpTQhXPRTVmjxAuGdRYxbGqCuyrzMxI+DH7aU0LMUGpCQls=;4:c0sSNiWNVUNAxp7W6j6aFIwbpd1jzcECSS4ReEy9qST94Q4XKEwqtWETtGpuL8ihNr+tfm1HSdq7Dob4R8eJCEQHSFSTJRIDT2b+pcJ9+0pULbyyl1hec/3XMCTwTRiR5SATy0Yj+bii2IfNhONwzC5Vr1Djcg6l5BY73gNji6/tA9Yi59JV72egqARQocKk5ZvNRQ5Se4xsCTYxXKKKojlywnjbBy5blb76rZgcmRw8RjWRwiUtemJ8K5PrvsiMi7sOyapccH3P9Ts6Uanmy2oUak5tzcQPAViU5qtEckVgCABSTyqzXC8C+6QbyrsY
X-Microsoft-Antispam-PRVS: <BN6PR07MB31693BC8BA2CA9211B52555997CD0@BN6PR07MB3169.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(93006095)(3002001)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR07MB3169;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3169;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(16526019)(186003)(26005)(8676002)(81166006)(81156014)(47776003)(8936002)(2950100002)(42882006)(65826007)(76176011)(5660300001)(229853002)(53546011)(72206003)(230700001)(3846002)(6116002)(6506007)(67846002)(386003)(2906002)(52116002)(69596002)(2486003)(36756003)(52146003)(6246003)(53416004)(31686004)(106356001)(4326008)(478600001)(25786009)(6486002)(23676004)(31696002)(68736007)(7736002)(53936002)(64126003)(58126008)(66066001)(316002)(6512007)(110136005)(97736004)(105586002)(305945005)(65806001)(65956001)(59450400001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3169;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMTY5OzIzOk1RVFhDZlQ0eklFQ2xhNmd5eit2Mis3a3Jk?=
 =?utf-8?B?RHFUelpkUEZuRUpZTG9iQW1TWEVhRWppc3IvTE82em12M0RqY2xjcnlRUnFv?=
 =?utf-8?B?U0t3akExN0xEbGhWeWxtcGVwK0FqUWRENGtaMGZoMTI2M2ZMdHEwdXc0Z0tM?=
 =?utf-8?B?RDdVSGczSHI3ZmRoTXRaMFFEMU1ER0pvWHBid3dKT0ZWZ2lLUDNmOUJSK2FW?=
 =?utf-8?B?VkozalUvMEhGWVg0NzRVbmdMOUdSWnM2RnRuNWV3VSs3ZWdSa21vOW1yTjBV?=
 =?utf-8?B?M2xIb0VVelViaW1UY3hZV1RUa2FCVFV4Z1dKMjh5MmljTUJvc0FtdlY2R2l4?=
 =?utf-8?B?NUpyMmYvcUNrWTJ4c2F0WStCSU5xVXpFRU9pcVVHN2xGYUU0UzNRZDJjenNW?=
 =?utf-8?B?dkNySitPZ25EVTB3bUd4cjM3VCtnUUFXQTc3aEllRU44WjVFNURYN1R3WC9w?=
 =?utf-8?B?NkpkOGlpMmtTTkM1VnU3YnllekwrNENUQU10RXdYdkdNS1A5SjlqUS8wOWhG?=
 =?utf-8?B?WlRHYzR5STIxd2krb25kWEFoenRrcHZJcVloSzR6dG9qVFBDeGFsQnFDUkw5?=
 =?utf-8?B?VXNmY1BtRVRnUEhkS0NNOUplcVFMWUtpbU03d1FiM3lQQzEwYkllalcwbkdO?=
 =?utf-8?B?MlNmQU56YkhnclF2MmM1aS91cWYwVjhVa3dhTDZtZERkNXdsUkR0SWhsZkl4?=
 =?utf-8?B?RlpDL3NIVDlXN2tVOEluMmN3cWZCZ3IwakdYYjE3UWRtSHNTWHA5T3Z3aGRy?=
 =?utf-8?B?dUlYZkZpb0dMd1c5d2c2Wm8vT1Y0T0V4WitjSWpSSGE2amNad0xkUmx5U2k3?=
 =?utf-8?B?SkwvM21sUEFyZDYyTnJ0WDM5N2dFQnZzRk9BMkdGYXArR3AxWmF1TklJK0tQ?=
 =?utf-8?B?azJQazNmbWpCNHJpdnR5clJtMHFkdEJNN1k3bDJBQVpRUndmbFpzSmo1RzFX?=
 =?utf-8?B?Zmk3TXlnVFpqVkFUN3dlVkFIS205RzhVY1o1bER6d3d6bTcyclBjWFdOZk9o?=
 =?utf-8?B?K1UzamQ3OXBWY2tyQU1ndWFLUS9DV3JLRE5VdTk0dVhYRXdBNTJIYUVhZmhj?=
 =?utf-8?B?L3NWbzNpR0grUjZYTXBvNHFVblRKMkJteDQ1dEd0OGJieUxlamJXcHpwUnR5?=
 =?utf-8?B?OHRVeTVZUitKZXBPamUxbll5YU9NUjRIUXd2WmpVN1JsZ2NuWWR1K21Tclpa?=
 =?utf-8?B?TUhrRFBuUXRnNi9xL0w1RWhFUXJKN0daR25KdUk2WVltS05IN25XOFhKWEd3?=
 =?utf-8?B?SDV1MTdRd0hNSmNMQzNlNjJLaGI5WWFvVnN6RkU4K0w4NEJPVE82dzJVRmE0?=
 =?utf-8?B?MmozN3g0c3Q5Sm5rY0YvMS9jYlRkRHlRVzdmNDUyb0YzNlBhc1M5OGtzUW5F?=
 =?utf-8?B?L1d1YTM2SzNmekdRNEFBYm5GbDdhODRBMFZKM2V4dTZJdUF5VjVoWGMvT0RP?=
 =?utf-8?B?NGMxWDcrdVg1RmtXYTBtelY0NmpqMzNjNnR1S05PSHFON2U0OXF1YUJNSEgr?=
 =?utf-8?B?UHhiNTZFQzd5M292d1pNVFBHOWozTnhXeXdCU002bldzRS8vODkwdERsbjYy?=
 =?utf-8?B?RHNGMS9QaEdGbDE3ZjNzVjJSc3luVjY3emxOSG9VL2FtTzU4d25Gd3hjT2ti?=
 =?utf-8?B?Uk9DOGdPdmxTdmR5dU5zTkpLTG1DMW9xTUhNc0xyQlg2MkRqTjRZdkVnTjla?=
 =?utf-8?B?bWR6NU5JTXV2V3BKVE8waThEemtmRkhmKzYvNjFla0k5SjBYU0tSSlR4VHFV?=
 =?utf-8?B?ZjZKbXhpenVBVHRZdS9TWjNsWXQ3a1dxRkFGN1dnM0NLS1pQekpiM3lKMldu?=
 =?utf-8?B?eWNsVUJkUVlvWTMzcUN0ZjhLMVNjeHNyYmNISTZuQ0R0UWt4ME5OWlZKUDF2?=
 =?utf-8?Q?k6ajIxWR91ZuQUV92Z8Eb3szKlMfIITI?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3169;6:9fH24d0vBhA1eaB8yso7OKKQBCPwfmdIitNu6anCVY5sH4HAk+eAsNFMcR/ohB0fHLCk6B2g1O/CrAGuoheVCACOIrJxh6gvAlZ6eb6UP1p2Upjk0g5qt/7kIlOuRYEka3jXJ8ZQr8KRbRJxuSNorqMEgxl8PlXQkY2WmxoR5C/qexu0ors/9pOMkBUt2+qcuBwRwMLCdATpdfw1JybORHmkMadhXpbXSxYV2D7gLSW/ESHqPWnjoi+hVz6YwgK7veZrPM1GJQ6KAB71AoVCaHnHcVmecyH2u95LVoX+B9ArDkBpw62gJAsHr4WS0TeJD+pNVt4JFrIGX2dw4zFJ6DYxVRuVuEnz0DqRzVH9BRw=;5:AtWRXd4q9CrGr04978+a8GtYp9orlqZTet7K0MlCwkw+cnOGiNDacxTmYl84Nrv60kfS78TzKR/c9Ss2ENXpXrmtvpMQl90RBz3Gk6tovsyXaEbpzmAZsN1LeiRcsVVyasJ+3mGOTy7mouV6GrN28wn3hSljGeFu4hCNmORwO/Y=;24:yT0rBZYqEm6n9lwS3tLk0mhku36zSHYExn1JiKaifj/bCoMlo0lBtbCmitd4ubxgGZ/pzLiH6+JAgz5yQmaRxC5As9nP5vyaIZsJJxUcO1s=;7:C96xJ1Wm85ctheBijXO6QqeAi4NrGtK0AP/vF+BVMxTK1JCl+3dJNP2xf50677L1VO64g3jxmxxWv7y6epoZownPM0DKTibICh3POu8vA/MWwilKXcljBUnXdC1J8EeEElZoQz/2cTBrCaYZZC6DjEg499ZXCf7JIrvWerdtihlnqlfBHKThWrrRy9nfPUN0LxxTDoUr+yYK9Og/hv9W86if0Nch9H5HNGLZqDZ48rGvJO6U7hkZlsJ2jFGQnIHc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 18:10:32.9896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb65caf-91d8-49a8-0984-08d57a1f90f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 10:08 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation of host_data is not null checked, leading to a
> null pointer dereference if the allocation fails. Fix this by
> adding a null check and return with -ENOMEM.
> 
> Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/cavium-octeon/octeon-irq.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index b993d9f2c9b9..203e1d2a56d5 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -2277,6 +2277,8 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
>   	}
>   
>   	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
> +	if (!host_data)
> +		return -ENOMEM;
>   	raw_spin_lock_init(&host_data->lock);
>   
>   	addr = of_get_address(ciu_node, 0, NULL, NULL);
> 
