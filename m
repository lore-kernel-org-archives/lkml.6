Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6270F20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWgGAp3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6270F20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeK2FVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:21:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43710 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeK2FVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:21:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so23408431oie.10;
        Wed, 28 Nov 2018 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7azP4mzGGa40kV9pnnK9b5t6fg6ERrxjmQmDJ1jYadI=;
        b=EWgGAp3C8xk+ydqV3gYA0nugTXz3KaG/3JfiyKEST4Z9B6XxTONVfAvI6x0mC4how8
         fvRia74cCkNZz6fj40jm8u0XUuBtFw+2t3/gw2N1aOhL5qVcvtE5Tp6V08U/ImAARYJ4
         TlZlN/hWSPInipMh4loCUW7L2Ynf7l593n2aFCFRoISEnZH5w8q+ld/DgJyJeqxTllYr
         qXHkkssZnI83I2WVjUEud7Wz0hDbq0FSvzZAmt/HOAVw2jpXeQq0ksmyYR0Q0PU+gTRo
         szJ0dqRDgETZsCZU1rynXc9gdjwUhxQSVr/9MS1ZYYUMccT6KIpxylt95HaZE5bd4WYD
         HNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7azP4mzGGa40kV9pnnK9b5t6fg6ERrxjmQmDJ1jYadI=;
        b=tuH57oap5QbiUxp7a2GYUJ17fb6PVPV6PNlghN/19/xdHzUhojytHNPzNhB5i6E5di
         oAVqeXoX+HzHo5tlPQh1tMeOh+9u1Mr/nuyH9pT2L237AhSJlqY/dBwl+iFLfMdlKUZM
         TWh4eDHCGYy5fTQWHxCY6WGrAYvX7adGQUWjhWp8s46TNerR5EPQz1dPRkusiSkkSBrm
         1WH+0jNGTykfc/VnwvRVakb+QsedyJGJ6KtiLsk9Xei63il9roVlBPURtiwJOZykil3K
         3WBqt2Tyn5dyjkKOeOnajAJfKNyKwn0MqSNteF2btO8WH/h4JFitvrIa7jtopN/elHKL
         2h/A==
X-Gm-Message-State: AGRZ1gLgpDnW3fTcCxmQwctGD4+Z+x0QhiSgOTYuDE6EWvIiQlnoXHRY
        OjOHrJgkyUV49Mc6bsyuOTlld/PKHrhf4w/n33M=
X-Google-Smtp-Source: AJdET5fti2OFqtg6lVizXZsfg+ft2sggDAKCHjClO2OaAokI6qtvDX+rKgz+JZFtJymygB/5iS3ocgUkKRt6mQHytEo=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr22464729oig.266.1543429156645;
 Wed, 28 Nov 2018 10:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-2-TheSven73@googlemail.com> <20181127075431.GG13965@kroah.com>
 <CAGngYiUL7bZVEehj4LGC2H+kv+Z4v_s=tG4uosOp1-Rc4_pGWw@mail.gmail.com> <20181128174238.GA4367@kroah.com>
In-Reply-To: <20181128174238.GA4367@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 28 Nov 2018 13:19:05 -0500
Message-ID: <CAGngYiXqscqVtSUkwwKGGweOgMm=E=W8nbxOXAbpeyYsk=5B0g@mail.gmail.com>
Subject: Re: [PATCH anybus v4 1/7] fieldbus_dev: add Fieldbus Device subsystem.
To:     gregkh@linuxfoundation.org
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:

> It depends on what you want to do with this device node.  You can use a
> static one in your structure if you use it to "cast back" to your real
> structure in the open() call, do you do that?

I do...

static int fieldbus_open(struct inode *inode, struct file *filp)
{
        struct fieldbus_dev *fbdev = container_of(inode->i_cdev,
                                                struct fieldbus_dev,
                                                cdev);

> Or use a misc device?  How many of these do you need?

Just one per fieldbus device.
But my main concern is naming in sysfs. A misc device will always show up as
/sys/class/misc/..., right? Given that this is a userspace fieldbus API,
we'd prefer /sys/class/fieldbus_dev/..., and cdev is the only way?

> For an online/offline attribute, no need to poll on it, just do a
> 'kobject change' event for online/offline and all should be fine.  This
> is not a high-frequency event, right?

Grepping... you mean kobject_uevent(KOBJ_CHANGE) ?
THAT mechanism seems to fit much better, thanks !!

> Hey, if no one wants to use it, either no need to write any code at all,
> or you get to decide everything.  Either way, you're in charge!  :)

I did get the impression that people are reluctant to take my patch partly
because of an unproven userspace API. Maybe they are (rightly) worried that,
once in, we will have to support this userspace API for evermore.

I'd love to get others involved in Fieldbus on Linux, but I'm not sure
how.

> But you do need to document the thing, in Documentation/ABI/ to get it
> correct and able to be reviewed.

The documentation is already included in this patch? Should I indicate this
in some standardized fashion?

 create mode 100644 Documentation/ABI/testing/fieldbus-dev-cdev
 create mode 100644 Documentation/ABI/testing/sysfs-class-fieldbus-dev

Thanks :)
Sven
