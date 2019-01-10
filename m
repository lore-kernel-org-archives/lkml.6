Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104CBC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FD921738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uqs0aoLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAJAyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:54:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42936 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJAyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:54:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so7045120lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whQTbq+D2SNbxG+9U732P/FdMekb35BbA4EKj0dp34s=;
        b=uqs0aoLhxVABXGYbNXR6KIc8b0zWMHpQ3q98ELUgWlUSGCaBA+632UThdlyNS3G0kb
         l3FKQVKbQOkl/ITslw0eK68IJg1C0dwOxBE4g6ppoUQaCaAmDwwV5ry0gfFeinY1ZQfu
         agtspiX+bRmHhsx5/YFAjJKMWpSFgImgRqKv+SbZGUbyOA5ueFBCRO4INJzMMdzv5djf
         K6aeHR4qe5cyy8kAkCEwBd9aoq0EvLNnXzVg6BHJcHRQBhrS06Lp1ql+yQcOvQ+khiDz
         +QVEMkrLG2FdFEvhLbeYPec7WF+muA1Eqgt8kfwAMGe7aXQ88sNZOMMhfFr5TTBqBiYs
         sOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whQTbq+D2SNbxG+9U732P/FdMekb35BbA4EKj0dp34s=;
        b=IKtoF4+Plg85rI7TlcUrIJYSLAsEMJ8Tp8p0Vojy11gRGHh+ueBjelauuWuUOGPc+W
         BL920DyWkik0hK1N/PDOmWlikOeTo8jjtYs/f5QQrFXDk8tnC34cvZHL4JwUPagTLAMF
         ZaaXbTevO24wU41t9hSHWq3qQWOYuakUPSK6l+TpXbRQbhT0JrfYY3WUvPxe1aZGT3xc
         qdUF/iM6nzKlFesag7XKxwzKMXi7njkXmx8uXWoYtBQujQrTo5XeVqH1qzA8nz9UtjGv
         onXqDRtKvxgIF3lyKIIvale3/raKommnE2+9FKCdSdpLQmP9mKRWPJ8EOWhggfWsBuPt
         MW6g==
X-Gm-Message-State: AJcUukf0+DB0Vx/2WoCESzBoi5XyDZ4lh276dbcg4o0qelGI6chOAC7r
        3WYjkO5flQwSutpWsfKm41i2yR1ldW6FjZLVPN9p
X-Google-Smtp-Source: ALg8bN5gl/8+9SwFBOGo4rlpklrR6vLFH0rSEdhtistndhAn9hlVjPUENXxRc1I06AXuAOqfgTZV6zL1ezQ8oh8Y80c=
X-Received: by 2002:a19:a40f:: with SMTP id q15mr2403509lfc.4.1547081669323;
 Wed, 09 Jan 2019 16:54:29 -0800 (PST)
MIME-Version: 1.0
References: <1546593547-24406-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1546593547-24406-1-git-send-email-peng.hao2@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Jan 2019 19:54:18 -0500
Message-ID: <CAHC9VhTpHNxFUR7OP+=cVPiFOTw33ptrV89HPCORo4bvMQFc-g@mail.gmail.com>
Subject: Re: [PATCH] security/selinux/hooks: remove unneeded semicolon
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 7:55 PM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Remove unneeded semicolon.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a67459e..73c679e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1263,7 +1263,7 @@ static void selinux_write_opts(struct seq_file *m,
>                 default:
>                         BUG();
>                         return;
> -               };
> +               }
>                 /* we need a comma before each option */
>                 seq_putc(m, ',');
>                 seq_puts(m, prefix);

Thank you for your patch, but the selinux_write_opts() function was
just removed in v5.0-rc1 in commit e3489f8974e1 ("selinux: kill
selinux_sb_get_mnt_opts()").

-- 
paul moore
www.paul-moore.com
