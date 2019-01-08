Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0675620883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ff5zqWtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfAHRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:33:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37021 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfAHRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:33:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so4124321ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfv87pSQ5LVZE74bOZwZ8D7JulJow6i/PnPfHwK+beY=;
        b=Ff5zqWtvBaoawRAIyfaAccJMtP0gD6XI3rNud/64ERuZvWLhDJGp1ZhDEz6k4MyKQz
         zl96KtWn8r9He2n6EF6CCs9eydPR9vXh0lkXoocD3+8xeKMI5XOsyRdq6YyFRLlwtH86
         TBsmVdBas62E0jXz0ABg5ddG9IA3IAetBAYM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfv87pSQ5LVZE74bOZwZ8D7JulJow6i/PnPfHwK+beY=;
        b=pcdbF6e4kycvmznFknGjNM0dAeqGFstt0UMm7CwkS84GsNiBSRC6RimVX0UTcHK6hg
         ghIn3hzJoFVy7/xglPKogYNkKubVlzj2pGJxgEXF67gfV5VNsyNSkSm/XFZAvMeUK6/x
         1w4ghCJ1Dp6Wx2cZm/lkYaAjn5WIv8la0ZcrEmc3HJkdPCArVVd/mKlnygMxG7OviZfD
         EqDl18qWiFOkxTpjA+V6DXW0DB6LQf3euWReCDfmk+fHjIqT2fEtXN+j9I0qrDoJc6YN
         HMGOI0yca8OkfKn4Mpm1B6RGPIBzseSan/gG4qf8p/mA66lhlKM7KkAp492aFjqbHKyS
         stEA==
X-Gm-Message-State: AJcUukcpUzzi0V6+asQNasUtnlMxr0aEXqmBmj7/9LXlX9SC1Re/ximz
        Wet80+oy7VY93q2WUmtyNGFzSumch/A=
X-Google-Smtp-Source: ALg8bN65HxJHnPh0/IRDqe8BAkV8LciGAqyhHn6dpi+/hOL65c2JbX0Nj6dkYMRITdakRCUTioh0jg==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr1521786ljj.165.1546968806961;
        Tue, 08 Jan 2019 09:33:26 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u21-v6sm14437390lju.46.2019.01.08.09.33.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:33:25 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id u18so3518791lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:33:25 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr1519595lfa.106.1546968805166;
 Tue, 08 Jan 2019 09:33:25 -0800 (PST)
MIME-Version: 1.0
References: <1546964798-30067-1-git-send-email-guoren@kernel.org> <1546964798-30067-4-git-send-email-guoren@kernel.org>
In-Reply-To: <1546964798-30067-4-git-send-email-guoren@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 09:33:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0H6_Vh3XNQ0EKWa96UFkr7j=v-++2L4kraSLR-RVciQ@mail.gmail.com>
Message-ID: <CAHk-=wh0H6_Vh3XNQ0EKWa96UFkr7j=v-++2L4kraSLR-RVciQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] csky: fixup compile error with pte_alloc
To:     Guo Ren <guoren@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Guo Ren <ren_guo@c-sky.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 8:27 AM <guoren@kernel.org> wrote:
>
> +       for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
> +               (pte + i)->pte_low = _PAGE_GLOBAL;

When I first read this, I went "hmm. pte_high is not initialized".

But csky doesn't have a pte_high, and it seems that csky and SH both
decided to call their (single-word) pte member 'pte_low'.

Which is a bit odd, but whatever.

Other than that oddity, it looks fine to me. I assume I'll get a pull
request sooner or later,

              Linus
