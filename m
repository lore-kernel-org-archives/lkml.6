Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668BCC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1F20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFVrgmW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A1F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeFSXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:43:20 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36753 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeFSXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:43:17 -0400
Received: by mail-vk0-f66.google.com with SMTP id o138-v6so890582vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vPLiMWFskOauyh1u+ggoUJjvjjW/WcJwF2+kWpwiAng=;
        b=fFVrgmW/lQwxcDacYqgqLAoNSm5R/s1ctXBeLuO4Cvff9UQfbyRxl0iEl6ybBMlmZc
         U3NWtyMbs9Y81aA+5aFr07tL3Ppd7tXVU2f7UEwIPy6b2WcVYOR130XH4NOL0tCoUR+x
         umpZ/hbQTEbB13sq4T3XL4/lgAQUPIc3bWHje7l8SW8728ka++4RpNQdRi1GjoY5TGXO
         BvBTDcA9GfMuWiTfz4PWfH8MJcVR8U9KfelMN9jIwbthGJewWrCl8WBXRgkBi3dt2+wo
         xvyzJR+0mxvIDF5FCLpdY3E/eBsStj7GwIeZYZgftcEBdRt/kBjeyF7wJ4tWXwf37GZo
         xw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vPLiMWFskOauyh1u+ggoUJjvjjW/WcJwF2+kWpwiAng=;
        b=Xs9cE6oW0aWmubZ7rMZlR4tQmNZM30aij8hW4wK3/fz5VUmzZay75RVkhxPUuNZ392
         AqH/AGauyjAc24uu6hMV7Gi5yZHa9qcE1uyclgLHPV5seF00dfw2x0KbW3HQsJ6nxCVY
         CpD+cSLyGcWyVUlwIPCoIhYc21iPZ0BHfZUOFsaNTzxSFbZ212/BqaLD+c2RJy+hJjMq
         OeuQ7d9X3Ha44toaWVw6enYJyhGN3CMtH7Lwee+C1Y5At1wa+1boz5ZcGrkAi9G72OkN
         We2azEhEKDituxccqlPJ5TlaNiuYEroEvlcFgRLnxb9RTitKHL2P66n91mPRxbOVKNuy
         ToyA==
X-Gm-Message-State: APt69E17PJoZAErpTMIFMybvI5onhJ51BHQmt5Gu0M/XXGgW/Rs75aV7
        wpXADjXAN2mdv9F74Ei3RUixR+6lCSydl5eIqgs=
X-Google-Smtp-Source: ADUXVKIhOop6Q9LWsQdUeW+Xdmsjey+hj45NnTymgpyOGEKkVy/IzJQ2YdvEIeQQHAM32Kaf0HWsNpmST+eUFimtAe8=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr11086599vke.176.1529451796347;
 Tue, 19 Jun 2018 16:43:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 16:43:14
 -0700 (PDT)
In-Reply-To: <20180619225145.GA23389@kroah.com>
References: <20180619205914.21375-1-javierm@redhat.com> <20180619225145.GA23389@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jun 2018 02:43:14 +0300
Message-ID: <CAHp75VcOd5K+T6bkxyz3qgqNr4-=K9GGRh+DQ_qgW7dGKdzO5A@mail.gmail.com>
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 1:51 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jun 19, 2018 at 10:59:14PM +0200, Javier Martinez Canillas wrote:
>> For debugging purposes it may be useful to know what are the devices whose
>> probe function was deferred. Add a debugfs entry showing that information.
>>
>>   $ cat /sys/kernel/debug/deferred_devices
>>   48070000.i2c:twl@48:bci
>>   musb-hdrc.0.auto
>>   omapdrm.0


> And what is the use of this file?  What can you do with this
> information?  Who is going to use it?  Don't we have other deferred
> probe debugging somewhere else?

Indeed.

Javier, have you tried to add 'initcall_debug' to a kernel command
line followed by 'dyndbg="file drivers/base/dd.c +p"'?

-- 
With Best Regards,
Andy Shevchenko
