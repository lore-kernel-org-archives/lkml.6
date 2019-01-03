Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD218C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6EA20578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="clyVUXEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfACLcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:32:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33476 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfACLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:32:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so22980277lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gI9xeQSjrTeaGF654imH4ePr5Pg1QGO+c6TbOfTNe0=;
        b=clyVUXEN+2/B7Bgxjv7QUstXEpjsTToGn6sfYAwcXfEcAKrndzETKpq/z4O8cYlGk0
         kZOMpwREnsFmkr3XTH7dooEzEVciWkTA+HjM9ZBZ4RET/J0AIQGjxlMCLNWB4o5gxHfM
         yk05QnY8xyB/HkWIhKCj3W3I/aguEESWxmqnFyVS8Z+N8y8tE3x2Hvi0TDHlw1pfUONG
         x8mMPinzFcCM7ojrwcqilrJizcdZrHk9gPLgmqPuqhK9zY/cK7KFZmed2ms0NEvLo+ZY
         0pmxqAn9lzsb2/X92KxrYfNQoBA4qba+gNNlosMZBqRMOWMt9bgC6J+TuPaz7JJoBW+n
         Y7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gI9xeQSjrTeaGF654imH4ePr5Pg1QGO+c6TbOfTNe0=;
        b=FtI6bJMixNVn6OAWZhHdSPbRuEEA6fshrUgg1/Eipmm7zT+ODaiqVoG6Q0ikDKWJxX
         9BIDRdIj+yHqClkABi3d3Eqv2RaxEuz0ZG6teE+f1o5pH/BQUWza+yErUlzczfUYrLFv
         TvxeA1a86jjvhQFwzYcuWgAPmAs1eC22H5j81oUzOdW9RSJU9fhPp/KseZqKjskgEP1v
         1OHWRL2hXsco2qq4UsypaT2eStM0jhZGo3pEX3zQ0BFnUSVGMXhlonaAh+KY/iOfZs16
         XYKmp8P9j2kTZUpWOOjSG3Lkh6+PVddK1bTvHBnQd26wmXwRA2vQTAIQJMU+D9G7u9+a
         Q7fw==
X-Gm-Message-State: AJcUuke+JxAk6iOyf2JLDD85ngVsMfDuLGmzzo+pfTwqAE/j73AR1fiw
        NOlM7NKNygKWAcITXYtPegUlnNxGEZGmVBDHkXBoUg==
X-Google-Smtp-Source: ALg8bN5R8r9b1Lm/rnAV4c5LtlbwmqQsOmfaYiNUu2apkFOweTCz9poqcAtz3TfpDqeGJ9ngKEP6VcQpl2xg3tXjtLs=
X-Received: by 2002:a19:2906:: with SMTP id p6mr7190641lfp.17.1546515130827;
 Thu, 03 Jan 2019 03:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20190102113219.3716-1-christian@brauner.io>
In-Reply-To: <20190102113219.3716-1-christian@brauner.io>
From:   Christian Brauner <christian@brauner.io>
Date:   Thu, 3 Jan 2019 12:31:59 +0100
Message-ID: <CAHrFyr5fOXVCakG6cU8FWc2F3cR_bL2xftZ18J_XmvyiK9Yzxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] binderfs: implement "max" mount option
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        linux-drivers <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 12:32 PM Christian Brauner <christian@brauner.io> wrote:
>
> Since binderfs can be mounted by userns root in non-initial user namespaces
> some precautions are in order. First, a way to set a maximum on the number
> of binder devices that can be allocated per binderfs instance and second, a
> way to reserve a reasonable chunk of binderfs devices for the initial ipc
> namespace.
> A first approach as seen in [1] used sysctls similiar to devpts but was
> shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
> is an alternative approach which avoids sysctls completely and instead
> switches to a single mount option.
>
> Starting with this commit binderfs instances can be mounted with a limit on
> the number of binder devices that can be allocated. The max=<count> mount
> option serves as a per-instance limit. If max=<count> is set then only
> <count> number of binder devices can be allocated in this binderfs
> instance.
>
> This allows to safely bind-mount binderfs instances into unprivileged user
> namespaces since userns root in a non-initial user namespace cannot change
> the mount option as long as it does not own the mount namespace the
> binderfs mount was created in and hence cannot drain the host of minor
> device numbers
>
> [1]: https://lore.kernel.org/lkml/20181221133909.18794-1-christian@brauner.io/
> [2]; https://lore.kernel.org/lkml/20181221163316.GA8517@kroah.com/
> [3]: https://lore.kernel.org/lkml/CAHRSSEx+gDVW4fKKK8oZNAir9G5icJLyodO8hykv3O0O1jt2FQ@mail.gmail.com/
> [4]: https://lore.kernel.org/lkml/20181221192044.5yvfnuri7gdop4rs@brauner.io/
>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Fwiw, once this lands I intend to add a binderfs.txt file to
Documentation/filesystems
so that we have proper documentation too.
