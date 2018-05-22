Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeEVUZQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeEVUZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:25:15 -0400
Date: Tue, 22 May 2018 16:25:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gargi Sharma <gs051095@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add missing header include <linux/mem_encrypt.h>
Message-ID: <20180522162512.224b301b@gandalf.local.home>
In-Reply-To: <20180522195533.31415-1-malat@debian.org>
References: <20180522195533.31415-1-malat@debian.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 21:55:31 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> In commit c7753208a94c ("x86, swiotlb: Add memory encryption support") a
> call to function ‘mem_encrypt_init’ was added. Include prototype
> defined in header <linux/mem_encrypt.h> to prevent a warning reported
> during compilation with W=1:
> 
>   init/main.c:494:20: warning: no previous prototype for ‘mem_encrypt_init’ [-Wmissing-prototypes]

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  init/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 3d6b31f4e520..35ce2ddb1322 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -91,6 +91,7 @@
>  #include <linux/cache.h>
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
> +#include <linux/mem_encrypt.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
