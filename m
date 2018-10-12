Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7698C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F642077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bS69ll8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F642077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJLIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:05:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39673 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeJLIFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:05:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id l58so10791930otd.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 17:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O3dVQ2VpkzyEy5AtqvYVsyf5CfAZqFhRMHYDEQWhI2o=;
        b=bS69ll8SS+45FdCeCQXRdeyX1WZ70u0jLFH95oHGj594lfmYJy5ZlueYOW4wgzxCAA
         i+6QwpNRSKZohJK1iHuKzd2ud6l0Rpmw4iF0tAFO64asFxetHsUth2VjoF3CNPMsJJn7
         YDCiv46PJbZMlJCkp5hAzP9OE0BVbOVuPJ50gvEPBU/FLXlyaSry4LZxFt2JEWdQOXma
         lkwGxMYIxta7tId0ea1pAdPtbZRnQp+Ow8+ZeqoRWZPRalg8zWzJ3vOHGJ4+sb3rbhnm
         cVlcKFWX5CeQk354e6EbK4LxQsPditor+/Tr7mtd+IkNvVeLJqVZv6Z6m/DeFztSi4kq
         sBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O3dVQ2VpkzyEy5AtqvYVsyf5CfAZqFhRMHYDEQWhI2o=;
        b=cO3X6NScTMywT14ci44mVV6Vvhnu2r4reeYGHcwu+NGfCMGUEvoLJeS27W6qQIRmfR
         fg5XX+FGhdlRnejdOAgvQyjX+uTxYzOHx4yiWcxzohPj2pFu5vzQUGmEIZ+8w6hc7wbM
         M+R3O3tNe2+p8AFp0YCh3bqa6q+vv6wKFO8C6JRwDojs6AZqT+9yZsH5tihxe7AOQZ7U
         RhT1AILrqPVdIJjRZlWabwN4BJfcGNbvVY90JqbDX3xxLkX8rqyQe4RUTQKW/oyuNxH4
         OyG0ZdDF0vPCDE5+irLnQN0fQfAPskSqrlp/l0mxzr1xcOOLBxY/mqtoVkp4uxseuj8T
         boGg==
X-Gm-Message-State: ABuFfohSwviPTbidMxuWHrBBnsaD+WnCnXwQvY8w7rd4pIYaae00Bx8g
        /+CXMVgZORuU81JfDEAW6OmXSmHncaacMNg6JNJApQ==
X-Google-Smtp-Source: ACcGV60wE/h4NRkFdQ03NEnOmZoRdeLRTJcSpJ1zcAmPTq5izdvagVxIQ4ZJUoHY5xKfIgBlSsz+ANnQ9QlcAlC5H3g=
X-Received: by 2002:a9d:4917:: with SMTP id e23mr2664587otf.73.1539304555105;
 Thu, 11 Oct 2018 17:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com> <20181011233117.7883-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20181011233117.7883-2-rick.p.edgecombe@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 02:35:28 +0200
Message-ID: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, jeyu@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>, kristen@linux.intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        deneen.t.dock@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> module space a user can use. The intention is to be able to limit module =
space
> allocations that may come from un-privlidged users inserting e/BPF filter=
s.

Note that in some configurations (iirc e.g. the default Ubuntu
config), normal users can use the subuid mechanism (the /etc/subuid
config file and the /usr/bin/newuidmap setuid helper) to gain access
to 65536 UIDs, which means that in such a configuration,
RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
applies to RLIMIT_MEMLOCK.)

Also, it is probably possible to waste a few times as much virtual
memory as permitted by the limit by deliberately fragmenting virtual
memory?

> There is unfortunately no cross platform place to perform this accounting
> during allocation in the module space, so instead two helpers are created=
 to be
> inserted into the various arch=E2=80=99s that implement module_alloc. The=
se
> helpers perform the checks and help with tracking. The intention is that =
they
> an be added to the various arch=E2=80=99s as easily as possible.

nit: s/an/can/

[...]
> diff --git a/kernel/module.c b/kernel/module.c
> index 6746c85511fe..2ef9ed95bf60 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2110,9 +2110,139 @@ static void free_module_elf(struct module *mod)
>  }
>  #endif /* CONFIG_LIVEPATCH */
>
> +struct mod_alloc_user {
> +       struct rb_node node;
> +       unsigned long addr;
> +       unsigned long pages;
> +       kuid_t uid;
> +};
> +
> +static struct rb_root alloc_users =3D RB_ROOT;
> +static DEFINE_SPINLOCK(alloc_users_lock);

Why all the rbtree stuff instead of stashing a pointer in struct
vmap_area, or something like that?

[...]
> +int check_inc_mod_rlimit(unsigned long size)
> +{
> +       struct user_struct *user =3D get_current_user();
> +       unsigned long modspace_pages =3D rlimit(RLIMIT_MODSPACE) >> PAGE_=
SHIFT;
> +       unsigned long cur_pages =3D atomic_long_read(&user->module_vm);
> +       unsigned long new_pages =3D get_mod_page_cnt(size);
> +
> +       if (rlimit(RLIMIT_MODSPACE) !=3D RLIM_INFINITY
> +                       && cur_pages + new_pages > modspace_pages) {
> +               free_uid(user);
> +               return 1;
> +       }
> +
> +       atomic_long_add(new_pages, &user->module_vm);
> +
> +       if (atomic_long_read(&user->module_vm) > modspace_pages) {
> +               atomic_long_sub(new_pages, &user->module_vm);
> +               free_uid(user);
> +               return 1;
> +       }
> +
> +       free_uid(user);

If you drop the reference on the user_struct, an attacker with two
UIDs can charge module allocations to UID A, keep the associated
sockets alive as UID B, and then log out and back in again as UID A.
At that point, nobody is charged for the module space anymore. If you
look at the eBPF implementation, you'll see that
bpf_prog_charge_memlock() actually stores a refcounted pointer to the
user_struct.

> +       return 0;
> +}
