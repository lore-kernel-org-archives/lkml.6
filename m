Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWJ/8YJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEC720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKJCEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:04:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43614 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbeKJCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:04:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so1728129lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A/yPq2X7AyccJgTcL0VX7V70idY2rklOuaf5NWHei4U=;
        b=EWJ/8YJs7bVEDjw6K+9Ln82XEmX0bm0pb8kKZ/59P0cvq146f0+LKi2jRQQsZPndR6
         P++oykVYlzqB7VBFIHmXE28NSZSiF6gT0/1RL8PTrh1AFJ1ZXqTwILMuDXE8aHRiW2PJ
         jT20HyUquseedgnvoCyK5MQPTo+WZHVy8u/SjxkwZegTFTQAgiVqkDS1fsrJ9KrVGHuC
         anVPV8Pt5wIAPKVm2fMLm6XT2L2v01LmrFXvnzEVL9MGV86Y3FuhyBAP0vOmS7eHYaa3
         ATuKzU27/GrYfSHN1nn/YJRSakxiv4m3EP4Ql7DSsPQ9jrk8gn8lK24fZGczeTG+o8fk
         6iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A/yPq2X7AyccJgTcL0VX7V70idY2rklOuaf5NWHei4U=;
        b=Qt8o459u9IHxWzdu8DmsUiUpSBF/WHwJaxL2cUI3SbeN44Xx63/7r7pFAE+PU0b2PQ
         gHJ3hNykuqA/04CA1PvTm/2fF4z0b6i/N5MRolJQ6XHfnjOEjaq3HspvRUaCiaNm21iG
         MXhzxNY2fGH6/nZwMklR455gxMXJKC1j1/uX+66aCdD7aMwJ46T7XzLVxj2RgqNudz0M
         gEX6bXEWDg0UeHR8UB13iUWlUsp+j/hw28OCm3jIuak/w0IttmAHoz7Ptf1HQY/lUhIv
         5bixdS71BQqcLSv8WBbYlN9hGf/qnd/Ii66qknfCrD2kUdUYC5Zy5Lyln1ryJIUZ0MgR
         wsOw==
X-Gm-Message-State: AGRZ1gJvhlYpNGI8YjoJul2A0xvvfpgQOB+p2wYul/uVel1q4H9DnK1V
        A9D7gh8IHZx1MG3Idb3bIANC7woo40Hcfz9vofPw+Q==
X-Google-Smtp-Source: AJdET5cwgdEVVliyunj8iUr0e5fGcpBObblCOr0KtU/0DJZLd+dujEcg+527iAyBY/MTKsrTU3pCVDFauZ8BbYZa6Uc=
X-Received: by 2002:a19:1cb:: with SMTP id 194mr5803999lfb.61.1541780577011;
 Fri, 09 Nov 2018 08:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20181106235532.171646-1-tkjos@google.com> <20181109123204.GA11583@kroah.com>
In-Reply-To: <20181109123204.GA11583@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Nov 2018 08:22:44 -0800
Message-ID: <CAHRSSEyRwXdpGcUxT96zq6qwBiiNv3e6F0=vnEi-LfoU5gWb=w@mail.gmail.com>
Subject: Re: [PATCH] binder: fix race that allows malicious free of live buffer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, stable@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:32 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 06, 2018 at 03:55:32PM -0800, Todd Kjos wrote:
> > Malicious code can attempt to free buffers using the
> > BC_FREE_BUFFER ioctl to binder. There are protections
> > against a user freeing a buffer while in use by the
> > kernel, however there was a window where BC_FREE_BUFFER
> > could be used to free a recently allocated buffer that
> > was not completely initialized. This resulted in a
> > use-after-free detected by KASAN with a malicious
> > test program.
> >
> > This window is closed by setting the buffer's
> > allow_user_free attribute to 0 when the buffer
> > is allocated or when the user has previously
> > freed it instead of waiting for the caller
> > to set it. The problem was that when the struct
> > buffer was recycled, allow_user_free was stale
> > and set to 1 allowing a free to go through.
> >
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > Acked-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
>
> No "stable" tag here?  Any idea how far back the stable backporting
> should go, if any?

Sorry about that. It should be backported to 4.14 and later.

>
> thanks,
>
> greg k-h
