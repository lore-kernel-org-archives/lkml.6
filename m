Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeCEBIl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:08:41 -0500
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:7079
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752067AbeCEBIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:08:38 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH v4] iommu/amd: Add support for fast IOTLB flushing
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com
References: <1519197585-10546-1-git-send-email-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <f9396eef-26b9-5280-1250-4aaeb0a38c32@amd.com>
Date: Mon, 5 Mar 2018 08:08:21 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519197585-10546-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [110.169.70.58]
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To MWHPR12MB1743.namprd12.prod.outlook.com
 (2603:10b6:300:112::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22a12846-68bf-4a73-08dd-08d582359ff6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1743;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1743;3:JNALa589fdPolPgs3qzwZt6HynaMIYiB4ukbTlqrnu3yZLvybcXrSnj5kNOD5bD/ol/dwpL6yowqaYdLw/wg665ch9h78RtP2vGUq1hardtZvw43ZsNiVMKZRQq5E+k7Vi2i7MGfzCbPitSfTTcrNh7LSjMbgg1kIIYxUiKzm33lMeLdEOav0Z70OBdhYVKgNuZcjQ1xffj0XJrVrsdUHe1SjCqyCR67OEBo7gjL/GjUb5tGOb+/TaJWGWXtIvaA;25:9NwwdssDepO0J1Vz+t8Z6BiWX7iPjJ4Fgd5j2ILTwekBf6gN1JbMjimIjZ3u6O+coigIH6YA+wsfBqOXI5m+QEN8qrO1ZXPAiORYmpFFkhI6/E83+wUgpenD2EktHD7LDNrwkG3YOC47txKhwz2eXTu7JIKVO+9HuYlaBclvabErNOQcmrIKy6/qvn6R4W+6E3mQZrINPb112X5rkW9OnyaI7240Ja6+jXBo5YBsIUmSjj+3DudkBfYZqtvu+9XZnb/sh2ua6oMFYdU3jF6c1Jg+B/CP6pWU66xfpqXiWG3zdZ+dQnMH53K0DfwWMU6sz+jd9z8TBRTiLYP7kbmKAg==;31:ox/LeNN4O4hruMHsPeEvKEiy0cL9abcKK1bmYJyaijF+KeFapHxY5Xe2BoPuOjy8fa2xyn51MoFXF0NUJizzgyAClw3av0THaSo4Gh/pGqm5ncC1vtNcbcC2WlCu0nKU+bnteItx0gJkI4Qcxl1sliuAgHN+y5zUv6AM2Iw8Jj5VIncf9maiU6ft9gR+jxPxUA3WDdGg8u8z/fjrIJi+pYi0wj/nw6jAxSh2Xv0gDP0=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1743:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1743;20:fR+WsFXvFlplPh/cLLAvcewJeGmDydPlVyGI99DpGYiX8tf71NmLraX1AU41c08hkQUfyuvnu+/i1eskp8Ss//eboPGyvVLsxC/v/2y0rw6iDzZytU8w3ZNY5d49VHa9gce7/qYAUlrYx25pYhZAVB0R6CDQRHRnMYT61utgHGkyiJhnc+Jzlr+PBKXkjwzDnmQm08SKAeafy1Q3Ww+ndavzPyoB9EtaOWrlYKB2JWM5rvjDgtUAPAafxTfRPMkbew7J/VljQpfAugBlpRqJLHBpsw1qD7YrlQ6A7yPGfjU54rCgZ2PyN5QcVRvnS/gXX+hyYJ6Xsw83kCK5PxD+eBg1SbLj0VGWUTK+IeYe9qhYjvBaRfaun0jseOK/OU7T2/YMiBqMwTewXFM1cT5wJesF48bpdypDvSz2G2He4863hK0aDgTMhcD40IGuJzxUmClqDwzyhDfSfxwjGMNou3ZFJv0n+Ke5xtTQSFHexW6Zkha1W6X3/dClJyCRVUzC;4:JMjbUjo+TrD7XHarfYxsTSsh5O6UXy1AlauoeNh7xBVhutLSZpgfxR7VeAM7eeGMnkP6UNRc28wuXIrv8YUbCKCrKO/CfUA0tDD9PPLq7lZiLWRfO51jHQL/U2I4sIlNqztnawQ3ZSF8oU2md3MZJARhdX57rHh4ztf2GAWU2Gjg64iNNi/jigrezdQzq3vp3Uz9EV12RQcHeTju6LTiQOXjjacHU41hXQyLwbqYu5z/eT6cN5Sik0gng0r73p2smERNJA/8qITTIKIpj1sXIOHwsoI9ZFdHNJDabDSTpTkpzGcZbXTcEJq0B9ot1ea/
X-Microsoft-Antispam-PRVS: <MWHPR12MB17437824584097A5DADE639EF3DA0@MWHPR12MB1743.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1743;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1743;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(199004)(189003)(81166006)(81156014)(58126008)(2950100002)(6666003)(25786009)(47776003)(8936002)(97736004)(5660300001)(36756003)(230700001)(229853002)(64126003)(26005)(31686004)(16526019)(105586002)(186003)(106356001)(65826007)(7736002)(316002)(59450400001)(8676002)(72206003)(6486002)(50466002)(6116002)(3846002)(6506007)(386003)(53546011)(31696002)(6246003)(23676004)(2486003)(52146003)(52116002)(5890100001)(86362001)(66066001)(68736007)(65956001)(65806001)(53936002)(6512007)(6306002)(76176011)(67846002)(478600001)(4326008)(2906002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1743;H:Suravees-MacBook-Pro-15.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzQzOzIzOk1UUVMxRDZ6UytKdG50b2VGTHpKOXdLYlZk?=
 =?utf-8?B?T3JMa2JhRWpCbXJ5MUhkTXMzb3UxaVJRWk9ENDV5VDlRTUJPanNHRCtqdFBE?=
 =?utf-8?B?dHZaVGdvWVB3b0JNUzlXbzNQMEhxbjNoZnRhT1MyUU5QWG1aY05uKzRhcUhy?=
 =?utf-8?B?UmwvYVErV292aFBJUG9SQU5aUjltZnowUmJsRUVBby80cjBIR1NscUthS1Rx?=
 =?utf-8?B?emlaYTRPdVppaExLL25rTm9rUW1DZ1JKWUkxcytEaXdhS0RVWEp0YkZPWllG?=
 =?utf-8?B?Njc4MUQrM0g4L0JzVFZjSTYrenIzQWtudC9zcXZ5dHpqT3oxR1RrSlNhMTI0?=
 =?utf-8?B?bE1idldaVDFsVkdNOVVUNjRFN3BHUy9YVmVFa0d4TW5vS3RiT1U3LzlVL0pR?=
 =?utf-8?B?T1FWbk56VTNIMGd1YysyQ0JNZjlBeitUaXBmSUZQK0NKN0ZsWks4MWNoWHRE?=
 =?utf-8?B?WTQ2VmVNWVkvZnJRMlFseXlzM1p1VEJ0d2VuZE9mZC9IdksxRHA5c0RPcVZz?=
 =?utf-8?B?S2dYcFZZWTcwZzA0SGRQajJJMlp5WEUzMTRWaWRUKysxNFhMbVhqMTJ3K0I2?=
 =?utf-8?B?SDdieDhBN3BuYWFDRWh2Q25ibjZmYVdUeDdLZ1NLQXJLYllKR0NuVkpraHQw?=
 =?utf-8?B?WDhpdW1pRUhJYjdDOTlXd3NrcVltekZtRXdzc3pzRWpkQ3pXSGR4c1lnUXho?=
 =?utf-8?B?MWFTT255aThKR3NoTlZrOXdIcTdEM1pOVjIwaXo4ZW8wd1VXRGNacm9QYk1G?=
 =?utf-8?B?K1l2dnJNZ016TGMrMkRWbE41bmJEU09QK29kYnVvbkx3MkUyYVVIT0lYNVgw?=
 =?utf-8?B?RStlTkJOK0pJa3IwcjRlNEU3UWs5aWthMnJ6YURJRGRzeG1GUUJieEUrMVN5?=
 =?utf-8?B?ZTJWMUtheElQSVh2MjlBQUw0SkJzaGROVUViZktvRFVrZW9rRmp2Zk8rL3dM?=
 =?utf-8?B?UXNTZFJQRFJVcVRjKzFoTE5XUnVEZEQ2Z0RidW1SRVgxVG5OcnFuNFFNNmhW?=
 =?utf-8?B?UGNZa1kra2NuMEE2VUR0MHAvUGoxQVExZ1BmR3FjS0plTzdPbUNSZGNMWlJE?=
 =?utf-8?B?QmlwbHBvOC9LNWpUK3VuUzdpQWVRcGt3V21ySU91Wmw4ZFovblc2SE5EZ05x?=
 =?utf-8?B?bXFZR1RsblQ1TVc3dnQ0NC9sSEt6L3RXRnJZcXU4TzQ2WjRJUHZxalkwK2Nt?=
 =?utf-8?B?M0FlWERMN2FZaVY1VkVpNzVHdHJvV0Z1SVJ5UEhkbE50Yk4yK1VDNXhKejBV?=
 =?utf-8?B?RCt5UGM5eUZvMnJNeHB2K1JVY2g3WUpxVE9meVJrSUVJL0VETk5qYlBneGNt?=
 =?utf-8?B?M1FtLzVMRkphTjY5QjRKdWh2Tit5WnpXWW9qS042S1MxOHI1T2pLbGJma2Rm?=
 =?utf-8?B?dG0yc3Z4RTgwc2dXMWgwREpETG5xbVY3OW1rekJha1Z2b3JKU2JKVEhCUjRj?=
 =?utf-8?B?SzVoRS9uMlozZXFLY1U5SzFJTHpZc2VrVlVQbVZUT0dxSzVmTWdXNjRIWWQv?=
 =?utf-8?B?STZoSXFab25ER0thcGxGeDBScHFQTmFSVmNXRkdFWHFQNk05VWoyZHNkMW85?=
 =?utf-8?B?SXJoN0pQbHQyZUdEWmZiK3RsS0Q5TEpGOExPVGVRcUFtYTQzYUFXTE54Z1dG?=
 =?utf-8?B?dmVEVUVVUHQwZ0E4RStLWFovczZneWZ6bjJPc3RmWGFjMzNoK2NSY3gyNzA5?=
 =?utf-8?B?ZnhCaTFWWUVZTmJPVjA4VEZkUlk4disxYnJiQlp5MTEzQnE1bkFjR3pmZXZK?=
 =?utf-8?B?Lzg1QVIrQmZYNHlZS0E1MFFaTGV3ZHgvMGxZWWFCSHUxRy9kMHFka0YxS01m?=
 =?utf-8?B?U2JNZGdMZXRPZzFVVUN2K3UwS2hia1g2bHJ5d1ZWNmoxNWVhWU9JTTl2ZzFX?=
 =?utf-8?Q?LZco2X5JBgtQDzZE+wv9Kp33tMD+7H/1?=
X-Microsoft-Antispam-Message-Info: pq1P9lFcCtQP4PSmuB/ZGw4jzhcJXUtVU6IrCxhm/vgF5aDJFHAqW6T4hsAiowRUzDrPbt727szIGvuIIpxnmm4awu3DMqeMW+qXvps+oBe8gSasjbh5lyGYheNPXrKiZ0gJf5zCei7bQwPPZLZY2RNtoAxrYWMUw9uSSkxW6yt8iRGN/SutB+hNYpzQhvxM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1743;6:ee4Ly3NhK4zb+raVGLucvXyx7FSex2x9APGMNQz4GzRBDfGzqERctfW3i107BgUgjKlseATSKzvHKHPKyfIVFvyKWFV5E+G8W2cDF+3N6RC4fwZ409twIKMtZIXx/VD3NsRSpbL1AyH+cJ0I0ZKKeTF+XZ/iAxLz9yFjSyIHkHVMDwyIP6u51Fb6f3lltWaHR6EC8Z+Z2zz5jNBOFUiw083ZOGYEFbDyjqpED2G8mGLSgleVSjuVpPxAhcPlCowrDmoDfP9dzRNZNZJp7wjkom1jHQZRc1guVL2Hiq0RyxWGjssHC69apTPeVEiMXady48gDNlQIW8UQSOL5htdsKFDtgwUMoEws0SLA11w2/tg=;5:ajVb4ypdHMW2iVlLzNRj/LrXFZwxChTt+w3VaLE4gMHjCWmpp4cDmgChVtttfzirD38e1m4U3c3ip2I8X2CzRHH4C747YhUWLoEcKr6JRsJsfDlyKMu4dNeMnrrxH+2NjPzXdJis7JqYvbWz20Ml1fltILimRvBLTG06b3C7as8=;24:NMRKFiqFCFRrVWntB0vhaUD0HmUZccylJakdStkqa/ScWAD1/eicw5PeKbH1y5lVomRQX79go8HSLaO5jSsk78JrWOL88rjgcA8FNqBrwHk=;7:alKs9WsOgaWubxldGmwhdi28mLBSoOsNa/uMryEJztFe3mQlLK6txMrvXWXmzL2WzDE2oAr+qd9OLFGM5hhclmUHwijgOLkoNVJ0hh3ftJgwBUUFWfNj10ga0sIrcu/uBfrh2noqNVL5sAxQRNzsCWei6j5u8g+2z6HPBJx2sBJwELbyZ4CQttt590rqXyCBm3KmRvHt8BB+9ztigdUjNxN11EB1/JGVz0+D7znbaZUftV1tCgnRmqlBidCN3KVj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1743;20:sinTjopzN5fW+bZsqLLZ/bsOGcoGUBzRz1ogXsp3rFHVt8NLZMHgZkWbyDLTh444khHDH1puLbi3G9bA8Fl0/wySdBWkqfig9sdyS2gvuFdehEhXh4D+FLut0Msme1p/6ESU2TrjezLiOfSNiwc+LyDtiQ+pBOHlVTlt3l8LAul3MtPDD6CFRJXAEkG9uRG3N/B03PdYyj7+QsNg4f2MBTKBoDZm5nqKgJfAcjbrPGqqbqXqM9+kxJqKAr1xH5V4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 01:08:35.6841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a12846-68bf-4a73-08dd-08d582359ff6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1743
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping..

Joerg, when you get a chance, would you please let me know if you have any other concerns for this v4.

Thanks,
Suravee

On 2/21/18 2:19 PM, Suravee Suthikulpanit wrote:
> Since AMD IOMMU driver currently flushes all TLB entries
> when page size is more than one, use the same interface
> for both iommu_ops.flush_iotlb_all() and iommu_ops.iotlb_sync().
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Changes from v3 (https://patchwork.kernel.org/patch/10193235)
>   * Change amd_iommu_iotlb_range_add() to no-op and iotlb_sync()
>     to full domain flush for now since we currently flush all entries
>     when the page size is more than one.
>   * Fine-grained invalidation will be introduced in subsequent
>     patch series.
> 
>   drivers/iommu/amd_iommu.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index fed8059..6061a8d 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3043,9 +3043,6 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
>   	unmap_size = iommu_unmap_page(domain, iova, page_size);
>   	mutex_unlock(&domain->api_lock);
>   
> -	domain_flush_tlb_pde(domain);
> -	domain_flush_complete(domain);
> -
>   	return unmap_size;
>   }
>   
> @@ -3163,6 +3160,19 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return dev_data->defer_attach;
>   }
>   
> +static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct protection_domain *dom = to_pdomain(domain);
> +
> +	domain_flush_tlb_pde(dom);
> +	domain_flush_complete(dom);
> +}
> +
> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +}
> +
>   const struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
> @@ -3181,6 +3191,9 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	.apply_resv_region = amd_iommu_apply_resv_region,
>   	.is_attach_deferred = amd_iommu_is_attach_deferred,
>   	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
> +	.iotlb_range_add = amd_iommu_iotlb_range_add,
> +	.iotlb_sync = amd_iommu_flush_iotlb_all,
>   };
>   
>   /*****************************************************************************
> 
