Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1308321848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D297cP5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBTRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:01:42 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40661 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:01:42 -0500
Received: by mail-vs1-f67.google.com with SMTP id z18so14383562vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tfb0VQ2uqwGh7AJzB5rNzREqve7ug8niy6IMgboCNw=;
        b=D297cP5P7G7cmQTUvFHbVpaPmk75LjlCeb6W499YBk4Z0UqNbOMlsdcVJWrX4/GR7e
         S/eEipKVINIWtvc0oNvl/oFsxilOm+WcutWKPBUEHzHN/Z4o20e56p70qPlrqhZoqUQJ
         bB1AKoKxVyUTWRMuvYFZk9+TP4/aKqwrZt+1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tfb0VQ2uqwGh7AJzB5rNzREqve7ug8niy6IMgboCNw=;
        b=L9yY2ZMBQw5GcblkhYqkrEu99kYVRc7KkWYRVwhOoVKlF6VFx8DVQw1UHWPEXyKtJQ
         gpKP6rAdLGS2G1EHCFF1QwosTctCeeygy1jGrbbLoX75KOHlE783g+JASIyF5z2+g9R/
         JiaDmU685bJlqosDBT1jQfSECUWiaVXljF4LqIMgpe1mcY0wfLJ5E3lF5WfQV239Xl6p
         ZpHFW3+acf2SMHuevnpCZnrYLBpkyyTL7wUMjnODxGc0z2/KKKxr+Ivju3MClMDg/9Ta
         n42yjbY4Xi+RHfh4S864cWfatrgoae6oO2XI47Zx5MA8CePQGxiPlucmYOuM8GlwEZXF
         Qagw==
X-Gm-Message-State: AHQUAuZjmiMB3HqFEuiOGhPxKZqN1c4QERBdZUYenpUo2OVSPAuwjjbe
        xg1mebHu4CovRlzvPyPJ5I1klDlr70w=
X-Google-Smtp-Source: AHgI3IYLOR91ljor9C53+VLvIZUHbv1TiPaFv6PDkvZF5RMcKMFHtu7xsvQvafUer0jU1ZtDLKV+VQ==
X-Received: by 2002:a67:fe85:: with SMTP id b5mr8776125vsr.42.1550682100692;
        Wed, 20 Feb 2019 09:01:40 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id u6sm2168566vsj.28.2019.02.20.09.01.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 09:01:40 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id l136so5670527vke.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:01:39 -0800 (PST)
X-Received: by 2002:a1f:9695:: with SMTP id y143mr18517349vkd.13.1550682099076;
 Wed, 20 Feb 2019 09:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20190220005449.GA25243@beast> <20190220081451.GA2254@light.dominikbrodowski.net>
In-Reply-To: <20190220081451.GA2254@light.dominikbrodowski.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 09:01:27 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKPtL4oSa_7QJEXVc++idNNH9GA1Y=z3tQrorRTs0fnsA@mail.gmail.com>
Message-ID: <CAGXu5jKPtL4oSa_7QJEXVc++idNNH9GA1Y=z3tQrorRTs0fnsA@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Pin sensitive CR4 bits
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:15 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Tue, Feb 19, 2019 at 04:54:49PM -0800, Kees Cook wrote:
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index cb28e98a0659..7e0ea4470f8e 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -312,10 +312,16 @@ static __init int setup_disable_smep(char *arg)
> >  }
> >  __setup("nosmep", setup_disable_smep);
> >
> > +volatile unsigned long cr4_pin __ro_after_init;
> > +EXPORT_SYMBOL_GPL(cr4_pin);
>
> Where is this export needed?

I use it in lkdtm (which I was going to land through the drivers tree,
but I haven't sent to Greg):

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/x86/cr4

-- 
Kees Cook
