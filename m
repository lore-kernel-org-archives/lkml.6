Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeBKLTU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:19:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37856 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeBKLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:19:18 -0500
X-Google-Smtp-Source: AH8x226sobMPbknE4D+sxNQlkSP69ugBLHweN89dgIZ0epcZ8jPCn52mH8TnuWp8wvZXD60RRfiRlg==
Subject: Re: [PATCH 4/9] nvme-pci: quiesce IO queues prior to disabling device
 HMB accesses
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bf278273-ec7c-e711-b82a-215d45dbe739@grimberg.me>
Date: Sun, 11 Feb 2018 13:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6fe7af0..00cffed 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	if (!dead) {
>   		if (shutdown)
>   			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +	}
> +	nvme_stop_queues(&dev->ctrl);

Nit, extra newline before nvme_stop_queues would be nice.

Other than that, looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
