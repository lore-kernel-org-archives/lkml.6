Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ADFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225D02145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225D02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIXNGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:06:49 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44694 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIXNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:06:49 -0400
Received: by mail-vk1-f195.google.com with SMTP id 125-v6so3792793vke.11;
        Mon, 24 Sep 2018 00:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJMpd6oqolD2HqlwqrotibNPVPwHIzaYIuH3pzkJjxg=;
        b=Cp9rgGBN/F4hJWdvTGB+Yue0Aet68Fsx+VGsNtsKfqvu11ejSermwVbC2qIpC3Zrjl
         Y2DTy+0kE7mjR+eNZRklSRjFYV3FhF2PDVEfpypgmuzcvDA6tJawJFCmSbAiBArqvbvm
         2WNlKBcZ0lAY2HC9K87U15/p7MaqU0iDSscGbogPUMamdDbHuE7FocKRkDRDlexSBEtS
         R1gYYEQjFmfZPrYEeu+GKde/gWIju8nitba8Bl9cX+NVBx1c+toX5iaYht4kqqy2Vmiu
         99lYcEH1NIBzzL6wwCSle5TMYkq+EPoIvxbDYhasPUtAZjoy36/VOcU58awzYiQYlLS2
         Wquw==
X-Gm-Message-State: ABuFfogHxOew6ehOcEqE2DdKGmebgKZPBeqBGiPPQo41cb0hlhbtNQYg
        GH5Hh0WxwaBOfYinajjR5EJ3LLK4ouDV8DBZx6M=
X-Google-Smtp-Source: ACcGV61myLfe1xcwD//NUwtkyarRf4ukHfSpvTD5CkTrDG8ixStH2QqCpXrKGzXeYROrp66hPYV94Gg2qgZAtnfL5Qs=
X-Received: by 2002:a1f:2ad6:: with SMTP id q205-v6mr2160668vkq.83.1537772769321;
 Mon, 24 Sep 2018 00:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:05:57 +0200
Message-ID: <CAMuHMdVbxvQMT9qAaPx8GPjzdM5T52KQ2jTGB6bmA61q9BAXyg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] m68k: added __IGNORE* entries in asm/unistd.h
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> Added few __IGNORE* entries for seccomp, pkey_mprotect,
> pkey_alloc, pkey_free, io_pgetevents and rseq in the file
> asm/unistd.h as it is correct to keep __IGNORE* entry in
> non uapi header asm/unistd.h while uapi/asm/unistd.h must
> hold information only useful for user space applications.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
