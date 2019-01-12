Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3359C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0012086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtFEkQXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfALVT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:19:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40585 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfALVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:19:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so15025609oie.7;
        Sat, 12 Jan 2019 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6NEv8OnAxCBAWP3N53NVanjafVjY+uoVLh/bevVheE=;
        b=AtFEkQXgTUFiTF7HVIFrsydDJGkFJOeKyLuD7+lVrmZWQ58aa23b/+u4a02ZqHqIEa
         rrQIj4vNTaOustR8reP2ZaP+wdzy8XgPOK/Pd/jM/sDnY543bQ3oCePUfuLCFisnueXQ
         Nf+n0ve459M3YsIyekaozRYnav8KOPw8R7y1TT4PwP9kBI0qyIkhusQR295qmAZnTVBf
         1OazHaL06LSk8S9oY8ZfWSUGSib3Jmuik34l2HNXMqPz1xwMIJHi/lva7qFjZCUkmsT3
         wT2M9rvKGDRv5rfniAGf85xg+fDwBBIhrw9EuS+Q49yeGxst7fBETZRmc05/BhH+D5L8
         EdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6NEv8OnAxCBAWP3N53NVanjafVjY+uoVLh/bevVheE=;
        b=bVyVqsHDQdeFXl2flaLF9yx7fvzRNxxRKDA+zPEXnaFyqTrMoknQdBULILQ73jK2bc
         aUg32H/RKwadlorttBOVv3wRmIwhBUkdQLjxsNM1CJJhjIa5Kcj8e8plhjx+T4i0zxOy
         3uG16F75b8Mzm7Nbq4Tf3COOLIoHn8mU6szeimc7VlQwHF5FqWFX9MN1HaT0BICg1XrV
         N/RPNrNMKnWnQNsr3zSwYYyEM3ud2fuywl+gnsZsyIH2cjj7dpkTs1orA4Wx9UyLw3TI
         76TkpRWV3SGzNAvfXLuKIc6IIXV0XEw8Aayf5RQyiVAecMSzLm03r7JgJ+k/6bN5aCm/
         Cb5g==
X-Gm-Message-State: AJcUukdUpeX9jWLVPItUw5E1/zcvYnrNSP/bDhRAuvx+cRSfjSCQMjiU
        S90Z0wegkjJt15GbXAvGG1Tc4f630FMFQRIVQ8DNHQQRv6RVeA==
X-Google-Smtp-Source: ALg8bN5e8ZjjZ0tuJrx+cv1EnNX8RYe477OdnjFpvda64xyPB/ss/m5apC7Lj6fb9geFLM759ynvkD8+wzVooqC1VjM=
X-Received: by 2002:aca:408b:: with SMTP id n133mr12833308oia.44.1547327965678;
 Sat, 12 Jan 2019 13:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20190111131102.899065735@linuxfoundation.org> <20190111131107.880515108@linuxfoundation.org>
In-Reply-To: <20190111131107.880515108@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 12 Jan 2019 21:18:49 +0000
Message-ID: <CADVatmMALKGQc3M3vyuHekDiR6zNhFzCiJCLrg00_9N0nDSChg@mail.gmail.com>
Subject: Re: [PATCH 4.14 058/105] tools: fix cross-compile var clobbering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Martin Kelly <martin@martingkelly.com>,
        Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pali Rohar <pali.rohar@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 11, 2019 at 2:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Martin Kelly <martin@martingkelly.com>
>
> commit 7ed1c1901fe52e6c5828deb155920b44b0adabb1 upstream.

This was fixed upstream by 755396163148 ("tools: power/acpi, revert to
LD = gcc")


-- 
Regards
Sudip
