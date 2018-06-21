Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA53C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDE6223C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oDABo18B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDE6223C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFUVRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:17:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39624 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:17:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so6365356lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2Z9UsCFajn1Qm23lsgLCsYqQE84zadNsk2+KOz9dvw=;
        b=oDABo18BvtFYoYoIkFawhKEx14Izlf3O/ogn3GHMsNHtDgBSO0urkYFzBTqIAcmn6Z
         WZ+A+K+Hh2IeET378eie16w7uT3uwQByGwJ0R4T+HLIXin4NkZtdRZzbyPj396Q3ExF6
         G2opQBRj4Owrp8MoPZxqfcIQmhemvOrP40vSJFACL8P2VAioxSAhJhpdtblNX6Tuz3wh
         DpTQ3MpvwLnTbj4F2qdoFGKXcQ1ZjFM50V4KKyDSjaPquJ2HWfKxv3NwsFPBPeHyzNQh
         DJqRw7pWPZgktR7v4ECzDY+35w22ooT9N/TQZF95FWp278Lmbfs8W12ONVJ/PUCRPV9V
         eupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2Z9UsCFajn1Qm23lsgLCsYqQE84zadNsk2+KOz9dvw=;
        b=jbxN8ZffXEeriKIxF/M2AgxbDW59P0TLbDvf2qGmDEm0bXAycZCHeZc31c+BLgwIrM
         cjbLz+hPm1R7olu0SLWf0tOt8Vljk9GUID+zJ94Dkrjpm7O6GcY4EA179CoEdSqwDeTs
         TzYKuJoOiYt3ojaEBHfkl2y2fZLFjTOvAm1jKULqKfL+11Q4X40WRDAUI20mBzL3xFEj
         PvvbvMk3VgTMpaZEPleefjkHYODtLOE+BUWmAuSUZS3i2IR1waxvXNxTIwhVhYu/SNCM
         Ig3fmqDQd0feqKsd64YFARjq57ey4+0anaDuCRTG9yUwjIy1sxlz6zlBrLmwLPmxVnxe
         nosQ==
X-Gm-Message-State: APt69E01H4WUpuY8zc7KhL4yHIem+apHd4Ji/psGjxYyLgCu8I391egh
        Ibjq5aPzGOPM1KKpMsEeH8hSJ0T/06qVXjX72lDt
X-Google-Smtp-Source: ADUXVKJUxEbSP43LC0LSY6WBCHNrW/+97UKQVK7kWhfB7Bw7n7mISjTaOo+1FYGoIRx3naxhHFvoyeK/xvI2xyB6pLs=
X-Received: by 2002:a2e:4d0e:: with SMTP id a14-v6mr18807631ljb.106.1529615856762;
 Thu, 21 Jun 2018 14:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
 <20180621083316.8765-1-omosnace@redhat.com>
In-Reply-To: <20180621083316.8765-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Jun 2018 17:17:24 -0400
Message-ID: <CAHC9VhQk42UA5c_XAaG20h3TZt20TQyJxDMfqWHHgu2=8+kcVQ@mail.gmail.com>
Subject: Re: [PATCH -next] cred: conditionally declare groups-related functions
To:     omosnace@redhat.com
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
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
>  include/linux/cred.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 631286535d0f..8917768453cc 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
>
>  extern int in_group_p(kgid_t);
>  extern int in_egroup_p(kgid_t);
> +
> +extern int set_current_groups(struct group_info *);
> +extern void set_groups(struct cred *, struct group_info *);
> +extern int groups_search(const struct group_info *, kgid_t);
> +extern bool may_setgroups(void);
> +extern void groups_sort(struct group_info *);
>  #else
>  static inline void groups_free(struct group_info *group_info)
>  {
> @@ -78,12 +84,12 @@ static inline int in_egroup_p(kgid_t grp)
>  {
>          return 1;
>  }
> +
> +static inline int groups_search(const struct group_info *group_info, kgid_t grp)
> +{
> +       return 0;

Is this the right fallback value?  If CONFIG_MULTIUSER is disabled,
wouldn't we always want to indicate a group match?  The in_group_p()
and in_egroup_p() dummy functions would seem to indicate that is the
correct behavior ...

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
