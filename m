Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755389AbeEaOKC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:10:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33702 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755287AbeEaOJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:09:59 -0400
Subject: Re: [PATCH 2/8] scsi: libsas: check the lldd callback correctly
To: Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20180529022309.21071-1-yanaijie@huawei.com>
 <20180529022309.21071-3-yanaijie@huawei.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <a8427e3b-baaf-3044-6fb3-c9c9a4253417@huawei.com>
Date: Thu, 31 May 2018 15:09:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180529022309.21071-3-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2018 03:23, Jason Yan wrote:
> We are using lldd_port_deformed so we'd better check if lldd_port_deformed
> is NULL.
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/libsas/sas_discover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index a0fa7ef3a071..354f6db5bb66 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -260,7 +260,7 @@ static void sas_suspend_devices(struct work_struct *work)
>  	 * phy_list is not being mutated
>  	 */
>  	list_for_each_entry(phy, &port->phy_list, port_phy_el) {
> -		if (si->dft->lldd_port_formed)
> +		if (si->dft->lldd_port_deformed)

If you do make this change, then you can remove 
hisi_sas_port_deformed(), as it is just a stub to avoid a jump to NULL 
from above.

>  			si->dft->lldd_port_deformed(phy);
>  		phy->suspended = 1;
>  		port->suspended = 1;
>
