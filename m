Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD71C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7283F222E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IGu5/K7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfBOXP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:15:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35761 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfBOXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:15:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so5504748pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=a/xCWpPO4dz3VeuOc/NfK8EyXiCDOjR5lA+mhjZkfV4=;
        b=IGu5/K7tG7NeesRq1DAVK/bnQcwgiQBlaBY0fH3YdE+0oIUiza42BuiYbMqif4fnbI
         GSlCN+UjV1WUhA56a9u2AKY4IIRy+0A/EhVemyCijnOMSY6AV8C1Ou4PBRXMSUfEWJRK
         Tf2gZzKHrhHo1FdQrdpOXWglZxFM3530pfp+uyCFaKRLYwYod+3RNaGlafmJroJNvnH/
         DOpm9tkPCANp47Km3nZX0XRGdEpWVOo+4FH5s/lSqWI9IINnMn8dmExN+vjqyX+G3uWT
         r2mcp0I9WZpYncPS/SUc0ox6t+4rr395nHu2yKy48oU66p1JA9na+4Nrn1AHmcFzCXbZ
         YR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a/xCWpPO4dz3VeuOc/NfK8EyXiCDOjR5lA+mhjZkfV4=;
        b=hn5bG60xPza5MLy4jGOl7KY6JF9Oc2zr6+kk/mE9ncFFPXCCICXr8wUIiXi5oEa9z/
         rW4NqCWXYKR0rClZPHSyn9Vjgi1BQPIHaNxYtyhgnOSmaqtFuegR9x0lf1XXrZXns7dM
         bdgGVqLsIOCi9l6f5AnmqHpCDxk1M+CpZ7Lowb/XrYmMT8JxvxjK4heiOSg9fxtxDHYv
         upUZI7vT83Kx8OImDrCQusgZRbYA3Qn6RnKxVTaiGSpBThWmGJ4jhok3mcatGvczoIbw
         B0ohmB5E73IFA0ks+sgkRCqHW6eDbKhPx7wpKyvSUjzx1WwR2gtLk3loQRCLQ+5yJuvP
         DMAg==
X-Gm-Message-State: AHQUAubb5mK/sfwND5uZnoGSKoZAiLpqQ0jSBFG/oPDp0Pv1d/y4Cp3I
        uEoZ6Pj5zGR/IM43LkRuUuHqkA==
X-Google-Smtp-Source: AHgI3IZX1O7yQLtX4uzcrYuO7zkypczEXlHzmOIX5x/DBGa0Bkf1VA8/KOLURGHWNzGp83wlrlepRA==
X-Received: by 2002:a65:6210:: with SMTP id d16mr7507604pgv.34.1550272557734;
        Fri, 15 Feb 2019 15:15:57 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:100f:5904:cb2b:8631])
        by smtp.googlemail.com with ESMTPSA id c4sm17086739pfm.151.2019.02.15.15.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 15:15:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Julien Masson <jmasson@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        Julien Masson <jmasson@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: meson_uart: Add support for kernel debugger
In-Reply-To: <86k1ibv74r.fsf@baylibre.com>
References: <86k1ibv74r.fsf@baylibre.com>
Date:   Fri, 15 Feb 2019 15:15:56 -0800
Message-ID: <7htvh4iqxf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Masson <jmasson@baylibre.com> writes:

> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch implement the serial polling hooks for the
> meson_uart to be used for KGDB debugging over serial line.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Looks good, and very useful thanks!

I'm adding this to a testing branch which will get included into the
'integ' branch of my amlogic tree for some broader testing.

Kevin
