Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC110C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A6421C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideoris.com.au header.i=@ideoris.com.au header.b="PFo07hUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A6421C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideoris.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeHIH1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:27:42 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:39233 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeHIH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:27:41 -0400
Received: by mail-it0-f51.google.com with SMTP id g141-v6so952100ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ideoris.com.au; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=J3hbDS8c829TTZs34XfqVyM81QW2xYC762eApuWxPyw=;
        b=PFo07hUWwnAj/yhhxCclt7iQX2Q1P6L6kwPxwnSd7dZoxCg8V8xAJ/M5yNiij2J0Mg
         ZkyIuDqHVxrpe3FvxHLb/DqeSU5Jd7U9CFLl0bfL9nUrs7ySsoLYCPLc59KZ/G/hGwm7
         l2pIbLr6BwRkupWCROn407gDgaq3nY0FlvBGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J3hbDS8c829TTZs34XfqVyM81QW2xYC762eApuWxPyw=;
        b=NXde4kNv1XgiXkSPUGyMAMOf/az/bROhYy5b/UKhaSMR/RZRU8zQtVhLk+iQeq1hhn
         4qH4IpWAFd1P7KKTlH3tLntqnP0caWKGCfxrkTTRu/w+B+Aw8pi/m13uCs+rA7pdAMMz
         zyCca+HqG7f6P+CRWgqUz5ErsogehlS0nYcz/NhHX503yjlM9LlenspHqOhIvp/0r7wl
         Vm6mrhl8K/v4Dwfvn/7ApdJkuez6UXEpOHRseXb4jf09AYCwAMa/psNuYwOFNHoSLIO6
         0OLM4kMEmN4/uvj+KUJfIpoeqYvt0BM4xYUTHTzG/D1wlpDyxT9X6u2ic0cdRk843w9+
         mKUA==
X-Gm-Message-State: AOUpUlFmczB4YyrvxkJAJncRN68pPb49SFD4d6ycQVKVvslKIGNcJvLp
        KbXoUhH2sRkyJbkgQocy8kGJQsr88yUDmKQO3rRKKwMHBA==
X-Google-Smtp-Source: AA+uWPxnyFxHAiSLAtFeJl8nu3GPRAV+CfG9dh3kKQk3IP485i7InuLyvYRk8JKYh/rVQ6hLfPJvLzHZ6MWNYZRZLLQ=
X-Received: by 2002:a02:5cd3:: with SMTP id w80-v6mr486385jad.85.1533791084156;
 Wed, 08 Aug 2018 22:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1e94:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 22:04:43 -0700 (PDT)
From:   Mohit Gupta <mohit@ideoris.com.au>
Date:   Thu, 9 Aug 2018 15:04:43 +1000
Message-ID: <CAMaKedC_cprruUZ+1S_KVsoe_ZRk6AB6pui_w=BnsnER0Y0uiA@mail.gmail.com>
Subject: ALT+CTRL+F2 - Switch Terminal - agetty process
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to understand how agetty process is called when
ALT+CTRL+F2/ALT+CTRL+F3/.... keys are pressed in CentOS or in any
other linux distro.

What I know so far
- systemd runs agetty.service with next tty[N] number
- agetty then run login process and then other process continues.


What I want to know
---------------------------
When ALT+CTRL+F2 keys are pressed what happens in kernel?

Looking at keyboard.c seems k_cons is called which calls set_console.

static void k_cons(struct vc_data *vc, unsigned char value, char up_flag)
{
   if (up_flag)
    return;

    set_console(value);
}

I am not sure how set_console triggers agetty with tty2/tty3/tty4 as
one of it's parameter.

Any information will be helpful.

Regards
Mohit
