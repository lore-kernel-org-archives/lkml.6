Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B6BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBA6214D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uta+hugU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBA6214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeGGQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:24:50 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45349 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeGGQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:24:48 -0400
Received: by mail-ua0-f194.google.com with SMTP id z4-v6so9359953uao.12;
        Sat, 07 Jul 2018 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SWdZ6KZct2xKS4eTeFSMkG+RGyRjk8bSCYjM9TBk2+I=;
        b=uta+hugU8Wj6IuPxXOviLFMLD2cuuD6MGxuAhrOtdOphdvvOrFZKJdf0v5vLQ8SIt5
         Wt91Q0mMfTr8ZAwIh9jJhb0RrrdN7LrGVA3zDRhIfaNLGgJPDy4wVpmNDtWAJJITYPq+
         2m2EWHFzeUYinwMfdsEJK5KyS1IsaAEiFyW0cYpiCH+q9PdDBR5EEq06m4Ez5qwi2ebF
         mZqY+AiIXsUREp20HxGrrdQCqR4s08twpx7wd7svrmVy8UQq7V7maZ18XKmxiRqwCKjA
         5eYFusu0H7+GVtlNblsbeT5yvUfrL6JVEJ6+jIwMGajEdVB0pyZP8LvxmS2D8g18Wy9W
         jPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SWdZ6KZct2xKS4eTeFSMkG+RGyRjk8bSCYjM9TBk2+I=;
        b=LJ6PjZMg9yzZa8OIZhCtcpSyGJkaujrXGYLEnBbM4xldQQNGZgK5MmRTqhgXias43V
         RZBoB2S/CCUMSyeuuMKbvjlcwBZRJcnMOjKpEfI/qyXwGbLYjpu7STy7e7J/QWRxSpA1
         XnPQu6yMZ5WbWsCX+vcWdn7up3l+qpa3lX+ju34OLBi35drK/ZurDvuSRt2sOgvHaJTb
         RjV4kDh7zyKECcMLdn9NZDsFSWFIj3efG+KFYKhcCJJ9P9gYs1tEy3YKGD/PtyIfnJaq
         TxEPy93TAzqolRU3F7KGcRdBXLywvn46JdPAcfb92eFvmdYvpIxk5OxUf0LX4NzDQyQf
         sqyw==
X-Gm-Message-State: APt69E2cL8A7JXMDnxBAhWaZVogkJiLAtC6ccFzyhrA7Gy6wCVIxDNyt
        4oQSNZZOHt97Xsoe80JPl6YsphfKjsaqrSAWkE4=
X-Google-Smtp-Source: AAOMgpfJ2mJjxAsoTki1uw4I2tpexq9WGWIP4b3c1lTPtyXuXElSxlVAgJ8j2a599RsRTmcX8OsuxJdHsCUe9xNnyzU=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr9006759uai.122.1530980685349;
 Sat, 07 Jul 2018 09:24:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 09:24:44 -0700 (PDT)
In-Reply-To: <1530935335264.5774@Dell.com>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
 <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
 <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
 <20180706235907.GE3041@fury> <1530935335264.5774@Dell.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Jul 2018 19:24:44 +0300
Message-ID: <CAHp75VeW9y2z2N7bzwY-kztLvgJYmHECHRF1q5Mr8ude8LOMUQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 6:48 AM,  <Mario.Limonciello@dell.com> wrote:
>>I strongly advocate for vendors to have more control over their drivers,
>>but this scenario really frustrates me. I don't think I can justify this
>>to Linus as a fix. But before we just say "no" (because hey, I want
>>these fixes available as early as possible too), let's ask Rafael if he
>>has an opinion or if there is precedent for this in his experience with
>>ACPI drivers in general:
>
> Full disclosure - an updated FW has since been rolled out that reverted this
> behavior back to previous FW behavior due to lack of Linux support for the
> new _DSM.  There is desire to use the new interface (as it did fix actual
> problems with the old one) so at some point it may return.  When that happens
> it would be ideal that people who are (for example) running an LTS kernel
> or distro kernel that tracks stable can pick it up too.

I am all for the better user experience and bugs especially in FW
should be fixed, but I think to support all kind of behaviour the new
FW release should always provide a knob by which we can check if some
feature is supported or not.

Above sounds to me as mistake in design of the fix.

-- 
With Best Regards,
Andy Shevchenko
