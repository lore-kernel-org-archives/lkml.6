Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbeCUVyf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:54:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeCUVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:54:32 -0400
Date: Wed, 21 Mar 2018 17:54:27 -0400 (EDT)
Message-Id: <20180321.175427.1419929873765406157.davem@davemloft.net>
To: jeffrey.t.kirsher@intel.com
Cc: okaya@codeaurora.org, netdev@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST v4 5/7] ixgbevf: keep writel() closer to wmb()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521668888.12746.32.camel@intel.com>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
        <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
        <1521668888.12746.32.camel@intel.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 21 Mar 2018 14:48:08 -0700

> On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
>> Remove ixgbevf_write_tail() in favor of moving writel() close to
>> wmb().
>> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> This patch fails to compile because there is a call to
> ixgbevf_write_tail() which you missed cleaning up.

For a change with delicate side effects, it doesn't create much
confidence if the code does not even compile.

Sinan, please put more care into the changes you are making.

Thank you.
