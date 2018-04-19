Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeDSSAA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:00:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeDSR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:59:57 -0400
Date: Thu, 19 Apr 2018 13:59:55 -0400 (EDT)
Message-Id: <20180419.135955.1394035686984705882.davem@davemloft.net>
To: doshir@vmware.com
Cc: netdev@vger.kernel.org, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vmxnet3: fix incorrect dereference when rxvlan is
 disabled
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180418194805.29119-1-doshir@vmware.com>
References: <20180418194805.29119-1-doshir@vmware.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Wed, 18 Apr 2018 12:48:04 -0700

> vmxnet3_get_hdr_len() is used to calculate the header length which in
> turn is used to calculate the gso_size for skb. When rxvlan offload is
> disabled, vlan tag is present in the header and the function references
> ip header from sizeof(ethhdr) and leads to incorrect pointer reference.
> 
> This patch fixes this issue by taking sizeof(vlan_ethhdr) into account
> if vlan tag is present and correctly references the ip hdr.
> 
> Signed-off-by: Ronak Doshi <doshir@vmware.com>
> Acked-by: Guolin Yang <gyang@vmware.com>
> Acked-by: Louis Luo <llouis@vmware.com>

Applied and queued up for -stable, thanks.

Please provide an appropriate Fixes: tag next time.
