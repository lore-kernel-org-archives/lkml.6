Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B3D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEEYzxuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfANIDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:03:37 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51820 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:03:37 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so11753406ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHUKvJWrC1VFZxWeTcoOOY1zDCQJuO+pPfl0ZJy0izU=;
        b=YEEYzxuJdPe6o/tgTybOIncpqWYPM9qQhB+oKPFZxQLunkrTP9gd/2hKITeH1oVYKq
         Nr96XhCCIYWB41NfH4VDJHmsQl/u+mEv4igToerQtsHfSkWW3BUulj3tFrpwI+Kh6ZxP
         e/G9aaE025PLm2RxI2HdWZQApRuYRxEX9tNuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHUKvJWrC1VFZxWeTcoOOY1zDCQJuO+pPfl0ZJy0izU=;
        b=XkH9tlAIiFdOPCfXOeslYp1/cPFsnYt7JkKZQQBiyIIo+9fsdusnqQukaDz24st31D
         GKFkJ2kNI0T984f5VV7D4dcnDVzLAMpN1fCc9TdMWENSH3A6WzAV+29YVEE6lnJMLEDw
         dfFyzB4L3oKfP8uQVjYreav4VWDmhZ+7+slt3/EeWf/rRhOWBRaiY30knweJ8fLFfq/3
         fH8incNQqP3el3UZ3v4w7a2LTUp8yqo6bm6buqBqfkW7JHRvc6UmMZgTqGJhEGtPoG6f
         ddh10hW8F4REZZcf5TceHevGPa9UF6/kBGzfPHc6//mwUByWUZPNPG5wEuQt12fi7ECX
         HjWQ==
X-Gm-Message-State: AJcUukd5mVcMPfDgPc6syLk3siA1PCpcPgp6aJM1UzbwMbTthaMhfSmb
        FeAuBrq47sPulnQHjxQdEW6gf/e5M3kftAgbxg2bUCj3N3w=
X-Google-Smtp-Source: ALg8bN5aaUyHCncXpwMN8wGVflvaQ3g1zT/Z6UOc/cq1Xrwy3RI/AkWBLTdxTbwCfaPM7I0OtdCqfnMKDaJfGlKMdss=
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr6888604itd.148.1547453016295;
 Mon, 14 Jan 2019 00:03:36 -0800 (PST)
MIME-Version: 1.0
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
 <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu> <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
In-Reply-To: <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 14 Jan 2019 13:33:25 +0530
Message-ID: <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
To:     Michal Simek <monstr@monstr.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Michal,

On Thu, 3 Jan 2019 at 18:39, Firoz Khan <firoz.khan@linaro.org> wrote:
> > Looks good. Will keep this in my queue till depending patch is applied.
>
> Thanks for the feedback. As Geert shared few feedback while m68k review,
> Hopefully, I may have to include those changes here also.

FYI, I'm going to abandon this patch series (for other 9 architecture
also) and planning to come up with asm-generic support along with\
this one. That can be single patch series and everything can be landed
in upstream in the same time.

Firoz
