Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEFEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15892077B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lId9DkoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfBWBW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:22:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43025 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWBW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:22:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id f196so2269190qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 17:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vm4+Pp8Xr6BO7M1iEWY8AJMKoYwXx7Dq0YECLT2/Q40=;
        b=lId9DkoEEcywXZHR9j9TKSvq7gcC9J+GgYP8HwoSWsnXye6O9vyJa+wEYPlJbmsov4
         NcxLdN5BXnm3ZeJCNSpSEeKe5zKLqcKQTIsxCTF621G5PXlN7InkPz651Y8JqwXdzTxW
         2NxwM4WbUFufk5ufz7St239sxM9l1+Zp/wf3p1hZuhNE0YOOVI+7cV+eqwYSzlY8e9Qf
         G7zDX/rCOzic5giluCkJNpDWAAtBRQ4uVIkj0xmch2m55L44d0QhhNmI3T2JjM+2rYSs
         sss2FMJcWF8SFGyLnkyEKmGgLAo3ytzhsbnXxQD4Gm1OFd409PaNydoEmhwDZ7ziyVO/
         ja+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vm4+Pp8Xr6BO7M1iEWY8AJMKoYwXx7Dq0YECLT2/Q40=;
        b=aWPk8azcGLhrJxl46Vs2ClvxjiV5GBk6T6RLO4nFhCMaLfhPpgnSf9MowfFhLUzIJn
         zEm0/Sns+VMrZrKDLtiEIVnAsO/KUmEuatgt2t8Bl3KCv2+KhhwF8GnQFgiNpjr5XnoS
         b2d2VZw9LRPxY8uU4WYIsr28585s0bVVkNpGYPPUgqOgzv3ckXdSN04SKt6qpJUgUx9K
         Vl0id5teDeFUj4H8b3qVYneuwGFa36tXSiKwdGTd9odMcQqqx+UoOBgWluY6nRbDm9HR
         hg0TTkcCZhtQffU2IYeOX1Zi0PoCpTwEtQJoa9w0E1qlpD9h2lJaLngGgmeOi88lti3G
         /J0g==
X-Gm-Message-State: AHQUAuaSvmgILWgCop67diM515IgLDik+D1/pLWMlTflIiqXYAkfhVdx
        LdkZ5/lOOxecAiUyD3hkumAfsLli9sI=
X-Google-Smtp-Source: AHgI3IYTtPlX+RRBzfssnU2uF7+JjBtJOnOJx3mLjUsmxqoyj0Ra2+mYPb0KTVyciL/yP3uhP4yozA==
X-Received: by 2002:a37:dc04:: with SMTP id v4mr5054125qki.197.1550884975886;
        Fri, 22 Feb 2019 17:22:55 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j68sm1682195qkf.84.2019.02.22.17.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 17:22:54 -0800 (PST)
Subject: Re: [PATCH] [v2] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kbuild@vger.kernel.org
References: <20190222222950.3997333-1-arnd@arndb.de>
From:   Qian Cai <cai@lca.pw>
Message-ID: <0bbc79a7-9a50-1340-1712-41b42ee36b4f@lca.pw>
Date:   Fri, 22 Feb 2019 20:22:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190222222950.3997333-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/19 5:29 PM, Arnd Bergmann wrote:
> Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> about overly large stack frames, the worst ones being:
> 
> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
> drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
> drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
> drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
> drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'
> 
> None of these happen with gcc today, and almost all of these are the result
> of a single known issue in llvm.  Hopefully it will eventually get fixed with
> the clang-9 release.
> 
> In the meantime, the best idea I have is to turn off asan-stack for clang-8
> and earlier, so we can produce a kernel that is safe to run.
> 
> I have posted three patches that address the frame overflow warnings that are
> not addressed by turning off asan-stack, so in combination with this change,
> we get much closer to a clean allmodconfig build, which in turn is necessary
> to do meaningful build regression testing.
> 
> It is still possible to turn on the CONFIG_ASAN_STACK option on all versions
> of clang, and it's always enabled for gcc, but when CONFIG_COMPILE_TEST is
> set, the option remains invisible, so allmodconfig and randconfig builds
> (which are normally done with a forced CONFIG_COMPILE_TEST) will still result
> in a mostly clean build.
> 
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38809
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Qian Cai <cai@lca.pw>
