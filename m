Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeBLShx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:37:53 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41701 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeBLShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:37:52 -0500
X-Google-Smtp-Source: AH8x227Dah5kx7OZvgYrSg52C6y4rk/g80kXWoDFx3ux5gUcS6k0Iwq4VYrZ79ptZOfBYi26vSfOLQ==
Subject: Re: [PATCH RESENT] nvme-pci: suspend queues based on online_queues
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440713-1031-1-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5011398b-8797-ece6-9df0-436c32aed33e@grimberg.me>
Date: Mon, 12 Feb 2018 20:37:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518440713-1031-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> nvme cq irq is freed based on queue_count. When the sq/cq creation
> fails, irq will not be setup. free_irq will warn 'Try to free
> already-free irq'.
> 
> To fix it, we only increase online_queues when adminq/sq/cq are
> created and associated irq is setup. Then suspend queues based
> on online_queues.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>

Can I get a review for this?
