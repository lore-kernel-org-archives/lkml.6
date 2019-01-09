Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C1DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C27420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547025898;
	bh=bjDePeJ8DLI210p+D7vIBZ6DGbQtykhTgMDUXcNIRjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tiKri0mSjLkGXfE1hwi/nftVdfk0K3NmlZXB9oyTe1sHag46rDrcJMU+pctaGJBb4
	 Ep6hq+uoOWtSX/Sai8A700PT5I+59ZHnWq+zM/vMSHyHKNq0zwC99dxZzhLqmh03y1
	 34A7dXEwIrjRCEbUXQi5QDFZIWBQaSgHBPXaz3NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfAIJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:24:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44377 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfAIJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:24:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so5725831oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVgvfTu4OpkhSyd0JI4qKR7THTvpO/6oht9sP0yaHk4=;
        b=XjPph5bXbg/NuC/W2NiZKWkz5HazzG/mwcmMh6x+mTuhydKavVSsV1ygXay7CL2AXX
         7Y1ju0HB+xhJJPOVxA4WZEJcn5x1jtSDQmf/qNCLUa8SySXhZfIam0X/+X/jmXCqatAV
         082F4qiZN6oFukVg0XxUmKXbod2n8DCyiauFVLvvHOQIlG3AX3KuM4xHKpwP6JCVa+PZ
         jNfpilcy4qhyDVRGY+3VAaOTy2yXLmHgijzb3wngaYiQCnfGH8RnH+7Wolx0kwadsrjF
         X78AklIJznB35FF6SYAfIyi4mxjtyhbOYDp57Uctx/y8JGK2y3Dg4C2/BPiyJhQ9cXGm
         m+Ew==
X-Gm-Message-State: AJcUukculaQxHKHJtBSohvMZl0Af0x9iOBjeYb0Hj8WfvDwwBeCFq7E2
        QMKOeopyf91YiXtXtCkiHVXnQZ+mngCn8SiymbdBlQ==
X-Google-Smtp-Source: ALg8bN4QaZwm+zeFoPH9I5EcnQ9J2x8Qhuy8LlLx4s+Igo1HvZ0eGDFGMQbmJ0KEsWPam7A4bkFvmLUiCNjFJBSCZcw=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr3278032oix.246.1547025896568;
 Wed, 09 Jan 2019 01:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20190109073614.18999-1-ebiggers@kernel.org>
In-Reply-To: <20190109073614.18999-1-ebiggers@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 10:24:45 +0100
Message-ID: <CAJZ5v0jkwANa_Yy98tmZmm0HgztGP5ATFy4FVUNxxkM2hkW7_A@mail.gmail.com>
Subject: Re: [PATCH] kobject: make kset_get_ownership() 'static'
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:38 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> kset_get_ownership() is only used in lib/kobject.c, so make it 'static'.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  lib/kobject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kobject.c b/lib/kobject.c
> index b72e00fd7d09e..aa89edcd2b63a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -887,7 +887,7 @@ static void kset_release(struct kobject *kobj)
>         kfree(kset);
>  }
>
> -void kset_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
> +static void kset_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
>  {
>         if (kobj->parent)
>                 kobject_get_ownership(kobj->parent, uid, gid);
> --
> 2.20.1
>
