Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969992AbeEXXwT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:52:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeEXXwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:52:17 -0400
Date: Thu, 24 May 2018 16:52:14 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v2 3/7] platform/mellanox: mlxreg-hotplug: add extra
 cycle for hotplug work queue
Message-ID: <20180524235214.GA10172@fury>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:48:51AM +0000, Vadim Pasternak wrote:

Hi Vadim,

> Add extra cycle for hotplug work queue to handle the case when a signal is
> It adds missed logic for signal acknowledge, by adding an extra run for
> received, but no specific signal assertion is detected. Such case
> theoretically can happen for example in case several units are removed or
> inserted at the same time. In this situation acknowledge for some signal
> can be missed at signal top aggreagation status level. The extra run will
> allow to handler to acknowledge the missed signal.
> 

...

> 
> Fixes: 07b89c2b2a5e ("platform/x86: Introduce support for Mellanox hotplug driver")

This sha doesn't exist in mainline, I believe you are referring to:

$ git l | grep "Introduce support for Mellanox hotplug"
304887041d95 platform/x86: Introduce support for Mellanox hotplug driver

While this was introduced in 4.10. There have been many changes since then, with
significant changes in the 4.17 cycle. I have not added the stable tag, please
let me know if you think this should be pushed to stable, and which of the
intervening patches you'd consider dependencies.

I've fixed the sha in the commit message, and queued for testing.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
