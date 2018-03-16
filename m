Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeCPOyO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:54:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753930AbeCPOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:54:07 -0400
Date: Fri, 16 Mar 2018 10:54:06 -0400 (EDT)
Message-Id: <20180316.105406.1653568798369743500.davem@redhat.com>
To: doshir@vmware.com
Cc: netdev@vger.kernel.org, rachel_lunnon@stormagic.com, skhare@vmware.com,
        pv-drivers@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vmxnet3: use correct flag to indicate LRO
 feature
From: David Miller <davem@redhat.com>
In-Reply-To: <20180313194141.12913-1-doshir@vmware.com>
References: <20180313194141.12913-1-doshir@vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Tue, 13 Mar 2018 12:41:41 -0700

> 'Commit 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2
> (fwd)")' introduced a flag "lro" in structure vmxnet3_adapter which is
> used to indicate whether LRO is enabled or not. However, the patch
> did not set the flag and hence it was never exercised.
> 
> So, when LRO is enabled, it resulted in poor TCP performance due to
> delayed acks. This issue is seen with packets which are larger than
> the mss getting a delayed ack rather than an immediate ack, thus
> resulting in high latency.
> 
> This patch removes the lro flag and directly uses device features
> against NETIF_F_LRO to check if lro is enabled.
> 
> Reported-by: Rachel Lunnon <rachel_lunnon@stormagic.com>
> Signed-off-by: Ronak Doshi <doshir@vmware.com>
> Acked-by: Shrikrishna Khare <skhare@vmware.com>

Please add an appropriate "Fixes: " tag for the commit which introduced
this problem.  This helps with -stable submissions and bug fix triage.
