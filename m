Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeBWFKZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 00:10:25 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34561 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeBWFKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 00:10:23 -0500
X-Google-Smtp-Source: AG47ELt7mp0HaUM02v7o/NR2LM9B2SKZk18sWPUrNj1t2XllH7qSiWVuNajOZTK0d2ujg0Tv4W+l8T6espDgd1IaQiA=
MIME-Version: 1.0
In-Reply-To: <70df05c82a8624987c76b16c65143f00a111c94d.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org> <70df05c82a8624987c76b16c65143f00a111c94d.1519120988.git.asutoshd@codeaurora.org>
From: Kyuho Choi <chlrbgh0@gmail.com>
Date: Fri, 23 Feb 2018 14:10:22 +0900
Message-ID: <CAP2JTQK3jNrNvxz=aF9weuO1M38zBCCa8YJfz5tazXF61p257w@mail.gmail.com>
Subject: Re: [PATCH 1/9] scsi: ufs: Allowing power mode change
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Yaniv Gardi <ygardi@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asutosh,

I've simple question in below.

On 2/21/18, Asutosh Das <asutoshd@codeaurora.org> wrote:
> From: Yaniv Gardi <ygardi@codeaurora.org>
>
> Due to M-PHY issues, moving from HS to any other mode or gear or
> even Hibern8 causes some un-predicted behavior of the device.
> This patch fixes this issues.
>
> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 011c336..d74d529 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4167,9 +4167,13 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>  			goto out;
>  	} while (ret && retries--);
>
> -	if (ret)
> +	if (ret) {
>  		/* failed to get the link up... retire */
>  		goto out;
> +	} else {
> +		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 0);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 1);
> +	}
>

Every ufs host has same issue and affected?.

>  	if (link_startup_again) {
>  		link_startup_again = false;
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project.
>
>
