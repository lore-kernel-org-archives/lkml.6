Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeE1Gs1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:48:27 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:36359 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbeE1GsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:48:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180528064823epoutp021a966ee3bda83f970bc473416851d206~yvCfu7iNL2179221792epoutp02T
X-AuditID: b6c32a4b-989ff70000001138-b4-5b0ba636bfc1
Subject: Re: [PATCH V3] scsi: ufs: Add specific callback for setting DMA
 mask
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "shaik.ameer@samsung.com" <shaik.ameer@samsung.com>
From: Alim Akhtar <alim.akhtar@samsung.com>
Date: Mon, 28 May 2018 12:05:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c9b0e89069769a093e07ac911f3a9019d1da32c1.camel@wdc.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7bCmpq75Mu5og94JjBaX/nxhtFg1Mc/i
        8q45bBbd13ewWSw//o/J4sjD3ewWNxbvZLPYsbDKgcPjcl8vk8fOWXfZPR4c2szi8fHpLRaP
        vi2rGD0+b5LzaD/QzRTAHsVlk5Kak1mWWqRvl8CVceH6H9aCpfwVB7faNzBu4eli5OSQEDCR
        2P/zL0sXIxeHkMBuRom3f1qhnE+MEh9abjFBON8YJZ5fXMsI0zKxfy0zRGIvo8SFty1QLW8Z
        Jbr6DrGAVAkL+EtcOz2HDSQhIrCKUeL/voWsIA6zwHQmiXV/3rGDVLEJaEvcnb6FCcRmEVCV
        eHexC2yHqECERNPzn2A1vAKCEidnPgGbyingKnGm5SVYDbOAuMStJ/OZIGx5ie1v54DdJCHw
        m02iZWcXG0RzmcSkSTuAmjmAEi4Sn9erQPwgLPHq+BZ2CFtK4mV/G5SdLPH38hJmCLtEomvR
        Yai4vcSBK3PAxjALaEqs36UPsZZPovf3EyaI6bwSHW1CENWqEs3vrrJA2NISE7u7WSFsD4nH
        B1oYIYF1jVGi4c0x5gmMCrOQfDkLyWezkHw2C2HzAkaWVYySqQXFuempxaYFxnmp5XrFibnF
        pXnpesn5uZsYwUlKy3sH46ZzPocYBTgYlXh4G35zRQuxJpYVV+YeYpTgYFYS4eXSBQrxpiRW
        VqUW5ccXleakFh9ilOZgURLn/WbyL0pIID2xJDU7NbUgtQgmy8TBKdXAKCw8dcsLQfHUbvEN
        7f/qkliqcyynczZEb/ulWz1j3qGHFY4nmlL5r5rtltn0LiIoMNlIVFKKketa1Lp59uHcs6br
        FZw1+vpVxNV9+8QIZsl/CqJLuxUnsu7tvif4UuLPHXG72/umzvOxKtnld8/r4Y4zH7XdEv55
        LY6+Fpl0+M9FaUWZusA0JZbijERDLeai4kQAKUVPik4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnK7ZMu5og8e32C0u/fnCaLFqYp7F
        5V1z2Cy6r+9gs1h+/B+TxZGHu9ktbizeyWaxY2GVA4fH5b5eJo+ds+6yezw4tJnF4+PTWywe
        fVtWMXp83iTn0X6gmymAPYrLJiU1J7MstUjfLoEr48L1P6wFS/krDm61b2DcwtPFyMkhIWAi
        MbF/LXMXIxeHkMBuRolJ306yQCSkJa5vnMAOYQtLrPz3nB2i6DWjxPrdS8ASwgK+ErcXb2UF
        SYgIrGKU6O0+yAjiMAtMZ5I4eHUZK0TLNUaJua/fs4G0sAloS9ydvoWpi5GDg1fATqKxnwsk
        zCKgKvHuYhcjiC0qECFx7/wnsHJeAUGJkzOfgJ3EKeAqcablJVgNs4CZxLzND5khbHGJW0/m
        M0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpe
        cn7uJkZwTGlp7WA8cSL+EKMAB6MSD2/Db65oIdbEsuLK3EOMEhzMSiK8XLpAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYyKToGzWpasrJJ/Vni9MqlZ
        iCufsW6epfK5V2Y7RP98OdJ3sfdRwod1ZQ2skQUn5xcxb/rasfvDToXHXvVB95/FPtwkZbTJ
        /v6qB1FprtGT36/ITU/mLxA9fGXeg7IpG2L7JwkLqGw6Frpo+bc17J+bN/wQfO/sdu9VWcQh
        iUvea1XDjvXekBJUYinOSDTUYi4qTgQAip8SMqUCAAA=
Message-Id: <20180528064822epcas5p392f2255a985966b4e78cbd31860a8873~yvCeqPAYy2177421774epcas5p3N@epcas5p3.samsung.com>
X-CMS-MailID: 20180528064822epcas5p392f2255a985966b4e78cbd31860a8873
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb
References: <CGME20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb@epcas2p3.samsung.com>
        <1526783057-16620-1-git-send-email-alim.akhtar@samsung.com>
        <c9b0e89069769a093e07ac911f3a9019d1da32c1.camel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 05/20/2018 07:51 PM, Bart Van Assche wrote:
> On Sun, 2018-05-20 at 07:54 +0530, Alim Akhtar wrote:
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index a355d98..9a1374e 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -7781,6 +7781,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
>>    */
>>   static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>>   {
>> +	if (hba->vops && hba->vops->set_dma_mask)
>> +		return hba->vops->set_dma_mask(hba);
>> +
>>   	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
>>   		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
>>   			return 0;
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index 1332e54..89c6dae 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
>>    * @resume: called during host controller PM callback
>>    * @dbg_register_dump: used to dump controller debug information
>>    * @phy_initialization: used to initialize phys
>> + * @set_dma_mask: used to set variant specific DMA mask
>>    */
>>   struct ufs_hba_variant_ops {
>>   	const char *name;
>> @@ -325,6 +326,7 @@ struct ufs_hba_variant_ops {
>>   	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
>>   	void	(*dbg_register_dump)(struct ufs_hba *hba);
>>   	int	(*phy_initialization)(struct ufs_hba *);
>> +	int	(*set_dma_mask)(struct ufs_hba *hba);
>>   };
> 
> I want to see the code that sets the .set_dma_mask callback function. Where
> is it? If it is outside the upstream kernel, please consider to send it
> upstream before making changes like this. Adding support for out-of-tree
> kernel code is frowned upon big time in the kernel community.
> 
Thanks for review and feedback.
Ok, I will include this patch with the series which uses this particular 
patch set.
Thanks!

> Bart.
> 
> 
> 
