Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68849C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2831C2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0S9G8y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2831C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJWOpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:45:14 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39753 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeJWOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:45:14 -0400
Received: by mail-qk1-f181.google.com with SMTP id e4so125257qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 23:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y74D9wcXF+MF7UYTa5cF/Lz2OMdtopJLGklBfwbLKjI=;
        b=K0S9G8y1eoUvmpU6qCJDDWUAL/3Rozmrxr79c3OEnIfZJk2CEvMdmKj9xI14OJTp9F
         YtCbSNJzW3/2OUCMrqumYAeQ7Ei2nL6qJ0yr5KMvPfwL80PSXAVoDN5GfILJr+YRB6xq
         TJA41USfcVYSRgr/ryEIqUqKgDk1qyjvZjTJ30yeu6uJ8EDxKaFpVMZoeCzzDKZyFVjy
         mjOoEsYG9bvk/BKnz/JNTMoWQFAmsXuKHgy1BkxEKZgeGA20mo0u/6ne5qybUoMSLiD4
         FkbLaE+lqbZlt0LVHzf68OAhS380t46DEVAYsdEpHDORqcpBftx1WxjXnYi53h4twwQq
         yr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y74D9wcXF+MF7UYTa5cF/Lz2OMdtopJLGklBfwbLKjI=;
        b=BMD6xFkvnfSUEjM3pril6Hl+KY5tIR6QDohDF9rxF7RL+fy/Spa7c0TkDRUa2Ouu3y
         miSmAZhYgz2g6wIkRcsaRPfzYFnJPhYS3fT3rd37RleqsCIH5Aly9LGw6GBnuYwBls+L
         vmJHTQ42W+Mae9bNn747P1yInnt7lpgYvUKK4Uz7YxDfpImvaE0VmjbuLSVetirfz71x
         Lh+qKanKla2jLPLOHYRPHa7NyYstqI6ljGIHn8uzaHRStPgCkSxa57N2PlDKJCLKSK9G
         fwxWBFHvaKXOhjLIL0n3TWZ7tEaG+JMqOpE1uE4jsDh64Qtc3Xb+TyJiXYhSQA5M9a2e
         Phrw==
X-Gm-Message-State: ABuFfojaOoYeX36B5oK2P2oCEvOiXFpiEvUJVbv0aFYXmVjiVbA2JM3V
        OlPikAUAlfL743EpiXUVMh7gkThnaJwYJ+l1ZGT7cg==
X-Google-Smtp-Source: ACcGV62uEQpn2Q/jdxiCGRNNBW2SSzHrA5ZHkIhtmn2Alm2gHYsmGH+i8RWnqeFURTJHLZNUYZs6tFVQa1C/ZCiHcBU=
X-Received: by 2002:a37:3094:: with SMTP id w142-v6mr25906665qkw.131.1540275796490;
 Mon, 22 Oct 2018 23:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMkWEXP4Mm5x9rdrKn9xRNVm7vxqoL62ftxb+UcJFAiJ+U9X3A@mail.gmail.com>
 <CAPM=9txnZaeUgYEauJF5eSidEsGS9DmT6M4O-PcTPtCFXL8adA@mail.gmail.com>
 <CAMkWEXN3v41hg70vjzygbJPK9==xZSBdeDPkSQNs85Sm4HFucQ@mail.gmail.com>
 <CAPM=9txOFw60VZZQYJnOg+BCXLoN8cUd+Ri_B8Bt4Lg0sYBH4A@mail.gmail.com> <CAMkWEXP96mXnzrjQEYb7Km5K-5WqYxwKZBXEm1omj0AM9Rn-0Q@mail.gmail.com>
In-Reply-To: <CAMkWEXP96mXnzrjQEYb7Km5K-5WqYxwKZBXEm1omj0AM9Rn-0Q@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 23 Oct 2018 16:23:03 +1000
Message-ID: <CAPM=9tzOVwXmSBv0C7nj4MMYOmutHdwgjZ3FSku+XDsEZmVmPA@mail.gmail.com>
Subject: Re:
To:     mtirado418@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 at 16:13, Michael Tirado <mtirado418@gmail.com> wrote:
>
> That preprocessor define worked but I'm still confused about this
> DRM_FILE_PAGE_OFFSET thing.  Check out drivers/gpu/drm/drm_gem.c
> right above drm_gem_init.
>
> ---
>
> /*
>  * We make up offsets for buffer objects so we can recognize them at
>  * mmap time.
>  */
>
> /* pgoff in mmap is an unsigned long, so we need to make sure that
>  * the faked up offset will fit
>  */
>
> #if BITS_PER_LONG == 64
> #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFFUL >> PAGE_SHIFT) + 1)
> #define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 16)
> #else
> #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFUL >> PAGE_SHIFT) + 1)
> #define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFUL >> PAGE_SHIFT) * 16)
> #endif
>
>
> ---
>
> Why is having a 64-bit file offsets critical, causing -EINVAL on mmap?
> What problems might be associated with using (0x10000000UL >>
> PAGE_SHIFT) ?

a) it finds people not using the correct userspace defines. mostly
libdrm should handle this,
and possibly mesa.

b) there used to be legacy maps below that address on older drivers,
so we decided to never put stuff in the first 32-bit range that they
could clash with.

Dave.
