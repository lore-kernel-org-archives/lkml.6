Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00480C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD96A2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUTkDr6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD96A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbeFRXNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:13:55 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43465 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755408AbeFRXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:13:54 -0400
Received: by mail-vk0-f68.google.com with SMTP id d74-v6so10592092vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuqKmbScvrJ0GfyWHtzlE8vGIg4yoSd0Y7Bv6tYkIaY=;
        b=bUTkDr6wAf2KCvQe6cD5qgiNCuKmGYB6lvwt4sDMUmdjSTX7ktOt14iW7dwn/pqrjG
         8aeEYMH+eVkF1CgWfzDBjjbvqbUBqqbuKJdF8156DE6I+HmYE4tqmbz1mkdYHLuIt5T7
         X+qdLpv4r3gCQ7Dt59ID+OFFEYxZ4MWJyrcz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuqKmbScvrJ0GfyWHtzlE8vGIg4yoSd0Y7Bv6tYkIaY=;
        b=EIgqhwPmEwdUniz0G9cvSxMBJ1U1pozDxlHh9dkJLtLqGrEJCrVBAKtrV/5AykVDrd
         N3bPXffoEywHrBsfontKj3mVHkxqJyVxZW8cplZxqv8TFrw6xL2rK5fca+enYmXgQxPj
         xXfCkMKTUz03mhhOkQn3+ufD3ySAefW3PZ4h/2jNaP5md8+NIwvt+2/YuN74HgRStWdo
         J4bUS3urjyqGnk/Ihcx/vVNfIlXvoydPAEREbDqiVJjjYaLGN9Je2ZIahVKfkaLfEs09
         1F0dSO9mUZVL95Soj0YUyKOAqsCv3fAGkM8yJ7aCnPUXyxNMvKhG87xw0qy6W+2qKyj0
         jV7g==
X-Gm-Message-State: APt69E3QtNH8uMYqkHzg+yMxT6TI0YrKd2PB8r/4pv4t9c+9jFvr/JnI
        abepMY8qEGWCWbqjYVCVq6g6r8ZVOif2jVMeGsVVCg==
X-Google-Smtp-Source: ADUXVKKK0vlyp4zboggAKyhG83MwATWdhPvyFcZOCcZrODAinb6jdFj/M53jP0kW4kCcl6bBjUmRsp3omySGdLOdNX4=
X-Received: by 2002:a1f:18d4:: with SMTP id 203-v6mr8127836vky.139.1529363633507;
 Mon, 18 Jun 2018 16:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180618225540.GD14131@decadent.org.uk>
In-Reply-To: <20180618225540.GD14131@decadent.org.uk>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 18 Jun 2018 16:13:39 -0700
Message-ID: <CAODwPW92-7NBjpyxq1v-8v7H=JFDvrrh=i_bW+BfMjsfgm-ErQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: Update Kconfig help text for Google firmware
To:     ben@decadent.org.uk
Cc:     Julius Werner <jwerner@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, pm.debian@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

Reviewed-by: Julius Werner <jwerner@chromium.org>
On Mon, Jun 18, 2018 at 3:55 PM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> The help text for GOOGLE_FIRMWARE states that it should only be
> enabled when building a kernel for Google's own servers.  However,
> many of the drivers dependent on it are also useful on Chromebooks or
> on any platform using coreboot.
>
> Update the help text to reflect this double duty.
>
> Fixes: d384d6f43d1e ("firmware: google memconsole: Add coreboot support")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> v2: Mention coreboot, and don't touch GSMI help text
>
>  drivers/firmware/google/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index f16b381a569c..ca049ecf5cfd 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -2,9 +2,9 @@ menuconfig GOOGLE_FIRMWARE
>         bool "Google Firmware Drivers"
>         default n
>         help
> -         These firmware drivers are used by Google's servers.  They are
> -         only useful if you are working directly on one of their
> -         proprietary servers.  If in doubt, say "N".
> +         These firmware drivers are used by Google servers,
> +         Chromebooks and other devices using coreboot firmware.
> +         If in doubt, say "N".
>
>  if GOOGLE_FIRMWARE
>
