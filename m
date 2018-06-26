Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8736026E6B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQPV0hdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8736026E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeFZRMY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:12:24 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46593 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeFZRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:12:21 -0400
Received: by mail-vk0-f68.google.com with SMTP id b134-v6so10469634vke.13;
        Tue, 26 Jun 2018 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x4wL6b6YsxX6mdmE2Xy/8a7J3K3VkavEv8eY6FFv8kk=;
        b=uQPV0hdnn/DJo8li1CFX3cg/cQMx0xwV3OblEfvK7T/6g98i0+3bZLxU8jSBZDIRPE
         hemou6aSC/nYKSyl6OxkC4hL4Vjo1mjlZ5Esoc0pcElmHocKoQPDUqwtMkoFcXjaCo8t
         Xsg3MwZMo5dgrKFZ9wtOFyRGYLurb6Uq/VcYu4cOUeDLcBETApt+CqqEYjufikIixq95
         NJyDhQY59XmcStOVdl5qqLR5W2OI5isimDJHdxUgOo9dO2mXf+41u4Kq8eaH6W15Hp9K
         4lK2onNq7cdvva6819LoRx8xj7f/FWFqMHxhJOxZEQsPrmayOpS2HL6/aGQiXhD46lVX
         Pt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x4wL6b6YsxX6mdmE2Xy/8a7J3K3VkavEv8eY6FFv8kk=;
        b=EIs7pAhksQ489PIOwmREYyVFThBywJkUyqMA/nxCJa70yYeYWGQvx/tgH4dV6cSsqX
         MxTgeW3s48yLAJwPSK4b411NjVzbIJiT/lCrK07nvOpYNvJC6/PzRynwA4WQV/Rb4u1/
         H8MetCsT7H0T/xNmASvPFO5w6re/Nkzml0Nrv7t2Mqy2cxXZfwzeqhfMET7/Wop3pgWv
         R0PN7ZMv47YdueZRF1gT1nxfm58J7ue7eCKoTIUwTa66DVbX+/a3IAKWB6G6Y/QCPXOl
         crOCv2NH9/U11YhKAsgKAmqmJcoLcLZZY0eZqCtm/flIbQkmTweaf8zWEoULbSZ68rIp
         lDrw==
X-Gm-Message-State: APt69E2ywpJLqFE8byVIgXHLyuCD1YMY9NkCY70JqBMpeq2wd3mwHYJD
        3jDWwtuCn/uvUzV3HGpCJnmVJW/88rBGGeINCVk=
X-Google-Smtp-Source: AAOMgpfw6yNrUwmgaBW+t4+xzLq5YkFf7IL8xp6wgnCbqLFZMF9C5difwbLKmBZZBKpSxh4ECTsLvcSrgB5Gjba6/oI=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr1513030vkd.15.1530033141099;
 Tue, 26 Jun 2018 10:12:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:12:20
 -0700 (PDT)
In-Reply-To: <20180626135535.2990-4-hdegoede@redhat.com>
References: <20180626135535.2990-1-hdegoede@redhat.com> <20180626135535.2990-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:12:20 +0300
Message-ID: <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Currently fbcon claims fbdevs as soon as they are registered and takes over
> the console as soon as the first fbdev gets registered.
>
> This behavior is undesirable in cases where a smooth graphical bootup is
> desired, in such cases we typically want the contents of the framebuffer
> (typically a vendor logo) to stay in place as is.
>
> The current solution for this problem (on embedded systems) is to not
> enable fbcon.
>
> This commit adds a new FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER config option,
> which when enabled defers fbcon taking over the console from the dummy
> console until the first text is displayed on the console. Together with the
> "quiet" kernel commandline option, this allows fbcon to still be used
> together with a smooth graphical bootup, having it take over the console as
> soon as e.g. an error message is logged.

> +       for (i = 0; i < FB_MAX; i++) {
> +               if (registered_fb[i])
> +                       fbcon_fb_registered(registered_fb[i]);
> +       }

Simple git grep shows that we perhaps do

#define for_each_registered_fbcon(i) ...

(As an example see for_each_pci_bridge() how it's done there)

-- 
With Best Regards,
Andy Shevchenko
