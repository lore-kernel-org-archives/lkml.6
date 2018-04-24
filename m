Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeDXTKC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:10:02 -0400
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:29612
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750766AbeDXTJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:09:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: [PATCH] drm/amdkfd: fix typing in (*hqd_destroy)
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: Oded Gabbay <oded.gabbay@gmail.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180424131416.1702-1-luc.vanoostenryck@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4a86713e-0ee1-35cf-470a-5b457554b5f5@amd.com>
Date: Tue, 24 Apr 2018 15:09:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131416.1702-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::45) To MWHPR12MB1711.namprd12.prod.outlook.com
 (2603:10b6:300:111::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1711;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1711;3:0gVHv99FD5RnndAXQs1GJrHu4j6a/MTEIVzaTR5uDxxPdw6SnzmV9deXCNEs4hhO0P0hfWLOrbTHiZEOgsD24ZdCF9gBcgEgKzIkt5uNNAixg/s9nWRnToFANMsf6EezXMi+pc+5dSZExGC7MDjA/ojE809YE2i9RinWsGITvO5nbCp8/ryBloK1Ou+zLygqso4jlvi03fvgwOSakNJNC28SQ2sDMemJcOFGtGCmp4e6lu8oo+kPuBYUZ5Xcutzj;25:iTTqwUVEiuzKiw/R+xF1bnz4hXCcyDwpevmhIuQaArGhY9U6KVRO+6uAcY/AVzOf2ionPwaXmAP+McLfrnWXn4ogWTHkkBDFhjcQGVZma7a6WYCaqSj5rViKcTAlAflNi4AzlPAzc7SbXQWBl9Rej/7yG8tkHxzebPSum8CFv9JyyQJuISXCM7til+vXLLECbJpCO0Kbgz/zTwIzPFJZnU+WF5v62PyNo1w3YI9GETPGLiGAHvvO2mQ8fIWum5aD/JI1VLIny7KJkVy8cR23pcMF89oLToYZQgsHCEiFGPv4iwBIqofXyiarpuXnWTG2SdBmpmGX1IV9aH4cz36Brw==;31:IlIQnvLx3ob6cVzzYs1VuvGAUN+l64ALhq6cqP7G5cOtM0p0vMj+8vgbb/pMYcWbGJAB9/yVU86uedLFe4xmXWeXd0iFXUFBNCad58b2pe3pIKgYJ3fXTjzKHkgQszyQw4Sz08Bbcp1CPnBu6xbNlFM5JSmsV5JYPQ/iDCGgh7Xu1CYLdMzMi71cdjH6g7tuEo7CuSaxI5SJqNSH/i/FSKuDb7bRjhDRQdIK135JjmY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1711:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1711;20:gYK6SiBb0K/AKzYotZqYVrzWzg69y0avgTmdfXn5KGT/NZ9NIoZqqdsQODq9R/Q839OvlH2RFCHY//yWSKjcseAMeCqb1MI0JAhRP/9L0ARld/GNdYEEJK6Rz2u3BPBQ6A/qpOmm2o5Sr4pfWHJgK5Gk/Bq2S6iXdCKa5csKVMqZLBRd71EUj43NE6dzHMCfxcg0Y0+1zK8HmAzU2LnYNLbRXyrJgWcWmR8bW3/gyR7TufH6LYwmvSXEMD+OP/SowcAMN94Ucpyj8HEEAcmHA+cJjVg2nCpgVH1gQ/3jpiLZgiFSkGrqGmHtgxSDYrIDOuyOH5+54+VYiRgdxcX5aaDadIiqPBFVla5i7cVTA/xa2yObuR1VenL/meq8YRzZlZ7lpG31ykJaZ0nBa0EJzHsruB35b5nkDclXThq2tXv6hbUdtoG3lhy3FnDMyw9I2RWH/II5E1UIHjJ+g2BJP8HxrjiQ3P+Dqt9r0BGg+MExSmIycmgs0zsZRDytVj45;4:ryQjx6p4fd3R7iyvUeMxcS4dC3xk+qaYcKhIFpb5MxnOLWKmgjhq01c8Z1uUAGcrXRAzvU+6frVIGlVSQ0WSZc8ukeWRtLvBEKc348HNygxl4Z3iF0xZir8vvwyLwwL9jxuEFx71PBoR0VJYKB1zScRI2YqU3+YlL8kNgy6DAxjRSKjl9CHWdvC284i3rpeT5vHvAXxm7NA5e/fvJygf9hfJRQobsVcMl3r0p1br6pyenvEfxiuMQmse7SaZSKQt8TOIXXplqrtXx1DEZRZODzi6GozzdGlJtL6YNdNMax2cTOBWRPRV7ctHhORA8Ye5unvTEnzr6lKQ9EQNFMqrhw==
X-Microsoft-Antispam-PRVS: <MWHPR12MB171164C7EAED77715B218C8792880@MWHPR12MB1711.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1711;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1711;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(377424004)(52314003)(189003)(199004)(105586002)(6246003)(77096007)(68736007)(26005)(2486003)(52146003)(23676004)(86362001)(52116002)(36916002)(31696002)(76176011)(2906002)(16526019)(44832011)(31686004)(11346002)(2616005)(956004)(446003)(486006)(97736004)(54906003)(386003)(53546011)(16576012)(36756003)(476003)(6486002)(59450400001)(58126008)(6666003)(3846002)(65806001)(6116002)(66066001)(4326008)(65956001)(478600001)(316002)(47776003)(229853002)(39060400002)(65826007)(72206003)(5660300001)(25786009)(305945005)(53936002)(106356001)(81166006)(8676002)(8936002)(81156014)(64126003)(50466002)(230700001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1711;H:[172.27.225.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzExOzIzOkFsTTh1NjVlZlVnbHV0ZnJEUW0rZVFUeVFs?=
 =?utf-8?B?OWpuME10SVJ3TXQzVzlhcWxmQitxVnJEajRTRzZKNTA1N2FxNUwzNEpITWRF?=
 =?utf-8?B?OWZBWFJpNVNrN0Rtd2s3ejViZ1RjUXVEWDhwQ0o0N0EzalU2ODZiL0F3UWVx?=
 =?utf-8?B?ayswRG5WT2lhSEZER3Jla3dFcUpEWjV2S25ZM0RxN2puUWgzQ0FFcCtTYkN0?=
 =?utf-8?B?b1QyRno3RFZqOVpnSzZQN3pvWmFMcXR6dVJrZGoxR2ZJNENucVMyOU00akNw?=
 =?utf-8?B?cktrN21rcXE3bjcxZ21rK1lObkZkQ1NlR3dvQVArU1V2d2FGVmtkbzErVzB5?=
 =?utf-8?B?aXYvZGpuZWtIQlQxNTdtSXZjUHlQdmdLR3dvTE5VOEZSRC9mdjVCVWpTUjBG?=
 =?utf-8?B?Tk15VzdrVjZpa2tlTytYam40SGRzUEpEb01ya3N6aENuM3pndjdMMm9hUzMz?=
 =?utf-8?B?V0NZbUJPM2N6Qisvbzd4NDdRTlNsMUJsS1VRbmNUcVNLVDA3R2JmblFqc0Uv?=
 =?utf-8?B?QkNmUDJmaXpoSHZCS0FrN2IweWsvN2RjS2dOTDBDS2dCZFNDeklLbERDYVNB?=
 =?utf-8?B?NGRtNHFGU2Uvd2ZHRytDZXFhbTdHOEF5S3hxaUd2cW9WRjJoVFl2a2pBamFN?=
 =?utf-8?B?aFJSODRxbFl5UHFpT2pCM29BVGVzdFA4Z0lzUTNVaUdNMGRET2VQZ0Y4Sjc0?=
 =?utf-8?B?dDRUUFNUcnZ1TFVTcFcxL1FNeTJsbkdTSDFqNEtxNkNmc3JDVloreTQ1b0JM?=
 =?utf-8?B?cXVHWUtkMWIrNGo4OVZaV1M4Nm9ua1ZjUFNESG9sMUwxOTNadTdEaUVCQ210?=
 =?utf-8?B?VDFBcjlIMXJZenlPVjd1N1EzbEdnaEh6RjRKQmhrb0c2VHFVWU5QMk1GU0U1?=
 =?utf-8?B?ZUlwTFhJRDhta2dvdG5qRUdEODRJNGN6Z1UxaEVISlp1L1d0TzZ4dHRlUFp4?=
 =?utf-8?B?YTFuV1F6WTEwZGcrZVZsTG1VV2lIOXdYSmV1ckVYdzNqNmRVNTFYUGZocVY2?=
 =?utf-8?B?bXNkUkxZekVBbXdwQXVOd2dqY1FjYVQ5TzFFemYxWCtYMVd0TFRWS0I3b3pT?=
 =?utf-8?B?ZTR5WVdvNmJTbktlU1p2aStmVXR4VGxlQTZEWStYTlB6cjRZeUhmbk5UL3Vt?=
 =?utf-8?B?VmhVTURQaC9YTFI0bzlqVzNEUHZtbVZOWFY2YWt1WFFad2JlcDAvVEFYTVU5?=
 =?utf-8?B?WnhEVGsxZDdLdHNmVldiVnR5ajVhWGxPdk13Vy96SVVmNk1OQXFzMktEbGtp?=
 =?utf-8?B?a0V2dHNjeW9OVEVMMkk5WnI4QnZtMlZuU0ZNOWhvOEVrL3N5TmxjL2xqemI4?=
 =?utf-8?B?YVZzMi9qbzZSa3FTY0NQU09CSHoxVkNtZm11bTBEVytzQjlMT0duaEFCTWV0?=
 =?utf-8?B?dU5LME9uandBVVZtdDJRRlAyY1dXaGR0c1lZU04rUlB3am01WTAzQXFLZW5B?=
 =?utf-8?B?clcwdFdUemQ0NDRobkNzQUJTS2dTYVczdG5OOHNwN0ZCY0trU1hIL2NIeUUx?=
 =?utf-8?B?bWhHaUFqSitjcmxhZmZId1NZRmJNRFBDaUU4NW1UY0dxSDJzRFhMWndWMlJT?=
 =?utf-8?B?d1M2VzRnOGltTlpCNGluV2wzcnliUkhsUVZ5b1BzWmhHcUl1QzFLOWRoQy9C?=
 =?utf-8?B?TnpiRXEvUFlHSUVkZmtrQlU2L28weVoxMmM1YU45YmJ4bzVPRXQzTkg3S0hH?=
 =?utf-8?B?OFlvb0ZITmxjU1ZIaWNDa0xNRjNiQU9RYzNFRlY5QzVhNU1sbVpUTjRRbHZY?=
 =?utf-8?B?U2xEL1UxYVJnMFdUU2lrRzhJQTBpekw5blpKWDc5alQ0bklCL014Q2NqVUl2?=
 =?utf-8?B?RXJiRFFLMFJ6dGNPODZ2a2tQMEpBUjZyQ0tSbnhkSzMxaUNYcHZhYzA1UG0y?=
 =?utf-8?B?Q3laaDFlTkhyamVpZS9yTXg3Nk84bVo3QmRCbVBhTGVvc1dDcWtGSWRrOUZI?=
 =?utf-8?B?NFJnZHZVVnVMZUp1MFZSdENaNUZoUGNmL3lkR0pHUnh2cGJuUFl6cHh2WHBI?=
 =?utf-8?B?d1ArN3lkdzV4Q2lOM1VrZ20wcUJ1aTk0RFZLMEFQRjlzd1B5T1Z4TUVnTlh2?=
 =?utf-8?B?WmhxRmpJZ1FCRmo4K3V3SUliVkQwOHRXWWkrakRvdWh4V0sxeG5OUHhUT3lC?=
 =?utf-8?Q?ZyFlASomydj86eDK1a7Rzq4=3D?=
X-Microsoft-Antispam-Message-Info: 5NzZF3w53qbAexuJrgMebdJBLU8pVjYxNQ8VwNfTTWuT4/GjjkkNUFJmNmaBqwSEIsdKm0ELX1J5BVj1UYyfCoYSbdO6Wmv/yvgxk2I1prtu5xPSq8xOtVUqDHQbdjMplCDiNNnLlnTz4YzplHwh+rgfND5p2ClDabN9m96uPPCu+C3CkwJKH6kN26+LSUN3
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1711;6:fLtKkSKG+bLJ9M7bsq67sjPUP5MPq4hhHcCRI9z+h2rHKERlV+x1TvtntUWDiYkZ4UTlNJI6helelCZiyP5gussa8IB7c9+6U1B0VvV9CU/T65P3KA1VJsRuObRCCqQP7UuBl/U406B6Kmv0zWqmNmZt9i7ErLdl+jelVQ2aazVHibxWUzhUW+Vntf1oY174A3Tx/FhmpFgUiSBi/gKZ4z2P3BqWfnJVKqy7p7BccD+EY3r+dPsXKTFpsmrzvmWeVYcS+wIDwJ763sDkKoeiCKQm/ssg1R67MjGzF243iL68y++DjTSUdKi8LjE/fBgCkOXakqO8T7oZ1UzzS3uDSYFjBIELPRA67h68lMcbcscmxxJZC67MQ8nMYV+sYTOlsBw4f83ZCW4kNGNNl6LJQVnsS70LvzW7y2F9eml1ZuKmNuUjjvA4PkWp46zoKFoJAAaUrVdL0itO6XlgZV4hAQ==;5:Uj2Hmn0oBrRyDv74CaLbR/fe/Cx5d7IkuMamYXvTCJ/UiGtxKIf3xgOWcSIu8W/M5vnGKlWRg7cM9Ds3xahYYK3IbwTyxaKtppwJ+7ZPSOQTEytAEydBB2pivm/j7iNi86mr+FuDaX+cmBwec713v5TztCFUmaMvG+uvmIjNFKU=;24:BLmuIE1vGIqRvSfmRee9TdbGz4rQPLcPdBw4ptby+9foe7m1wAO/dqMskOTGbXpXwxqzeFlCQfQD0G7VIBadI+iJT0gmvieseCAKBUOG9Zw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1711;7:6iHn10sFlNKes66aIF2U8SdEoWdN0YyRrst2smKXSKOpnQgk/cKc93/KaqAHzgCD7cJjU/5SSrfjSwb5aX0HRn5awnI9kQ/qGfV1BVai6bbpbMoAJd2lbn/FT5ZeQDz3DGSZu1PLwsSMepPyl7kwP6KA7+p6mX8jQ/4DU8j5TIaTD9izeBCkmAprYEYOcC/tGNo7qn2n4UH5XnUxZdpPA+MHkcGzL5TJVMW2g+tht4D7xtKgKYnvrIur0d2PAyBB;20:B1z2zFasko5AEk/22TKgc1bxRErQx7+84UO9fyNAwS1WDUVwhO+aiG9jtdGj2TznQuC698VIdLJNxFtTolSV78H9swa8KBIvlo0gc27wJeM33zmSg3gWzbInlxwSUm5q5H4TzAlyMdDavwYNN2xPOQpVmN86TB9h5fjhWKCg8uczDHtvAMDeU/O+PvCXpOmN4j4EDNt85fq+YHYU0U2sa4rEGwwdw563B6R0/WhK1lRpUjD7fMVVUdWN+1a/i492
X-MS-Office365-Filtering-Correlation-Id: 16840319-63dd-493e-3693-08d5aa16f61f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 19:09:52.1317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16840319-63dd-493e-3693-08d5aa16f61f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1711
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-04-24 09:14 AM, Luc Van Oostenryck wrote:
> The method (*hqd_destroy) is defined as using an 'uint32_t'
> as 3rd argument but the the actual implementation of this
> method and all its calls actually uses an 'enum kfd_preempt_type'
> for this argument.
>
> Fix this by using 'enum kfd_preempt_type' for (*hqd_destroy) too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Interesting. I'm surprised I never saw a compiler warning about a
function pointer type mismatch. I guess C isn't picky about integer
types as long as the size is the same.

Anyway, this patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

> ---
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 237289a72..2890e8581 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -298,7 +298,7 @@ struct kfd2kgd_calls {
>  	bool (*hqd_is_occupied)(struct kgd_dev *kgd, uint64_t queue_address,
>  				uint32_t pipe_id, uint32_t queue_id);
>  
> -	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, uint32_t reset_type,
> +	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, enum kfd_preempt_type reset_type,
>  				unsigned int timeout, uint32_t pipe_id,
>  				uint32_t queue_id);
>  
