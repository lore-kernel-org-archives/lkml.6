Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99159C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B621273CF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TYs1ofyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B621273CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967305AbeF1Pho (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:37:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44154 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967292AbeF1Phm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:37:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so4859971ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbOmmk5lznkqe0a8EzLeVE1XeQfVMP7MjaPbgKkQaPk=;
        b=TYs1ofyQ2zmHDm6Llsn6iJ5qTteKbNyrZcqx5SbJwuIJKkSGCrfqep2fmUf9J6trjL
         QONbS6tK5MxFFf7hoa8tIiw8Do97Fl9kK4Eiz5rRVxJvecpILP0bPZygL2FU9Jqjxofm
         sCiqg4YvWRZVI+Vp1ojv2I0xa6DvWvphZdwfaueELtYigay1HIUfZfO1XSoWiMBK3Ie9
         Sg+oNuGetAErlWLkAuRgAVbv6X+kO1W9E1oB9Ds4/sALRTdcE5EnuZINYsE1kDWePrLW
         vaL0CiDEanpGLfcpAeCf1QiZxz6W1DXJLa89aQgTBhHOQOlS/yJMkLGDxQQ9IBR1JLSp
         UV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbOmmk5lznkqe0a8EzLeVE1XeQfVMP7MjaPbgKkQaPk=;
        b=dG9W+rn/C/2Z4lDhMugS7Dn0P3zKlPfdfF2hSAL7X8/5YAqavue+JBQ5+hHZRUy1c/
         8cBZcbQ/DyZ2K2FN9RT9/wFiqW0vZTqVoW/kBeiYFXvQgrAKL0/TNPrFCLRrMsZFxeUV
         1ASg2XJoqyc0wjRtFAkrvXhMgvhK9Ym+O8QRdWY7IDmCKLZgBv9Sq/oI7rbcNf4B62xb
         bQq2+sylL3X8wvRfQ0cXu++3uGtDKPCCuZWemiRZQNkfnG464SO1EAG/wRO1uQ5XlpBv
         EcI3NFXK0SgUr2Ofi1xaAZs0VaYvCOlq+w7dadJ5tBHLmeIORzakEkIPwz26bPVhsngs
         zBng==
X-Gm-Message-State: APt69E2zmUcvUIkBRiY3jUzmhp91t+4jnKk+vFBYgKlAhqBp3TEQalVc
        B5g/5rLhYztfSH38PCl8sM+acO0BOwU1BMv1c5kNMf0=
X-Google-Smtp-Source: AAOMgpfEDqrPif6O2vedPh1wTao4tIe17p64U6cWdDxTE6wFDvDpD/3wbTO5dux+Y8eEJhCpvKE6orOOD09RjLLB4sM=
X-Received: by 2002:a2e:18b:: with SMTP id f11-v6mr7417880lji.83.1530200260613;
 Thu, 28 Jun 2018 08:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180626110442.21014-1-omosnace@redhat.com>
In-Reply-To: <20180626110442.21014-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 11:37:29 -0400
Message-ID: <CAHC9VhTsHby0V=3hv8x4Ut3TU_cn3cRw_WnMP99b_ppXMXpsng@mail.gmail.com>
Subject: Re: [PATCH -next v3] cred: conditionally declare groups-related functions
To:     omosnace@redhat.com
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Eric Paris <eparis@redhat.com>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The groups-related functions declared in include/linux/cred.h are
> defined in kernel/groups.c, which is compiled only when
> CONFIG_MULTIUSER=y. Move all these function declarations under #ifdef
> CONFIG_MULTIUSER to help avoid accidental usage in contexts where
> CONFIG_MULTIUSER might be disabled.
>
> This patch also adds a fallback for groups_search(). Currently this
> function is only called from kernel/groups.c itself and
> security/keys/permissions.c, where the call is (by coincidence)
> optimized away in case CONFIG_MULTIUSER=n. However, the audit subsystem
> (which does not depend on CONFIG_MULTIUSER) calls this function in
> -next, so the fallback will be needed to avoid compilation errors or
> ugly workarounds.
>
> See also:
> https://lkml.org/lkml/2018/6/20/670
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=next&id=af85d1772e31fed34165a1b3decef340cf4080c0
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes:
>     v2->v3: commit message corrections
>     v1->v2: change default return value of groups_search() to 1
>
>  include/linux/cred.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Merged, thanks guys.

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
>
>  /*
>   * The security context of a task
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
