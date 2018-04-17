Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeDQWPn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 18:15:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32978 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeDQWPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 18:15:42 -0400
X-Google-Smtp-Source: AIpwx4/rRBecWd2e0Y/g6ZXfMtk4LOv73aAc4pO4r9UZfrYA4O8qWd2xqxT8leE/icqzT2Pk7QhxGw==
Subject: Re: [PATCH] nvme: lightnvm: add granby support
To: Keith Busch <keith.busch@intel.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: Wei Xu <wxu@cnexlabs.com>, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
 <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
 <20180417220901.GG11513@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6701f433-e865-5a17-f1c7-4c0e0c5effaa@kernel.dk>
Date: Tue, 17 Apr 2018 16:15:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180417220901.GG11513@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/18 4:09 PM, Keith Busch wrote:
> On Tue, Apr 17, 2018 at 08:16:25AM +0200, Matias Bjørling wrote:
>> On 4/17/18 3:55 AM, Wei Xu wrote:
>>> Add a new lightnvm quirk to identify CNEX’s Granby controller.
>>>
>>> Signed-off-by: Wei Xu <wxu@cnexlabs.com>
>>> ---
>>>   drivers/nvme/host/pci.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index cb73bc8..9419e88 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
>>>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
>>>   	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
>>>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
>>> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
>>> +		.driver_data = NVME_QUIRK_LIGHTNVM, },
>>>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
>>>
>>
>> Looks good to me.
>>
>> Reviewed-by: Matias Bjørling <mb@lightnvm.io>
>>
>> Keith, when convenient can you pick this up for 4.18?
> 
> This looks safe for 4.17-rc2, no? Unless you want to wait for the next
> release.

It should wait for the next release, it's not a fix.

-- 
Jens Axboe
