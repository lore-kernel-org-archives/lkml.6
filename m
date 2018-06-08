Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wWW/KnU1Glt+LAAAmS7hNA
	; Fri, 08 Jun 2018 07:55:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 01838607DC; Fri,  8 Jun 2018 07:55:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyK13+QJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A66B606FA;
	Fri,  8 Jun 2018 07:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A66B606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeFHHzC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:55:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35399 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeFHHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:55:00 -0400
Received: by mail-io0-f193.google.com with SMTP id u4-v6so14917732iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=02YJLiTn1K93elUCyc2Dx+YeI9TZ30xum1zNOs3yZq0=;
        b=YyK13+QJ03hnFFlfEr3HHLfE7uI8p5doYtof5twWvGY6gtI58H0PIsYBFlsVfypep8
         M/S9U9uIzRXlvg3CHGEN7qanFvAqUQn2axvMPXS1qQhs2MzrvK5WhZGdFnUjK4zIaAhh
         VOpIL7Eztyj9A5vZxovCeY3VMLPH9jR2Wdp3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=02YJLiTn1K93elUCyc2Dx+YeI9TZ30xum1zNOs3yZq0=;
        b=DliHQLi5G6eSja7HmGdgMjg311dJQunI6g317SCtCii25iG8cbEMagAueJMFENMqF9
         Q10E7VcSrCKNb09a0MnPHUDVug0cvUEPlVbeg7i5Xwl7PhVSE+OSe7Ebn2nZyy7sIZ4f
         wWCdi5Jf8NS2dGuKrdDxM+hBHiyrPqZzOdjUxh3WQMzrgwv4cOq8lfPgEXj43izM+ajW
         /cu1aAebzUQ8P5zmcLzXIWkbZ7fDo4/ajTIk2P0ZVRC9GsO0He7/bcHpff5uMqfMQroN
         TvJAYbvnAss1JC5mv+X1o/LO0YuzNxx4c4rjOM6xWjOuQhFtpo7CP2K1vQYlDA4BoAlS
         0xUg==
X-Gm-Message-State: APt69E2CFZoUP65EBSK/TqucIu6B8iQHQ/CJb6/FRuks4y93ygrOTXTB
        UvMI4OimC+7PY1q4YisSojGJNRjk8RitSszo12b1dg==
X-Google-Smtp-Source: ADUXVKIFaTipapPuoS8cmRT8LJDhhro8i8nGEycG9skhaWPngqEISWkrY75Xa0NcXefiOTbq2PHRTcEgGNlAYTm4U6w=
X-Received: by 2002:a6b:8b91:: with SMTP id n139-v6mr4247996iod.109.1528444500095;
 Fri, 08 Jun 2018 00:55:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:54:58 -0700 (PDT)
In-Reply-To: <1527737273-8387-2-git-send-email-djw@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn> <1527737273-8387-2-git-send-email-djw@t-chip.com.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Jun 2018 09:54:58 +0200
Message-ID: <CACRpkdbye3-6WyuXW8AqttFLEKUK244xk0aNWSi_gsRhRzDrVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] gpio: syscon: allow fetching syscon from parent node
To: Levin Du <djw@t-chip.com.cn>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 5:27 AM,  <djw@t-chip.com.cn> wrote:

> From: Heiko Stuebner <heiko@sntech.de>
>
> Syscon nodes can be a simple-mfd and the syscon-users then be declared
> as children of this node. That way the parent-child structure can be
> better represented for devices that are fully embedded in the syscon.
>
> Therefore allow getting the syscon from the parent if neither
> a special compatible nor a gpio,syscon-dev property is defined.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

This patch has been sent upstream for v4.18.

Yours,
Linus Walleij
