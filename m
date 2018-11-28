Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6B2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEBF2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBL+dR0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEBF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeK2Cl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:41:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37554 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2Cl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:41:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so23899956oth.4;
        Wed, 28 Nov 2018 07:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=550FDsaVFHWAgUfQ7T9Iyvm0Wnrve/q00wxmvCndFSs=;
        b=lBL+dR0+4laf5f7EckiilPHSwUQzzUlj397z8JWDVmKiZshP/Zo1eukrU2cDxIcZ/m
         Mb2WXyrVwPfW+Kzx7cqKrHKG7J075RUc8+G2hqDk9lCThiErc2RHj8yRsAqdvcJidoBC
         m8sr+RRR9luGsCHx+9QzwK3vhPm5urjo+NwWrG0Yi9Dl3QNZASlz3nhe2xaQPYwpxoRc
         Ij/QncyWXyRY5kPViGIBvxIvkDT++SNBAcA09Pwv9WesQBo4Hp8NsK8+w2jQzl4sKolO
         Dfpe3TjoaRg2IV4+Y/idPx0+RBu0fpStdjHXL0QKb5zQ1ynJmRGL/IEyD8d72rRR0gqE
         W4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=550FDsaVFHWAgUfQ7T9Iyvm0Wnrve/q00wxmvCndFSs=;
        b=a1qCxL1L4ja/rtj8L0c9KEI+98SfUsXQEb7wMxin0Hk9K6vWQlVuCCIQ89Q2q6HUVB
         K5/OAjgrJJ26kUmGkV3j4sWywOQ1Mg7szM7Ij3WrEd5n+513xvYQQqV7VXJ5RbM6AVry
         c20dH3OkCqBhtAWv2O/RlBWwM0F2f6p6GancQ0HFK56b/JtP+5YCFLJ9Kn0LgBayba2+
         oaDjTbHcqOz1A4tnWUtenfzIxC1y/RN/IFh69xoeMOvcVphyBKI7M4doicdsgooomB9Z
         cpjSr2Irc9af4fOKXafpf1y5ko5ErgzKyGR+MfS6esvIiLrIg2HBTkYREx9rzcN6EMuu
         Pt5Q==
X-Gm-Message-State: AA+aEWYEJBZ5MfgIaYmq6TL/n9D296/343K+sCU69tUsBygOkhc/ZCLC
        zHkgoPk8hheWluWt4xeGOv/NhOkKTBK1GaO8PhQ=
X-Google-Smtp-Source: AFSGD/WVMU5fO/u4fBZ4E6kfcfIEtyz3ofy3rcG4BIy9BcNW5JpIobGg6ExW4c53ZQxFhXCOiqP9vNs6uPv3olp+eAA=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr22775271otp.225.1543419592340;
 Wed, 28 Nov 2018 07:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-2-TheSven73@googlemail.com> <20181127075431.GG13965@kroah.com>
In-Reply-To: <20181127075431.GG13965@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 28 Nov 2018 10:39:41 -0500
Message-ID: <CAGngYiUL7bZVEehj4LGC2H+kv+Z4v_s=tG4uosOp1-Rc4_pGWw@mail.gmail.com>
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

Wow Greg, thanks for the review, this is awesome !!

On Tue, Nov 27, 2018 at 2:54 AM Greg KH <gregkh@linuxfoundation.org> wrote:

>> +     cdev_init(&fb->cdev, &fieldbus_fops);
>> +     err = cdev_add(&fb->cdev, devno, 1);
>> +     if (err) {
>> +             pr_err("fieldbus_dev%d unable to add device %d:%d\n",
>> +                     fb->id, MAJOR(fieldbus_devt), fb->id);
>> +             goto err_cdev;
>> +     }
>
> Why do you have a static cdev?

The proposed fieldbus API needs a single /dev/fieldbus_devX node for every
device. I just looked around the drivers/ tree to see how others accomplish
this.

Is there a better way?

>> +     fb->online_sd = sysfs_get_dirent(fb->dev->kobj.sd, "online");
>
> Ick, what?  Why?  Why are you messing around with a raw sysfs attribute?

The proposed fieldbus API has a sysfs attribute that can be poll/select'ed on.
Is this behaviour still allowed / ok?
If so, you're saying that I should not store the raw attribute, but just do:
sysfs_notify(&fb->dev->kobj, NULL, "online") ?

Now that I (hopefully) have a few seconds of your attention...
I suppose the fieldbus API in this patch can't go anywhere, without buy-in from
multiple people who also want to use fieldbus. Right now, there are none.

This might be a chicken-and-egg problem. Perhaps here are no fieldbus
devices because
there's no good general API. There's no good general API because there are no
fieldbus devices yet.

 Is there a tried and tested way to break this deadlock?
