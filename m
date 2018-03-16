Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeCPOxn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:53:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753572AbeCPOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:53:40 -0400
Date: Fri, 16 Mar 2018 10:53:39 -0400 (EDT)
Message-Id: <20180316.105339.409351441331109496.davem@redhat.com>
To: doshir@vmware.com
Cc: netdev@vger.kernel.org, ntanaka@vmware.com, skhare@vmware.com,
        pv-drivers@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vmxnet3: avoid xmit reset due to a race in
 vmxnet3
From: David Miller <davem@redhat.com>
In-Reply-To: <20180313194008.12852-1-doshir@vmware.com>
References: <20180313194008.12852-1-doshir@vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Tue, 13 Mar 2018 12:40:08 -0700

> @@ -977,6 +977,8 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
>  {
>  	int ret;
>  	u32 count;
> +	int numPkts;
> +	int localTxNumDeferred;
>  	unsigned long flags;
>  	struct vmxnet3_tx_ctx ctx;
>  	union Vmxnet3_GenericDesc *gdesc;

Please use local variable names with all lowercase letters.
