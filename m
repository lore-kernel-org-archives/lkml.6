Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeDIVMr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:12:47 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46921 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeDIVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:12:45 -0400
X-Google-Smtp-Source: AIpwx4+Vw8DfUDtFZvNkkORWgMek06K3N8QUur1da9qudVe5r9tCmwBB9nV+QN/u/rdQ4vuSFS5KIA==
Date: Mon, 9 Apr 2018 16:12:44 -0500
From: Rob Herring <robh@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: mark.rutland@arm.com, ssantosh@kernel.org, malat@debian.org,
        w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 01/11] soc: ti: K2G: enhancement to support
 QMSS in K2G NAVSS
Message-ID: <20180409211244.cq45hzntyuppnkjc@rob-hp-laptop>
References: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
 <1522679881-25643-2-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522679881-25643-2-git-send-email-m-karicheri2@ti.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 10:37:51AM -0400, Murali Karicheri wrote:
> Navigator Subsystem (NAVSS) available on K2G SoC has a cut down
> version of QMSS with less number of queues, internal linking ram
> with lesser number of buffers etc.  It doesn't have status and
> explicit push register space as in QMSS available on other K2 SoCs.
> So define reg indices specific to QMSS on K2G. This patch introduces
> "ti,66ak2g-navss-qm" compatibility to identify QMSS on K2G NAVSS
> and to customize the dts handling code. Per Device manual,
> descriptors with index less than or equal to regions0_size is in region 0
> in the case of K2 QMSS where as for QMSS on K2G, descriptors with index
> less than regions0_size is in region 0. So update the size accordingly in
> the regions0_size bits of the linking ram size 0 register.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  .../bindings/soc/ti/keystone-navigator-qmss.txt    |  9 ++-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/soc/ti/knav_qmss.h                         |  6 ++
>  drivers/soc/ti/knav_qmss_queue.c                   | 90 ++++++++++++++++------
>  3 files changed, 82 insertions(+), 23 deletions(-)
