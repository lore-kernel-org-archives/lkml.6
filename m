Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581B3C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE8320856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M77fojZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE8320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeJ0VuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:50:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38681 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeJ0VuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:50:08 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so4795240ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVgO1p08CvwfatKLlFYbBr9SZlwTlWKQfgVpxX97BKY=;
        b=M77fojZ3K/oJgfTBxelFSWSIMunkASojg9NqjAVLGLbYYfAuvlLQf0mMemQlUioy6S
         IEcNhonZAohOvi+8s5+G3shmyXAbRFL5u2hSWnkaklh31ZoAWsOAwIf8e7zigRSc85Nv
         KbkmraqaMRsBxtBuXkfgDdClMHifGTEtLxxBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVgO1p08CvwfatKLlFYbBr9SZlwTlWKQfgVpxX97BKY=;
        b=csfdnh7EMIep8EJs88WRvxpTkVrkAnJBiawWmEmVy+0//V1uhfSELL33vivcCGBGSr
         z7hBhHGdId5ez/1YTsBT77ksv5+UWN3m2JqcR+oDJHab+6NPHtyA6vU2L3yaULw9bzRg
         AXaur5dAw+0OItpnfNCexCvmPyeQFbEd3PxeDn1wtH/3tI7CTkt+IK+qcchawd6b/Lpq
         Ievokr+wPeEvJjviC36gvlhvO4HBUNiQNuZXEJrBr9ogHYFTIJxk9Ac7jvrJ3eqcCT0d
         doTPBmLtgzZ37zol/35BHMKyW7pNm/+rVHiaG1xLzliAmfNhfKB3JNPO/pZhJ9yrot9B
         1ceQ==
X-Gm-Message-State: AGRZ1gKoT0cZNlv2LCEFAuoSCkD345qeE1epZdzia5X074kAjrL3joRY
        JnZdVNkYlv+eutRbU/VmvY4bDWrjCPiRZz8jAGragw==
X-Google-Smtp-Source: AJdET5eNIhH3mDBBTx7Chh77OVR/N9av24XU2X++OZBv6SJ8W0xn8qeZuT0RkP6lR88hNG2g4dqXHsYHc4gOHn3kg/8=
X-Received: by 2002:a24:3088:: with SMTP id q130-v6mr5753540itq.148.1540645750633;
 Sat, 27 Oct 2018 06:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org> <3908561D78D1C84285E8C5FCA982C28F7D42C7D2@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D42C7D2@ORSMSX110.amr.corp.intel.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Sat, 27 Oct 2018 18:38:59 +0530
Message-ID: <CALxhOniEXwznjhYbAAM3-QR7PjSYvbHVZa798OUa3hu_PKj8Cw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ia64: system call table generation support
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Sat, 27 Oct 2018 at 04:28, Luck, Tony <tony.luck@intel.com> wrote:
>
> > Finally, this is the ground work to solve the Y2038 issue. We need
> > to add two dozen of system calls to solve Y2038 issue. So this patch
> > series will help to add new system calls easily by adding new entry
> > in the syscall.tbl.
>
> You have great optimism that anyone will care about ia64 in 2038 :-)
>
> Patches look good now.  If I don't see any comments in the next few
> days I'll queue them for next merge window.

Sounds good. Thanks for your support!

Firoz

>
> Thanks
>
> -Tony
