Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825DEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B38D214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwbUeeVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B38D214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeLFNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:24:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42346 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLFNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:24:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so440463qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzBj3lLeAxxUqLRc9cwUrqSdxH8xzPnO+69yZGS6HTs=;
        b=ZwbUeeVZegdUcSTjVVkFepVxOS2Tn7xCLjeF76h6iQeV6nLcga7WRZHthTTb9C94ht
         dPpuv0fXr0VTXT/xeFSrxW6xvg6Hs1J6pJ4h+4BH89KQXWCkxSyfV8/ultFCoEzv+yvu
         pgta+xtWk46TlFI1h29AK+Uasf6Yc1m5MiZDBbBtlKnFpJDThzjqqms42+uC7YJBy1mz
         YxqCSFJ+2ySznJEkUH5nMlxEQu4ynHjiOUddPqEvV3uXsptfK32w0ftYY7Y01GZJ5Qju
         5LIvXwGqYKGytbNoZL2iU/IobGn9tCCCL+BZzr/VjqCZFVDc0ODoTkANBgGCm1uJN6Bj
         oPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzBj3lLeAxxUqLRc9cwUrqSdxH8xzPnO+69yZGS6HTs=;
        b=T/r0VmMGOhwRhjY5VUmp2D9MdAwtPGxV/AfVxtVF25aXKrs6kJ3VDqQMLy3Piob9gZ
         WB1+4nQxNLmSLEip3QH3m/bwFHjxhVl4qH7iWbQJRY58v1nsU7mWovczd24yL5ZwMYRJ
         VJfRUw4Scx2eZ9E5xWEV/TxM5uIeT6wWCvfuETPxgeRL9vv0sgVMjR9qoCbzp7/QWT23
         HXQn0mvZSwjO0Fa4sxxlt++aFTDFqzHSdC82r2OAyEC/rS5LI9A7n1bKFYWPOdQ945dB
         rDGUGHfwGI2ENxVmPWBPaXtw6nXfV1IYayPgVdEpacZ+Y5cqyUuBc8alhDPog/Lj5qE+
         ReSg==
X-Gm-Message-State: AA+aEWagLbWZvvfxq4UHp4UrpBNZRnV2W8y2YDfw+VhelUHjhJAImMFe
        CeCBG5cP5p91p75oME01YWzDfWK1PcKaHssPElS+4OpkWLQ=
X-Google-Smtp-Source: AFSGD/XCj8C/zeOdmgISp62yj3AZt8IDs9qkkVYWChKq6m6Y8CTmRWtGR2e2ce4YJDZVeSr3gb/8LZEZfuM2ISaY1w0=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr26329686qtj.327.1544102681314;
 Thu, 06 Dec 2018 05:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20181203182141.29720-1-andriy.shevchenko@linux.intel.com> <20181206125842.GA1480@kroah.com>
In-Reply-To: <20181206125842.GA1480@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Dec 2018 15:24:29 +0200
Message-ID: <CAHp75VfgNv1hGB9zwXXkwuaVAqLhj0jo7qwh=0G-VuF1S2gSBQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Respect return code of platform_device_register_full()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:59 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 03, 2018 at 08:21:41PM +0200, Andy Shevchenko wrote:
> > The platform_device_register_full() might return an error pointer. If we
> > instantiate platform device which is optional we may simplify the routine at
> > removal stage by simply calling platform_device_unregister(). For now it
> > requires to check parameter for being an error pointer in each caller.
> >
> > To make users' life easier, check for an error pointer inside driver core.
> >
> > Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > - rebase on top of linux-next since the conflicting patch has been applied there
>
> What conflicting patch?  This now doesn't apply to my tree.

One patch from Heikki had been applied earlier, I rebased and sent v2
at the same day as this one.

>
> Let me fix it up by hand...
>


-- 
With Best Regards,
Andy Shevchenko
