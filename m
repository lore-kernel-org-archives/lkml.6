Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB20C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABF826134
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="W83/SMAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABF826134
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeFYVEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:04:35 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43762 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeFYVEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:04:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id z5-v6so2342332lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgBmpAtYMzHKDhrsvpkRnZfjf3we7Z94+nJEq4TsMkg=;
        b=W83/SMAc0mG88BFvMfZvWzgM5y9/FzjZxPQ4zkAWNMR+I1OCinLqe9F5dYkPwY79cX
         NZHhMQmCf4225Z93MKHYjCfeqkx1K1DTJY71BzD9EwSe/D9VTyW4H9fAd4Ioz2km5V0D
         s3seEug4s9TgEBPegil5eOO9Yqfz4eRZiPUd+IXN6aDBTFfFmzmOo5Q9ycJIW7p3ks3p
         FiXoY9WBhc2WR3cOWN53WBjvdDUcSP+D5RFRet7AdEp0ZgO8q09aOgif4GcVnvQ2FAEe
         DN4uueltD52Ejy2SbKTqtpz9EtTR8PieEIW2Uq8jdDYeBjGviLSLibEvavq9cv9Xq4SB
         nkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgBmpAtYMzHKDhrsvpkRnZfjf3we7Z94+nJEq4TsMkg=;
        b=b3+CaISwms/SDA97O3MaZpjWTi3idNNZnhW/rnYH1c8ZrmBbUj1sTi2Xxp1B0o38X3
         jx71zR6akcphhbygUBmCnWG2d7Y59TgY0EZSiUCmTIqxQ2gm4BoWnLfHfAvzkdotC8rd
         OxNHXGBYNPlUeazPojgG6nKp2RWE6MuJxD6FKXueQsl8JeA6y3Gtfy5a3bcylQczn+Wq
         7EtaiXqzaQjdAlWS+DdacFiZWuD26ObE6RX5GDFDB3uVhhGrXN8k65EUCTluEDgGpBYi
         opYCrlRsgYT+YZO8aEkjX41K1UJxyEFmxGRUImOqixwkqwlX4eY8R+ah3Fe9riAb262U
         UoZQ==
X-Gm-Message-State: APt69E1jB0f6f1xDathB5EAWnQ+IBqgrf+ETHMLcYNq1xpjW6rzabU0g
        70gwBounci6RMsA/S28ElL2kIRWSlWzpDq9/p+Pu
X-Google-Smtp-Source: ADUXVKKFHy1O+5ul/VpQlGuxFv44c9FrOXpY9Z/5MjpJ/oVsEvXxi8MbFawtRPhGHhwhbnsfDTLPavqw8Y+Qvddtc4U=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr6805198lfe.39.1529960671830;
 Mon, 25 Jun 2018 14:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180625065532.7268-1-omosnace@redhat.com>
In-Reply-To: <20180625065532.7268-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Jun 2018 17:04:20 -0400
Message-ID: <CAHC9VhSQwAH1k-cnpQ4iYs-gtHiQRfFvX9aSVW1_-cFEtJ1JCg@mail.gmail.com>
Subject: Re: [PATCH -next v2] cred: conditionally declare groups-related functions
To:     omosnace@redhat.com
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-audit@redhat.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 2:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The groups-related functions declared in include/linux/cred.h are
> defined in kernel/groups.c, which is compiled only when
> CONFIG_MULTIUSER=y. Move all these function declarations under #ifdef
> CONFIG_MULTIUSER to help avoid accidental usage in contexts where
> CONFIG_MULTIUSER might be disabled.
>
> This patch also adds a fallback for groups_search(). Currently this
> function is only called from kernel/groups.c itself and
> keys/permissions.c, which depends on CONFIG_MULTIUSER. However, the
> audit subsystem (which does not depend on CONFIG_MULTIUSER) calls this
> function in -next, so the fallback will be needed to avoid compilation
> errors or ugly workarounds.
>
> See also:
> https://lkml.org/lkml/2018/6/20/670
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=next&id=af85d1772e31fed34165a1b3decef340cf4080c0
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/cred.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 631286535d0f..7eed6101c791 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
>
>  extern int in_group_p(kgid_t);
>  extern int in_egroup_p(kgid_t);
> +extern int groups_search(const struct group_info *, kgid_t);
> +
> +extern int set_current_groups(struct group_info *);
> +extern void set_groups(struct cred *, struct group_info *);
> +extern bool may_setgroups(void);
> +extern void groups_sort(struct group_info *);
>  #else
>  static inline void groups_free(struct group_info *group_info)
>  {
> @@ -78,12 +84,11 @@ static inline int in_egroup_p(kgid_t grp)
>  {
>          return 1;
>  }
> +static inline int groups_search(const struct group_info *group_info, kgid_t grp)
> +{
> +       return 1;
> +}
>  #endif
> -extern int set_current_groups(struct group_info *);
> -extern void set_groups(struct cred *, struct group_info *);
> -extern int groups_search(const struct group_info *, kgid_t);
> -extern bool may_setgroups(void);
> -extern void groups_sort(struct group_info *);

I was going through the list of functions to make sure it was safe to
move all of these under CONFIG_MULTIUSER and I believe there may be an
issue with key_task_permission() and groups_search(), specifically one
can disable CONFIG_MULTIUSER yet keep CONFIG_KEYS enabled.

I'm going to guess that the fix is going to be to have CONFIG_KEYS
depend on CONFIG_MULTIUSER, but I would talk with the keys folks (I've
CC'd David Howells) to see what they would prefer.

-- 
paul moore
www.paul-moore.com
