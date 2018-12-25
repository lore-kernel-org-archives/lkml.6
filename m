Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C0CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C835221726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AYp9ximD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeLYVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:13:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34274 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLYVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 16:13:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so9935887lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUf4H07VFsiXZjCkOwiy66KZvhPPi/utGiiZL50k84E=;
        b=AYp9ximDGd35tTZQ8LCFAcjX2zHm6TuIJJ8rKbpVnGGWw+EiYLdL0rnqa8GGL1Uss4
         I0OjgsSW99/To0egR5WMA41xoovIVTCMExm0WDwOI/b6Qx+9ePqCwNaqqtDFvDGwrdta
         /0p535kClwEWK9BTtzxXu7ENxDiqPm3JOJq+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUf4H07VFsiXZjCkOwiy66KZvhPPi/utGiiZL50k84E=;
        b=LD/NZDfvjF0ayfcl6Fsks+Tg3IuTtU+UbiWeIh+g5sr4R+CwrWnxbUjajqpdjEQY76
         lp+VKqUlHJ/5ComJ8W5jfGdLtsVQ9FiwDw0Cb+c4XNngdZq0xvchWRvcKvoX7vqgFgHk
         zkaougBNEbeJBnYdPv5kvLdUlsLlxWPEJ5L3nqqt1XThlib+vZhGdmTY0lxzc9ODLQCw
         H6AR6o/DcqVngNn27MWZZN7Hin8kb0PGbJc8VHzf3zfkqwyEoIfUu+NMZBCa1Eeosj8s
         WRpFg415I+AG5WYdZiOVz+TJkUMoyIYZDoQKl/CkrQXPEQaWfJN188L59KH9/+DUpavm
         5tAw==
X-Gm-Message-State: AA+aEWaI9N2BPo4gRH6VpOYYRDy8QTJxcwAEEfN12njZDBCVBF3SqrzD
        ZgOnkjnoN3AtCRQ6MXCk0dvm7bjo5iE=
X-Google-Smtp-Source: AFSGD/UoMhLjB7sZ8TFhWxadsjIGbOdwOxQdOU2aRDn+OiU1hZt1p3s2faxW9Ws91Rc6M5dn+OTkhA==
X-Received: by 2002:a19:690d:: with SMTP id e13mr8666619lfc.84.1545772396318;
        Tue, 25 Dec 2018 13:13:16 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t22sm7237073lfb.0.2018.12.25.13.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 13:13:15 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v15-v6so12588288ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:13:14 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr10058599ljs.118.1545772394436;
 Tue, 25 Dec 2018 13:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20181220104544.72ee9203@coco.lan>
In-Reply-To: <20181220104544.72ee9203@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Dec 2018 13:12:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqS_ShU4th7mKd4kLEXaKKyrnK5FkyJgdy=_=_wy1KGg@mail.gmail.com>
Message-ID: <CAHk-=wiqS_ShU4th7mKd4kLEXaKKyrnK5FkyJgdy=_=_wy1KGg@mail.gmail.com>
Subject: Re: [GIT PULL for v4.21] second set of media patches: ipu3 driver
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 4:45 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Also, it would be good if you merge first the docs-next pull request from
> Jon, as otherwise, you'll see some warnings when building documentation,
> due to an issue at scripts/kernel-doc, whose fix is at documentation tree.

I don't seem to have that in my pile of pull requests, so docs
creation will warn for a bit. Not a huge deal.

                     Linus
