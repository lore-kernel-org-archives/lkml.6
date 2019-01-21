Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3347C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B556D2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9XdJv9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAUO1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:27:12 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37044 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfAUO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:27:11 -0500
Received: by mail-lj1-f176.google.com with SMTP id t18-v6so17706604ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l4d3MI03wm+L1QqCOyUl6n7esdnkzB2Sz3Unosk9F0=;
        b=N9XdJv9ueixP61EMkaraeKhOJQyYOMiafzlisTsk4e+ga4zFroy1beuu5Mu5tbuBFn
         UML+IaXrwT5sLKi6aX0KPRM3pUiV3ahD7pUxbbFAi278n2KAkpgaOk2/Nj7ujotcQKaH
         e2m17C/a5k2Yzxz+1CznbamdbXdCGmTUgV4AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l4d3MI03wm+L1QqCOyUl6n7esdnkzB2Sz3Unosk9F0=;
        b=eUdohx+N2qFD45iZxMSzgC42WdUWzwdBG+eQG9TnTaI1XAUtwbpWGr0YPygmzM/Pw5
         asA5tBh6jzrQqeTy3+jfn9UJ/FP9UKOrLmJ5Sah4foZZrR8iKqwhHt6U0Zrk7FXLNVO4
         QSLkYfcbNlerPTLUAUjHI4UmopE1jKbFuhO2PjPfQBCptl3x+eg8prT+fKNFR1ZbUR4h
         5K04DxsGnDQN5SqVGQ8YV8o9e8MWQZH1N6Cqn0pFwWR0yKhfU/MAtaZZ2H4BCsyhALw8
         ySeRns/Fh5ZKCxZaVBtQ93Atxk9jda+B4P1uUZ3s2BF7pbfH5VRdKGuUirfyN5ZpwNZm
         8SkQ==
X-Gm-Message-State: AJcUuke8cf5WQSkT45AhKPx12EZT8HHm8oCfSxuCWDOwOg75DbT1DQQP
        r+MehbTA//bCT3lVRMfxOQ8UW2iTjaaJK472TJxpbiGzMdA=
X-Google-Smtp-Source: ALg8bN6xq1VYPdVWzl/UOtnPn/iZdLVPUsV0RKnDmPm4YheO0BDwPEbxWcVlHmaLsS09EkVCo2UpbRsHwY0VF6WPyvc=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr17933228ljp.12.1548080829336;
 Mon, 21 Jan 2019 06:27:09 -0800 (PST)
MIME-Version: 1.0
References: <94b9acab-a739-a014-b068-768f40de38ec@linux.intel.com>
In-Reply-To: <94b9acab-a739-a014-b068-768f40de38ec@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 15:26:57 +0100
Message-ID: <CACRpkdYPBf6sYzbk1W-znYxaaaGvvO=tT_rXt7SXBwDRa6fJ1w@mail.gmail.com>
Subject: Re: pinctrl: -EAGAIN not supported but documented
To:     Ramon Fried <ramon.fried@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 2:28 PM Ramon Fried <ramon.fried@linux.intel.com> wrote:

> Stated in Documentation/driver-api/pinctl.rst:
>
> Since some controllers have special logic for handling entire groups of pins
> they can exploit the special whole-group pin control function. The
> pin_config_group_set() callback is allowed to return the error code -EAGAIN,
> for groups it does not want to handle, or if it just wants to do some
> group-level handling and then fall through to iterate over all pins, in
> which
> case each individual pin will be treated by separate pin_config_set()
> calls as
> well.
>
> ----
>
> This is not supported, and there's no code for handling it.
>
> Should we add the necessary code or just remove the wrong documentation.

The idea was removed in:
commit ad42fc6c84795d19972e7f7dee70fe74bec4c2d8
"pinctrl: rip out the direct pinconf API"

I think we should just remove the documentation.

Do you want me to look into it or do you want to send a patch?

Yours,
Linus Walleij
