Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeEWSRn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:17:43 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41264 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbeEWSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:17:42 -0400
X-Google-Smtp-Source: AB8JxZo+1lLS4T+NBs5rQyppP7fJlLMIQyO/MaNhlTB8EtsWBakLT6sYU3Geth50bRWz48jjGNOaFQ==
Date: Wed, 23 May 2018 11:17:39 -0700
From: Tejun Heo <tj@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: move function definitions within CONFIG_SMP
 block
Message-ID: <20180523181739.GQ1718769@devbig577.frc2.facebook.com>
References: <20180522194732.29140-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522194732.29140-1-malat@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 09:47:32PM +0200, Mathieu Malaterre wrote:
> In commit 7ee681b25284 ("workqueue: Convert to state machine callbacks"),
> three new function definitions were added: ‘workqueue_prepare_cpu’,
> ‘workqueue_online_cpu’ and ‘workqueue_offline_cpu’.
> 
> Move these function definitions within a CONFIG_SMP block since they are
> not used outside of it. This will match function declarations in header
> <include/linux/workqueue.h>, and silence the following gcc warning (W=1):
> 
>   kernel/workqueue.c:4743:5: warning: no previous prototype for ‘workqueue_prepare_cpu’ [-Wmissing-prototypes]
>   kernel/workqueue.c:4756:5: warning: no previous prototype for ‘workqueue_online_cpu’ [-Wmissing-prototypes]
>   kernel/workqueue.c:4783:5: warning: no previous prototype for ‘workqueue_offline_cpu’ [-Wmissing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to wq/for-4.18.

Thanks.

-- 
tejun
