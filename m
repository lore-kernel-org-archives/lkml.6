Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D501C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557E42154E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GTWZL//A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557E42154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHOXi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:38:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39277 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:38:59 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so2097716iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li2MODc71VbwVXd3HfPVx637KmA01kipzz5spz/gzT4=;
        b=GTWZL//AGLPGUXNnzBeX+tv64U8IVAgiC4pd9P7JP2M8XXJP6w853ybgx86xxiPp7a
         a+DxaWekU4DOTD1lcNvYA+Xlpdqx+KDkc/Iz4z79vKTbzeAQVsJGdf7Qvwzz+MpDNY+W
         vAYGb1zZkJeXLVfkYhEr+SHBMNa4epUDxUWHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li2MODc71VbwVXd3HfPVx637KmA01kipzz5spz/gzT4=;
        b=C8gO/4EwOJLn4FsBiveas3iI3Evr0XPnMcpNZubDduMCbu454D+dKPANSG2OyulB7n
         1ShQH2ZXhM1wKAgG0uUq/zRldxk1/clwXf1M/vyfZAeb9BTCdwrnl9XaLHtHB35niWzV
         J+hkjgyc4TpiUkokzzp3v8x6WgVMFEy6g8Yb2DS4j6InkjIt+d/u01xHhExmzWl1KRHx
         bYt+etW0JhRIk/SWDU3ZOr1V1PY2GAIiMMEjOB4LYSKkucpeiSTccXVMFdruX18IXrnx
         /vRtjyQEV+hWx0fXZ4bhX2xvG0Wxuma+3AWU8b27gbJlph4p8kluCfxa+BTtdKRrZuPG
         bcEw==
X-Gm-Message-State: AOUpUlEMtHAAnXA4FmDcXC8aNxYuEw7KCKMxtwmz1YltQ0BRF9LKf3HJ
        Hnimsbixl8wfen/NntfxbPv78B+2g7/v1vSdbL8=
X-Google-Smtp-Source: AA+uWPzcWdv0k30LK3g9HvEJieyCLXHay5R575o6vZmsHa9qhIoNgJ+2MJC7HXdW3OreXhrD0WSU4q3r2rpXSzKV3QY=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr10649449ioh.203.1534365913286;
 Wed, 15 Aug 2018 13:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <1534364547-20300-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1534364547-20300-1-git-send-email-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 13:45:02 -0700
Message-ID: <CA+55aFznJ95+Wx+WVdREJ5iEB-2VtaxnGz81EGdXFr7yStywJQ@mail.gmail.com>
Subject: Re: [PATCH] x86: i8259: Add missing include file
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nstange@suse.de, s.gottschall@dd-wrt.com,
        Sven Joachim <svenjoac@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 1:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> I have not seen a patch fly by, so here it is.

Applied.

               Linus
