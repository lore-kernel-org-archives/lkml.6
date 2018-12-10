Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA064C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29F22082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/cgfuVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29F22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeLJIFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:05:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38564 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:05:20 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so16636951ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeB5TU8dkdrhQ+/voqyCldGbok3k4VlRyRCuw0NXPcA=;
        b=V/cgfuVCA7fcg7myVMup3fWM6xj71RtepV4oUs+DFdOCYVwD15EH/5qQpwUGiiEN/g
         /wiAsfeHwHdu8B2xsH77Q6KhU5sKseYnPRe3mkdVS5+Z3pk1+GVzS8T5zun9GVLN1aJs
         RA9Ni1eD+JrWSaC9GRHGeePCBCRjmK6U6Ufm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeB5TU8dkdrhQ+/voqyCldGbok3k4VlRyRCuw0NXPcA=;
        b=hpgMdTcubMd0ZQ/M99VrqkRcYPYGVY093Lnc5JRKN1zCRsdz+wZTel/gDmPf5i6cl4
         eFdK8d2GvJcXjmkY8qkF/7GzXtDeR4FjoPKlja6ND4mhduLtie3WQz/tkAprRZ2u3foh
         I26D9mK3qae1w+iGx2YToTbqO15RVqL5NZkc0Oeb7ZCAd8/0R7TYlN5otzRlRF1hk44y
         v82x2vhR0qau/JXnyrN4AaQG/3ZE5BnzqUtmqCHp4dIae5GHc1tth7z724evWbCw92EP
         9f6X4b2eGxuoY8E/MKCUP6D3iEU8mWzFyE74is1BwO2cdrdpaaq4Xdy5AoERZOua66ie
         cVhQ==
X-Gm-Message-State: AA+aEWaJge0LmtjG3MHXy1FSnvzf4ZZNUonxcPVtQzjhbHqsjli4QUYO
        0pT9Vz+6Mkz1fWd/uHaNw7OvMgW4Y2eZ20v6NIOguQ==
X-Google-Smtp-Source: AFSGD/XCrSDTRvnt65FKCFK2/vYfOYPGQHiJjGz5uBPpI4rAHpUDjOqAJOpOHYdVxsB+MaT/pUwW3BsMudNQDrv1Q/I=
X-Received: by 2002:a02:f42:: with SMTP id h63mr10657949jad.133.1544429119298;
 Mon, 10 Dec 2018 00:05:19 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOninHsCiB7puVOkU3i6W9gfhGqAA6EDT0kAEC9ZqMZPh7w@mail.gmail.com> <20181210054116.2hq5ykjfh5itcvqk@pburton-laptop>
In-Reply-To: <20181210054116.2hq5ykjfh5itcvqk@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 10 Dec 2018 13:35:08 +0530
Message-ID: <CALxhOnjWQRgE3rmoLr=J51Babys48kw5D6QiNF44mw=rY_AkjQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] mips: system call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, 10 Dec 2018 at 11:11, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Mon, Dec 10, 2018 at 11:05:38AM +0530, Firoz Khan wrote:
> > Please review this patch series and queue it for linux-next.
>
> It's been ~4 days, 2 of which were a weekend. I'll get to it, but
> pinging so often won't help.

Sure.

>
> Thanks,
>     Paul
