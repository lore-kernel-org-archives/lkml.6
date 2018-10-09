Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF81C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A746214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RA+jJwLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A746214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJIUBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:01:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34000 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:01:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id v69-v6so1095723oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Mgv8nZVA4iK9x8cx21nzvxLWBG8pe5Xw26erHZzU5Y=;
        b=RA+jJwLnTAQ9n6isy6HNiqDqwGXa2MF3ZGCTbQcGiz7RQi4UXqyGr7e2oi0DtbnuSy
         4rI8YrV91y95NeOSyL6+vQ4ziiidNOvzCEm+T1CHHCtSBdPesCTtDnufEmrRKf2dvWI1
         U7Mr86q0COczug6s7bMatjsz8K3jCDOyem8tz9DWKW3DAADN8WxkVbr9C2h0KrPiBmu2
         kti10IJfirH/N/PdQYfSe7jE/Ow260m4EKqZjPK6fT+Nsemo2WnCwrWL3QnCihuwRTHp
         w9feCR378rJynVcifYii8EbOwaXuhNHiSGhyPnvaWtWZQMEALNxvdvj9Cue5+6ZhGUD/
         51tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Mgv8nZVA4iK9x8cx21nzvxLWBG8pe5Xw26erHZzU5Y=;
        b=RckDrPyA0O24Tnve3/3vSne4DVtA+XYHmsNX1IiQ+ZVObwPZIL253ye3VHO4AQier2
         FM5mN7+il3mNUWVbPQNutRGy5LMhv3loH9UjDVwycLyrwv9DL5I8shA5xciiPxuavaLH
         qyw3xgkMVfnBKag5BokgTrmlfIMfkLr+f9HgD85NLUanN+Ei6+qEwVeNzlpBZJ2Afy4Y
         sswOjQjDiPhSz8r673giF8S2s5wtoWrzdCw2MIhLxxz8V7VwYjEoOucUhF/DFOvWN9Ao
         FIllJf/9JRLoknL/eVx4zIN1Q1qQCBFi88GkqlZ2cBsF3i7hcP2NulOXewKwm7zW9DEZ
         48kw==
X-Gm-Message-State: ABuFfohE1tC2oUe7WRp8nkBfRDuAVilsufMIgU/WLILRzhYemiKQ1U1E
        fZPpLTm+tipPci6ZfqGz1EWvhoqoashdHAyybn/tcg==
X-Google-Smtp-Source: ACcGV60Okn4ivAN+Trri9/yg80uIhsw3OvvZoAgNkvZnifUAldKAzZYnI6tYAJyONdht1F93uL5P1fDnSnJDQUrCIOU=
X-Received: by 2002:aca:c045:: with SMTP id q66-v6mr6110923oif.22.1539089062316;
 Tue, 09 Oct 2018 05:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181009103752.21482-1-laurent@vivier.eu> <20181009103752.21482-2-laurent@vivier.eu>
In-Reply-To: <20181009103752.21482-2-laurent@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 14:43:56 +0200
Message-ID: <CAG48ez1OVKqRZe6AtTwXSc27AjNF596nt-46J9WPffKu7fNb8Q@mail.gmail.com>
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, dima@arista.com,
        Linux API <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, avagin@gmail.com,
        containers@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 12:38 PM Laurent Vivier <laurent@vivier.eu> wrote:
> This patch allows to have a different binfmt_misc configuration
> for each new user namespace. By default, the binfmt_misc configuration
> is the one of the previous level, but if the binfmt_misc filesystem is
> mounted in the new namespace a new empty binfmt instance is created and
> used in this namespace.
>
> For instance, using "unshare" we can start a chroot of an another
> architecture and configure the binfmt_misc interpreter without being root
> to run the binaries in this chroot.
[...]
> @@ -823,12 +847,34 @@ static const struct super_operations s_ops = {
>  static int bm_fill_super(struct super_block *sb, void *data, int silent)
>  {
>         int err;
> +       struct user_namespace *ns = sb->s_user_ns;
>         static const struct tree_descr bm_files[] = {
>                 [2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
>                 [3] = {"register", &bm_register_operations, S_IWUSR},
>                 /* last one */ {""}
>         };
>
> +       /* create a new binfmt namespace
> +        * if we are not in the first user namespace
> +        * but the binfmt namespace is the first one
> +        */
> +       if (READ_ONCE(ns->binfmt_ns) == NULL) {
> +               struct binfmt_namespace *new_ns;
> +
> +               new_ns = kmalloc(sizeof(struct binfmt_namespace),
> +                                GFP_KERNEL);
> +               if (new_ns == NULL)
> +                       return -ENOMEM;
> +               INIT_LIST_HEAD(&new_ns->entries);
> +               new_ns->enabled = 1;
> +               rwlock_init(&new_ns->entries_lock);
> +               new_ns->bm_mnt = NULL;
> +               new_ns->entry_count = 0;
> +               /* ensure new_ns is completely initialized before sharing it */
> +               smp_wmb();
> +               WRITE_ONCE(ns->binfmt_ns, new_ns);
> +       }

You're still not preventing a concurrent race of two mount() calls,
right? What prevents two instances of this code block from running
concurrently in two different namespaces? I think you want to take
some sort of global lock around this.
