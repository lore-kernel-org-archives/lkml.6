Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6667C20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyPfttIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfBFOeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:34:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36473 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:34:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so12189390otk.3;
        Wed, 06 Feb 2019 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0wVbegYsceVoy7zFUzYAMc1psV/wsSkQB6hhOsyhfY=;
        b=eyPfttIKeU3J/YKC3cpdW+xd5pEdkskzq7Nd7SI1a7wUROleQp6Cz3ER2XqiugvBmm
         zqr92keMsfzkEgbvEHGUcoA0PkrlMP1sQNhFg1XPQ9bHyA2ohSGv0W3eSYl+pVFtx7Wd
         L12m45+gyAhh1Fxdg1j8iBjRy9PKI0l3I8GuNHnvqEl101XEl5lEC8lcXwb7dBPaNo9h
         Xv9Vz9bB0BjDUrQHzZfB/xhlOJEzU5ptMZ6MmOUSGVbquOntDPKwSyvCMHquekbOZrgO
         vbZyWapFvX+fi0mKNMvo2nF91tE3Z5nIRBSEtgoRYV2NPNDLen+34KfuG1Fy3x3qyJvg
         VjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0wVbegYsceVoy7zFUzYAMc1psV/wsSkQB6hhOsyhfY=;
        b=dN27NC/KmmlRFbstZExwODWzmkM8RKc6O3EX0LdXIWNbToVruuJbLTuFo5/6xH2uKZ
         L8LwEIq+a3YH14Ae+lnaJf4dulxKNoGcagqaBUgx1DFxj2tpykK1ks8ICosCiSPCtu25
         aK2LFdiOHfLUmFmbzF33mJUWwBe2ARnh9Y5xa8o3sJYcn4Px9tko8u4wM6NEcEzGXncg
         lqwSn8gd/xxflNupxAZFuVPkZXgMWo8QhBFCZKp+zMOoDj1yZ+4h9ri2Ipt+a7e8PV2Z
         xEBpF9M2k3nJ3wONjFhMAzzaBr9jDt1ep6CzdxSzRv+egYlrEs+fJClFgjd8hf4H3Vfj
         r5JQ==
X-Gm-Message-State: AHQUAuY0qwlPqGjsIOsw/tws8gPKPcfO8v5KxJdee0BzdS4ts/GtekmQ
        26Yhn757Rpt4t6ZSZcwQmuYjzrnuyYQoGFBuurw=
X-Google-Smtp-Source: AHgI3IZjMSVC4ZWs1N5pMlWBOc81Zc0t3+tCEBHCX+p7tkTYtx0ZSfOpv/bLxdH4Q8ZUHPNGHqHpCdivPwAnV+cJkVI=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr5747002oig.266.1549463644583;
 Wed, 06 Feb 2019 06:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20190205222050.GA145676@dtor-ws>
In-Reply-To: <20190205222050.GA145676@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 6 Feb 2019 09:33:53 -0500
Message-ID: <CAGngYiXFYb8DczTL2dbRWx1pUhYhLAqRdVzXbGdG_FLY8pzHLQ@mail.gmail.com>
Subject: Re: [PATCH] Input: cap11xx - switch to using set_brightness_blocking()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 5:20 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Updating LED state requires access to regmap and therefore we may sleep, so
> we could not do that directly form set_brightness() method. Historically
> we used private work to adjust the brightness, but with the introduction of
> set_brightness_blocking() we no longer need it.
>

Elegant solution, nice !

I read the patch to verify that the user-after-free is now gone, but
obviously I cannot test,
as I have no cap11xx hardware. For what it's worth:

Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
