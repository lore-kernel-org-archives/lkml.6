Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeEKIte (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:49:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752277AbeEKItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:49:31 -0400
Subject: Re: [PATCH v5 4/7] ocxl: Rename pnv_ocxl_spa_remove_pe to clarify
 it's action
To: "Alastair D'Silva" <alastair@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
        felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 10:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051108-0008-0000-0000-000004F578DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051108-0009-0000-0000-00001E89C9B9
Message-Id: <76f8c289-7322-5a6b-b109-8ca35b2f38d5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/05/2018 à 08:13, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The function removes the process element from NPU cache.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

>   arch/powerpc/include/asm/pnv-ocxl.h   | 2 +-
>   arch/powerpc/platforms/powernv/ocxl.c | 4 ++--
>   drivers/misc/ocxl/link.c              | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index f6945d3bc971..208b5503f4ed 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -28,7 +28,7 @@ extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
>   extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
>   			void **platform_data);
>   extern void pnv_ocxl_spa_release(void *platform_data);
> -extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
> +extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
> 
>   extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>   extern void pnv_ocxl_free_xive_irq(u32 irq);
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index fa9b53af3c7b..8c65aacda9c8 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -475,7 +475,7 @@ void pnv_ocxl_spa_release(void *platform_data)
>   }
>   EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
> 
> -int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
> +int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>   {
>   	struct spa_data *data = (struct spa_data *) platform_data;
>   	int rc;
> @@ -483,7 +483,7 @@ int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
>   	rc = opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
>   	return rc;
>   }
> -EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe);
> +EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe_from_cache);
> 
>   int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr)
>   {
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index f30790582dc0..656e8610eec2 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -599,7 +599,7 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
>   	 * On powerpc, the entry needs to be cleared from the context
>   	 * cache of the NPU.
>   	 */
> -	rc = pnv_ocxl_spa_remove_pe(link->platform_data, pe_handle);
> +	rc = pnv_ocxl_spa_remove_pe_from_cache(link->platform_data, pe_handle);
>   	WARN_ON(rc);
> 
>   	pe_data = radix_tree_delete(&spa->pe_tree, pe_handle);
> 
