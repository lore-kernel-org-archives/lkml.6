Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C468F206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOhkp/HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C468F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeK2KoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:44:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33883 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeK2KoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:44:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so91107qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCqIcfLg6JilU3SrwQ4czbhNK5CR+Nu3c1LC6V9GWuA=;
        b=JOhkp/HD/J3jBTDQMUbaUB2DxMVUTn6yMEeoHhaYmVMoVmGWnspGS5CgZzpB1/uToC
         DakyBpmTtxuVlw76Ni1HRxyMT7svhXTq2nbagii/4eBaCqMIXpUDe9JS2Eie2LmcZ/0m
         AFBUi7Ce0UHgLJl0KNyqmcNEp6rm0c4AHL7rzLTHZjGynGw9mpVae6BcCIjKg05FwPnX
         f+68KK+4skv5oftPsnK0IykVd9bXEx98xFVAQ7/DRpaRT0whvoGOGUWrxqxWNvZzuixA
         i7TlkO2jMmnts3jyKiKIgY9ASQCPba+/XSEfxtmywB1T5nmz9QjxZMEuPJA2aTJoX4HZ
         EY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCqIcfLg6JilU3SrwQ4czbhNK5CR+Nu3c1LC6V9GWuA=;
        b=t5h05vY/lT/J3DXMdJJR2hNp4gMBchGlT+0vF64A85dx61xQ1JasuafPxAZP13me2X
         wIlTLKNQfMvmqEP8Aa3kj3WtJgBaJr8BdEhKPnu9TjDDUsu9jtg6oGLJ0lgEePhJb4E6
         aENX4xGBSRX4/izSPjmliznNS5/W97Mz9/a/TcIouBmRsCyRkyyoS3Jy8s5AzqVbMMpC
         TH24a4mFkamYI+HLt0PpTILlfwSGl4sfM9ULAkJ+alU/DTej4K5a8F6vFJySzbJ6EXVe
         SyI+UgQTRRkmykUfyCohl18kPdMVDZzxtAKsdsgbE0mxxvOJlDDgWXYFE2O2skIbnYm/
         q+Hg==
X-Gm-Message-State: AA+aEWYHsuV88VkzXoQTmEcD/qkGp9nFlXIZI+BBeQ/zaX5mr+IoxfcY
        /cxgauxk/ofVZO2kZPydp0U3xpC6ifVKvhA6fog=
X-Google-Smtp-Source: AFSGD/VmRM+7LZ5UniWWYIfElrBRWl9QBjL69hoQvzEj+GPP7ZN7CGzPs/R+AWhczGKkBASgg8vlIhpH5nNMiojW/gU=
X-Received: by 2002:a0c:e84f:: with SMTP id l15mr36672938qvo.124.1543448465375;
 Wed, 28 Nov 2018 15:41:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541397462.git.sbobroff@linux.ibm.com> <3350c5dd5ea08c71e4769ea3801290e7f9238a6c.1541397462.git.sbobroff@linux.ibm.com>
In-Reply-To: <3350c5dd5ea08c71e4769ea3801290e7f9238a6c.1541397462.git.sbobroff@linux.ibm.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 29 Nov 2018 09:40:53 +1000
Message-ID: <CAPM=9txRjd6E3DxdcM14mzWG1P-Cr70P61Eyce95bBhJtqfH7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/ast: Fix connector leak during driver unload
To:     sbobroff@linux.ibm.com
Cc:     Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 at 15:59, Sam Bobroff <sbobroff@linux.ibm.com> wrote:
>
> When unloading the ast driver, a warning message is printed by
> drm_mode_config_cleanup() because a reference is still held to one of
> the drm_connector structs.
>
> Correct this by calling drm_framebuffer_remove() in
> ast_fbdev_destroy().
>
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  drivers/gpu/drm/ast/ast_fb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> index 0cd827e11fa2..655372ea81e9 100644
> --- a/drivers/gpu/drm/ast/ast_fb.c
> +++ b/drivers/gpu/drm/ast/ast_fb.c
> @@ -263,6 +263,10 @@ static void ast_fbdev_destroy(struct drm_device *dev,
>  {
>         struct ast_framebuffer *afb = &afbdev->afb;
>
> +       /* drm_framebuffer_remove() expects us to hold a ref, which it
> +        * will drop, so take one: */
> +       drm_framebuffer_get(&afb->base);
> +       drm_framebuffer_remove(&afb->base);

This doesn't seem corret, no other driver does this pattern, and I
can't believe ast is special here.

The get just doesn't make sense.

Dave.
