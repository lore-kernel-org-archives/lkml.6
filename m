Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CCC3DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832B7208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEW1+8sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832B7208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965462AbeFNOm2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:42:28 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36594 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965416AbeFNOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:42:24 -0400
Received: by mail-io0-f196.google.com with SMTP id k3-v6so7379506iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V9FtkrQCk6DsqxRpmYpZXOTvYr/ZRCKRIlyz4VVO7ro=;
        b=HEW1+8slA1r898RY3g+KLOyka5LcmpNVR3L+8+azsI+ohL71Ui6fjO8ZI2h458l+qn
         J7ItPatiavQh65NqPBa4spRX/cTdMMxq6wjadLnSxhz9mR780wU7i3gC+QhagMP5EUrs
         zur9evIzhII2XXWnsFCA56rbu2f+tWljFrfII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V9FtkrQCk6DsqxRpmYpZXOTvYr/ZRCKRIlyz4VVO7ro=;
        b=rW2C/rq8UTkyRFwH1YUiSyXQKOLGGmWg3uFJQlyNnWqy0BdkCqZ8WVppTql0XVI7vD
         ITGVdEPUrqZ1XAEml6IgNkziRinL+BP04XyiEO6DNsiafMK7VgjLkE1StGJxrYttkcVm
         jt+53gFiDlq69NeAKvTZRmDLGcL0Fg7UycVpJPZ8IVLMq9SQvjQx1QbJRck7sE+PDTPL
         hTKG2RRMHjxC4/9O30NuaqlMbNNWRECOxOScat4Rqv5pOt/qRXdf3lCb9sEoY6UtBZpu
         dhYBQ8XnCfuoTYczBXLxvbgJnAXt/2zXdY3D7/U7vAq92cMt4Ol9xMKDsBUGVFD7ePN5
         wPOw==
X-Gm-Message-State: APt69E1pYx7BDsgchnjRnh4CPxYazrrq8KbUdOQFlZkpg9zyZwmVSMoI
        UHlom/OU4sBA5pgamVI3vZdZqePbBbyNS0bLazRrrg==
X-Google-Smtp-Source: ADUXVKJD7QA/rmpOhcHhmtayKmrotmLRiV1TzoAhBRAHqZLpfgKopKBg+5Dn73GKz3itJJ5+q4+8epaR7ect+dpdFbk=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr2522312ioz.304.1528987344109;
 Thu, 14 Jun 2018 07:42:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:42:23
 -0700 (PDT)
In-Reply-To: <20180606174424.9630-1-rafael.tinoco@linaro.org>
References: <20180606174424.9630-1-rafael.tinoco@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:42:23 +0200
Message-ID: <CACRpkdZ82RNta7LGp4OB=6TY_q3mdqGGDedayz-C4hB9m7WG9Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: gpio-mockup-chardev GPIOHANDLE_REQUEST_OUTPUT
 fix
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>, shuah@kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 7:44 PM, Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:

> Following logic from commit: 22f6592b23, GPIOHANDLE_REQUEST_OUTPUT
> should handle errors same way as GPIOHANDLE_REQUEST_INPUT does, or else
> the following error occurs:
>
> gpio-mockup-chardev: gpio<gpiochip1> line<0> test flag<0x2> value<0>: No
> such file or directory
>
> despite the real result of gpio_pin_test(), gpio_debugfs_get() and
> gpiotools_request_linehandle() functions.
>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Bartosz, does this look OK to you?

Yours,
Linus Walleij
