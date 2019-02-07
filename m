Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C6C4151A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A6520823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiC3rd9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfBGK1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:27:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45746 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:27:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so17273903ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQVJ0Qx0jz4OgVw+39LjkotjVwynNqSsNpBV0A3AeRE=;
        b=iiC3rd9agn3fFWTEACayeEOzX/qIU3OUfTULp016nf/Pt9wZ13bomD4YfSTmmB6CfE
         V/y2oKetpYWIw1Ok/H6Tie+qdiJgS+Jmh8vLMJ8/GJpsV0EfhUOnAxBC1Bh9tPEKk5dj
         aHQQeBcHuYDjv+Pg0mnbbmHKZjlkauMBuAIqORuxyYvcdpMTrsB0UuuygbgANOb4EJpj
         Cz5Gyy3s6wEJsKWsy9/wjcUf5sy1hn3fqkv1FhiHmH97lUeAZSy7Sqk99afWYoY1qWkq
         axUzREfdptBlzxELLkk9VXDLa0A0vq6BqqzI9+xQc9h/UoaEPlgr83H7GznZszMTdixI
         CvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQVJ0Qx0jz4OgVw+39LjkotjVwynNqSsNpBV0A3AeRE=;
        b=RE0p8SPqtkwln/Xjhm1+mApu5hU9WdGM//WW43CDAscixPPeeMtZ79EOZQJAuTuN5e
         hekVf+MBhP3S5jYJt10FaLbE1Dzm5QwmB63Dk6fX//4u6aOeAjy/j6rX8N9I6lv4K+N8
         kEjpDOKz6ExnEvH8alAQqex0xFx3pZMr+9gk1k+vEXU4vLFqh24PE4Qpw9pG6lLqqSjP
         JUlRnXGjWSLxmv4/Cd4Ob5UIjM08g63MwxNdhqBURfZIG/XBo4Trjwhh3GooxlmeNdax
         6dKRczYqbdwyj/Kz2/l6l2VUSXw1tU8hjWTFRowfBRq/MPnJ4DXs/70oS1THAl34rqrh
         AfZQ==
X-Gm-Message-State: AHQUAubx12H4M+1kzkT1jU8Mn8a39pEwqH7Zq/GSCmRcU5wLEixzFaq4
        m8paiZoA8EuC+exHA2AMxIFNftJv10KEtI9UuN+Jlg==
X-Google-Smtp-Source: AHgI3IbAjKvQxulqhIkAuOqdf95N7/LHxBrA5Kg81BCJVsQ4ajeb4xF6iL//RLLe9VbzWYskUcY5fo6qcLiAtEr0Kkg=
X-Received: by 2002:aca:e003:: with SMTP id x3mr2231660oig.39.1549535226052;
 Thu, 07 Feb 2019 02:27:06 -0800 (PST)
MIME-Version: 1.0
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
In-Reply-To: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 7 Feb 2019 11:26:39 +0100
Message-ID: <CAG48ez1gXgsBG6bYGG5+B4Dqkhk_iVaYLqt63RaxURxE0yt9eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 10:22 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> In powerpc code, there are several places implementing safe
> access to user data. This is sometimes implemented using
> probe_kernel_address() with additional access_ok() verification,
> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> pair, etc. :
>     show_user_instructions()
>     bad_stack_expansion()
>     p9_hmi_special_emu()
>     fsl_pci_mcheck_exception()
>     read_user_stack_64()
>     read_user_stack_32() on PPC64
>     read_user_stack_32() on PPC32
>     power_pmu_bhrb_to()
>
> In the same spirit as probe_kernel_read(), this patch adds
> probe_user_read().
>
> probe_user_read() does the same as probe_kernel_read() but
> first checks that it is really a user address.
>
> The patch defines this function as a static inline so the "size"
> variable can be examined for const-ness by the check_object_size()
> in __copy_from_user_inatomic()
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>



> ---
>  v3: Moved 'Returns:" comment after description.
>      Explained in the commit log why the function is defined static inline
>
>  v2: Added "Returns:" comment and removed probe_user_address()
>
>  include/linux/uaccess.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 37b226e8df13..ef99edd63da3 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>  #define probe_kernel_address(addr, retval)             \
>         probe_kernel_read(&retval, addr, sizeof(retval))
>
> +/**
> + * probe_user_read(): safely attempt to read from a user location
> + * @dst: pointer to the buffer that shall take the data
> + * @src: address to read from
> + * @size: size of the data chunk
> + *
> + * Safely read from address @src to the buffer at @dst.  If a kernel fault
> + * happens, handle that and return -EFAULT.
> + *
> + * We ensure that the copy_from_user is executed in atomic context so that
> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
> + * probe_user_read() suitable for use within regions where the caller
> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
> + *
> + * Returns: 0 on success, -EFAULT on error.
> + */
> +
> +#ifndef probe_user_read
> +static __always_inline long probe_user_read(void *dst, const void __user *src,
> +                                           size_t size)
> +{
> +       long ret;
> +
> +       if (!access_ok(src, size))
> +               return -EFAULT;

If this happens in code that's running with KERNEL_DS, the access_ok()
is a no-op. If this helper is only intended for accessing real
userspace memory, it would be more robust to add
set_fs(USER_DS)/set_fs(oldfs) around this thing. Looking at the
functions you're referring to in the commit message, e.g.
show_user_instructions() does an explicit `__access_ok(pc,
NR_INSN_TO_PRINT * sizeof(int), USER_DS)` to get the same effect.
(However, __access_ok() looks like it's horribly broken on x86 from
what I can tell, because it's going to use the generic version that
always returns 1...)

> +       pagefault_disable();
> +       ret = __copy_from_user_inatomic(dst, src, size);
> +       pagefault_enable();
> +
> +       return ret ? -EFAULT : 0;
> +}
> +#endif
> +
>  #ifndef user_access_begin
>  #define user_access_begin(ptr,len) access_ok(ptr, len)
>  #define user_access_end() do { } while (0)
> --
> 2.13.3
>
>
