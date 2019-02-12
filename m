Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFAE2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcGMV6SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfBLNk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:40:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35320 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfBLNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:40:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id z15so581238pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6BsW48ysrGHYw4i45nfM6R54XydeVksGSTXwXpR/5Kk=;
        b=VcGMV6SJrM0k6yh3+oYx6pRhuzo99UYiT4U3N9sqzdcTVa9hyNYD+Cmc0RxukqpZwO
         ShyV7LFIPvqRyeAJhaUB2HIuDeuAIm1xn9OKBLAfQQ3S0UY1K7slgATLeq76AJX7Okwt
         AKOnf307NgsMShur4a19niJIP5t33mYaUe4iB5u/CODnbZeD1VzCeFMLLPUxI+pIe6Aj
         edJzFfZubplOuiaahhtuzoj5vtO2GXXHcg6StnDgsz8P0fJ9cMzBSPUr55JSP4c6TWvB
         c/XCVREWDHg1XSCULz+jGWRV1eb3wNvzrCj4BTynVVAfb98sWcVPvdCvWpfTPWhIN9BY
         0gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6BsW48ysrGHYw4i45nfM6R54XydeVksGSTXwXpR/5Kk=;
        b=QVz1Ita74tlI2e8vlecKgT820zfoa+gUNpmCxwyK2P2pCxCLu3yjl2itmOrCwbMAv1
         NqeT0Z4rA4mmc5AFHMkuqnlU5KmAmu2I2UV0idhfVyIsvzLDNzqmdULi9L9VtPQAp3Us
         HCT2hL4hdowK6FGjma2427q+HoJUWYt7NpuoZ9R/IttCLdRsMeOhH99gN1yGkLdA1B55
         2zVa27ylD9qF8TS28/McpDySc6VkiBfIDp9xXWHaKW/T4XTPV3DUNmoraTaJrQQyBCsu
         VPvdDtGUJO/G/7TIE6nRTMF35uHTbFbxB2jwY4yzoIqfoGs+nC72F2EKHNTU7J1uV5rI
         FVFQ==
X-Gm-Message-State: AHQUAuYPccFINB4sZmtM8wvFqZVpkFt3VI2GLgBltPqKIKR7V+KIfL1n
        dbb0+1o02nSN0VxYRBCb/q2XyUpJqt5sDn/pBrE=
X-Google-Smtp-Source: AHgI3IYdanJ8vO9tz1Q3EAo6OiQ7/ypKkeietsZtQDwqHAvEc/GYbclmO8Cb/8fqRCd9e4TI5jyVfoK+DOFXINjynJc=
X-Received: by 2002:a63:3287:: with SMTP id y129mr3705258pgy.337.1549978858175;
 Tue, 12 Feb 2019 05:40:58 -0800 (PST)
MIME-Version: 1.0
References: <201902122125.Ba1Ua2jh%fengguang.wu@intel.com>
In-Reply-To: <201902122125.Ba1Ua2jh%fengguang.wu@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 15:40:46 +0200
Message-ID: <CAHp75VeWO7k-ep4UutZ0Lyqsi_G5v5LLjeJRXLs1TbfNW7TRPg@mail.gmail.com>
Subject: Re: ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko]
 undefined!
To:     kbuild test robot <lkp@intel.com>
Cc:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 3:20 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Jo=C3=A3o,
>
> First bad commit (maybe !=3D root cause):

Yeah, I barely see how the error below related to the mentioned patch.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   f17b5f06cb92ef2250513a1e154c47b78df07d40
> commit: 78f3ac76d9e5219589718b9e4733bee21627b3f5 platform/x86: asus-wmi: =
Tell the EC the OS will handle the display off hotkey
> date:   3 months ago
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 78f3ac76d9e5219589718b9e4733bee21627b3f5
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D8.2.0 make.cross ARCH=3Dia64
>
> All errors (new ones prefixed by >>):
>
>    ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>    ERROR: "numa_slit" [drivers/nvme/host/nvme-core.ko] undefined!
> >> ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] un=
defined!
> >> ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion



--=20
With Best Regards,
Andy Shevchenko
