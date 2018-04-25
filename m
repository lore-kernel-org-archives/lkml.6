Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbeDYNVg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:21:36 -0400
Received: from mail-co1nam03on0051.outbound.protection.outlook.com ([104.47.40.51]:44216
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753537AbeDYNVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:21:35 -0400
Subject: Re: [PATCH] drm/vmwgfx: Fix scatterlist unmapping
To: Robin Murphy <robin.murphy@arm.com>,
        linux-graphics-maintainer@vmware.com, syeh@vmware.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <3a08f0343cb4e7a767601c59a381884121f9b751.1523632202.git.robin.murphy@arm.com>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <85d48f28-5df7-8c7e-d175-ce651838db53@vmware.com>
Date: Wed, 25 Apr 2018 15:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3a08f0343cb4e7a767601c59a381884121f9b751.1523632202.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: LO2P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::28) To BYAPR05MB4583.namprd05.prod.outlook.com
 (2603:10b6:a02:f2::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4583;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;3:8wAd0fyyh/gQWar720qVNpH8V0se/tk1f0H9XZbsvFRwynX0quEHVgKfqFFx7pmF1sChGzNBmus1A3kxYNEhmP4opZqBlzl1GYhQyVfTToggQw4ZZP/jKGewBiSrnVALqWsCiliUb8EdC9i2+ExVIjnr4erDcwKHFLcnvcE6mm8cd/YouXuH6Bm0PorV3tHMZZS018dAX6duheRKGiOzY8jQt6M+zvsT4LTAs5jjfNawFggzqLWckFguFVh43EsE;25:4EKqRrASayc0eJ6RUhWGZWH839ZqzWCWtG3agDFv3kUNYNJZRvWczujN0cg6/tM4tEPO2AHpr7Sm4UCIaIK/5Bmre+yWyts/srgR3BV0XGS6KSvQ4M5pNsux5Nf7kvMEd9MEXcf972bpepwVIk6Hz7grAhct5zobzaZy+u92n8uL+3b/pdSyqt1UGaNZb8w9hgVSmUGM9pJIPe/G9BC5cKAIahJJCz4e3CXsywyOgDJlgU++kKVS1MPYHmuzB397ht0/m1TIp4/uL/a1/4wpbtG5VgvWi3Qh89+WuJJbWosawEY7dubIqH9QjJWonsQA7R77dzirI7feYXCGk8nTaA==;31:uWh+TPryq1C8MAwE/Uc4tOr1V+XNDoo4/4HbBKdKV71K/3L2WWnqQ53esBYbv+Gz/QZlwZFqqU/1rh/KVkjEGDEItFh9/rLaOGYWoCQe15EEXTl+4RnN6+LufPX4B4kFDwH3eF4XaSUOeYVTLqt7DzAraLcZBjUi54Rh8MyCLAF85KdcSdyDHYP7ZSD60RxLoIKWVSeiFa3U0ZBTqY4CbdHqU6uSXZSRehSsftTBo+4=
X-MS-TrafficTypeDiagnostic: BYAPR05MB4583:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;20:ZWoNcEOYOxhD84sHrP+Qn7cahz841YNd7KF9F7ORqT5B7/X0ldH07h85EbOs+suu0uUBCECRcWDA9nACNLD+oyzhdBd94mZ9C591p69Q+wjVEsPzeCEJCvHOmiwbmswVscRbXC6fjUUrbL16i937rzwyzPxcigtlPTcIPSQa2mo81St4FzGTCMvNm44DEtvfSvj3MFCB0IlG5WZpXDd30YPOtUX7bDcVTPMOuoStJ+BHzbpJwhGNeyo34d+bnV6Kh0X/eT4SX9Y7/jAG1W3BBbnlhRtyJvYWixYMQ2LtB5ybVsqkPiWCwlKbLVjNDutiRhJnphDiGkCCiFlQhURctD20q/TGdXVqdTUdeWF8QWHD7uVygZxeT4tzKtSe8fFAwWQAKY0YGRupl1cwFMKoWPdje6z2DaoK8QA45VxKiPGVc8BvPQZ+JJ/D58HDUvb0TUEk1iwBlocXoHvgZmgLo//UiMx2U8xB6Bi+y/34wOdcDc0GSWJjC0suEMmKlZu1;4:aiNFw9ynYj0vXjek1X8uLyuJZ/skg4NQ4nq7hAN4beRd5oRfyJjGn1HGPh433RWkbwr/bNZTn0EIya1YIuZp3f9QID7TAe0SXCop8UnFEDDPh5hPeam3gAe0KyY3kZmvE88rIZHlUGkvAOPpK4GGEU1avOswdRRwe3cjNbk9FxL4t+df1OcxVQEfXz7o+4w+iSQgrghaZhQbPt9iCN+XIGB0YoDx/UfE7m+IUZpZO05uAL63oljBU3oeSUfl9MxbxR61EjpvLA4VGTaSfZHQ+wBnKjwX2ngtVJ3LYd9WWCK58g1yAsf4RflIRGAW19xU
X-Microsoft-Antispam-PRVS: <BYAPR05MB4583D7ED08E5D8AD416F67A7A18F0@BYAPR05MB4583.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR05MB4583;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4583;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(51914003)(199004)(189003)(2486003)(6306002)(53546011)(6636002)(6666003)(5660300001)(66066001)(65806001)(6486002)(6506007)(386003)(65956001)(6246003)(229853002)(68736007)(2906002)(50466002)(105586002)(36756003)(76176011)(305945005)(59450400001)(81156014)(53936002)(25786009)(7736002)(52146003)(47776003)(6512007)(67846002)(4326008)(966005)(52116002)(478600001)(26005)(11346002)(2616005)(486006)(97736004)(446003)(8676002)(58126008)(81166006)(106356001)(186003)(956004)(476003)(3846002)(316002)(16526019)(8936002)(31686004)(23676004)(65826007)(31696002)(6116002)(230700001)(86362001)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4583;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA1TUI0NTgzOzIzOm9Qd0ZUNUlmSWRldVNFZmtTZUpnQ3NXK0Ez?=
 =?utf-8?B?WEszNmVsMFAzS1JMZ0FQTTh3UXcxeGZzYTkzRWRrZnBRYTJYSWE4bDZmdy9P?=
 =?utf-8?B?YmdmNHRDS3JyQTFER2JTUVRLV2dpdi91WlBGNk9WR2dwTDRpRUtpVGJrRlZI?=
 =?utf-8?B?Nkt6d2pGdm9hZ25ZTmk2Y2F4T0tuTWZiQlZOTzRQWWpwWEZYM3krTXhCb0Fr?=
 =?utf-8?B?aVRkaXRGdGM4a2ZqSEh2ckVTZE9TTGhYejdzYXhmK282Y3hCTll6Z29aQ1dr?=
 =?utf-8?B?NmxLYzFicUFZbWJ5VDhLTnNaSWhqQ0FWRnVpanZKMDA0RHl3bU1WWndMYXNO?=
 =?utf-8?B?T1cxbzFwNVU0ZjFPM3Q0aUJmbFdRZW10eGg1WXFSVHRxSzhnMUlZUi93ekdk?=
 =?utf-8?B?MGZvZ3NvdnVYTHBGYlpVZ1pDdk5pdjJZYTN6RW1HRnI4UUFFVmEyU1l3T3Nl?=
 =?utf-8?B?bTJkalpVcWpydFZsTUY1TmFkWHRQZTZGNXJlTDJFSkErelRvTm11bGpJNGJa?=
 =?utf-8?B?Tlp3Q3k2eVlkOEczRDI1TG9vZXh5bDBUcll4d1cyRmszVGtIR2piNU1LRnF6?=
 =?utf-8?B?QTdlYW1LVHByb1RZS2FJSjVUT0NXSlNYSFBBREVhUjNNbUlmdk5pU0NoeUF3?=
 =?utf-8?B?WG1CdTJzY2FiRlh0d0NzNGF1WUJCRUFKT1J0YzVsc2hOWjdDWHhHdnJPOUUv?=
 =?utf-8?B?VXV2NWZMdUtDNVhtQ0ZPcTRHU0lpQlVNVVZrSWdzYkxKTUZDRC9ZV2xEZjRM?=
 =?utf-8?B?cWN0amN6Skthb3hGaXd1ZlZqa1h3RmtVTFJieGZkQkwzOXZnbHZwWWtZWlg0?=
 =?utf-8?B?UVJGUUZ0aWRITXFVd2wxNm55NHh3UW9JZ2YrdFRUVzNuT3lTTzF1SHVIbzRl?=
 =?utf-8?B?S0M1V0h6aDFrSExla0czZVBIV29YeVRFcmg4TlpNYWE0L0JhZ0hGSklJRFhH?=
 =?utf-8?B?UEZNcVBnZ0FGb2pBZGR4U3JDVWVmc0tWcGhFVXdIMGtHS004dXNTaE9UcEdH?=
 =?utf-8?B?QmwrdDVQRFZNalBXYkFZTlN0ODB1V3FmV0JORS9OTDVlcDErWnliRk1kYWJy?=
 =?utf-8?B?aDV0NXhBbVZsVVNQZ2lsNXBXeTRYWm1FVDBmNUsyVmwyUlBGSGgyaUtJRTIv?=
 =?utf-8?B?YXRpeHorMXloVHZSYmZFclg4ZmhqRDBYM1R5dlR4R0RaYnNwMGUrR1RaUTQv?=
 =?utf-8?B?UEhycEp5aTZpMVdXc2NocWxyWVFpbUoxQ0lBZjVBU1FCWXgzUUJJak8wSWFm?=
 =?utf-8?B?ZGQ5V0RyZXZuMldpaG5ZY2RYTVRCVzZZa1NGQy9mNWRoTE5ndHU2U2FqSjhi?=
 =?utf-8?B?anZINk5xb01EeW9sNTF1MHduRDZKTEZ2U2lhT2ZjU25BT0RSRlpFcWxiNU1D?=
 =?utf-8?B?RHJXaWRSeHlJNHc4WjNDaWhUNndmN0p1MlBzNHllNFYvQVpBVFlrVjdsZ2lW?=
 =?utf-8?B?Nnh1dnJLQ3EzekZDQUMzaGlaUHVubUkxWHBBS1FpRXFsVlIxbytpVXN0bGdw?=
 =?utf-8?B?U0doZFdCaEVWOXlaczZrbnpwOXJCNEJEUCs1Ykw4UzlFQjBDWU9qNVQxZnJz?=
 =?utf-8?B?RTdIR1N6TjlJRjRzN1g3Tk9hUzZaMkJWTmQrRzhOYkRwNmMwK3hzNW1MWmt4?=
 =?utf-8?B?N3g4cjdwMDB6cG0zc2hkanRja29RVHhCWmw5bDhWOFdrcWVtRURXYm55ekxH?=
 =?utf-8?B?SjFuenQxSjUydG9zWnp0ekplUFVZNWpVQnRobnB2dGlpbThtbE9OSWlWWWZl?=
 =?utf-8?B?cmVoaGFKMnV4MWhLZi9WRnQ2VDkwMVNZSkV4NHk4VDdrRDNLdUxTc3REY2Jo?=
 =?utf-8?B?V3JSUkFYbktvNHRwbmYvc0o0SEkvRkVmTFRCb1dveSt6elNwcFZEcjVHL0xl?=
 =?utf-8?B?cVkyYzQyYlN6WHU2dERRQjI1bkt4bXBkR0ZJSmZRVEJ2ajlOUlNMTXZ6RE9z?=
 =?utf-8?B?NGhlUy9VaGFwbTVDTlRFNXVHUWxkYWlXNVRHMU5qd0hENWRuSXRZRWNnNXZD?=
 =?utf-8?B?anAxWC9JeStQNlJZTmJvUGZaeEwzQ0VNT1BtbVVFcit0c2pZUTRlV2QzS2ZX?=
 =?utf-8?Q?mnxc=3D?=
X-Microsoft-Antispam-Message-Info: tpPCTS+H7Otck3YKrZsKIXXRDZz7rizgAhXZ8BYBumWB7vs7RYnOpGKmEUoZ+4ldx77XuDOUXxnRAaFk6L4gxd6e+TEXFG41x2ckxqllpHdEEPeFjbtAb6xPKdiKY1mS/YmE55VaiQcZTpgwZdsaCu9areMjmUpgMg4kW3RtdrdkL2ul8U9wsUA6kURCLY0U
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;6:8NsqPkfjjoSE5ammYCQpKBKAkQGp1SpMIS/nyJRT1D4SiYLr/DKwMDXPmMfjG+0mxYDUgdFNt792UZYSSdMa/Ta+WPGFcf/ixkzL60fBVHWMN/X/+cOzKnQ7OC2zmmSDouWABB0nROzxA0uL3LVs7eEMnGEpw4dpR3lR4oJfJjJYRk4iNLVvSGw5Y8hXiFsJ7JHIXfUCKUGvuVBm/p8F4UBGXt5Fd9v13DyOHLFe5nod/vyJqV7QSHrrmyzL3419sH7tbgfx16noIX4MUgNlNty00LPH0XEdB6Jwend68XB5SjUr4gSAzWweQL+vH/ybJSfneS3n+/zhAmIbpaSwY9Uwul6R59FzmJq3Cd7g8Yi8ucpIAVMSYrkAcdW5V+OB/Q4ze5hafdGjpvkerVbX6WCJ3dux4ZJlFUwZVScEFk0+yPOk+AkraUtQ4dPaew2EojNlDqOjnyLjxtrKRNwFgA==;5:dSp8ceNd0m6utrOkc4RMnIbCw0/NuufNEWk6C7Je4Su+YZkAI7HeXxJ+vL27YUdKj/qd4cDxeal9K3Dmu6fVIj9ZmQD7nXoVH2RtLxzZkZdltsFmG3KxTtpkZRw5w+3uEfSuepq0xneMynqlNVARLqZ3ak8NxQtR+L967sK3X1M=;24:NtWWrjjRLzCxuZgqsUGyaxJD5vWmwh/xLKklV7/Rhy8HEfEqscIeCe6q18a8kRsUBYyQzVtpJqNorT6XiitS+Igoct/5neFZOxDZ77QctrI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR05MB4583;7:FzNcGIuaH7WRgdVi28gRxcncpsd7HAFVVnKUb1T8fBNis3Dg4fXfM+kvYsK75EXnxNRzjk4is3F3C8KDr0umWSQmSquxDzRskGaIeBSubmaJY/ztv8OgVaXBB16YiYkE5JzKTqSfA0k+hQJ9HBUB6EYLtq8l4JbdHYPNnq8RpukOFcFdRKb5lObPucFomlX6cLoA2B4pcOxqOIR3b3f+oh88HoFJaHX2OoHcN6ItdKUOVD/V/LSZDRtLUx6J9rLn;20:rASMOy4pSp2Wqt7OoLbz0mYa6Q2bPDC7fpYkpb7PaBJDCCpndPAnOocb0a4fAVUd1NznSz8Ocra/aLsu9D4rMcFx88pC1L+J2DfXXglJHspAVla0QNYLpb7r98mlJSqg/NIekUpCkIneYZyjvpg5j4PeHjSWKrJKVAN/AK36zFE=
X-MS-Office365-Filtering-Correlation-Id: e5ed42b0-a2de-4ba0-4526-08d5aaaf75ab
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 13:21:30.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ed42b0-a2de-4ba0-4526-08d5aaaf75ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4583
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robin,

Thanks for the patch. It was some time since I put together that code, 
but I remember hitting something similar to

https://www.linuxquestions.org/questions/linux-kernel-70/%27nents%27-argument-of-dma_unmap_sg-4175621964/

Even if it's clear from the documentation that orig_nents should be used.

/Thomas

On 04/13/2018 05:14 PM, Robin Murphy wrote:
> dma_unmap_sg() should be called with the same number of entries
> originally passed to dma_map_sg(), not the number it returned, which may
> be fewer. Admittedly this driver probably never runs on non-coherent
> architectures where getting that wrong could lead to data loss, but it's
> always good to be correct, and it's trivially easy to fix by just
> restoring the SG table state before the call instead of afterwards.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Found by inspection while poking around TTM users.
>
>   drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
> index 21111fd091f9..971223d39469 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
> @@ -369,9 +369,9 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
>   {
>   	struct device *dev = vmw_tt->dev_priv->dev->dev;
>   
> +	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>   	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
>   		DMA_BIDIRECTIONAL);
> -	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>   }
>   
>   /**
