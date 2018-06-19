Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BEC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E3020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRJSPDPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757336AbeFSUTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:19:39 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39439 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755265AbeFSUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:19:38 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so667315uad.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cl7T09r+aPR+ac4wUzItobmTJRAlCxC0yELc1HRoIUg=;
        b=FRJSPDPUbsgaV4A+a626WkosS+UckTaatptMevmHXzwAEu31sGuNZhoYwfEewaMtQK
         SPGorJFJ38piant4TBb0Ivhpnb78+dtYPpZrd5GQcGbqAsE2g9mIr1K21evkvBYiE7KF
         8Zg0HcybcHnEe0ujTGp7Qiz+4tP9KvP26wnMHWd9JWug1WGKFZi2ETt4qKmjsTUh3UzX
         W6Ll00gTfXmQOWyjK130E2Ft+FMZ1CIDMQBNuKOjC0bT4m5DwGZmfOA2sOXd70XD2hfi
         pzB4Pae8R60cefVeekQLIECk+085a5Q+dohWxNF4bOS09z15E8bVOm1a9PehQ7czsHI+
         pyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cl7T09r+aPR+ac4wUzItobmTJRAlCxC0yELc1HRoIUg=;
        b=Dq/ejDrFicJyv4GRDw6kJN8xdTMxZTup31VvDFpGjDD4lwbytE1J0j8wH+yzji2ypD
         iDs0/g31oK0Yhtsj8QTZqjAJ2O6nAWPA3SlUlB54OjP4uVsQDAe0yHwCggTbzfv9lUiQ
         Ey4WNTCEJhjnlVt9tc9A6DLzs4IlyUxeRKdc2kjYG+eMHmycCq7azqOkMNrK8GcDoKEG
         ojjJ0Df+NywU/Aa+WeLumgmqqg2ilKSjLr//J+uOGOjVbhbLrKpgpSMC0Uti2fwODuOO
         GbmQmPZ/P0DDCxi7OLtPm9k0g/oyfTVYWG+JUHzOpEPdbssi1wQrwbVjO+hQ5xFAdUx3
         5pLQ==
X-Gm-Message-State: APt69E2MAvJzNbisOoKH7qOg+OdAgGmqtb+CrLXPEMDFGr6lYM704ZLo
        3iBondNOHwliFXoqb3wXWXQnzE9luslsmTK6Wlo=
X-Google-Smtp-Source: ADUXVKJuEvtQ9Kggj5ERcE0h8bXTLfEyaPAag/QLrn2JKx+YcKGs9B8tSua5at5+uYxdsG0jCFA0oD5HmiDGMWTAtIM=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr12118246uad.49.1529439577500;
 Tue, 19 Jun 2018 13:19:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:19:37
 -0700 (PDT)
In-Reply-To: <20180619195605.31321-6-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com> <20180619195605.31321-6-johnfwhitmore@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 23:19:37 +0300
Message-ID: <CAHp75VcnFbc3SKh-6Ovc4nxNTPLaYU9LeGNz8eCRdJficek5EQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] staging: rtl8192u: Use %s and __func__ instead of
 hardcoded string - Style
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:56 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> Changed a number of hard coded function names to use %s and __func__

Oh.

Looking at the code, much better fix would be...

Move IEEE80211_DEBUG() to use netdev_dbg() [dev_dbg() or pr_dbg() as
last resort) and actually drop it completely in favour of the
netdev_dbg() followed by removing __func__ parameter completely from
the messages as DYNAMIC DEBUG will do this if user asks so.

The IEEE80211_DEBUG_DATA() should be just print_hex_dump().

P.S. I would rather NAK this patch because it brings nothing, just a
waste of time for my opinion.

-- 
With Best Regards,
Andy Shevchenko
