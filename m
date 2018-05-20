Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeETCcr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:32:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:23810 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeETCcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:32:46 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180520023244epoutp03a811ec31471f875decc2e77772ac170e~wOZAGVK0G1685116851epoutp03T
X-AuditID: b6c32a4a-a61ff700000010d4-02-5b00de4b64d8
Subject: Re: [PATCH V3] scsi: ufs: Add specific callback for setting DMA
 mask
To: linux-scsi@vger.kernel.o, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        subhashj@codeaurora.org, vinholikatti@gmail.com,
        shaik.ameer@samsung.com
From: Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <2b9cad84-4be0-dc29-e60a-6d55fd0b61f8@samsung.com>
Date: Sun, 20 May 2018 07:50:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526782262-9808-1-git-send-email-bharat.uppal@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG+2/Xe6/S6jo1TwpJIyEV30plhKkfIm4a2RdBlMiL3lTUOTbf
        KRKNEk3JyMS51FG0MSXDfDeXbtZcZpGuFGmmpEWRpllmGpbbneS33znnOTzngUPyhZ0OHmS6
        JIeVSZhMEe6EdRp8fP1jpnclBg3UE2JttUQ83qvExaaHZkKsNm7yxEOzfYR48m4PLu5WFUUR
        9HhVJY/uUVgIekb/CKOX56cwuqpdi+jHmg5Er7QdOEskOIWnsJnpeawsMCLJKU1VV4qkBrcC
        43AFvxjVOJcjRxKoEFjvbsHLkRMppPoQmN+vEVzxHcGYqs5erCL43DnP315RG6/zuUE/giej
        xYgrFhDc1JfhVpULFQtvR5Q2dqWOQY1y3SbiU6UIOq6MEtYBTvmBpbadZ2UBFQHKoQbMyhjl
        DSb9ELKyGxUPJZ9+E5zGGUx1czaNI0WDWdVt2+VT7jA112hnL+haUNrOA+obDqrSegfu7hMw
        0mKxZ3CBL8Z2gmMPWFnsxznOgCWjya65CIrXlfZ+JAyYlVvG5JaBD7T2BnLt41D8rMOB890D
        lRtzPKsEKAGUXRVyEm8oXXyDcewJ1RUV9mtoGNCN4jeQSLEjmWJHGsWONIr/xk0I06L9rFSe
        lcrKQ6VHJGx+gJzJkudKUgOSs7PakO2bfKO70f2Xp/WIIpFotyAoZ1ei0IHJkxdm6RGQfJGr
        4AG71RKkMIVFrCz7vCw3k5XrkSeJidwFqyGbCUIqlclhM1hWysq2pzzS0aMYHR5MDNVNFNyb
        8N/70/DUEumnPRofVd0SrbmluxQ23XWwNVnnrUr+6nZb7dNs8LpzOVa6vNZcx7jt02jGy1PO
        GIfH3v2t/XjtQonnsDn63Ozg+AuDydzoX+KvtvxgnBtO5WviDgUnqTfCfdbnwvoLp/6cTFPE
        xM3oJjN/fXj+aqlJhMnTmGBfvkzO/AMrCVOYSQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTtfrHkO0wZ23gharJuZZXN41h83i
        5IYr7BbLj/9jsjjycDe7xY3FO9ksdiyscmD3uNzXy+Sxc9Zddo8HhzazeHx8eovFo2/LKkaP
        PSu2Mnp83iQXwB7FZZOSmpNZllqkb5fAlbFwZjNjwWHRiuMnupkbGKcKdjFyckgImEgsP97D
        3MXIxSEksJtR4uvev2wQCWmJ6xsnsEPYwhIr/z1nhyh6zSjR/e4iWJGwgK/E7cVbWUFsEQEr
        ialzfjGCFDELNDNKXHz2mAmiYzajxNV515hBqtgEtCXuTt/CBGLzCthJzDkyjwXEZhFQlTh5
        6AgjiC0qECFx7/wnNogaQYmTM5+A1XAKeEhcWbgDrJdZwExi3uaHzBC2uMStJ/Oh4vIS29/O
        YZ7AKDQLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcCxp
        ae1gPHEi/hCjAAejEg+vQQlDtBBrYllxZe4hRgkOZiUR3nWpQCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MC858N5FyOy6112Zz72/FSe5ngno0PgZr
        Xfy4Y8Ijy7vf11+1LX1rLh1U9Xfx39TIt+YMfOvins2auTFR1/Rdh+DE2Y+ZCrpMtr82ndA6
        K41Dde1HlcTkyryrBzfWVPwI08xg/r2oxsRGM5l5aXqjUIOFl4Nuec2D0LzVDFPiN++sCpq2
        fcprJZbijERDLeai4kQAKZHaf6ECAAA=
X-CMS-MailID: 20180520023242epcas5p17d574844d1c529b7483199a0485144b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180520023242epcas5p17d574844d1c529b7483199a0485144b2
CMS-TYPE: 105P
X-CMS-RootMailID: 20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3
X-RootMTR: 20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3
References: <CGME20180520022321epcas1p4b0084a15aca3e5aea02700e272149ef3@epcas1p4.samsung.com>
        <1526782262-9808-1-git-send-email-bharat.uppal@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
Please ignore the below patch, sorry for the noise.
Will send updated patch soon.

Regards,
Alim

On 05/20/2018 07:41 AM, Bharat Uppal wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> Currently DMA mask for UFS HCI is set by reading CAP register's
> [64AS] bit. Some HCI controller like Exynos support 36-bit bus address.
> This works perfectly fine with DMA mask set as 64 in case there is no
> IOMMU attached to HCI.
> In case if HCI is behind an IOMMU, setting DMA mask as 64 bit won't
> work as HCI has only 36bit addressing and SMMU has created mapping of
> 64 bit and as the device truncates the address, its mapping will not
> be found by iommu.
> To resolve such issues, let the variant driver sets its own DMA mask.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 3 +++
>   drivers/scsi/ufs/ufshcd.h | 2 ++
>   2 files changed, 5 insertions(+)
> 
> I am not sure if there are other ways available to handle such cases.
> The IOMMU I am talking about is arm-smmu and it DT binding does not
> give much idea about handling such cases.
> Have tested this patch with HCI controller with IOMMU attached.
> 
> Changes Since V1:
> 	- Fixed build issue as reported by Kbuild test robot.
> 
> Changes Since V2:
> 	- Remove RFC tag as suggested by Subhash.
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index a355d98..9a1374e 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7781,6 +7781,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
>    */
>   static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>   {
> +	if (hba->vops && hba->vops->set_dma_mask)
> +		return hba->vops->set_dma_mask(hba);
> +
>   	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
>   		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
>   			return 0;
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 1332e54..89c6dae 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
>    * @resume: called during host controller PM callback
>    * @dbg_register_dump: used to dump controller debug information
>    * @phy_initialization: used to initialize phys
> + * @set_dma_mask: used to set variant specific DMA mask
>    */
>   struct ufs_hba_variant_ops {
>   	const char *name;
> @@ -325,6 +326,7 @@ struct ufs_hba_variant_ops {
>   	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
>   	void	(*dbg_register_dump)(struct ufs_hba *hba);
>   	int	(*phy_initialization)(struct ufs_hba *);
> +	int	(*set_dma_mask)(struct ufs_hba *hba);
>   };
>   
>   /* clock gating state  */
> 
