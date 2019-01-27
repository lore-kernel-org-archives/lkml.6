Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1746C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72BB20881
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FusUvrOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfA0RcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:32:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37280 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfA0RcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:32:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so10194854lfj.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyBimp4YdvHCL5tmYqBBWnF5UpvIoaf+6MNAbFGuSDU=;
        b=FusUvrOEVNTi29de6qnrwq11aywNUBxBY89BjDPED9g8y8SCWwbSQcfMjAjyb9PoHn
         BWgu7UIoypeLl6BQFR+HvJry/XzWMD0E1uLz2sGVzhijzEsziooXLJ7onnHbFfFRZybO
         QDagv8HQnBLP5ECkLqIkEuBOyn7Oiq54/LCw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyBimp4YdvHCL5tmYqBBWnF5UpvIoaf+6MNAbFGuSDU=;
        b=i6iycGSq9iTO02XL+AGkHqZOQYQF0WqNQ2XTxstNY5Gbj6xWAjpxwxrz+Cvx2gmPAz
         L4SkWDNpzwwV9YMpinQg0Jlwti+Ing/sxrLABB0BpgO3FFn6I0JnrqcSw2xIeVt3d9UM
         EtN4E3fBBaC0n3vLbdlayY1ZuXb7LMpAxGLnRprlXgmg0MToiZEcyjy2wN4x7nniLQeP
         ZhsfT5JdAE0EV2uDsyAQmNMoQvnHvnihda5yFuBM2VWgpntvXaunQq8VeMEYypIMaVcX
         YWq/DEu+v2EC4TV9nLhMGz6jC5sE5bmWy/VZkbmUj/78LuG6inQShGuR9X6utBPyHElV
         bIoQ==
X-Gm-Message-State: AJcUukeYmHxYzFTPJpXDIHqWAhnY6T+8IWpDakDUR87MUbYccm14JCLO
        IqZ5JTXcPwBRXOkbBMrygVl6RFveXHM=
X-Google-Smtp-Source: ALg8bN47NVo7VZ8FfBrAm3fO/mhg8YwcJXB2Dj1WOAD5rb5MQOdff+iTdOEMs89byGr0ug4/gtBkmw==
X-Received: by 2002:a19:7018:: with SMTP id h24mr13940924lfc.162.1548610326169;
        Sun, 27 Jan 2019 09:32:06 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k21-v6sm2582799ljc.15.2019.01.27.09.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 09:32:04 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id x85-v6so12266312ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 09:32:04 -0800 (PST)
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr15515360ljz.54.1548610324218;
 Sun, 27 Jan 2019 09:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20190127170618.22800-1-Florian.LaRoche@googlemail.com>
In-Reply-To: <20190127170618.22800-1-Florian.LaRoche@googlemail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Jan 2019 09:31:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjBZvZ-AZ0OG+DBbyN_5CqPVNOva3v5vmUuSxvT+j1smg@mail.gmail.com>
Message-ID: <CAHk-=wjBZvZ-AZ0OG+DBbyN_5CqPVNOva3v5vmUuSxvT+j1smg@mail.gmail.com>
Subject: Re: [PATCH 1/1] int_sqrt() adjustments
To:     Florian La Roche <florian.laroche@googlemail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian La Roche <Florian.LaRoche@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 9:06 AM Florian La Roche
<florian.laroche@googlemail.com> wrote:
>
>
> -       m = 1UL << (__fls(x) & ~1UL);
> +       m = 1UL << ((int)__fls(x) & ~1);

No need to add the cast. It doesn't do anything and just makes the code uglier.

The type of a shift operator is the type of the left side of the shift
(with the usual int-promotion).

The type of the right side simply doesn't matter (the *value* does, of
course, but because the value range is limited, the cast is just
noise).

                Linus
