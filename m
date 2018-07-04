Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C92CC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6256223B5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqVVe3Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6256223B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeGDREe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:04:34 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42024 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGDREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:04:32 -0400
Received: by mail-ua0-f194.google.com with SMTP id x18-v6so3818822uaj.9;
        Wed, 04 Jul 2018 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v1cWStz+u9BUkA3lZMmGnduq900TD/VO3vq7WG3UvRA=;
        b=MqVVe3VltFXSStrOZcXUTgvh5iL+eTwgHjPiaD9VdR6kApNelxSiaD+PlL4j77BY9j
         cHSGtc555sgzxYM54rBFAVTfuHGCvt4KlEKZJHj0nSEQU/T0CBmk4FaowPNt32j0purF
         3nqXfvJiRf+kVKhQILnRZdPRfDWAlEMvfx9MMweR9MZ+AdZR6Z6Q+jskJaBqXb+Wmy6W
         6yikYq93k571JrFQT+C4K2QxAiRdcfk1lkr5jNdxVx3UrVYO+l7il2qM8IXyuF9tqVfj
         p5NRtPW9zoxKbQ9vPuiSmRB5p/vNEn/GfrjIyQVbWOZOYxrTLAmC9lF1OAwyf9hF/AS/
         S7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v1cWStz+u9BUkA3lZMmGnduq900TD/VO3vq7WG3UvRA=;
        b=DR9GZsw1x4eNpkhI9PMXfFPpK/jMOCDYVbfI1faVOsHI4bnn5+BeQWdZG1EhguQ2oU
         95Uuc9AH920zdlKCtH6SYtV1MPtb+L/4DWNN1BnOsApwQvwRcL8I3aVBE9pdhmLT1aZ5
         j7NF3Y8USeFZEQFCYsJFVbL6Og9RRqq+e47pvp05CtrwvM3klAieEElSC71xFEaaTdRN
         xGf7/+APsVhPf/SIfLUWDsFgfpgfdExxMYnuEuFLoeZds2VjXRNHmBEl8eXqzO0dxJfJ
         0LfiyZCmYboKtjkFD2gmA8QlJXz/FjixI7oLmFostFCsO+Z10mw3uLu8T6VYaNLgtPy8
         jMIQ==
X-Gm-Message-State: APt69E0AE2JdcgONfw4zG9Ti0uGUfl9w+ECOIyIUc9mP/ovgCkd4dbTz
        w4sasLqDOXt/wgMAlNOvgwOeT4jDAhhTo7uco2s=
X-Google-Smtp-Source: AAOMgpf4toK2v1nPWLWmf0hkv4qvZrndVEKf8HoLVdlSRUKPp/VDw5w8G8EXDJsnCMqMW4DicO2SUwSu90Kmt4r0OHU=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1668164uae.12.1530723871212;
 Wed, 04 Jul 2018 10:04:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:04:30 -0700 (PDT)
In-Reply-To: <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
References: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net> <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 20:04:30 +0300
Message-ID: <CAHp75VdEUquwcd3_OxbHAK+gOCnpff_Fd91jkHx87XKkD2xwKQ@mail.gmail.com>
Subject: Re: [PATCH] Fix platform data in leds-pca955x.c
To:     Rob Landley <rob@landley.net>
Cc:     clg@kaod.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Jeffery <andrew@aj.id.au>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 8:00 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 4, 2018 at 3:46 AM, Rob Landley <rob@landley.net> wrote:

> For now, you can switch to unified device properties API (basically
> un-ifdef pca955x_pdata_of_init() and replacing of_* by device_* or
> fwnode_* compatible calls) and providing a static table of built-in
> device properties in the platform code in question.
> (see include/linux/property.h, for example users of
> PROPERTY_ENTRY_U*() macros, like arch/arm/mach-pxa/raumfeld.c)

Taking into consideration that device is enumerated by i2c core, which
is being aware of device properties (1), better example might be
drivers/platform/x86/intel_cht_int33fe.c

(1)
commit d3e1b617ae20c459627f501b4bc55b1ea91f662b
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu Feb 2 17:41:28 2017 -0800

   i2c: allow specify device properties in i2c_board_info

-- 
With Best Regards,
Andy Shevchenko
