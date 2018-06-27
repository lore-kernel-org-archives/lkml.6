Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D77C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4195925BC8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtGEu3C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195925BC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966231AbeF0Vmh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:42:37 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43207 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965721AbeF0Vmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:42:35 -0400
Received: by mail-vk0-f68.google.com with SMTP id d74-v6so2072814vke.10;
        Wed, 27 Jun 2018 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e6zODZ7LQXZmvJbyI4Y255Gm6WfbuUVM4XNQqLyQyJ8=;
        b=NtGEu3C+CnwHEdo2QDx64uuDLtG9SUJC/CcXE/eI/O5dFMQ161rX+M8UZgedMnXi7f
         RyWeKvnyLSv5K0AnxeqmQUlOBZblVC7wsWzNu30r0GCl0/5AQRoMdULeADPpVGi28yDF
         BMO+55vEQ939oyPfiD5n1B66VplEuDLmFKyhcnk0i9nmBLgdbMJ+pITJ8rb4olyAKhxx
         XMzJ7xM0GR0Bsxl2BZTmNjSqrSMBwUty6CFIog317XJwPuonwFWZ56yastmHYlCPELwj
         ouWkA+6EjGHWfh/dxNE7KZKmUqlTZYRpn8YbR7C9xv+/JZEk89kUmsZcMJIHBHAdSNKe
         2wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e6zODZ7LQXZmvJbyI4Y255Gm6WfbuUVM4XNQqLyQyJ8=;
        b=kP/vDBrzKcrRJXMekE1wJd08RrDdgL46gXw05VsJ4mUORty83wDGqFu3phR/fRM6Vo
         94HDA7GQ/jpTdZXJZ2DSda+/8Q89HMAdB/B063dMxenYlpyHxQ0EiNb6xHtUYV/a6ctk
         cshqddFziOyIbDal0Kx8cmDT2k63cnRrg1AQnRi2d+VHMdPr+isjG1avB4HS5fF5/0/E
         Yg1hMzoKAXw03uvQAnQYVK2aSx6GjUgbptcl2godC8DnE1zxzZ77i0PfoSbII8dAsbjP
         9t4Pg+tZtm2eZw2eKZR6eVdA8S7/gsLnJc4qt38TF0ftM8oHhEswqlz1cAwEbAhF/Sk3
         0BYA==
X-Gm-Message-State: APt69E3whvalnDyY0nYZvceaD1BEV3fk73GdIA8CW4NmWQoLJycSsYSc
        gpvillCc+QbiNeqCRXbCZF+Z5u2lBeZ7mtSAcPfd3w==
X-Google-Smtp-Source: AAOMgpdhTv/YlNv1BNMHFgYAcNprA5xNM0jYIx/C1sE45n3LRzqYA1/ZYOttpVAJKHqTiqmVSvERE5AGzCFKyXYMt60=
X-Received: by 2002:a1f:a8d6:: with SMTP id r205-v6mr4690075vke.129.1530135754693;
 Wed, 27 Jun 2018 14:42:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 14:42:34
 -0700 (PDT)
In-Reply-To: <20180627200218.GF18113@avx2>
References: <20180627200218.GF18113@avx2>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 00:42:34 +0300
Message-ID: <CAHp75Vcp61v_VeMNrKYwpc7MKXy2Mjcx9kek-oPyX8A+P7ci1w@mail.gmail.com>
Subject: Re: [PATCH] proc: save 2 atomic ops on write to "/proc/*/attr/*"
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:02 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Code checks if write is done by current to its own attributes.
> For that get/put pair is unnecessary as it can be done under RCU.

>         /* No partial writes. */
> -       length = -EINVAL;
>         if (*ppos != 0)
> -               goto out;
> +               return -EINVAL;
>
>         page = memdup_user(buf, count);
>         if (IS_ERR(page)) {

> -               length = PTR_ERR(page);
> +               rv = PTR_ERR(page);
>                 goto out;

You alredy have more than one exit location, why not to convert this
one as well and get rid of out label completely?

>         }

>  out_free:
>         kfree(page);
>  out:

> +       return rv;
>  }

-- 
With Best Regards,
Andy Shevchenko
