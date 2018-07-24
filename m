Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3377C20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUOVOQWV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sTLlM4I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3377C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbeGXSJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:09:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36889 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbeGXSJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:09:24 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so4835057qtl.4;
        Tue, 24 Jul 2018 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MKfAIw3yQbP7cyBV9BvWXN6wLtKZ0EwjNpYu7wLR6Ww=;
        b=tUOVOQWVfkv3QekSUftTdmwSH2Xqke0lD9+CNZdtRYTd5fclGv0JyWJZXn+/xgVBGt
         LkTkyzcCbK8AsUQOnpgy4G99oZKInjK9fHuN2Z10mDiQBqVKtZgMAyONYC2V+bxArzG4
         8cC8Tyf9UKXaz9iqlulGr8jQ+r2KgrKkV7nzMt/SYFY2repWQ2xAumqAyIwm4/f946Ks
         LBKe72r3dw8CsyGziY3lN4ckjptDcB7Ny6dhd3mC/x6ZLMmvV10+IzoG0qHnW0qUvyqc
         YZyQL8zxN8PVC46PBwuxWrCM2iMPlSUoGKJ4w7eMhEK+GcIiyf/fXI2Tb17HAoGk+/2J
         HSiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MKfAIw3yQbP7cyBV9BvWXN6wLtKZ0EwjNpYu7wLR6Ww=;
        b=sTLlM4I8ab1VkHXkc/cjNHaBOU3h4BeFQqAh5q4DBJcxNRe4wXNfXi0a+O5DT8f6oO
         EMmhI2MkRU5HQ0nSfCJUqTFopGiYORpptRPN6kD6KDOcCKtGgu3BDlfqSO4vjsQA/gbJ
         vfYSKeO33kpehFePKV+s0k2gfEZE4sgI72OhDMcS9k+WLqMIsxo8x9it6pCH5T37ih+4
         vgYFYvNI8czhSOzw+ayyJwzEcNUEFIe9a3MjRX5hfsiymgViU7bcgNvfo8G/WBBZwWNR
         CAgfZDfoRVpD60lT6mOtkjlcArF5TN+oevekjGyB99/9WEFhZBrevTGOcxvwm2YfGPEC
         46Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MKfAIw3yQbP7cyBV9BvWXN6wLtKZ0EwjNpYu7wLR6Ww=;
        b=ACI5c8qM/F9cEgnkbbtuG8dPkrC8jFhZsJA92ymwt0YoZd7UTLcRf/LWF6qsEQ3NEd
         Cu8yCcJMZR8GVyg594r7datHxAPld7DDC5xAzcc9T3/UVYyiTXP/xQWlyQPHN2px/JKA
         cy1SlnO5nRsY3LEt+/QxqGbhDQvk4vrVkwZBoMXldH447S1dBPb6xtlLp155k+15ASLi
         oJJ7mqfrgYxGEW08tV4VJoDg+6cO3usnNBOf46plER8iacoAL9Q+9i1FjMDiHzQ9czli
         r7XomBS7Z8xUMlVbeMmWXylnBNm0epLcwDY6p66R3Tvp6C6P8dNmWZk+POQ8YcBUdDKO
         dKCA==
X-Gm-Message-State: AOUpUlGsXzI8Bc2gdqfU3VA5JjEKXmOEHaXkBVp2MJnCnUXtXerE7KIv
        R7SdUB/CFt7A0BClXi/oceg0Ov33lgJsR+Wjkes=
X-Google-Smtp-Source: AAOMgpfKHfx3QP1Qvw9skcuPX6Kixq1j0Os9naLKbuBi3SshX0OGhyZy5MtmeGLd3ZCZSoJpWL2XEJ7UyfbLm28hEp4=
X-Received: by 2002:ac8:2cd1:: with SMTP id 17-v6mr17184268qtx.360.1532451718764;
 Tue, 24 Jul 2018 10:01:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3fc6:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 10:01:57
 -0700 (PDT)
In-Reply-To: <20180719140745.4503-1-msys.mizuma@gmail.com>
References: <20180719140745.4503-1-msys.mizuma@gmail.com>
From:   Tony Luck <tony.luck@intel.com>
Date:   Tue, 24 Jul 2018 10:01:57 -0700
X-Google-Sender-Auth: e4356SG3luQKgzv0MthVjqZlHJ8
Message-ID: <CA+8MBbJSox7YsfoL=90yiLp8_oHFEjkN3-nk95rGbUmk58R0Gw@mail.gmail.com>
Subject: Re: [PATCH] EDAC, sb_edac: Fix out of bound in PCI multi segment env
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 7:07 AM, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> KASAN reported the following slab-out-of-bounds when sb_edac
> module was loaded on Broadwell machine which has two PCI segments.

Although you found this with KASAN as an out of bounds array reference,
the real problem is that the sb_edac.c driver didn't know about systems
with segmented PCI busses.

So the Subject: for the e-mail (and thus the commit message) should
be:

[PATCH] EDAC, sb_edac: Add support for systems with segmented PCI busses

Otherwise this looks fine.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
