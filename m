Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeCUNpt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:45:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34091 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCUNpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:45:47 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180321010527.GA16616@embeddedor.com>
Date: Wed, 21 Mar 2018 14:45:44 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8448C1B0-A2A9-4376-9CC3-7643F0FFC0FB@holtmann.org>
References: <20180321010527.GA16616@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation instead.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> Changes in v2:
> - Fix memory leak in previous patch.
> 
> net/bluetooth/smp.c | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
