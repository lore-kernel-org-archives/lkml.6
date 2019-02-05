Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38A5217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB0U/NuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfBEWDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:03:52 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42834 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBEWDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:03:52 -0500
Received: by mail-ot1-f51.google.com with SMTP id v23so8524539otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyLg6JowU5VbHNFjqC/Wiy+GwrTjQbE3MmUVfrWRogg=;
        b=SB0U/NuXza0PUvKc84N9hhybgxnpP61ZNmdquMB+zMcvqSDUmLQdz0Mz8iojMnrkC2
         l92V7zNtGxdlgL4btEDjs7AIu/GlvuVQNzZsmT0ZolzxDDyJ48i3vnWrE1i2zPcGxIvQ
         ldkdP6zzDxqZaJWoNSRSMueOK5EBVTous1md7w2FFvOx+/JduKTd7QZHnIuXYoc8Kb1W
         gvpx5px6kdz7/pLq7hlYmgiKC8CFlQo/1YCmVADYLfWmJChBuo4mabdq+1KvuI+g/Oix
         ZbNH38MrNmz4c4ZOEGMscnE4gesXpwOoDSqogRhnjvlZ9crEIfNygvEFV7BXO8Ix/kWS
         dToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyLg6JowU5VbHNFjqC/Wiy+GwrTjQbE3MmUVfrWRogg=;
        b=BVMrKkADP0Lu5R5cRCumebKSgGNVgSW9BmcV4BZERa5dTLCbVoWVjnjUR5ymRpOOiS
         K5q8GjPkdLr8JR49HXEZ5RHPsTBUQYxnbGvaZsWANecswJ3TZr+57lIts1QqjC/fDYFW
         IKim3+0hDqbT7gq+LeNoYP7qU/oKfO18PMTsTWCexmQcvFW9/E5gmzfvL3yzUPdW5KGf
         XjTfwLtJQvDxFociLZ9w7m/6e1WKTGxJVg+9IRgbaRZZqnmTPdaUE1fnZ0XHUTTAXnui
         +++c+PJcCuHH/QGy39jftKPc+x7XHxUAvZ8Iu7vCNYNSo1AZ1gqvDqVsluC3XpzWoQuj
         1qTQ==
X-Gm-Message-State: AHQUAuYy9QgYatbsINmihAJmCB4sI0pzv0IDdqerBsEtRRv3FB36wtu6
        007EZJkyHPZ8Hpptb+4Ogzjo5B4TU9kNBkZIlnU=
X-Google-Smtp-Source: AHgI3IZDtFRZ9NxNeDLGpE739RnOIMXcBcWVu27aurMCgqLuCPykQBqJZKQONWejPy9qz6lfcRFoa0TZVH35AiLgC/M=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr3919519oti.245.1549404231727;
 Tue, 05 Feb 2019 14:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-4-TheSven73@googlemail.com> <20190205081846.GA118684@dtor-ws>
 <6565ec19-b629-c289-2fed-a5f404763b74@gmail.com> <20190205214351.GB19151@dtor-ws>
In-Reply-To: <20190205214351.GB19151@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 5 Feb 2019 17:03:40 -0500
Message-ID: <CAGngYiUJtk3fzHBVtd-NoaDQ14UHyBQe+LDW9WcE5UCPK_ia9w@mail.gmail.com>
Subject: Re: [RFC v1 3/3] cap11xx: fix potential user-after-free on module unload
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 4:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> OK, great, I'll write up a patch for cap11xx and others if I find them.
>

Possibly also drivers/input/keyboard/lm8323.c
