Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNMNH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:13:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:13:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Mar 2018 08:13:05 -0400
From: okaya@codeaurora.org
To: Timur Tabi <timur@codeaurora.org>
Cc: netdev@vger.kernel.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
 <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
Message-ID: <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-14 01:08, Timur Tabi wrote:
> On 3/13/18 10:20 PM, Sinan Kaya wrote:
>> +/* Assumes caller has executed a write barrier to order memory and 
>> device
>> + * requests.
>> + */
>>   static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32 
>> value)
>>   {
>> -	writel(value, ring->tail);
>> +	writel_relaxed(value, ring->tail);
>>   }
> 
> Why not put the wmb() in this function, or just get rid of the wmb()
> in the rest of the file and keep this as writel?  That way, you can
> avoid the comment and the risk that comes with it.


Sure, both solutions will work. I want to see what the maintainer 
prefers. I can repost accordingly.
