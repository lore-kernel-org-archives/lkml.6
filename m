Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE19EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B4C218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546414842;
	bh=xk3UX3rJzibJ8bJ+K3P/o/ARe6Dde8vOr9CtL2jJOQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HgIfibIjQB0WfKA9xnijn8dwqyo9ysir/zhP2G75yb/uS+ApRwuZjrEVMNvfb+kK9
	 j0xcI8R98N6dukguQOgHO9S2oMX4uMAemi3oBi/fyIriE4GIZAFhUxmz1IYqGfNTzP
	 lIv/eGivYVcWkJ3Di2RF+9IcR+1xAGbEGfLEIKGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfABHkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfABHkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:40:41 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C9D218A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jan 2019 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546414840;
        bh=xk3UX3rJzibJ8bJ+K3P/o/ARe6Dde8vOr9CtL2jJOQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B5hOh7EEp1nFrmVDl/MlCns54xJiSDm50HrB0CyE144pBSjDrXRR4J9HDqn1cEztN
         Dg+NSmDMsaO2HOArIVOvfJuFHqYP2KR5iMmW4S3ovHYVwCjBBoYZaZ04LSYysNPvoI
         cUflFghvWVKrX9puBct7VckzmGNX1jJz3Z7hdP/I=
Received: by mail-oi1-f175.google.com with SMTP id c206so24513651oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 23:40:40 -0800 (PST)
X-Gm-Message-State: AA+aEWZD0bPXwvgwmEc8YiTk9iGdjf14Qtgfr8jHZOv3bS7WoMfYZzAP
        B0RLBdVV9/n0Cu2BHj7cdB+rOlWa4kxSm7cSTY4=
X-Google-Smtp-Source: AFSGD/Wq3rRUWDOEGOjzmC9+wAyzNLYSgIr3JP+eMm5vGiadm6ZHaSDTYTle8RhIcwUnAfmmlqcgkO7sZvawJfDvqT0=
X-Received: by 2002:aca:c312:: with SMTP id t18mr30078573oif.92.1546414839640;
 Tue, 01 Jan 2019 23:40:39 -0800 (PST)
MIME-Version: 1.0
References: <201901020739.5sx8hjOo%fengguang.wu@intel.com>
In-Reply-To: <201901020739.5sx8hjOo%fengguang.wu@intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Wed, 2 Jan 2019 07:40:28 +0000
X-Gmail-Original-Message-ID: <CAK9iUCMfURHL_Dzj=JX0nydD-SuDc_Qu_u4+KByh0+M1rQrncw@mail.gmail.com>
Message-ID: <CAK9iUCMfURHL_Dzj=JX0nydD-SuDc_Qu_u4+KByh0+M1rQrncw@mail.gmail.com>
Subject: Re: device_sysfs.c:undefined reference to `utf16s_to_utf8s'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 11:43 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Sinan,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   28e8c4bc8eb483c22d977e147a0b98fc63efadf7
> commit: 5d32a66541c4683456507481a0944ed2985e75c7 PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set
> date:   13 days ago
> config: i386-alldefconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 5d32a66541c4683456507481a0944ed2985e75c7
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/acpi/device_sysfs.o: In function `description_show':
> >> device_sysfs.c:(.text+0x44b): undefined reference to `utf16s_to_utf8s'
>

I posted a patch to fix the issue. Someone needs to pick it up.

https://patchwork.kernel.org/patch/10745249/


> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
