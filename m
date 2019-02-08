Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DEF2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/C7Ms4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfBHQod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:44:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43797 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:44:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so3518687lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vH9MF2VJ/mZsuifPIeSJXySSV33CGWujLbuBkNInlec=;
        b=q/C7Ms4c9X4XCpPkvUCSUNW5S/vcOsPSRg2vBAzcHvDKP0ho/hs54Et+IdYSgPIjIY
         38qDbbB2jwfw2OXros4obVgE3txkWeVKVh0G+RR1goz77/yBNUsQ29mLC2/BW+aH4mhy
         stLix7e5+x+4N/kB5s4Bh0sfY5TP3oAweJ5ONqX+YBplaWNNFlXlw3NvBUQ5gvvXzPyK
         RWeOzHi+hUKpdHE+4buscGCAn0PNsowPR0zgDGaEAi7szURsw07hgww/uCnfLmoGW3PW
         cbQkdY7X4IanvZR9QuhDWsNWc6LWbwUAzijemah1ZAx+OsLYe6mjPJKJ1lczSJwuBAuT
         HzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vH9MF2VJ/mZsuifPIeSJXySSV33CGWujLbuBkNInlec=;
        b=sLZCufVMEc3PAjfyYzsqjwqsmQVwaMr5VI/xuCuaPm/ww8v3pUqM+NCXklCm32ePdY
         HUl1MfE/Il8senf1M5k6o+GGwD02aPwi9awXNGQa3+2U8AmSKHzLicZX4kGHHfo0YPhQ
         TKDxBWmVc7ltaVelKdmqoJrnfjGEvhWDqP7Z+pBLg/mJtNpC0bQ5Dm9iZe7uRnzrPLRL
         mmmon2SV+I/uhiB1NUeLatRKWJc+ZnxACqQCTBhQCiE8K5MrsztFuC88AaroJFHKPAi1
         c7CSTPHTULggIxr+1Orqmr5R7hfSGdxKI1YIL+O7FF1025mDZxR3DmWdANfqqoo++Fp6
         wDIg==
X-Gm-Message-State: AHQUAubnht8wX+FwGe86FQn/L3VYQqqK2/fGbwXy5Gu4+aH6QwK4F9g9
        Z8CtsU0frUZYKyh5Sbx/abZ1ECLeKewy0YnEnEQ4uQ==
X-Google-Smtp-Source: AHgI3Iaqyu677akJUA+/8Q066YhqbZ1vEAC2F6obhyaMxM+RXxODhdxmCS4Wc8Jj86susuDSbUwPnTnkmh/fPzHf+Hg=
X-Received: by 2002:a2e:7d18:: with SMTP id y24-v6mr1953179ljc.170.1549644270685;
 Fri, 08 Feb 2019 08:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20190130224655.255149-1-tkjos@google.com> <20190208112600.GA22147@kroah.com>
In-Reply-To: <20190208112600.GA22147@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 8 Feb 2019 08:44:18 -0800
Message-ID: <CAHRSSEzEW7AfhmrUbUJnL+DFB2sU2X7J8dnnkO6px7Z7BzpE=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] binder: eliminate use of vmalloc space for binder buffers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 3:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 30, 2019 at 02:46:48PM -0800, Todd Kjos wrote:
> > Binder buffers have always been mapped into kernel space
> > via map_kernel_range_noflush() to allow the binder driver
> > to modify the buffer before posting to userspace for
> > processing.
> >
> > In recent Android releases, the number of long-running
> > binder processes has increased to the point that for
> > 32-bit systems, there is a risk of running out of
> > vmalloc space.
> >
> > This patch set removes the persistent mapping of the
> > binder buffers into kernel space. Instead, the binder
> > driver creates temporary mappings with kmap() or
> > kmap_atomic() to copy to or from the buffer only when
> > necessary.
>
> This patch series blows up when I apply it to my char-misc-next branch:
>
> drivers/android/binder_alloc_selftest.c: In function =E2=80=98check_buffe=
r_pages_allocated=E2=80=99:
> drivers/android/binder_alloc_selftest.c:108:44: error: =E2=80=98struct bi=
nder_buffer=E2=80=99 has no member named =E2=80=98data=E2=80=99
>   end =3D (void *)PAGE_ALIGN((uintptr_t)buffer->data + size);
>                                             ^~
> Did you forget to enable CONFIG_ANDROID_BINDER_IPC_SELFTEST when doing yo=
ur
> builds?

I did forget. Thanks for catching this. I'll repost with the fix.

-Todd

>
> thanks,
>
> greg k-h
