Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDD6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EC52085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4vVuneB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EC52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJHSii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:38:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40728 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeJHSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:38:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id w67so19216580ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/C/y3lpAtTJo881tbkv715dFdFoYRmWSGG67Ae1MjZw=;
        b=Z4vVuneB12GhQsOj6PFab8NMpSelYR2/4BjdPhY6ucv2S4lceWxKQ7ulrpRTncso6l
         b+mkgIO5+SOAFXJMHJoP9WLT40sKj8Q6PFDw0ooEad4n9kUg7ciC+t3zvBhWSzm8LFuA
         rvCduoVFIJSwVa+dUI4ID65Wi2hPqNdRqmPnvzPZTwmkfhsJkRq2br1UVeXwTYEJ4Fyq
         G1nkqMu7Ywe6YEHXWYt1q/ZF9ebdZh0enlG6XYmxRadVY4GN8v2HEzxJc/imDsDv0Zwk
         h9fF4qSgduEZA+sJ7z12OKGPBq/xZ/D/WkWQ3Oi6+0BvrXQBnFE53j9giwiApW1i/vwv
         5/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/C/y3lpAtTJo881tbkv715dFdFoYRmWSGG67Ae1MjZw=;
        b=AJ6FeJ1NVefiHXOa5VjBoAMOJEsIGOz7LgBhIYpI9B0PTxoNkJyb9XOZ9Tr5YbDOoK
         N5Eby5UGnSyg24JD1Hd5eSys9gnTRfmRvNq5PeROsWSXCjVq4vPEXglDY9WdCF14Q1Uv
         4X2tMs/+30opI4eGvw3X0ZvPko3Kc9yLHwdk6152Za5M0tBKHrs+cLPpnTkX9pK+frh/
         j/n7CDvDHFs7WWUMbeXayXLykXhHcdcc+5lwD4cxZq0uMmh4PYmTtGqU6LhzwwGqsLHV
         I9mGN79Jq4vJxAjAKAyTkUPnkXzeyU9jhe4MLyld0jh231F5SkWe5klUvAoMfvgAC2lb
         9vWg==
X-Gm-Message-State: ABuFfohh75U1okPirNClykmmrBfB1QigNdUmJwpFlZo78OAmSu0YeWxc
        d87bX8/Go+FMIVNil14av0y5pvQWFrCyJyZbiN/ZBf7r080=
X-Google-Smtp-Source: ACcGV62Gz7LSEEE55UZ5jF+NpfI5nDpjUeDcjN73RpI1EJJF50Lr0N9LgeYvQiURrvtSOWVO2ev0pGWxpFTzIUu2PlA=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr12618271oth.292.1538998040550;
 Mon, 08 Oct 2018 04:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181006193546.29340-1-laurent@vivier.eu> <20181006193546.29340-2-laurent@vivier.eu>
In-Reply-To: <20181006193546.29340-2-laurent@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Oct 2018 13:26:54 +0200
Message-ID: <CAG48ez1S7CVDCCec5F-N32BVEPckLb0Qy+PypThezwKA=8HSSg@mail.gmail.com>
Subject: Re: [RFC v4 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     kernel list <linux-kernel@vger.kernel.org>, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>, dima@arista.com,
        containers@lists.linux-foundation.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 9:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
> This patch allows to have a different binfmt_misc configuration
> for each new user namespace. By default, the binfmt_misc configuration
> is the one of the previous level, but if the binfmt_misc filesystem is
> mounted in the new namespace a new empty binfmt instance is created and
> used in this namespace.
>
> For instance, using "unshare" we can start a chroot of an another
> architecture and configure the binfmt_misc interpreter without being root
> to run the binaries in this chroot.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
[...]
> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
> +{
> +       while (ns) {
> +               if (ns->binfmt_ns)
> +                       return ns->binfmt_ns;
> +               ns = ns->parent;
> +       }
> +       return NULL;
> +}

If the value being read can change under you, please use READ_ONCE().
Also: That "return NULL" can never happen, right? You should probably
at least put a WARN(...) in there.

[...]
> @@ -838,7 +858,29 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
>  static struct dentry *bm_mount(struct file_system_type *fs_type,
>         int flags, const char *dev_name, void *data)
>  {
> -       return mount_single(fs_type, flags, data, bm_fill_super);
> +       struct user_namespace *ns = current_user_ns();
> +
> +       /* create a new binfmt namespace
> +        * if we are not in the first user namespace
> +        * but the binfmt namespace is the first one
> +        */
> +       if (ns->binfmt_ns == NULL) {
> +               struct binfmt_namespace *new_ns;
> +
> +               new_ns = kmalloc(sizeof(struct binfmt_namespace),
> +                                GFP_KERNEL);
> +               if (new_ns == NULL)
> +                       return ERR_PTR(-ENOMEM);
> +               INIT_LIST_HEAD(&new_ns->entries);
> +               new_ns->enabled = 1;
> +               rwlock_init(&new_ns->entries_lock);
> +               new_ns->bm_mnt = NULL;
> +               new_ns->entry_count = 0;
> +               ns->binfmt_ns = new_ns;

What happens if someone mounts two instances of the binfmt_misc
filesystem at the same time? Would you end up creating two binfmt
namespaces, one of which would never be freed again?

> +       }
> +
> +       return mount_ns(fs_type, flags, data, ns, ns,
> +                       bm_fill_super);
>  }
[...]
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index e5222b5fb4fe..da4950282ea1 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -140,6 +140,10 @@ int create_user_ns(struct cred *new)
>         if (!setup_userns_sysctls(ns))
>                 goto fail_keyring;
>
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +       ns->binfmt_ns = NULL;
> +#endif

Isn't this unnecessary? The namespace is allocated with all fields zeroed:

ns = kmem_cache_zalloc(user_ns_cachep, GFP_KERNEL);
