Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D1EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90318213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOTjXQv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90318213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJRGNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:13:08 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33045 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeJRGNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:13:08 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so11036065ywb.0;
        Wed, 17 Oct 2018 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6gNPQuA8wjAYjUFtN6tALZQinYGmG/L6svoW1XvOXg=;
        b=UOTjXQv36ESUeeaV5SEQVXnQYLeTATGS8j+2FrVEf/g7k6IMynZNxomwEeHJNXvsLg
         B4wAeEta5vbHIuZ0fCfrdszdN7CIyRli1OX1P6S26bme2slZ8mnnHx2H9HOV/Gdq8Tdp
         rTu5QYnarGRmhbfrGosGFRHmdyF5CkJW3oylfcWNZ62HldG4sMWXgY+IKjBpmygcCLNu
         QZESKuvBF8sLbyyclfl3SRas/f7TFJsoVx9f6l6gtlOQhYuESFFtj4rxhIc8T+Nh2+c4
         5Hxb/zXfH64ymYTrthvGcezKXjHEsRmm20MA2ft/4WUWVY714AY/W5SscFbr2RnE5XpQ
         b40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6gNPQuA8wjAYjUFtN6tALZQinYGmG/L6svoW1XvOXg=;
        b=silA9IjzMiIR9ougp4QfzuzVatGR3v4tQd8DU4j/VlYkXsD3tnzVWjj5pDajEF0UX6
         bscobOJcBR2Zv+YFyBLyDi0o3nywK1D2R9xXAGuqCv8pWnofrJOZEcVbngDmgtlyh6zB
         WhjLc1rANj9nLFkv+h+AqtiSyUar+bEFVQO+yLcbJxJLr8+CKqYLOz4MQF4PE7wxTZz8
         /DCrHMDZXgDNoBfETSl0TVEPoiqI3+gwLbyHQd+0o1e2WZUh0nyygD5aNhjVdhGaq12a
         hrJQ5pOmrJkEtjkOG7tBMnb4eEtlzUetYDZO1NjnPkT6jczLzlIKdZS2YBwFc53du9M5
         u04w==
X-Gm-Message-State: ABuFfojYBzhroy64jBpKLujCYaLr38jDJsldPJopTQwb5tSokU0XopmH
        tWVomXkmjGooXQD8LdWnyLx/xw2qRolw2y17Oro=
X-Google-Smtp-Source: ACcGV60nHhQYJuFu+owFTz6emgxTumx2Gji6JBc40peQopz5KZR9QTbOkoPf2oMe+gToR9UnG7jpju1mN0DAeA6h1GE=
X-Received: by 2002:a0d:c947:: with SMTP id l68-v6mr16732891ywd.404.1539814524342;
 Wed, 17 Oct 2018 15:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca> <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
In-Reply-To: <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Oct 2018 01:15:13 +0300
Message-ID: <CAOQ4uxjqS3R_0O6gKVFEUJR7BvB+rpaHekjZm+fhMA+7on8AwQ@mail.gmail.com>
Subject: Re: statx(2) API and documentation
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> >> - STATX_ALL definition is unclear, can this change, or is it fixed?
> >> If it's the former, than that's a backward compatibility nightmare.
> >> If it's the latter, then what's the point?
> >
> > The value can change over time.  It is intended to reflect the current
> > state of affairs at the time the userspace program and kernel are compiled.
> > The value sent from userspace lets the kernel know what fields are in
> > the userspace struct, so it doesn't try to set fields that aren't there.
>
> What's the point of a userspace program specifying STATX_ALL?  Without
> a way to programmatically query the interface definition it's useless:
> there's no way to guess which mask bit corresponds to which field, and
> what that field represents.
>
> And there will be programs out there which specify STATX_ALL without
> considering that in the future it may become slower as it is now due
> to a recompile.
>
> So what's the point exactly?
>
> > The value in the kernel allows masking off new fields from userspace that
> > it doesn't understand.
>
> Okay, but that has nothing to do with the UAPI.  Even as an internal
> flag we should be careful, as it might grow uses which can have
> similar issues as the userspace one above.
>

FYI, I identified a similar anti-pattern in fanotify UAPI when I wanted to
add new flags and did not want to change the UAPI _ALL_ constants.
This is how we plan to solve it:
https://github.com/amir73il/linux/commit/8c2b1acadb88ee4505ccc8bfdc665863111fb4cc

Thanks,
Amir.
