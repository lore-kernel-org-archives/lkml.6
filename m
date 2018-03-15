Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933105AbeCOXa5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:30:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932841AbeCOXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:30:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D198C6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered
 archs
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <39dc5bb4-02b1-bf7e-fbfc-17fc484e4fb7@codeaurora.org>
Date: Thu, 15 Mar 2018 19:30:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2018 9:41 PM, Alexander Duyck wrote:
>>  }
>>
> So you missed the writel in e1000_xmit_frame. You should probably get
> that one too while you are doing these updates. The wmb() is in
> e1000_tx_queue().
> 

I brought wmb() outside along with the next descriptor assignment to be
similar to the rest of the other code.

if wmb() and writel() are not visible in the same function, let's not touch
the code.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
