Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933721AbeCMQ3j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:29:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34225 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeCMQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:29:36 -0400
X-Google-Smtp-Source: AG47ELsscjQhYLSetppykuT9/Hhv0+eSqiAhUtfFU0JJaIK1Osz182qTyxGNX0hcYcb2hUT6JuoeaQ==
Subject: Re: [PATCH][next] scsi: lpfc: make several unions static, fix
 non-ANSI prototype
To: Colin King <colin.king@canonical.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180313120849.30128-1-colin.king@canonical.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <566b5646-80a8-bca3-5f35-d78a97960ed2@broadcom.com>
Date: Tue, 13 Mar 2018 09:29:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313120849.30128-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/2018 5:08 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several unions that are local to the source and do not need
> to be in global scope, so make them static. Also add in a missing void
> parameter to functions lpfc_nvme_cmd_template and
> lpfc_nvmet_cmd_template to clean up non-ANSI warning.
>
> Cleans up sparse warnings:
> drivers/scsi/lpfc/lpfc_nvme.c:68:19: warning: symbol
> 'lpfc_iread_cmd_template' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvme.c:69:19: warning: symbol
> 'lpfc_iwrite_cmd_template' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvme.c:70:19: warning: symbol
> 'lpfc_icmnd_cmd_template' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvme.c:74:24: warning: non-ANSI function
> 'lpfc_tsend_cmd_template' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:78:19: warning: symbol
> 'lpfc_treceive_cmd_template' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:79:19: warning: symbol
> 'lpfc_trsp_cmd_template' was not declared. Should it be static?
> drivers/scsi/lpfc/lpfc_nvmet.c:83:25: warning: non-ANSI function
> declaration of function 'lpfc_nvmet_cmd_template'
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c  | 8 ++++----
>   drivers/scsi/lpfc/lpfc_nvmet.c | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
>

Signed-off-by:   James Smart <james.smart@broadcom.com>
