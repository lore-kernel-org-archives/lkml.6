Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F71C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951620838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIlwuxoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLFQhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:37:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33137 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:37:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so1012069ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWJi+gvVhh14j2esNahz5XLa5mbxmHqMbvRc4yIlQqc=;
        b=vIlwuxojztqbKY6QdsQ0ClAWi6wBBmfQA3KF/ZSxTDi2nl4K3WhrO36w8csUwhAS0O
         bB6zw5Dw5+lx9/NDHG3Ikf8cIiU6OkA0Qr1qX5qgMYxhysY27L5AyVkSqzWMNGp9RJdZ
         cEK22xbBQYH/kWjGLoZA0KLGOi2kCeASC1CShK3MnYXRQH62roRzK5uCfw+StpOI4/2x
         DUdYg0GlXcggQ5LS6GzzQkFD7u8511b7L7IvXjt71VNAH2KXlXB+F8UMXlfBDELiYUsG
         TdbhaemdK7rnXOEAbOgmVrdVfe/9pWV6BkSt5pdbWvbaYd/2IOY6rBXgW9otsJIHmfJt
         wdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWJi+gvVhh14j2esNahz5XLa5mbxmHqMbvRc4yIlQqc=;
        b=VuWgnKL3zfUqiaItyBGhTKx0wuMO8phGTZvYoMzLxxwYoWVxOG1LaBMKCrqA0LFgEf
         4tZQlcdMA/0DAL8eDEVQY8tkAEnY9HP71BxbEUJHyy4Auyf/UQ/qh6IOHQxtu9H6I1HH
         ucUDcPHQtmrt32rZc9sNswXCTfR4KZj455Qof/zhTY7diddMFIG/jrPTDOxsmXfjN5Kp
         D6p5B8sAGfiMuEsh+BNMDqEjTeoGFA0lma7ZPxIYdd4N4Vavx7xbJgineaaSTTpJIsXw
         iznM1zZy7c/6hp4i4G5ZPX10pk5gG5KOvOmAvPKw/kuLGiyd1Vn2gyiw+AOybGmFQrrX
         oqOQ==
X-Gm-Message-State: AA+aEWZVclxoQlXtAvxc6y2N9FBgcdbjap5YdUMp7IKw/9gmk8ZLCd9s
        RsR717wHLZMsY4TQlhDlMubRdfBzPKSwnCBN8FhcUhr6PFabfw==
X-Google-Smtp-Source: AFSGD/WGUUWF7E+abeZEHK+bxRE0RiRdoJ/Wc0HqNO+ELLbHbwj6ldjqhOPy3YL8DlA8O2Xzbe07DLq7CIeTv4gkXig=
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr6202148lji.122.1544114272500;
 Thu, 06 Dec 2018 08:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20181205231926.45928-1-tkjos@google.com> <20181206144408.GA24078@kroah.com>
In-Reply-To: <20181206144408.GA24078@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 6 Dec 2018 08:37:41 -0800
Message-ID: <CAHRSSExQzgVZdk09rxoow-OTbEq0fhgW+MgemToEPEN=TiwWLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binder: fix sparse warnings on locking context
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 05, 2018 at 03:19:24PM -0800, Todd Kjos wrote:
> > Add __acquire()/__release() annnotations to fix warnings
> > in sparse context checking
> >
> > There is one case where the warning was due to a lack of
> > a "default:" case in a switch statement where a lock was
> > being released in each of the cases, so the default
> > case was added.
> >
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > ---
> > v2: no change, just resubmitted as #1 of 3 patches instead of by itself
>
> I've already applied this one, right?

No, not yet. I confused you by failing to add the "v2" in the subject
for the other two submitted with it that you applied this morning:

binder: filter out nodes when showing binder procs
binder: fix kerneldoc header for struct binder_buffer

Sorry about the confusion. This one still needs to be applied.

-Todd

>
> thanks,
>
> greg k-h
