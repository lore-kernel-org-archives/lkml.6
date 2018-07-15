Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A759ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 17:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E1D2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 17:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9nOqHIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E1D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeGOSB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 14:01:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40771 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeGOSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 14:01:56 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so13434251ywg.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B7r56mqz65Lx9ox8IXJSsHT25+tRbDr5vkcMVpTKgd4=;
        b=Y9nOqHIh5DPreThpOHoJfmi3/+qRjwHhl3a6vQ0CmOYuuzjJNBvXpsvvFdAbDDUi83
         3acAaJpI5dNBn4wwgN9geGBZ1sD3ZSz0rXQ/rMxS2sZHvmNltuuNKdZyvr2Z/t5oH+2a
         KX74yYu7y/RRAizpjZArDeC8Ex772iSU6Z3Wr6IohKV7dPpUjn5CRMrsxar3i1hPMinv
         aa4ycrQ+Ab8BynfzqpJ7ficgJTG42HTN3YA2u3MGyd2UI3HX2k3fQHu5cxkSm1ZRNQsX
         8zqqt+zpZj4a8GRy+OLuPhGbCdcgLF7KKIsytArIhhZKLLSaIoVRPKfLi6XBdSdJ4yk1
         sR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B7r56mqz65Lx9ox8IXJSsHT25+tRbDr5vkcMVpTKgd4=;
        b=YC9uPg1s/h6VtKU2OB9yT4O7+d0oW22L1Gmlr0fAS+2cTfQl6ZG7h9391mjQ+hE0oV
         6wcwHwC4Wz2GxOCEy4ICVNsi2Js6WXkYkulq0Uhhtxgs/+mSYo+dh5w3gEUati0BSCL6
         6L2g4i16sThV343IgyaCQCGQTuuYBIQ2sxmSQZoXELKwAfHG4b7AQNlHjUcJAXn4Dy1i
         RqBvfKo8Eu0mHiLK5EYFRpBhivFl9ubSyV1OwW+qGBl8a8fA4QsBdx+zMlEMKq9ByGhE
         Rxu9B5FOhfyXKAvPW/VB6IdyUj6Dzjs06jsSs2D60zVrCQUVDc2/iW+EXdQTtyRV1HJ3
         unkg==
X-Gm-Message-State: AOUpUlHKx6hAbGDle5mEoVP3utavZ8IqzCTzIXoAcIHAJh7yxMm3FHdu
        syG3CxdqliVbGwIO/sIUUO/E2loRiil1N3dJVuw=
X-Google-Smtp-Source: AAOMgpcYJ89R17M6e7ceOGfS2MjwS0d1hK03UqIKDBlswSvfRC56UDlyS1xvNXbCv04TOlWjr9tOXMvOc2m6vlC69F4=
X-Received: by 2002:a81:b662:: with SMTP id h34-v6mr6643643ywk.262.1531676297882;
 Sun, 15 Jul 2018 10:38:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 10:38:17
 -0700 (PDT)
In-Reply-To: <20180715090055.GB23333@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-13-toddpoynor@gmail.com>
 <20180714063502.GF20451@kroah.com> <CAO3upobyf9JpKLSoSPeVfNGOh6R0cud=hT+bhA=U2kNkGEJ-aw@mail.gmail.com>
 <20180714074450.GA22469@kroah.com> <CAO3upoYSywZWQCnhYijzEeNdr+ONXxcX3kJVv6nKUeqqe52ujQ@mail.gmail.com>
 <20180715090055.GB23333@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Sun, 15 Jul 2018 10:38:17 -0700
Message-ID: <CAO3upoa1BsVjAu9BOTHa6a3O=FG7xqjXHUjc6BMDN0fp2mZ5vg@mail.gmail.com>
Subject: Re: [PATCH 12/18] staging: gasket: annotate ioctl arg with __user
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes you're right, I see the entry now.

Thanks -- Todd

On Sun, Jul 15, 2018 at 2:00 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Jul 14, 2018 at 12:20:51PM -0700, Todd Poynor wrote:
>> >> I think I'm following http://www.kroah.com/log/linux/linux-staging-update.html,
>> >> but if I'm off in the weeds do clue me in, thanks.
>> >
>> > That's something I wrote 9 years ago :)
>>
>> Still the top search result for how to work in staging, suggest an update. :)
>
> Do all subsystems have such descriptions?  No, working in staging is no
> different from working in any other kernel subsystem.  If you want to
> find the location of the latest code, look in the MAINTAINERS file for
> the git tree.
>
> There's nothing "special" about drivers/staging, except the quality of
> the code...
>
> greg k-h



-- 
Todd
