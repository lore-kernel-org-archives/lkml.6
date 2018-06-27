Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8969FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303F521CF9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoxsHWQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303F521CF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeF0GJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:09:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46711 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeF0GJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:09:14 -0400
Received: by mail-io0-f194.google.com with SMTP id u23-v6so769125ioc.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JuseYW54efpSu/lgMf1oo5gGl0WQN+PezM3iswx8YKo=;
        b=NoxsHWQgffkg8DWqBw0oVBTKNzsfLOVz4w+N1n75GzhvF9P6v/F8MBR4qpg/zkZAmv
         Yy1RxcjoIK/PVWauHJi9XrVzPxt9Fc+M3rZuJxNEGps0EeX86hjheKX25Kp+3KbTNrSi
         5/hchtknP0izyrkX2FcaI/TGujguRgT5eNfYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JuseYW54efpSu/lgMf1oo5gGl0WQN+PezM3iswx8YKo=;
        b=CUwlJrqXF5EkhdtLFWn3NC4W9/0zFUtw8HYwFjLPw+cugeb60pShoRwHxUkMHG/RDh
         DkWbDRI3cahbL+23Z2G7968gjm8D0uRCdQ8OQrez73rrZfSFEcYcEut1WKF1jkCBLh7o
         4AtKEjey7PRz3ghY+8DWWzyvMtz+Xu8qQS2Q15CXTjUBvAu5vlrs8rmNAgNyViihOn/Y
         kC6/zD3tSbYvkHbWJQpsavv6mYkrHozIaazbi6OxeY48eW/vVNrsePbXdyeDFQY0hfEz
         ywcRSxC/XsYrLM3o85Co+Cv0409g0iGhIkgYvd+TpdPH1Pyd55NuBsXgHiq+NuxP+fAf
         j3nA==
X-Gm-Message-State: APt69E0SI0rMta3Y3y36/HfwSOj89fEiAji8QNJyjYBYogOaZhLi+0IR
        x96m2T8rq0A/nzHlpmg1iMkniSYkQ5+rcBx64jtfkw==
X-Google-Smtp-Source: AAOMgpcfQdwkAulEJGwyJbAv5rg+xkvekhn45DWhVBn8CjSXyX3FIbRwFp2QIiu0Yj7U1p7Bk26lhD+Ys74wJ9UAzIo=
X-Received: by 2002:a6b:5d09:: with SMTP id r9-v6mr3645293iob.170.1530079753994;
 Tue, 26 Jun 2018 23:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 23:09:13
 -0700 (PDT)
In-Reply-To: <20180627060257.GD18756@yexl-desktop>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <201806261053.B3CmI5Dm%fengguang.wu@intel.com> <FFF73D592F13FD46B8700F0A279B802F45FD1614@ORSMSX111.amr.corp.intel.com>
 <20180627060257.GD18756@yexl-desktop>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Jun 2018 08:09:13 +0200
Message-ID: <CAKv+Gu8bQKnpHbGS2S3RwTErP_F3o8mogc4bAbtX1r7=Fyp=NA@mail.gmail.com>
Subject: Re: [kbuild-all] [PATCH] efi: Free existing memory map before
 installing new memory map
To:     Ye Xiaolong <xiaolong.ye@intel.com>
Cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        lkp <lkp@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:02, Ye Xiaolong <xiaolong.ye@intel.com> wrote:
> Hi,
>
> On 06/26, Prakhya, Sai Praneeth wrote:
>>>
>>> Hi Sai,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on linus/master]
>>> [also build test ERROR on v4.18-rc2 next-20180625] [if your patch is applied to
>>> the wrong git tree, please drop us a note to help improve the system]
>>
>>Since efi_memmap_free() is a recently introduced API [1], please note that the patch
>>is based on efi tree @https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>
> I noticed the official efi tree recored in MAINTAINERS is git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git,
> are they identical?
>

Which version of MAINTAINERS did you look at?

> EXTENSIBLE FIRMWARE INTERFACE (EFI)
> M:      Matt Fleming <matt@codeblueprint.co.uk>
> L:      linux-efi@vger.kernel.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git
> S:      Maintained
> F:      Documentation/efi-stub.txt
> F:      arch/ia64/kernel/efi.c
> F:      arch/x86/boot/compressed/eboot.[ch]
> F:      arch/x86/include/asm/efi.h
> F:      arch/x86/platform/efi/*
> F:      drivers/firmware/efi/*
> F:      include/linux/efi*.h
>
>
> Thanks,
> Xiaolong
>
>>
>>[1] https://lkml.org/lkml/2018/6/22/39
>>
>>Regards,
>>Sai
>>_______________________________________________
>>kbuild-all mailing list
>>kbuild-all@lists.01.org
>>https://lists.01.org/mailman/listinfo/kbuild-all
