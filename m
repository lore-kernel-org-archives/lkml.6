Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeCPQdf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:33:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeCPQd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:33:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DDFC60F78
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [Intel-wired-lan] [PATCH v3 09/18] fm10k: Eliminate duplicate
 barriers on weakly-ordered archs
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-arm-kernel@lists.infradead.org
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-10-git-send-email-okaya@codeaurora.org>
 <CAKgT0UcKdCpzFgX4qn7EdYnedOsJa9as5g24tfb6qFLXTxZ29A@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2d346b70-70d4-5996-24ce-94031ee68c90@codeaurora.org>
Date: Fri, 16 Mar 2018 12:33:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcKdCpzFgX4qn7EdYnedOsJa9as5g24tfb6qFLXTxZ29A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/2018 12:30 PM, Alexander Duyck wrote:
> On Fri, Mar 16, 2018 at 9:16 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Code includes wmb() followed by writel(). writel() already has a
>> barrier on some architectures like arm64.
>>
>> This ends up CPU observing two barriers back to back before executing
>> the register write.
>>
>> Since code already has an explicit barrier call, changing writel() to
>> writel_relaxed().
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> You can update the writel call in fm10k_tx_map as well.
> 
> Of the drivers updated in drivers/net/ethernet/intel/* it looks like
> this is the only one that still requires any additional changes.

will do. thanks for the feedback.

> 
> Thanks.
> 
> - Alex
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
