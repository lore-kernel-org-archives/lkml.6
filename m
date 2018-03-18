Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeCRAFK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 20:05:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50082 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeCRAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 20:05:07 -0400
Date: Sat, 17 Mar 2018 20:05:06 -0400 (EDT)
Message-Id: <20180317.200506.1922029560822089854.davem@davemloft.net>
To: doshir@vmware.com
Cc: netdev@vger.kernel.org, ntanaka@vmware.com, skhare@vmware.com,
        pv-drivers@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] vmxnet3: avoid xmit reset due to a race in
 vmxnet3
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180316214754.20650-1-doshir@vmware.com>
References: <20180316214754.20650-1-doshir@vmware.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Fri, 16 Mar 2018 14:47:54 -0700

> The field txNumDeferred is used by the driver to keep track of the number
> of packets it has pushed to the emulation. The driver increments it on
> pushing the packet to the emulation and the emulation resets it to 0 at
> the end of the transmit.
> 
> There is a possibility of a race either when (a) ESX is under heavy load or
> (b) workload inside VM is of low packet rate.
> 
> This race results in xmit hangs when network coalescing is disabled. This
> change creates a local copy of txNumDeferred and uses it to perform ring
> arithmetic.
> 
> Reported-by: Noriho Tanaka <ntanaka@vmware.com>
> Signed-off-by: Ronak Doshi <doshir@vmware.com>
> Acked-by: Shrikrishna Khare <skhare@vmware.com>

Applied.
