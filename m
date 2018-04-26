Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeDZTSw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:18:52 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:38654 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeDZTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:18:50 -0400
X-Google-Smtp-Source: AB8JxZoTA8o2FcYKUaeyXMV60YJXkudZKggbrhkHGDYccGG9Ath2I888re8J7RifyPIg0Z7WaR7dZw==
Date: Thu, 26 Apr 2018 12:18:47 -0700
From: Tejun Heo <tj@kernel.org>
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: Re: [PATCH 2/2] blkcg: init root blkcg_gq under lock
Message-ID: <20180426191847.GS1911913@devbig577.frc2.facebook.com>
References: <1524110769-107033-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524110769-107033-1-git-send-email-jiang.biao2@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 19, 2018 at 12:06:09PM +0800, Jiang Biao wrote:
> The initializing of q->root_blkg is currently outside of queue lock
> and rcu, so the blkg may be destroied before the initializing, which
> may cause dangling/null references. On the other side, the destroys
> of blkg are protected by queue lock or rcu. Put the initializing
> inside the queue lock and rcu to make it safer.

Hmm... I can't think of a scenario where the above could happen.  The
queue is still being initialized and no one else has access to it, so
I can't see how it could be destroyed.  Can you please describe the
sequence of events?  Have you actually observed this happening?

Thanks.

-- 
tejun
