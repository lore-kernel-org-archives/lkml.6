Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeBLCTV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:19:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932481AbeBLCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:19:20 -0500
Subject: Re: [PATCH 4/9] nvme-pci: quiesce IO queues prior to disabling device
 HMB accesses
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
 <bf278273-ec7c-e711-b82a-215d45dbe739@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d523fe54-b16e-6dc1-6a01-9c301f603b5a@oracle.com>
Date: Mon, 12 Feb 2018 10:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bf278273-ec7c-e711-b82a-215d45dbe739@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

Thanks for your kindly reminding.

On 02/11/2018 07:19 PM, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 6fe7af0..00cffed 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>       if (!dead) {
>>           if (shutdown)
>>               nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>> +    }
>> +    nvme_stop_queues(&dev->ctrl);
> 
> Nit, extra newline before nvme_stop_queues would be nice.
> 

Yes, I will change this next version.

> Other than that, looks good,
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=YyTE_X1Vl7LP-4IDkvFIPtRdBfnPAeiULK6MVj1Qfy4&s=0q3njAGASSRaQZEYLRXwJmUjYJRweNTVwoqR9mbHWTs&e=
> 
