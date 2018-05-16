Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeEPHcK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:32:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeEPHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:32:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8851E6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date: Wed, 16 May 2018 13:02:02 +0530
From: Sahitya Tummala <stummala@codeaurora.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Fix deadlock in shutdown ioctl
Message-ID: <20180516073202.GB6293@codeaurora.org>
References: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
 <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
 <20180515075747.GA6293@codeaurora.org>
 <67bd2926-6851-0544-c24a-85dfa72aa70f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bd2926-6851-0544-c24a-85dfa72aa70f@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 02:48:42PM +0800, Chao Yu wrote:
> > 
> > Thanks, I thought about it too but then I checked that XFS shutdown ioctl is
> > not taking any lock for this ioctl. Hence, I followed the same in F2FS.
> > Do you know why XFS is not taking any lock? 
> 
> I don't know. :(

No problem :)

> 
> > Is it really needed in shutdown ioctl?
> 
> IMO, yes, we should keep freeze and remount be aware of the shutdown operation.

Thanks for your inputs. I will send the updated patch set.

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
