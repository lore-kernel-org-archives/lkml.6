Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933450AbeEWPHa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:07:30 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com ([104.47.1.90]:7116
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933151AbeEWPH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:07:28 -0400
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Subject: Re: [PATCH] nvme: host: core: fix precedence of ternary operator
To: Ivan Bornyakov <brnkv.i1@gmail.com>, <linux-nvme@lists.infradead.org>
CC: <axboe@fb.com>, <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <keith.busch@intel.com>, <hch@lst.de>
References: <20180523145611.10297-1-brnkv.i1@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2cdc9032-901d-fbec-69e5-63087923e4b1@mellanox.com>
Date: Wed, 23 May 2018 18:07:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523145611.10297-1-brnkv.i1@gmail.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10019001)(6009001)(438001)(377454003)(479174003)(51704005)(24454002)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(74706001)(36756003)(76786001)(76796001)(81542001)(54356001)(31686003)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(77982001)(59766001)(56816005)(33646001)(80022001)(65956001)(76482001)(90146001)(65806001)(65816001)(87936001)(56776001)(54316002)(74366001)(44376005)(87266001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(83506001)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(31696002)(64126003)(575784001)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002)(65826005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4455;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT059;1:t+wRAqWEEElJ3Iz7mVz24MQ+5QWoul84yjifliIp7ErKEA6rQL/qqENZFAwbpX5k+WUBHcuQ8xfUZK743OQs8OLozXck5JAblFI1nCLHbnUR6O4GesFaVE0A+LAs8tW5
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4455;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;3:wA7fZxhLtplQTcw5NgE1G+zosPl0XaWM7abXNm42ntepDjLnqunFGsjq7OJptoSVRIwx67ovlTVC08/h+FMKEhbxkXicr+NA/le2ODYjYWrVJQ/U6tVWsSAb+Gb9rYMKrh9ufYto3FRJD6LaoPyjtVNTtPmjT/CX+6DmMxsTJv2PzegTWDMTIrxMftk72nimLfJMtbw20wSslJEH20XuXUicE1nWXKJxUcEijw4Kn9VtiLqyBjk9SRLmGUQ74KsVXpdzni0SogLH+wSFBnjfB/Pn0nwTMh1iZRD1UO0IjAtkiu2z2KRpUzDJjqV/kWCEbt85I/pNetP5miTAcFlssd/Ts8rF0nQloSmpdLxxBlY=;25:5pJhCnU3NO9K8Juwvq58KDMDYmiy2ql2VmW/mNulvlBzKm4ijiZrMpqk0XNlTEr9i+i90frlxTBDppXJXh+zE2rkwIr02oWC8ZqTXDTvVRvi/H/iAQVQMwMDYS+uMPlPd8+YHFYSBVtjbK7B6SMv6/Cqho3NUJTe1F6dcTqavBH0De3dxPBTCgjNIcQv1KN9LN5ImfDZp+6E1USBsdHx1rnE7e2eYmLJIHaarImJy52vEp3ec1VwqS5aiY78E0NjKiXj2jD1e8PXpLxYocIfAMJbNvbJSUeS0UibacA2zEVK2EIJaDtt7ZbrjM5Pjw6o2/XpGArjmvij3dOv58rE6w==
X-MS-TrafficTypeDiagnostic: AM6PR05MB4455:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;31:2slC1Iiv0czRYbvCZZXXG06Dncb203Ecz+SnxrQl33i7h2XXsUAbupqZ3Mu16Vii/rBKNdaAG1tRly6AnnMPelOm8iiEh3uTq4BNJTEliFJL+IdQ6Oh1puNbO4x7eha4DC6V7SniiyYMVMnBS5yVxaQUjHnBwcR7gYFyrleWBO0Vk11o5Ag8w7D3aJy8a0by6006TDlDAL+MStlGbKXWCufiuKi7WAOMur7rwIJIWxg=;20:eBdsWoTJz13suzhIhPFWjT/2+/RFY74MqlDvvYHq1bVXX6nKru04763QYt0SYw9EexwFnK0yGe1LdyNLKiI//foO7f6SS6/xh//kub0MUOD7uNBq5l28k+jRoYEMB9kvRsluhSoPGFber7O/Z0TcJZH6jLOjY0O4E0CmhlO3dYLbgLw/fHP/W9VUvI/XQmpQLvQAINTUnhgzf75aELz4kJONBqwL+7HS8b7z9pH4jNVbb3wRSK3qZrnKDPDpgkT2IPJD4xw746KXMiGYr9aNWLOkwN0TeeFl1I6dUK2Cy8carT68rLwlfXpeEeBifdMk4YzbB5Ucf2gC0S6MQdW2Vwut7neIb8fyhkLkIhWxa1vZVb0uDGW7J6ZLVThuM4TY7LyRMYV9rI0sOsvysM+sAbxBj06SI7Je6yarqTjBTjEYJIPLnGgQ1hvDoc0d0vxw6fQhI+5c9LgHHoI5DNI/WApkt6fJgR/fA9gaqjoVD723sXnxHLphMnt+3Xk1XCXb
X-Microsoft-Antispam-PRVS: <AM6PR05MB44555D35F7742CAF137FE68FB66B0@AM6PR05MB4455.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4455;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4455;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;4:Ey50+UQ0fo6SmjL9t/VkH+TDzYX9nqWMvds9amvBlnKob0YcX+F8Gnf24IdKdGwgNrZe5CnfJOdJy9sFvZ3wzkZ9egt4zZmZAkbPYzr0T9ynxC0FxMNN6UPm4oKg/jdmkmrQS37/N9ZVXQyEukI/TKl45CrRIKVLD8LXVlIEEdyqS24QrCcerKBkYhZVrEU16SxA1j7MSTDtx9VAIw1Hp/eC36wtc/gdXdgFzpDZOlxezMez2mDqFaDX9HRCAQDsV92CFXObv4AouEae1SPkpxMnkWU/CzicPwRFcT1J2xuPTFAmY5J0TpmCR9EAWjXT
X-Forefront-PRVS: 06818431B9
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;AM6PR05MB4455;23:44jVTS4p2w/AIqDYkKzDgHKfZToB2UMMXdeUV?=
 =?windows-1255?Q?mYd3/SHkMRHfAXPvogIv0iCe/niRWaV8z+yccOmwQgMWC6fmINp2ALQc?=
 =?windows-1255?Q?X1dtJDmqfd54ta1rdxmYGgaJb4xa31Hs3klhqIm3Gro1eVvwVniyY8D3?=
 =?windows-1255?Q?6UH92yOB3/1xwbAaHl9uWSpHR9d4K4t7cdRXrQE1XEQwcILco1tT0Xlx?=
 =?windows-1255?Q?IU089Y+DyVXkSP34swumaDDyBD897SkHD2GYjhTWG2xczd2eCkWSRIZS?=
 =?windows-1255?Q?+5+nNUoYPSm6Snf5Vyt4Jz5CjVbsQX5pGxBPwJ1Bihf3Q6ePUB+yNYTW?=
 =?windows-1255?Q?6FkUzQWCnfi6X8yklJVog9iPIxiH6fACjt9QfkVbOrd49z5WUQRMKjTz?=
 =?windows-1255?Q?tCTalkfQGnn80pYPFsV4aTyPMg/qMAd+gc7OGH1oW0dVdFQtgSsl4N40?=
 =?windows-1255?Q?Xk40h5NdhZ4k3j+nTwxtXSrD9T8kvWh6rqzCvDSj5ypVeLUANCaFDxb9?=
 =?windows-1255?Q?oq32vHSrkr6OiI2yotzsDp8REUsBh/O9RTgcYH/JgMxA8FSVcL+a6y/m?=
 =?windows-1255?Q?dSQBKZxzzVTjz6bHtLjoGxX0Jb6acyvvTVwmdHIZv47FXNeSrlygsySM?=
 =?windows-1255?Q?o9e4tJzmM+uZJnrtws58SzCkM9NUOUgEKMIT28irfwHIYCgGBb9uGNdC?=
 =?windows-1255?Q?x06d62RN1mPXDMFeq7BPPHEqcvPEbfR0W49LPeQ1L5c7MeBhFsc1u7CN?=
 =?windows-1255?Q?8HRaSeDV+au41oxQU5ZXoacNnuBqQgfpdXSfmZyz53tUOvOTOwXlXZh2?=
 =?windows-1255?Q?xSFcQHgRljWSJ7+3YogK+IK1de9wkZ+X3Gu56Bh0zQREl8s37aQQROQ5?=
 =?windows-1255?Q?a1sjPd3e21sHbiJJ3qKoNOMWBTjP7VnWTF9nxzGc6u9iucT8ADhlXDq1?=
 =?windows-1255?Q?Nw3LfqCqPgXOMNeBxKNR0xUwL2UqiqlgJ8lFrn0Zq/Wi5ijZEfitt4iA?=
 =?windows-1255?Q?hEHksgP14p2b1sRpFdxFypuOgRjpTdiP01fCMUUWBYgN0OQKa/twpNqY?=
 =?windows-1255?Q?DhIfzqivI9RXk75iRNCJCNs12jZV5RfQasGkdgFPO6Jiw8Rf3r5EhEAG?=
 =?windows-1255?Q?Jj58H45hJPUwgLUGv7ykukgNi22Be04KXEW3LJ7FTi/gef/nlyrGcXbR?=
 =?windows-1255?Q?oDIA+ZhZsoPSh0BDnB6vCrHHhuVcVT/VQEbgQyIiddlEK4IAO3aLU3Jp?=
 =?windows-1255?Q?yJnah++qQTGhKxIRnWtG+95/2atsE2ab8T5pDuC1ighy3UWE2Ph4vfvv?=
 =?windows-1255?Q?oJ6bB/9UcNhn8/Z8ABzfND9fjaX13rDOz/LPlvKIyvBijyuB577e8puy?=
 =?windows-1255?Q?hbN3OySmUMuTUNeZ9P7s4XgBzNXtyYFp2On5aXkMQGw1veKgqo5Dgm6y?=
 =?windows-1255?Q?jTiVRorQEn8fK3QQK4DFTdLp2EpwBupBtc9jZ7u8JDtl8rOc7bkddJtX?=
 =?windows-1255?Q?//tyP2yJ5iK2EzAgTKBiIvTQGUlkK4Gd4yVnim5lt6XsXU24yEBDdE74?=
 =?windows-1255?Q?wtc3FVI64pBw9sHUvOLB0ifVYlSTQIFX/2ZTwZP8IrUeoagAoE+6PXiI?=
 =?windows-1255?Q?Si3a8gn0dMAXYnmfLTLeWoLht/rMrgxZpmiZ6LU5EpwD+HJf6eQVB51N?=
 =?windows-1255?Q?p9+LXD8dEOcG2/wzO6r0nEbY1Cb9JD+c+xAHy6sjtZCBsUebjU7IJJqP?=
 =?windows-1255?Q?U5kM5LIkOna9hJtsnZyO6JlKgGpz7pmH665pq0rBMNQEAqwXRvdzvezS?=
 =?windows-1255?Q?yluBDdDjcw901gGF16i0I0dkjNrApOaRQBwCwq0kkghRdxfyKQvsTENQ?=
 =?windows-1255?Q?DPmFi7Qt3y2e9JF0j57LEShQtoMVo3j0O5ybkysS2jJuz6b4V2TJO6pN?=
 =?windows-1255?Q?ZWE1TZVyOoCqPQxC00MxfPJdxoX20zywwRwVX+a4Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZDJkXb+95CqF2HtEUb+C0sUAVrAZjJ2EE1zzegiKOhJSz6hY6Z6hV/3VEthlFJJidpBh8DiBsC1enuh/3KrBxk0kku+gYyRD4dn0x+VzK/E0za/suUZ0TvYiu8P+fL3sq/Uk3lPA4/4ZvBWXBvvAuky+DCPaAgJUhZ9OXacT960LLjGFongu4UWjeJ39NcM9
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;6:jxy1gTbumACQoRXIDa4kihJkxZENYPLNH9O7VqR347Hx1/PORbxkNtk0PTBzuDESBNU3UwWxXfVr5SwQoskvzEVx8iEL7NNk3RJ3vQJiiNAVASOlgh8TpwqPMAg4KezSnsUttIBhHKZNgJ99SDkabu3fZGmGhwipbQ9Mgdc//vtyE9f/b6wg1rkiZkqqbUWiM/cVCQG8hFPKMvtRRub18gf5IoCg4p3y3kIDtecKPxBT7a7Zgc1pjQmxKv+Abdaz4D8ZoIm/uHvZumOMk+eWUojEDbVxLTcGsd2XuVP3Y1o6Gb3JNBcCT1+dUuq60NPKO5i+OL+P1mCRT2GpYLdWdWv3NeB4jB6rJX1vsrfdqiqE5sb0NvVROtJVYPvJyRhY17vDl5cdipBB50SXu/ddw6c6fktDeR16qjTHPnTjKCeilYDs7AVKXfcXWR1S5xtautpdi9qG+OEJ7a6tzE3wVg==;5:iMUf4pDPwnTAHnHpsv7r7L9BGfU5hZpGGJ0OMww2uSnwU58lnj/3MhfOXlHAqMOoUL1x7X+4iPJs9NpgX4kmA7J08QFHcSyo1raXW6q+diK5Mil1pClAvsyCscdF+biU70Ly2IOu6tJhpIJDeJDOXtd7PvWmcjeilK50KzLExuM=;24:NyTiTi+DD6NMwwPdkFGqIL6FQoYuXx5yVsB/bv97DeCgk7CpZr1MMs5TtEVKesUnUn14YzvHPRXW30RjWRadj9dl63g4jaYjcTKULkI5qKA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;7:Kr0yKuSPgkkVMVxXY4hvmQxuLGN5tzEX6jhejQm/UyLoj22Zxc7v9GMkM3wtQU0pqGbc3AFFfbgQReN9L9Zs0Ytn0EvuBGbCk9zdeVXkg+lEmVywX3M/iVib0Ei7zHjgd2h3eIbCf9HIN7u7zIb/5ZSHxNaS+Ngh0HIkRka68lxFj/ZRpb+14SPZ1dHhaEVbhtGcRO7gocoqQx/AHIvkCDS96rKBH+nEflhBiWbQBCSL+VAn33TIjmzAd/T/rHz1
X-MS-Office365-Filtering-Correlation-Id: 763b841b-0f22-43bf-9c71-08d5c0bee38f
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 15:07:23.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763b841b-0f22-43bf-9c71-08d5c0bee38f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4455
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2018 5:56 PM, Ivan Bornyakov wrote:
> Ternary operator have lower precedence then bitwise or, so 'cdw10' was
> calculated wrong.
> 
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b070c659391f..1eba9b0cb9dc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1577,7 +1577,7 @@ static int nvme_pr_reserve(struct block_device *bdev, u64 key,
>   static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
>   		enum pr_type type, bool abort)
>   {
> -	u32 cdw10 = nvme_pr_type(type) << 8 | abort ? 2 : 1;
> +	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
>   	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
>   }
>   
> @@ -1589,7 +1589,7 @@ static int nvme_pr_clear(struct block_device *bdev, u64 key)
>   
>   static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
>   {
> -	u32 cdw10 = nvme_pr_type(type) << 8 | key ? 1 << 3 : 0;
> +	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
>   	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
>   }
>   
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
