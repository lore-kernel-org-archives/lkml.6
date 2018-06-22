Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F535C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C116423F2C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lZl4cjE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C116423F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeFVIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:48:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35903 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFVIs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:48:57 -0400
Received: by mail-it0-f67.google.com with SMTP id j135-v6so1919133itj.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TYZ0sHkkriaPb0Nz7y/VYBcI9cTCYncUNwoFDQK8/Eg=;
        b=lZl4cjE9QPDzcCLltck/YCvYnMs1hOL6IiNC7OLMaGo/78tkZwJiKfnGxILnGSfonL
         jir7pPwv7RgXwfl257rR+IElchuLMtA45+CgHkJ6y8qfcQPFD9R8p4lTZi09WNr8i1Cy
         t0hWl/7xww+WE+qZieOL7SFw4wcROqadM9n2soC/OcibNGF7fjiTwpFqVAidg7zYEpBc
         S6tnPuF6JP0bWerLE62U0wWO/raAdcoqx9sOMCTe/5uzUYm5p0gmxh2vzAKN3A89Ds5N
         Helb45WAfbidBvCdMJbp0bFl2cnMq8KxHjrQO/CYOCYK8f24SS54leS2j5LWfLReGt69
         vgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TYZ0sHkkriaPb0Nz7y/VYBcI9cTCYncUNwoFDQK8/Eg=;
        b=NeL2pxU1DXTHWztRPjrzO2va9XKB/nKBgfd7q7PO/h47sVfj4Hv4OwjfWIkc5q8EcY
         /Y4N3B8gow/i1K/Sd3oC/0xVm3gW9C/ZvfdHpZhHjTJUcIDrt8T+Hx9dyPf7l9PwQZ7c
         itVWlZWMhcqATvSufYrOZ6L7cxEsLAuec3muZFzKBnSUmev3XSCv70P06LLELp7eybDR
         0XFnv5F6O5l4gQx8QXUCKoVWXG/z9vkFJOZ4UZgoeuJOZ93HUbfGOp6ZjEllDrkaUKCx
         TMPSWL5Pi5FS4m5obu0WuQXCIityVzvb9qR8ODvNJbgayNCbhLzIE9Ha4AYE/dG1jeZr
         uzPg==
X-Gm-Message-State: APt69E2n/Nv2uqxgQwXY3ie8HFIt9gA25z0oHC+kfEjgQFl19B6M6Lyu
        MNsFxUDwGTRhXtOj7hIPgDqAhesD1HU//9vzENjlKg==
X-Google-Smtp-Source: AAOMgpevvw7gDzLlTTFEADoDzYmDS9NF8Atp7xObsTuNex+CeQM/WYTF2niMFOamBpXEgKqPqPLe5XPGlM5Z9MIrAVs=
X-Received: by 2002:a24:7a4b:: with SMTP id a72-v6mr748450itc.123.1529657336721;
 Fri, 22 Jun 2018 01:48:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:4642:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 01:48:56
 -0700 (PDT)
In-Reply-To: <20180620232937.GA177510@joelaf.mtv.corp.google.com>
References: <20180620005735.219840-1-astrachan@google.com> <20180620005735.219840-2-astrachan@google.com>
 <20180620043200.GA10888@joelaf.mtv.corp.google.com> <CAKOZuetoYikhAz1c6NuaVjeU_E58hbH7wMsDUKCYWqb63ESPeA@mail.gmail.com>
 <20180620232937.GA177510@joelaf.mtv.corp.google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 22 Jun 2018 10:48:56 +0200
Message-ID: <CAB0TPYGfE6p-avP1BknP62EHz=yCXfRytzd_isuVBmSX5tZ+Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] staging: android: ashmem: Fix mmap size validation
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Alistair Strachan <astrachan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 1:29 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> Also if you look at the kernel sources, there are dozens of drivers that
> check for correct VMA size in mmap handler and fail if it isn't sized
> correctly.

If that's the case, we should definitely do it this way for ashmem as
well. Since its size is fixed after creation, preventing anyone from
mapping a larger size seems reasonable to me.

Reviewed-by: Martijn Coenen <maco@android.com>

>
> thanks!
>
>  - Joel
>
