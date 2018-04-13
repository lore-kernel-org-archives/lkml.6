Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeDMH7v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:59:51 -0400
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:11715
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750960AbeDMH7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:59:49 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.ie; dkim=none (message not signed)
 header.d=none;linux.ie; dmarc=permerror action=none header.from=amd.com;
Date: Fri, 13 Apr 2018 16:04:38 +0800
From: Huang Rui <ray.huang@amd.com>
To: Mathieu Malaterre <malat@debian.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, <amd-gfx@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: change function signature to pass full range
Message-ID: <20180413080437.GB10330@hr-amur2>
References: <20180412193333.4951-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180412193333.4951-1-malat@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(396003)(39860400002)(2980300002)(428003)(199004)(189003)(305945005)(77096007)(33896004)(478600001)(76176011)(186003)(8676002)(26005)(72206003)(59450400001)(47136003)(106466001)(2906002)(68736007)(48336001)(58126008)(5660300001)(54906003)(316002)(33656002)(966005)(2870700001)(356003)(23696002)(486006)(126002)(55016002)(50466002)(47776003)(81156014)(53936002)(81166006)(97736004)(426003)(9686003)(476003)(6306002)(446003)(11346002)(8936002)(229853002)(105586002)(6666003)(6916009)(33716001)(336012)(4326008)(6246003)(104016004)(86362001)(1076002)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2421;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT017;1:gYSWmok4/FK2uyn2UH2wnEOCg2Gei867cu177xkxXmUcwH0WVdCFtUw8iTbIIdKLAaI4UESA0xFOG1H3JcDg8/x8krb1Mo6abRVc7W73UOW6VTa1z63d+c5YCHnkBf2i
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR12MB2421;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;3:9m3Z9VFt3tmmJ4nWDE+cShXYiCKJi3dWGp4iQ6GMKyx+yPa1G2FUKthWFcwfF1Pqx+H6fqfnoMcd5AcV0YeovrZuJkGf22fPWHXh13vP3R7cW9ZMrJ639dBpPa3DFrO4znYsJ99OvoCD3MX+pD4taFZ0uLPXOprBRssONGtclXq9fYvyHwD/5RpfyBFLbKvk7W9ic8SaNoyiO5g/LG4TDt1ycXzOAVac2oPfpxlOOqPJUJ9vZ7lCH4cRa/ft6pv5z8dF+ROFqCiZp2XmDnayOBddIRkKSRg2O6RvFqDlxFiRvmjk5pQ/nVDqaVS9fkZuNUFyfQySlDLeh/50QkhMJS+wwOOzGqs34uIMbV+YM3A=;25:pdtp0wZru5Rjhp/7CvTlh7/t5FNIvuH2Uh8sIAyk3gKnhyTeiqtlMU+mCKL7Kz1o5hCwCLdS3dzyKir9t2uaGtBjBIXQCWF26k9IjdQkjtukHX6dXa39UggH3S2lD6eKmznHFX5pHlDnUsrqCSYOh15kiHF1OIwIhsIExaGPfD5VAXX86KE0nf5sAtKAcvJtcpm6cZVoitQE41DjA9Yi6z9Y5v01SUZTJzfL3r93G2a2eqxj4XfOCz2s99a76OfDdr94cOn8W9341IF8PZQtLNJlGtmGi+5q1jJXyLtypejButIWDnpzRy4CN5/Zj0cw0xT7gfOfNYU6+MrTV8pocQ==
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;31:lOmIJIdik9OCqmxVFFQx1R0IMhNpdPQtWEFX2YuJ1PmxS7dSxRcoNo7UP5eSV+kpusABhvLTzcx59VMujKCz8buoNS27Vr62zlSfl8eAbioGJyopLgIuh4M6eU2YUrrchfNZGn3jTPZenHBIc8P3/6/3Vgi3VG/j6UghxDnzl4lLZV2X6YMFdve8bESHkFE35GDJ5H3jqezZe9RjL41dcdS5/C7BMJmJfRBCA6IByrc=;20:U/N7VpYWNDOWXxSPggcTgWcPbOApqPu+PIT4+FfCYJ0T+iY0nPxXgOawQY1/8sxEXvOj+pCjCeaZsSHB7258EzGQzYfgG4FTe/jAtmpdnT9mq2crAhATMBT2tyU0fVQ3oaHt8C/8X4qgEB2F+mrsc3GPXIYVWVVDuyQFv5LI1cPyLlnzhGNkEx/y33Yg9LHbIX2ActogHBZWv0se6jcMw1A6vR+SNTe4VUxtSNNjO8Pg7gj2TbrR2ixxsUGw1e3KP/b+UE0a7RcBzATZYn7CQqdtQwKT5HcxH/gRrSWHimv/s7ZS/ysuK3mmCzAW3ceynmYZbI5e6mZTaG8lE1nEHJvrnTeM50wlNsVSJlO7CeeMqKmpAgtJmwzuzOiIoYCcV5ppNQvd+CHnBhMv+IW049J7/TX05QALryi4JUmsg4E1RaS7Go//srEjBLgfw7ItM2DaCEn67cyCq1vL5A0kTnEfjZp9z4s8e9t9qG2bp+3FFN2UwYa3vzTnecFKRT1u
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421EEDBC9795CA2A9790618ECB30@DM5PR12MB2421.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB2421;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2421;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;4:SmCrgdIUvZGgOG9flA7kq2+aZKkdtjYQ89IOMDwccpxLbs0xDslcayWx2JCdEhDmtUso3oHbjsReB4shl6v6oJvMCKWmBLqNcmsR11x/oJ4+Am9I31sriCXVJtM6w/pppwYJ/kYa08JEaqrQsD8sBDyiuYJP71hLDfb+lt6F9r+Lz/mqJEqBL8faNllNbJxy4kw+6aXKy7Ji+nacIrVa+aIlqOhcw9/0dKf3eKGAqZVgzem+MGFPov2KTeZ3PxRbJyMPrfUAZfqxG7FrSmBXSuG4+NTA72znrkZdlvFiJEzobbmEQK5BaJN2OXpPrvgH3fo5jlcGjXi3w64DqhoKID5g1EXFq5VcWRJcSZrpdxs=
X-Forefront-PRVS: 0641678E68
X-Microsoft-Exchange-Diagnostics: =?gb2312?B?MTtETTVQUjEyTUIyNDIxOzIzOjdidkI1OFVxZkdIcEdPbVRCUCs5ZVFwTkJj?=
 =?gb2312?B?WFJ3d2pGTTNGdEFpRHh4Q0ZZS3c4NzhMOTc1VFIweVBiNnRka2RXcXM2RXQ3?=
 =?gb2312?B?OEFyRVNPUzYxQkU5azNYZ2Q0MXN3K3RvdG8zRWF0Ri9zQUFxNGJnbGZXeEV5?=
 =?gb2312?B?YkVVNCt0ZmJaTlM1RUlSc2o5WHpWS3dua09QN0NydjFiL3dmV1dtWEpxcko0?=
 =?gb2312?B?RWhQdlZ4Q0hvYmJ0SzkwdGFxaHQ4Qk9XMDgzeDZvZU5MdkFLWlZMRTNUSC9O?=
 =?gb2312?B?dS96Y0QxWEJGUU9ad2VMQko0TXdpUTVBVnhWeHV1OEh5R0p0eEVwcWhGQ21G?=
 =?gb2312?B?OXV2SEJHenhEZVlzc3h3Z2d5QWVzaTVpdDNFQ2RiNjFSMUFKNVJsT1pHQjNu?=
 =?gb2312?B?UmJ2S0YvVnN3OHBZdFFjcEdCUjNEWDhsMG5RcnRqcE1mcGdHc240eEtQS1F0?=
 =?gb2312?B?UzhVaWorTDIxd3ZwRDVRTjIwSWdUaTY4N0dZSU9qU1A5bUdqRS9ENGVZZW1U?=
 =?gb2312?B?T0NQUjBNQkJuWUI5MDRiNEhOajM4enFBakM1MHpGN1U1ZTc5Q0JIVUc2L2tH?=
 =?gb2312?B?K2NFTnZzclpjWWIrS1BBd0pDWUxLT0dObG5CaysyZHNGUGNFSFh6b255cFV1?=
 =?gb2312?B?QVA3WWpUOFRhbFQ3OHlaSmIyWS9WbEtJM1BxZmNmaUJCRmhkZGdKOWZMMENW?=
 =?gb2312?B?cTFwT3dGUklBZ3hhUi9pR2Mwd3E0Rmo4NTUyL25uTnhSenhXeWJlako0MmdC?=
 =?gb2312?B?TGRod0NJaklQWUh0dUxKK2JSQzVsTHVGKzdvYi9Qd1F4MTFTa1ArRm1tTm8y?=
 =?gb2312?B?c0lPdjhOUm1kdnc3QzFRMk1sU0JaOXMxRnBtaUJ6OEJmblZJSkxId2Q5NXo0?=
 =?gb2312?B?M0o5ckZ0Ti92WVFTeW8xdWtYeTcxbCtHM3REZEZ1bkZGR0hlb0JINjU0YjBV?=
 =?gb2312?B?ZmpDbjFQc2tJRitJTGwvWE9nWkJLZytkZlJ5YnpEWE1KaE5oV1J1Z2U4cGZE?=
 =?gb2312?B?WjFkNEdkQmRmNitDRmluaEFZMFY2Q2JYSml1KzZtTTZwY1hkUi8rb0pncndz?=
 =?gb2312?B?WDNUQjZzakNMaXh5QXNKckhLUGhNM2lTRkZabU00S3ArSUxWZVBmdUZaUGpW?=
 =?gb2312?B?Q0JJWUkzbVA1Y0RDZG1rQjN5KzhaRWQvVHBtalJ1TUh2N294bFdaTjAvL25X?=
 =?gb2312?B?ejAvWkoxZWppcVplUUJTOUh0SzF4Z1dwT08zeHg0bThDMnBZTVF1OThCSThR?=
 =?gb2312?B?Q25iS2xMdUg0TzdJM0RDZE1PR3JiU1hEbDh6M3RtQnFKN1F0T2xTV1pCQkl2?=
 =?gb2312?B?NVh0b3REUm8xUG9OOXN4NHBuaWpyTUJMVzZ1UUdEL1N6SHNMbE1ReVJyRVd0?=
 =?gb2312?B?UkRacTJuUm9MaTBROXZqQytmUktwN0VqUFBDcG9iWHRhc3hZcW9idUM5cm5V?=
 =?gb2312?B?WjA1TkhxZ0w3YXBFM2hIbEwvbEpKeDJxSkZFVlFnRUFOVVVKam1HTlkzVEVv?=
 =?gb2312?B?K201SUtNczB3UzBBbWxhK01XRWRpNW0xaGZucGZQS2RpWk1PbUE0b1VFZm02?=
 =?gb2312?B?a01McWtpY3FkRnJybXBUQmgwUTZzZ2VSSXZvL2s4aGs2VUJ1RTN0RkpkbmNS?=
 =?gb2312?B?NVM5VlVNY0F2ejZTdFl5K3NrVW5tejVHN0h3MmxrZUo0b2NRSTRNU3RFckY2?=
 =?gb2312?B?QzA2a1BabTh1ekV4czlxcDljSDJzeHlxYm9HL2VBOGZYN2VkVjh2R0ZIUENt?=
 =?gb2312?B?SmNuaVRuOEtKVVpwcE1HL1NWNjlwN25aWUZqZzdpTzJCK1hqOVdUVTRZdFBW?=
 =?gb2312?B?Vks2aW12emhTdnlvOXVqQTN2RExrRncxK0tQMmJsUGVRdGZhbGVsRVhjQnNL?=
 =?gb2312?Q?x8N/wBL2R1U=3D?=
X-Microsoft-Antispam-Message-Info: skiCuo8Z/AkmOA+RUYOxIu690F0Re3py18RTd+Ls8sQ6l0/GE5T3ftCp/Ijyf/4Mfye4jNSa5gso8HSEvev0YHiD6LmJnsuxwTBkJIJfZr6FAsDipf+s0+QG6w9+8BOZo5zxlq1EiXp/mf/8R01Igjb1rPv5mU7wn1jUyV9TfOghOPhBIUY6/SXRV6WKC5JC
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;6:gKaTN1FXDuvneCaqdHucJZWWTBDruWpCaPivrv+eVZmxScoPWCRv9jCY/tMPCPhtIORsq1oUILRFiyM2fRF09/TTQl1Q4wL+d+P7ZAx264uGFZcipe3HVkvLVB0zRTs9ElNMXreW974f5ioSBwgcfi2GKlzPsEJMqNFJhArCw84KZ23DAhyLsyztpbsMFr/i/ZoC1VubAvxynxjRJSNNZ3vuBxRtEm+CzZ1jkY/aAjCJO8G1Ls5TRruX7OL9zxsAAc4aCkLIQ87YD5s8otdCBo3vHL4oViQyuMB5l+vNtr1Q+hODBvp9kklP5kvhkSB/iuqzo+2MYyD5mAaSWgkRFnHSy71B6V+EAaYLjfasn9iAV7BGyB32nMKO/n80sNNcUwJDn9EkytX4CI8sZMue4hV8YYdLbZoMFCzFTWt5lRW6+1leFAB8hLqtqOy5jy450G1zpkxRkJGb94lAazp9wQ==;5:bGA+HRsLLArRwH8cV8GeEVrGLacTHp5GVK2TQTnVqhtEsstSPMZWrGw327OmQLNWjUrc04c55VqlZpBQrlthOvQIvoyi53jDRdOpj1L5Xr/I1oMs3WGe+I0JNRQ/J3697aG+IEKb43lVol7igHCICvIzp6AnlQtS5vX+7T2lhoE=;24:wBY0B6PBrOl6bCjBw982sA2lw07v8UJLpkby+3IPzRvDvQIQL0Pd0v6a4oWL/82Pg/v+jQ+Jiduysy7f9laVyAQuQ+t0BdnzMW9eo55kzzc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;7:iw/Fitx8++2qvhWu5xFzEbJPihLNI9pj8XBuogEyvB8G8KAWPbadIwWieYo8mJ15Op9IIB2feohy26wnm6lw3SvxMNMLUrhoQX/xwI8v5b1eGZwmJQpIm7QQobP/SYfuhPvpSu4c6wdMoF4utC1p8t74jYG2kWOWvGyRRmSK8BhzFbBN97wQDNt/v97uy7k1zNPBBLDD2wLtVsLVWlTohUH1sha/JSDStDFmNfpvH5ZD9CsEo3kJVMUofta93lhP;20:S++a1sRBxRvPDG5DizfT/DHqTYDn1AonDJonA1TT1G5TVQq5pn/WSdvUdp8vLkRFoCKkSvVCnH04na2rOVLd16jXM0r608zbCP8R4BG+HfiZtaLSdB/ukKj3zcpBRM5rZhfDutdFHZQ4ahEf+tPYxn7Vd1FnlGz1hqx7iZpKxFSOt8XonA8caCVsR0ZggIfPvby8H9J+P3yfFJbNEWEtnX8MFZLwENVXGwA9ZdoCIBNnFd70xI+7pW28BPfb9IZW
X-MS-Office365-Filtering-Correlation-Id: c72e5f2e-8040-4a32-229e-08d5a1148676
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 07:59:46.8537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72e5f2e-8040-4a32-229e-08d5a1148676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 09:33:33PM +0200, Mathieu Malaterre wrote:
> In function ¡®radeon_process_i2c_ch¡¯ a comparison of a u8 value against
> 255 is done. Since it is always false, change the signature of this
> function to use an `int` instead, which match the type used in caller:
> `radeon_atom_hw_i2c_xfer`.
> 
> Fix the following warning triggered with W=1:
> 
>   CC [M]  drivers/gpu/drm/radeon/atombios_i2c.o
>   drivers/gpu/drm/radeon/atombios_i2c.c: In function ¡®radeon_process_i2c_ch¡¯:
>   drivers/gpu/drm/radeon/atombios_i2c.c:71:11: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>    if (num > ATOM_MAX_HW_I2C_READ) {
>            ^
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/radeon/atombios_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/radeon/atombios_i2c.c
> index 4157780585a0..9022e9af11a0 100644
> --- a/drivers/gpu/drm/radeon/atombios_i2c.c
> +++ b/drivers/gpu/drm/radeon/atombios_i2c.c
> @@ -35,7 +35,7 @@
>  
>  static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
>  				 u8 slave_addr, u8 flags,
> -				 u8 *buf, u8 num)
> +				 u8 *buf, int num)
>  {
>  	struct drm_device *dev = chan->dev;
>  	struct radeon_device *rdev = dev->dev_private;
> -- 
> 2.11.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
