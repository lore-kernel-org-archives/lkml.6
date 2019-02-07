Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9664D2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJyvUcvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBGWcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:32:17 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44680 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:32:17 -0500
Received: by mail-ot1-f46.google.com with SMTP id e24so2648394otp.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xprK3DO2dgIPaLc0GaBQ1orSs+O0lP1cFE8b0GoujoE=;
        b=JJyvUcvqjIqq+EHUvbRAP7b8IECA3YDNfpg13OCTPcGoGkOqUcu11ouHiX540x/u6x
         1UkI+ARtPKPdwBgfU1GtOv5Un0I9VRfF72Y81WlolHMEbCr7UgKXgb613Qo+S7MRDmRU
         x9AwfZgxQ4DYJm8hApx78/g9PHgzICD1Yv3BwZUSGm3LJ6C233apHVOXffkcyI00ZXHL
         4msvrioLtIcQxnDhp3MeggKq54zhowPtgTbwdP9oRUiDiwpaamtv23/pE4HyuFHcqHyF
         OJpLuvZYJjkwhwScFQh3rk0wvonHlPTW2X/hS5OnEHJwOGMzQu6cTFW6bJ6uA4yrHVo/
         FKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xprK3DO2dgIPaLc0GaBQ1orSs+O0lP1cFE8b0GoujoE=;
        b=L0KJQDi7cmPyZ5crIVdTMXOIHmxHfnKM22m+q9W2ozhGFe7yYjCQen7Xy3KRwdlX65
         WfktHQMRAKUa7RznZ31Pl1G21Ntdi0xVvNw1obng41wisXgYgGvWgV6brMKA2D5mUQgF
         3pLXeXuVs4a9GzHifOSmOYv1XIRfVM9OUIjNJPocEFyEPGxmdn5etvEIu0l50ByyNHao
         1s841DEbFhKtJLo9EVn45bJCCkFzjlckGD1qZzNrsS/mWLSMFsWn2rtfKnqS4CzqRNgX
         j/R1TCuU2LqiizxECE+Y4NSHRQflPa/G66WvRnby5293h6S2UfV+8rtADGguQzEi4Pt4
         JV0Q==
X-Gm-Message-State: AHQUAuYlFnU4QJPWRaUOpQd+TWTQdKYSpu30sSlXA21FSl8BIYhGf+hf
        YVkqxzrZc5PNt21Zor/VqTLJaciueVXED0BYQOJGd4bt
X-Google-Smtp-Source: AHgI3IaZJRCdPv9e0lYFbyLSZoHd/6qeVuPeV575vqPbeaE+E8lbry260xEqNKNMK603nvah/YuTHjo566NhCC+t9J8=
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr9547289otk.279.1549578736731;
 Thu, 07 Feb 2019 14:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com> <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
In-Reply-To: <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 7 Feb 2019 17:32:05 -0500
Message-ID: <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
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
>

PS If you change
flush_work(&keypad->work.work);
to
flush_delayed_work(&keypad->work);

then the Coccinelle script works correctly, and does not flag
this driver.
