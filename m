Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDPSrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:47:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46163 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDPSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:47:30 -0400
X-Google-Smtp-Source: AIpwx49vrIlk42VFUepYCYin1hU2BGO1z1DkbPjA6Ys2wWaw0FmwXwygxNoqn2kN4xGJlveRCg7sDg==
Subject: Re: [PATCH] lightnvm: pblk: add CNEX Granby to the pblk device list
To: Wei Xu <wxu@cnexlabs.com>
Cc: javier@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523870357-2118-1-git-send-email-wxu@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e595a844-8879-5919-6fc6-8563da666af4@lightnvm.io>
Date: Mon, 16 Apr 2018 20:47:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523870357-2118-1-git-send-email-wxu@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/18 11:19 AM, Wei Xu wrote:

> Add a new lightnvm quirk to identify CNEX’s Granby controller.
>
> Signed-off-by: Wei Xu <wxu@cnexlabs.com>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cb73bc8..9419e88 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
>   	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
> +		.driver_data = NVME_QUIRK_LIGHTNVM, },
>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
Hi Wei,

The patch looks good, but the title is not description of the change.

Could the title be changed to "nvme: lightnvm: add granby support". 
Also, please send it to the nvme mailing list and CC Keith Busch. It is 
a pure NVMe device driver change, and can go directly up through the 
NVMe maintainers. I'll add a Reviewed-by: when you've sent it.

-Matias
