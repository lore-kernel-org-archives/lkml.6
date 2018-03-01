Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031621AbeCAO7z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:59:55 -0500
Received: from mail-ve1eur01hn0206.outbound.protection.outlook.com ([104.47.1.206]:4306
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031551AbeCAO7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:59:53 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Thu, 1 Mar 2018 17:59:35 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH v2 3/3] x86/kvm/hyper-v: inject #GP only when invalid
 SINTx vector is unmasked
Message-ID: <20180301145934.GA13964@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "Denis V . Lunev" <den@openvz.org>
References: <20180301141514.3482-1-vkuznets@redhat.com>
 <20180301141514.3482-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301141514.3482-4-vkuznets@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::29) To VI1PR0801MB1981.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c158cb-f70b-40c9-c5e7-08d57f850f85
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0801MB1981;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;3:E30rb0evo9BZYSfK1OdjROq0CK265Vlk7wtB7Nl3rkyhAFUbEX/uaJ+K+fnkEM2WSUe+M1Cm+nG/K+nFfWrDUzk4lIgVni50yyqQNcns057kqIebfs/VWid0Fa2hCjSRV9BScVqOx/ZwbLr75OHW8obHEAz1Qfr/sRVjxcGXPoYiUQP8HjW+PvCqCDwSjUg/o97TkX84+hBp3yLczlICuEFfTiKyS+QODSqdYFUNPBjzLAHp9LynbZgFxA3unvx7;25:9tlk8wbAZhKDlxtakrsFnPlz+AFWeMIAYWkG79KDQ3C6tGchMHIc5L+3ZPHJvjqtsNv9hkmVPRbjN7AH5M2NWGxXuR5MHtEIHB6LcR7T2Kk3UvJkfgiOXcAYyhpj8JysukjdLu1rHt4UAWUqx/RfuIOPZMytLfApuyL8Gm7kZdpz32npRG6a04ufQBSDaFBDxZekEtJsfBsD0DwLPruYVyJmp5D0sgn4+7EmMr2nDCBHro94pOX5tyFE+tlhnFRK9dKuPzVUAQrqOW57DaE1EIjfwDXsR7nSv2fkTcFV/v/imWeKTEcu3oAy758evm/+7MxZckH5XLF4Jb4hLUl5GA==;31:fmZBxf2a0XqlsS3Tma18ZenxyWqVegQkE3LorTHA/IEJ1L0/cnYyXlUzTgt78JiDrFSswGuEWQzHOTD+/U7T7/oQiCS3RuQiUoy8DabLuAv6vWqy3a5I2kjnmDe7akscXXy51U1cF3/F9eQNsSoB4N+k16jvR8DkvnLjGuE5ezV+gFu3HR0RPJ4SIYerdHfNCbl8q2TmUWsR3z0yXTX1/fgqd675zHWCLzKxzLUdLf4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1981:|VI1PR0801MB1981:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;20:H4s0VgGySvPEPzO7eXmzVtTkKKC57hJjFBABXzqAL8pUwTrBaj+36qCsAUtn6jVaF+Z9/YPAs3vLOQCRSTmRVroUJSrt5pnrrN0JnJSAZnSJsxKvsuFh+qfrb3+ggPMXccktx9upVZ3EKyEZ9l0a8SPUAFdnZVV++tksN00M3+2XJPa73Uex7xfDSLAuvaFM2aB6saci5rLpitoy1TiVhytNZbkCiuHTbL4uKvVQCAqWxWoNarjb9hg7L11T7VqP10pxrSCiOgHtYxIllccXbWSeqFEELITH7y7bp4pCD2t20TRn0l6jS7zgIL9KnBBnQ1omA66I+/Iik7y+QmM7vUJiasSYabixE/yM9lvmTcDM3VTm0EUwIjfH5r1sYcF43sfZx0428HZw4ugOJBrGWzYOGJtSOojVZjUVA6eCMkVvbf6rdlcVoXig/jJpAg9wUOIFPguuSsl8360ZyK6tWCITxREh8bQ/dKT4E31HaHWjcfBsF3pG3hL0Z8ipwTDI;4:Cm1lVbO9Kl4kyMmc0AwFPBO4S5acm04l75absZ2SA+0QsgaDmDlj4t2BK8faw3lEvSEIE+TWrkv1ECd3bdzVT9AwNE3eGhiRvu/Hfhvk8MI574GYB/nKhiiOkuJAuzft+ZRG+hhvMkDCqsW1RpPC99MMNgv4Qzt+tul2x0f7r8Boiy0WAB+dK0KGCAQPOzefPHpMTKOGYRFnfZSXiGupZh1RSmb2U5JIJokuBx96Wfi/hGiLqRvcojBWfglOfhF5jawug39mtXbX6aYvBQVr1g==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1981B0FE5A78988ED7D51772C9C60@VI1PR0801MB1981.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501228)(52105095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1981;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1981;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(396003)(39850400004)(39380400002)(366004)(376002)(346002)(189003)(199004)(66066001)(68736007)(107886003)(4326008)(47776003)(55016002)(58126008)(6916009)(6666003)(105586002)(2950100002)(8666007)(97736004)(33656002)(45080400002)(16586007)(25786009)(86362001)(53416004)(229853002)(9686003)(54906003)(1076002)(386003)(6506007)(2906002)(53936002)(23726003)(55236004)(6116002)(3846002)(186003)(16526019)(305945005)(5660300001)(7736002)(316002)(26005)(59450400001)(81156014)(81166006)(76176011)(8936002)(478600001)(36756003)(50466002)(6246003)(106356001)(7696005)(52116002)(69596002)(8676002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1981;H:rkaganb.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1981;23:9FdlMY5luy1iKwjXroYwQoRKlUHGsC0owRKV+1z?=
 =?us-ascii?Q?B100Pvz1vPlgV/+gyCynnzxc/PBXsR6VTmMrOXV4y0vpAHaEw9+1zzAjj9wy?=
 =?us-ascii?Q?BF2Cc5pNlIgD+CilBOQIdjrJVD+NHU5WfESkjrpeKhhbBZv+7OyEx3UX6qQK?=
 =?us-ascii?Q?kRgny7UgWDoSS2bOLcc9n5292v/LEpothMmiAif44zkMtbwOyY6ZjF/d0CY6?=
 =?us-ascii?Q?/abjfCRHDpiQc+LHtfm6vCIvgxdA17cgEQvmN+zi6TpO3OOvTivqSaKvYidx?=
 =?us-ascii?Q?0OKRMAEqhAtJtSVj1hUH2ETga0GNkoLRLXIseKyqaD6FA1516bEVt5obUHCR?=
 =?us-ascii?Q?1u7soYBMxE1zWuCTQmmEYtjOhv4oOxANTm0htrKgxXmY9MpyZovevV3nm/fS?=
 =?us-ascii?Q?NluOOPaISGQZ9xRvMZ/NyOlmeVBGIG8HNlHyi3C3Il5fbRyOWS2HNC4seiFv?=
 =?us-ascii?Q?LSahbZ/C50Mt3Lda2tTfME7/oqjCtr3ZF05RFPlLH1UViqGkNeRkAifamdS7?=
 =?us-ascii?Q?Hoe6Y60p4mUitdC6aeBAA2a9TzYqInM6c1zoi7dAFc8I+9DTUPi2zWv024+C?=
 =?us-ascii?Q?90tdHl8qnWsGGFUnlxTmzaFPaWZa0muMZlYzhr1DD1gD1BrPdoSy8gFKYZyZ?=
 =?us-ascii?Q?9+YPuXN61cUxRy9j8clQJqf83aMuVforyPlS1eatlJ9bQQ5WS4hMHvqDuw4p?=
 =?us-ascii?Q?o0cLMMaPmJqRoSlJHAb3ShrptnskRy0L/pGcMRMKoEVNcnzH6NQWcH1ZDs78?=
 =?us-ascii?Q?84V3RaZRk+H+eMHEDVeJ42ZBPnM+AqTS80hvkcbLb4cf7qhEtz/ku/Fm5ZUV?=
 =?us-ascii?Q?nUaOPvLDmmZAqYeA3HaZGhlXigiZ9WEy/UpKVIxQHMD3AAhpRd+ap9orlqOU?=
 =?us-ascii?Q?oBLqedl6/tdGm9kNNHCJz9lISoT6igdV8w8Hkv2uOlgViwcyn2+bBccU1G3a?=
 =?us-ascii?Q?3W8P8BG5zFSxas3Jueq/yNx+2yDIf6YPzJOOi1fovBq+dwMJiaCWZui0Rr6s?=
 =?us-ascii?Q?mBMIj9YlGwoHxLnBOB14XBN49cuyS4Z5/hBSTYRRIpcsobAFn1qRsUH9+u9q?=
 =?us-ascii?Q?Z2mXJLA0MXOdVZGDN7RtTJzpx63yn9rlkrfsEpKoB6HQCONLDx6KewZs02gz?=
 =?us-ascii?Q?cnZw8k70+qRyjQXpPVQ3woXgCRBgIvpJGIOD8qum7agrbfxAtkkevA+ZfEaK?=
 =?us-ascii?Q?Vk9EWpx1/U9bvE7j6MNVML5xzS7SL4y7nkaHI1tfQTxkEuynzgymM/AVgmeD?=
 =?us-ascii?Q?bIc/7VlvQbifWtDwYCrpuEFFVp4Z93uxYVIygH1GZn8gzgbWbptc3r7jl6xC?=
 =?us-ascii?Q?CnwKQxSrq8lbSBVmRN8TlPA6xtQ1+0Y7Pu4N7774F7RcPk9dkmFppLdTMsxY?=
 =?us-ascii?Q?vaPKdUUZ0aIDajJKGNmEG9v35gE8IQEKJsnZdKeUVCxSV5JFYgSEorVvDedH?=
 =?us-ascii?Q?mD6YiRN5CgA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;23:/4ORmyh6/Xk3Uc9K9PB9jJ7cVknoSknMgdWjlThEM8fvfYeMf8fxlfIhAbmUfMEK72ifokvTTyXCFgYPl8XunPg3s81uC04VxGdTdvVUyn8fNDxw2iceQ4nIsELEnOQUsQe04DGCMMVTW//xspYfKg==;6:sld8JkoaV+sF4PxcZMSpv2tAbPuKbX3Y4vyYPbtREkxlH//ykdc1RRNXGxKgf0IeKZqpCv6MaLwJ1HcDPECMsIvnXIf+2APyjyC7UMSrlswxWUNSB9udbwfObXwMl8NYHhprQ9EnIYDuEK6rbdyTxp+eIu0HLKwLY5B2QY1L1J7WnaZB9JWPSodGVtYsqbN6zpZ5Qqld6qmLDM9RNwqq7VWu5HsoEjR5N3dSQTLq99hQ8AYhQEXentDvlCM6Ff0xX7mNFPvN38un7Ha31hY6CV1cMqQ0xTPEhpEclZt1lf/ARWHRiXcmEKrC8hXJ5PD1+Ermtc/5M5q87l79+BXvXrWXJEjzECUU1sPeOGlBHR0=;5:QtbF59KMrafcGOy7DvV5pnkRkmyvKSn9iyz2S/Ze5YM2N3n/I/Q0A8qugNAYSR5zUFPexZ7KZpew58ceLXYY4ulA22mJ+dxvcYYDu/wNue1IGCKzc1yQwLdo3TKU75SNh8tIbTCE0QTC6iBWB9BXT1hArYNAKz5yLRvkU1nGpqc=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;7:yPFgbQJuv138eWOu/UqJa+elTsfWvunGADjfU1QNn4kr7J1Xx15fLiygrCn6bA38t+GCurNT2dCFV9xVfGg0z+pNPU10geH2PRiSoz4nliSzuI7rcJ43OhdvUtAvwtQWqQrmEbM5r8pcMDLTadxPGHR1DUA7vnqI9/1RgYqNSye5kp8zM87vZKXkdOV3yYMzQCSasewC0uWEzq6bjlDbk3Bjn2L7/PFGAtJYAXxxiO1SRbG7IYaBuZzS+5dty/GA;20:9E1LwIQedfaspj/Tro+J/ShyQ3FY7j2W45Z9d57F71/zoeBwWy4wPr01DTn7LP+WwYU59WJuaAeQuMeFvn63ZrO8XuTP9FHa4iKhxlHZAS3PrH3BHrRXWmTV7cHBv2NLQBd41Ospw6A02pyVpoSvBGhUju2SnyoPA8ZFND3w4v0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 14:59:40.2627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c158cb-f70b-40c9-c5e7-08d57f850f85
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1981
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 03:15:14PM +0100, Vitaly Kuznetsov wrote:
> Hyper-V 2016 on KVM with SynIC enabled doesn't boot with the following
> trace:
> 
>     kvm_entry:            vcpu 0
>     kvm_exit:             reason MSR_WRITE rip 0xfffff8000131c1e5 info 0 0
>     kvm_hv_synic_set_msr: vcpu_id 0 msr 0x40000090 data 0x10000 host 0
>     kvm_msr:              msr_write 40000090 = 0x10000 (#GP)
>     kvm_inj_exception:    #GP (0x0)
> 
> KVM acts according to the following statement from TLFS:
> 
> "
> 11.8.4 SINTx Registers
> ...
> Valid values for vector are 16-255 inclusive. Specifying an invalid
> vector number results in #GP.
> "
> 
> However, I checked and genuine Hyper-V doesn't #GP when we write 0x10000
> to SINTx. I checked with Microsoft and they confirmed that if either the
> Masked bit (bit 16) or the Polling bit (bit 18) is set to 1, then they
> ignore the value of Vector. Make KVM act accordingly.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
> - Drop 'polling' bit check for now as we don't support this mode. We'll
>   need to bring some form of this check back when polling mode is
>   implemented [Roman Kagan].
> - Add a comment explaining "!host && !masked" in synic_set_sint()
> ---
>  arch/x86/kvm/hyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
