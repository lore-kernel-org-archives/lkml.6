Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeDPPvN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbeDPPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:51:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE3421776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Mon, 16 Apr 2018 17:51:05 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Jia Zhang <zhang.jia@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: Allow to always show the status of modsign
Message-ID: <20180416155105.vbog5ynqk2p2ogz3@redbean>
References: <1523418814-6857-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1523418814-6857-2-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1523418814-6857-2-git-send-email-zhang.jia@linux.alibaba.com>
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jia Zhang [11/04/18 11:53 +0800]:
>The sig_enforce parameter could be always shown to reflect the
>current status of modsign. For the case of CONFIG_MODULE_SIG_FORCE=y,
>this modification does nothing harmless.
>
>Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Both patches look fine to me. Queued on modules-next.

Thanks,

Jessica

>---
> kernel/module.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index f695474..1e3337b 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -274,9 +274,7 @@ static void module_assert_mutex_or_preempt(void)
> }
>
> static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>-#ifndef CONFIG_MODULE_SIG_FORCE
> module_param(sig_enforce, bool_enable_only, 0644);
>-#endif /* !CONFIG_MODULE_SIG_FORCE */
>
> /*
>  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
>-- 
>1.8.3.1
>
