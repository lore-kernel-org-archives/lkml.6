Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeETBsE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 21:48:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57314 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeETBr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 21:47:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180520014757epoutp02db2310d1c5a4b362855c442728e2e963~wNx5afPJ60138501385epoutp02W
X-AuditID: b6c32a49-583ff700000010df-29-5b00d3cbd73f
Subject: Re: [RFC PATCH V2] scsi: ufs: Add specific callback for setting DMA
 mask
To: Subhash Jadavani <subhashj@codeaurora.org>, alim.akhtar@samsung.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vinayak holikatti <vinholikatti@gmail.com>, devicetree@vger.kernel.org,
        Shaik Ameer Basha <shaik.ameer@samsung.com>
From: Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <1e53194e-7255-a353-54ed-5c6c815205dc@samsung.com>
Date: Sun, 20 May 2018 07:05:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1f7df8bfbc161243956233eac80f2cee@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmlu7pywzRBj8Xm1k8mLeNzWL+kXOs
        Fqsm5llc3jWHzaL7+g42i+XH/zFZHHm4m93ixuKdbBY7FlY5cHpc7utl8tg56y67x4NDm1k8
        Pj69xeLRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGZ93NDAWvJOomLDrNmsD4wORLkZODgkB
        E4n15/uZuhi5OIQEdjNKbFy1iBnC+cQocXXjUVYI5xujxO4La4DKOMBaNr0IhIjvZZT4feAu
        VNFbRon+SUuYQeYKCwRL3OhrZwWxRQTcJaZf+QRWxCzwhlHixdd5LCAJNgFtibvTtzCB2LwC
        dhKvTrSyg9gsAqoS//fdAouLCkRIND3/yQ5RIyhxcuYTsF5OoPpJ0zeBxZkFxCVuPZnPBGHL
        SzRvnQ32g4TAZzaJVXs6mCE+dZF49KiHDcIWlnh1fAs7hC0l8fndXqh4tsSH4yeh6mskZl3s
        hYrbSxy4MocF5H1mAU2J9bv0IcK2EjOnLmOB2Msn0fv7CTSEeCU62oQgSlQlmt9dZYGwpSUm
        dnezQtgeEufefmGawKg0C8lns5B8MwvJN7MQFi9gZFnFKJlaUJybnlpsWmCYl1quV5yYW1ya
        l66XnJ+7iRGcorQ8dzDOOudziFGAg1GJh/dGIUO0EGtiWXFl7iFGCQ5mJRHedalAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzfTP5FCQmkJ5akZqemFqQWwWSZODilGhiTgtarTdN+qXvX3rel
        sLPCmDP88saJ53lNw2PkJ7L76Z7KOrtK71Kl5DP/IwyKL+4vOVgneXTHr5X/JI9Gs+ouWOEV
        85mro2tW+RYj04/7Dzcoii/QE2kJYFM5lzfzvbB2h0+epoqeUWK7wXyRVUItn5d1d7+W9f3V
        dm93z1Pr+XWKfU4GG5RYijMSDbWYi4oTAa93VdRNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO7pywzRBpufCVo8mLeNzWL+kXOs
        Fqsm5llc3jWHzaL7+g42i+XH/zFZHHm4m93ixuKdbBY7FlY5cHpc7utl8tg56y67x4NDm1k8
        Pj69xeLRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGZ93NDAWvJOomLDrNmsD4wORLkYODgkB
        E4lNLwK7GLk4hAR2M0pM/vmHrYuREyguLXF94wR2CFtYYuW/5+wQRa8ZJeZu2ccKkhAWCJa4
        0dcOZosIuEtMv/IJzGYWeMMo8eR/BkTDVCaJ49eXgU1lE9CWuDt9CxOIzStgJ/HqRCvYBhYB
        VYn/+26BxUUFIiTunf/EBlEjKHFy5hMWEJsTqH7S9E3sEAvMJOZtfsgMYYtL3HoynwnClpdo
        3jqbeQKj0Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        EaWluYPx8pL4Q4wCHIxKPLwGJQzRQqyJZcWVuYcYJTiYlUR416UChXhTEiurUovy44tKc1KL
        DzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBcIPDKrlzcRvpfkHzmpDB2YclNIoIK
        v5/8WdbRKWzQdklyZdHMg+8O7v/azPA5suh/3h/TG/n93ls8myr0Hwrwi/NE/fVo9GeRKbFl
        Psm8iss5t62270ng4t51iwRdPx5MtJZXNfxi8+jvzAi/DT+5bnh//l+42evwllOW8wOt9/v5
        HrZMD1JiKc5INNRiLipOBAANBoYHpAIAAA==
X-CMS-MailID: 20180520014755epcas5p35ad929bc3ea3297e2b4c90078d70ea35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180520014755epcas5p35ad929bc3ea3297e2b4c90078d70ea35
CMS-TYPE: 105P
X-CMS-RootMailID: 20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03
X-RootMTR: 20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03
References: <CGME20180308111416epcas1p4f9f1dbb36e8567121c6236ac0e9b4e03@epcas1p4.samsung.com>
        <1520507013-2410-1-git-send-email-alim.akhtar@samsung.com>
        <CAGOxZ52yZ8Xqype7AVsH43DWOA2byh2kW3SGsfHyHtzqSH6QPw@mail.gmail.com>
        <1f7df8bfbc161243956233eac80f2cee@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Subhash

On 05/17/2018 03:01 AM, Subhash Jadavani wrote:
> On 2018-05-15 21:31, Alim Akhtar wrote:
>> Ping !!!
>>
>> On Thu, Mar 8, 2018 at 4:33 PM, Alim Akhtar <alim.akhtar@samsung.com> 
>> wrote:
>>> Currently DMA mask for UFS HCI is set by reading CAP register's
>>> [64AS] bit. Some HCI controller like Exynos support 36-bit bus address.
>>> This works perfectly fine with DMA mask set as 64 in case there is no
>>> IOMMU attached to HCI.
>>> In case if HCI is behind an IOMMU, setting DMA mask as 64 bit won't
>>> work as HCI has only 36bit addressing and SMMU has created mapping of
>>> 64 bit and as the device truncates the address, its mapping will not
>>> be found by iommu.
>>> To resolve such issues, let the variant driver sets its own DMA mask.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>  drivers/scsi/ufs/ufshcd.c | 3 +++
>>>  drivers/scsi/ufs/ufshcd.h | 2 ++
>>>  2 files changed, 5 insertions(+)
>>>
>>> I am not sure if there are other ways available to handle such cases.
>>> The IOMMU I am talking about is arm-smmu and it DT binding does not
>>> give much idea about handling such cases.
>>> Have tested this patch with HCI controller with IOMMU attached.
>>>
>>> Changes Since V1:
>>>         - Fixed build issue as reported by Kbuild test robot.
>>>
>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>>> index a355d98..9a1374e 100644
>>> --- a/drivers/scsi/ufs/ufshcd.c
>>> +++ b/drivers/scsi/ufs/ufshcd.c
>>> @@ -7781,6 +7781,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
>>>   */
>>>  static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>>>  {
>>> +       if (hba->vops && hba->vops->set_dma_mask)
>>> +               return hba->vops->set_dma_mask(hba);
>>> +
>>>         if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
>>>                 if (!dma_set_mask_and_coherent(hba->dev, 
>>> DMA_BIT_MASK(64)))
>>>                         return 0;
>>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>>> index 1332e54..89c6dae 100644
>>> --- a/drivers/scsi/ufs/ufshcd.h
>>> +++ b/drivers/scsi/ufs/ufshcd.h
>>> @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
>>>   * @resume: called during host controller PM callback
>>>   * @dbg_register_dump: used to dump controller debug information
>>>   * @phy_initialization: used to initialize phys
>>> + * @set_dma_mask: used to set variant specific DMA mask
>>>   */
>>>  struct ufs_hba_variant_ops {
>>>         const char *name;
>>> @@ -325,6 +326,7 @@ struct ufs_hba_variant_ops {
>>>         int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
>>>         void    (*dbg_register_dump)(struct ufs_hba *hba);
>>>         int     (*phy_initialization)(struct ufs_hba *);
>>> +       int     (*set_dma_mask)(struct ufs_hba *hba);
>>>  };
>>>
>>>  /* clock gating state  */
>>> -- 
>>> 2.7.4
>>>
> 
> Looks reasonable to me, you may try posting non-RFC version.
> 
Thanks for review.
Will send a non-RFC version.

Regards,
Alim
