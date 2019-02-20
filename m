Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BEDC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7672086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCo4N+Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfBTPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:09:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44917 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:09:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so40556321otj.11;
        Wed, 20 Feb 2019 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iO4aBbX/wKzyhNfhJOP7W7e9DNyMpQKdyAylvLuFuHI=;
        b=kCo4N+GwnvrFdgMbJq0D+OAr3/koMldXQmk+tDBMsA+RzR6lwLzFJdzsTBCX7lkXeR
         5pI/orjVnwhYZ40n1zYIq1/7ZCWqVESp2A9UNH+CY/x+z92eRUZ1yyxUl9UgnUmgxzQs
         +AAhstCGCYJC2MevOEVb2kzu5tULV/CsuHpCPK0cWL6hIkl8F8r8fTVQ71JxkBoBPnZy
         AI43hxr0cfyg94yfQvTzTJaHVyjgd4EXjKGBevxDcdj3FMtbKmH+4LU4EyyrFNgcPkeF
         8dNdB29251cNrdXI8RQut1QZuoz8mK55RdjfP0Y5DpFc4j/WRUdnW1zELqtDlGyVWf1O
         7Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iO4aBbX/wKzyhNfhJOP7W7e9DNyMpQKdyAylvLuFuHI=;
        b=Mw5P7TM+P4JzjtNkW5tEMTcU//rS/Tm1x5h6PUWi1/hu0vDNohCE9IablNiAGaVnXV
         B0BWmCaSx4GNwThEWHx8tqhCiaOLm0IdmNPxNnYPXfDxPZ0lcMP9lfQQskcEE+ACDie3
         nZ051lrBpZaUUsWgit441WeEUNGEGv8E85LhA4vH6dQfTEyWf1BPWhKdkSl+bbpXWljp
         g1elvzQcVhZBf58WsuKb2gPIFnmF8DA5o5AprGaq/lK5sySCNiXP+acQp4veguuWsH2k
         ylguMvm9Y/5hWT7SR2RwZltv4rteU6OZTLOdcorgdG6CTtknQYLgBN5VOFoVSTbGGM5R
         FqOg==
X-Gm-Message-State: AHQUAubG5PLpETfNiMirNqpgtrhoOuib/Lm/358mxUV0jzjHU+VscKIY
        zw00jP4u7KFXH2j0IxIh7z43IfcGjxQxX+tWPMg=
X-Google-Smtp-Source: AHgI3IbOWfHdj6tjckm00wO4IEXDBddJ5CuvIZ/QZ177y3mXzsPYSx8YXVdk9Iqx8bH3lRfjkiYKmFyab5IQtRoncMg=
X-Received: by 2002:aca:3142:: with SMTP id x63mr5977877oix.92.1550675384326;
 Wed, 20 Feb 2019 07:09:44 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
 <20190211212734.01909e62@archlinux> <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
 <20190212204730.16864802@archlinux> <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
 <20190218151606.00000d10@huawei.com> <CAGngYiVQLwFxNJcCCH3byL=_p=L_BjMHJ1kCbjR8XkOF2mN3Ew@mail.gmail.com>
 <20190220123240.77d764ea@archlinux>
In-Reply-To: <20190220123240.77d764ea@archlinux>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 20 Feb 2019 10:09:33 -0500
Message-ID: <CAGngYiXg6wPdsXZNmXJ3Z20xRp+cVrysj97gfEHJAxiaL27oNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again thanks for the feedback, Jonathan !

On Wed, Feb 20, 2019 at 7:32 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Looks to me like that happens (I haven't checked that thoroughly) via
> kernfs_fops_write which takes a mutex - so we have a barrier.
>

Yes, if there's a mutex in the path somewhere (which sysfs/kernfs appears to
provide in this case) then we're ok, as the mutex_unlock() should provide
the barrier which makes the flags visible to the threaded handler.

If that never changes, we are good. As with regmap_bulk_write(), changing the
current behaviour may break many drivers. So it's unlikely to change.

>
> That is a serious - "in theory" circumstance.  The moment we hit any path at
> all that results in a memory barrier it will see it.  Here its not critical
> so we can wait.  In this case this is triggered by a userspace write.

I wish this was an "in theory" circumstance ! I've personally been stung by
this very issue. Code worked great in all tests we could throw at it, but
failed at the customer, of course.

IMHO it's easy for developers to be lulled into a false sense of security.
In many/most cases, there'll be a barrier in the 'invisible' supporting code
somewhere. Or we have to use a lock anyway to protect against concurrent
inconsistent writes, which also implies a barrier. So when developers forget
that these visibility limitations even exist, usually nothing bad will happen.

Until it does, and then we get bitten :)
