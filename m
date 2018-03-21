Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeCUVvb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:51:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbeCUVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:51:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 17:51:23 -0400
From: okaya@codeaurora.org
To: jeffrey.t.kirsher@intel.com
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST v4 5/7] ixgbevf: keep writel() closer to wmb()
In-Reply-To: <1521668888.12746.32.camel@intel.com>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
 <1521668888.12746.32.camel@intel.com>
Message-ID: <c2ce63d1213b5145f77bf70f57c3360d@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 17:48, Jeff Kirsher wrote:
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

Hah, I did a compile test but maybe I missed something. I will get v6 of 
this patch only and leave the rest of the series as it is.
