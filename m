Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeC1VuH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:50:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeC1VuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:50:05 -0400
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector blacklist
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180326135651.8193-1-ross.lagerwall@citrix.com>
Date: Wed, 28 Mar 2018 17:49:54 -0400
In-Reply-To: <20180326135651.8193-1-ross.lagerwall@citrix.com> (Ross
        Lagerwall's message of "Mon, 26 Mar 2018 14:56:51 +0100")
Message-ID: <yq17epvj2f1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Long, KY: Please confirm.

> The Windows Server 2016 iSCSI target doesn't work with the Linux kernel
> initiator since the kernel started sending larger requests by default,
> nor does it implement the block limits VPD page. Apply the sector limit
> workaround for these targets.
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  drivers/scsi/scsi_devinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index f3b1172..5cb748a 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -213,7 +213,7 @@ static struct {
>  	{"Medion", "Flash XL  MMC/SD", "2.6D", BLIST_FORCELUN},
>  	{"MegaRAID", "LD", NULL, BLIST_FORCELUN},
>  	{"MICROP", "4110", NULL, BLIST_NOTQ},
> -	{"MSFT", "Virtual HD", NULL, BLIST_NO_RSOC},
> +	{"MSFT", "Virtual HD", NULL, BLIST_MAX_1024 | BLIST_NO_RSOC},
>  	{"MYLEX", "DACARMRB", "*", BLIST_REPORTLUN2},
>  	{"nCipher", "Fastness Crypto", NULL, BLIST_FORCELUN},
>  	{"NAKAMICH", "MJ-4.8S", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},

-- 
Martin K. Petersen	Oracle Linux Engineering
