Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C26C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85922147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKuLesrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGW1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:27:39 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45867 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfBGW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:27:39 -0500
Received: by mail-ot1-f51.google.com with SMTP id 32so2619536ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6VV0m7OwM6sm/r2va4gnhX/8E+YVxIUEmNTwqMvQcw=;
        b=JKuLesrtoPy2Mv20tKiBOiLD5OdmwJbTwT6HQB3h8zlmWwFnI34n+sXCvZGP6uSJ9D
         5ciZuC8cyNNJNBowxzRFi3LMTZ+xDWQpFWhoJ91qT9ljyVz1lXNLgq83JbTW2odMg8/T
         H8hHWlWnQNc0Hotgnh0lHOgrrpmyQ1DKPQbeDe3DR9IhxpKu+6d00g73uRE9+LPY3QzC
         emywjoAOiAD451+yHFVhudbPRFfVJiwYLBdxk58GrYAlQCPzcLoMYcAFqyEP7VbrWuYG
         MrxFZXrdQuZhiTHJQdv1JrMV7X5oHlgyC6NXwgeyDbBfHfcTRBKZbhbbVX7Ca1lbMvih
         zHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6VV0m7OwM6sm/r2va4gnhX/8E+YVxIUEmNTwqMvQcw=;
        b=CfnGCTOJGgyfwTz1HXg2eNwIKRQe34bQK3XaIEcU8fxMK5oE98yL2L85kSftedho4W
         xxliL6Nw4+hja+kYMPjA83w1GNnil9MIYU2qCBqaVNA1EgWWuBNc46wNZS5REu8VT9Qp
         EtWQH9NpdBTXHUr2PbFLKIunwz75/Hq2vE4x50TkJGYGDomwAE4UUTSYhtcbV9hOphb7
         NXVCkojNDHiZQHk7EqV8lXF7zlBS7GcGrV1PyggZDW/Ri5R8EVwOR+KrOvcEdYLsExxy
         NmToHP00cw7mZMC5QC3iBLCgOUF8UR9k+ZSGkSrjBMLr236OESL9HeY6LgYYLfhYZTh/
         Okgw==
X-Gm-Message-State: AHQUAuZbOqgmBoL4PmFdHwSN8ISpxnCwaRyMNODsrZbA+l5KdHAB68MW
        W5U1yoVGFbyesoOowasYef0uSrmYgqCUcnVQ9Y4=
X-Google-Smtp-Source: AHgI3IYaMvOBdnsSEpLzLncTc0bADlWLNYfW4b/pkrfNUEZwlYF5CHCc5WmM2KFFLtuz6njB2GLUdqpBPvITUh6RGug=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr10815574otp.225.1549578458456;
 Thu, 07 Feb 2019 14:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com> <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
In-Reply-To: <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 7 Feb 2019 17:27:27 -0500
Message-ID: <CAGngYiW9=FT2TiqoZQb-MyqBWvcZugYQ_x8j4=Yg9MJG0_JYyA@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 5:21 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> > ./drivers//input/keyboard/matrix_keypad.c:512:1-18: missing clean-up
> > of INIT_WORK/INIT_DELAYED_WORK initialized here
>
> This is not as simple.
[...]
> So in effect we do not actually leak work
> past driver remove().

That's expected. No Coccinelle script is perfect
(especially not my feeble attempts!)
so there will be false positives.
