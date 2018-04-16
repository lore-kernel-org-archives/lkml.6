Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeDPRLO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbeDPRLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:11:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6E321776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Mon, 16 Apr 2018 19:11:06 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: silence a gcc warning
Message-ID: <20180416171106.rlm2nrvrxfoodcvf@redbean>
References: <20180411190509.24995-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180411190509.24995-1-malat@debian.org>
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mathieu Malaterre [11/04/18 21:05 +0200]:
>In commit 8c8ef42aee8f ("module: include other structures in module version
>check"), the function `struct_module` was renamed to `module_layout` but no
>prototype was added to `include/linux/module.h`. Remove warning triggered
>at W=1:
>
>  kernel/module.c:4378:6: warning: no previous prototype for ‘module_layout’ [-Wmissing-prototypes]
>
>Signed-off-by: Mathieu Malaterre <malat@debian.org>
>---
> include/linux/module.h | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index d44df9b2c131..28046e8b7e9d 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -786,6 +786,14 @@ extern int module_sysfs_initialized;
>
> #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
>
>+#ifdef CONFIG_MODVERSIONS
>+void module_layout(struct module *mod,
>+		   struct modversion_info *ver,
>+		   struct kernel_param *kp,
>+		   struct kernel_symbol *ks,
>+		   struct tracepoint * const *tp);
>+#endif /* CONFIG_MODVERSIONS */
>+

Hi Mathieu,

We're going to need a forward declaration in module.h for struct tracepoint
to address the kbuild warnings.

Thanks,

Jessica

> /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
>
> #define __MODULE_STRING(x) __stringify(x)
>-- 
>2.11.0
>
