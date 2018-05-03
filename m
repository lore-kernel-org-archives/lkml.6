Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeECOTZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbeECOTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:19:23 -0400
Date: Thu, 3 May 2018 10:19:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 5/5] asm-generic: fix build error in fix_to_virt with
 CONFIG_DEBUG_EXPERIENCE
Message-ID: <20180503101920.3157f63f@gandalf.local.home>
In-Reply-To: <20180503132508.qudxf67tyijvjndo@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
        <1525268700-10631-6-git-send-email-changbin.du@intel.com>
        <20180502101930.25a5437d@gandalf.local.home>
        <20180503132508.qudxf67tyijvjndo@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018 21:25:08 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> I think fix_to_virt() is designed for constant idx only. So I think we should
> fix it at the caller side by replacing it with __fix_to_virt().
> 
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
>                 pte_t *pte;
>                 struct map_desc map;
> 
> -               map.virtual = fix_to_virt(i);
> +               map.virtual = __fix_to_virt(i);
>                 pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);

That's a better solution than the current patch.

-- Steve
