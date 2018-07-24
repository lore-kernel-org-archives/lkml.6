Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E5AC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A42320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="flnBXnGj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LIHH1bvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A42320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbeGXXPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:15:52 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38396 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbeGXXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:15:52 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so2254822ybo.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=P/ed/Q2I/hcC2QpcSTynFKeNq+wbtnVj2KKaTP2e++U=;
        b=flnBXnGjVMDtKZs+lp4NfdX9QmZGYUSr/GKTM9S32/3XjeQafL+vEZL4xFJYBIXz+f
         E5HOg9J9IcWYYb3JfLpdgicqVvDE+pIKsrruTs/72JQ8xLP7QG+PvhvU5iIx57dS3CBB
         2BFrmbPYnCVbgG/xXsCAgTFQ00hYY3o3kpnWsbES0wQ0q+Dt87tw4Ir8eesWZiWFWPGW
         FdtT6PIfRNpPAuhbhJYttGiEMuC/fw7ybxBeJAphcqPOSh+q0uKVrb5Yiw7uqbrC0l17
         RYQBDxGFKvdM0b/FrqXpQiQoc/LSHxwvz6x/8nKD2BpDc0D1ZRH2D2jGkHUhgUHn3cr5
         C1Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=P/ed/Q2I/hcC2QpcSTynFKeNq+wbtnVj2KKaTP2e++U=;
        b=LIHH1bvApzZUPtbudniwBV0JQEQgsMQmAAqEsE/4JhNBVZ4R1QuVeJmKstPX+rTAnz
         HI4TM16+H+EnqDTLhtDbDjXXs3vcZjSsjWdFoCkH1nH5pefHVbqGrhaq7Y651zVX8S2G
         DoWc7JM5HqYzF+VB80DcQsyTITBPBTum8QSO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=P/ed/Q2I/hcC2QpcSTynFKeNq+wbtnVj2KKaTP2e++U=;
        b=fMOxV7YzTWIkSlAHEn0XseppDb3U49ODpCNhxBUWaPdvSxQ2+BbhTgxjXAEcSgRkP9
         mZuQwz3e4YnzrmDsACWa3Ui7F8QnfSAqzK4suFnBXzTNN7Sxi02JdDaiWZe5zEMGKQiJ
         qke/GrCOTCvViccsDskE7nXR7kTtZDQbU2ZkROZMUG5hu62/3AQmahPZgvNjhgtgfoxw
         ZWr8BOBjuCywnXy89L0w7nn1UVdEvoiFoni92SlPwRrzEUkvFB4AKviZh4asSypfhISU
         +L+F6X4gHD0dCq34FhdYkXS0RHAXn6ciB19jZuAmm5yxEle5uygbV99Kaq51obOtfTe1
         EEgQ==
X-Gm-Message-State: AOUpUlGoRE6GmqFnSNfbvA/aQngd1O+L/ZQeimtF/ikiHWFbBiUr22Wz
        /Mhwkt6Xz7V8yMjqPn8l3GwPZTCUv/9BK9r1btHe/g==
X-Google-Smtp-Source: AAOMgpeEHMTckbJU0EyK6zIg2qrgbHVLRxGOWZIllLd7ydiMXLQcH8KizyzcynvdMeVfWS9JwurPT1KFjqwHXRKqWqI=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr10089013ybe.118.1532470038751;
 Tue, 24 Jul 2018 15:07:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 15:07:18
 -0700 (PDT)
In-Reply-To: <20180724200214.95975-1-zsm@chromium.org>
References: <20180724200214.95975-1-zsm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 24 Jul 2018 15:07:18 -0700
X-Google-Sender-Auth: RL0mpwQfeCs01T-rQmROI7HhA2A
Message-ID: <CAGXu5jJ7jS=ChfVF1oRJsGu-bSXK_WvTs94f_dQ9ud9Bt81-WA@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Annotate tracefs_ops with __ro_after_init
To:     Zubin Mithra <zsm@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Steven (maintainer) and Al (fs) to CC...

On Tue, Jul 24, 2018 at 1:02 PM, Zubin Mithra <zsm@chromium.org> wrote:
> tracefs_ops is initialized inside tracefs_create_instance_dir and not
> modified after. tracefs_create_instance_dir allows for initialization
> only once, and is called from create_trace_instances(marked __init),
> which is called from tracer_init_tracefs(marked __init).
>
> Signed-off-by: Zubin Mithra <zsm@chromium.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Who's tree should this go through?

Thanks!

-Kees

> ---
>  fs/tracefs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index bea8ad876bf9..20e965873f27 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
>  static struct tracefs_dir_ops {
>         int (*mkdir)(const char *name);
>         int (*rmdir)(const char *name);
> -} tracefs_ops;
> +} tracefs_ops __ro_after_init;
>
>  static char *get_dname(struct dentry *dentry)
>  {
> --
> 2.18.0.233.g985f88cf7e-goog
>



-- 
Kees Cook
Pixel Security
