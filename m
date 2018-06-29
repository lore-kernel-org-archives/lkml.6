Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278AFC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75BA27F77
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KIc+2sRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75BA27F77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966326AbeF2N5B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:57:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37486 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeF2N5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:57:00 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so2985970itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pm8pMmSvPR0bMAJEgAosoyN1NvjoeiWRfduiOQBmCh8=;
        b=KIc+2sRNRw9XIVlfZTB0GMJ05a2vfNcaSFd9SJE1FdJQYKtTY5i16UXfcMynSL413Y
         p4r6KWIZ9btsqXMfsJfoavjQKdFqFIKuaa5pX88bKDtx46eGrZW7RVrbO01uOdLqZKGZ
         Dyd6tA7NXMB99pRUdlAfIgtblWBz/L/6HffP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pm8pMmSvPR0bMAJEgAosoyN1NvjoeiWRfduiOQBmCh8=;
        b=Z9qrZHGfRfKnldVVn94nRLEbdhvRWZi8lOjFCrW5lBzAQSG+XvEEAY6ZX5aNBwM1E4
         9ixK4miCaB/xxDwGx3LYuslXBTNlvzfx0y0Br1FVM/jXlS7Hl9qR8UrkemY5qPVA8D0y
         SEy7S+HRfG+R3+hK98KpCemSnrLn1sYMQpmB8KKIYOGXKGVqrsIkZV+nDQ7AHS9+PixB
         xZ8aohbteBK8kAGBtukdGlwqlQNppHx2/0xqfcvtBidsQ0cz+qc4Nff1DLfqEaMkqQj3
         kxltFJAtvOmRyUdpDYW6JQAu9RoGE3CmyKNDR8Rer784k3PTZ9S8+Usz15kcVuDvrkOd
         Hoaw==
X-Gm-Message-State: APt69E233UEujesGYR8yGJwIsG1Ow3+3pgkCFwQWBMRb4Lo9Z2lB+VZE
        yMvWM0i++XJGqzlPRma8uVLKAotiXKIYbc8Ra8c=
X-Google-Smtp-Source: AAOMgpclykOmbFQPgVW42N89nki4SCfrkAnE8nhk7TaboUhbDhgtWr+qte5P4AIWhdQ95k71FPaNyY8G/HGgviMFFJM=
X-Received: by 2002:a24:3c09:: with SMTP id m9-v6mr1760452ita.113.1530280620024;
 Fri, 29 Jun 2018 06:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com> <ac64e45950c8e3df26fd50e7b251d5895c1d2201.camel@kernel.crashing.org>
In-Reply-To: <ac64e45950c8e3df26fd50e7b251d5895c1d2201.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 06:56:49 -0700
Message-ID: <CA+55aFwZG+wWwRX-FOgQHwt3eA76qgKb0W0sRGSd8Ug=szr20A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 7:22 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> This fixes it by instead doing an explicit kobject_del() when
> the glue dir is empty, by keeping track of the number of
> child devices of the gluedir.

Ugh. I was hoping that you'd just do the "only check duplicate names
if actually in use" instead.

This patch seems to make patch 1/2 pointless. No?

                  Linus
