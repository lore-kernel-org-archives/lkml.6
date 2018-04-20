Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDTRT1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:19:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47801 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeDTRT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:19:26 -0400
Date: Fri, 20 Apr 2018 19:19:24 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC
 check when attaching ubi vol
Message-ID: <20180420191924.18b81e96@bbrezillon>
In-Reply-To: <6551534f88b3aa77cc377c4270c4ddf7fe92cdf4.1524214122.git-series.quentin.schulz@bootlin.com>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
        <6551534f88b3aa77cc377c4270c4ddf7fe92cdf4.1524214122.git-series.quentin.schulz@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 10:52:41 +0200
Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> There's already ECC on NAND pages so there may be no need for one to
> check the CRC of a UBI volume.

That's true that ECC can help detecting corruptions, but I don't think
this is the actual reason for disabling CRC check at volume open time.
The actual reason for doing that is when the UBI volume user (in our
case the squashfs FS) is also checking data consistency on its own
(which is the case for squashfs).

> 
> Let's introduce a ubi.nocheck parameter that let one skip the CRC check
> when attaching a UBI volume.
> 
> This also drastically speeds kernel boot by removing a potentially
> useless check, e.g. I gained 3.2s on boot time of a SPEAr600-based board
> for a ~20MB UBI volume used as rootfs.

Can you give the old and new open/mount time instead of telling how
much you gained on the whole boot-time?
