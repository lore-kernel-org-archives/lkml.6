Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6480620896
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546940411;
	bh=m8icA14JXVaOt1hON8KunuL16Cs7j1KNE/bqdrDhLi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X+/hMOnQhLJXjCceDLHVdCaHZjKboDXoqMcqEIb0yeeUaERZdS6Q5+neyA1cNf7iZ
	 rA/VfYY5Ktw5DVGXWnJrCvvOwEVVoSlIKVEEayd5B62IQUJCwcz0h+aspiXg8KOQlT
	 Sru5D662hX167g5lq11s77nAGuCf+4PRysBUMHIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfAHJkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:40:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45993 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfAHJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:40:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so2909545ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/KC+dYTkmm346c3dFdW7Q9778m55qi6fU42h6VVnm8=;
        b=cQ0vo5QGfN7qjpoelxCc+q3192dQipb4po3benwGpWXMWPfc86JQ2Y6gWsfCnsQS5w
         jtVep3c1KKyIPwY/7oCJhCeANhZA94rWqZxMXSuSgBVspxRBK8eveYwTGLgNpIjEk+EH
         0IX0yIGompnq6m7ho6uTtjCYU61V/2tI5Ea+hFQ6fUwfBxHhySW2QjUpHEZQoNWz1VRD
         qYBsxZAqCZ94SRf8YIJ/Ztj9HL1xRw9ASm+qkA1p+hNO1pk80aDVfRJgVoqkHMk8Yk3N
         mQXT5aDExrOhoxVTttGLeuB06liASQ6+OU2uLTZHklii/SFVac2Txbq7zyhsoBcWFHzf
         S5qw==
X-Gm-Message-State: AJcUukc/9EN7BWG3dpAscIrx8JMAHboIq++0QYxLG/H9nf38BDR+KldN
        bvlAZcA5T4VE2e5JTc1CvZ6fxd5RwaJyJEqUtz0=
X-Google-Smtp-Source: ALg8bN4r/B8o1l/n3N0eNKQi69/mPng7fboA4BKMbq8lL2XfoubUdmNSpytg4RHzmuNbn1N6qdWgcT51v/9dLPRTo0c=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr697419otn.200.1546940409006;
 Tue, 08 Jan 2019 01:40:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546915794.git.tsu.yubo@gmail.com> <8c73ad4b2b29bda53f2dfb6624b8b7984b52e307.1546915794.git.tsu.yubo@gmail.com>
In-Reply-To: <8c73ad4b2b29bda53f2dfb6624b8b7984b52e307.1546915794.git.tsu.yubo@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jan 2019 10:39:57 +0100
Message-ID: <CAJZ5v0iiPKNVz3SE1oumOUDPGTrCHd5-hEoe6O=SsqSKD39XNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kobject: use pr_warn to replace printk
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 4:11 AM Bo YU <tsu.yubo@gmail.com> wrote:
>
> This is a fix to replace printk with pr_warn

You call it a "fix", but what exactly is wrong with the code as is?

> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  lib/kobject_uevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 27c6118afd1c..499dfcdafcb0 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>  out:
>         if (r) {
>                 devpath = kobject_get_path(kobj, GFP_KERNEL);
> -               printk(KERN_WARNING "synth uevent: %s: %s",
> +               pr_warn("synth uevent: %s: %s",
>                        devpath ?: "unknown device",
>                        msg ?: "failed to send uevent");
>                 kfree(devpath);
> --
> 2.11.0
>
