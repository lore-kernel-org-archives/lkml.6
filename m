Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC822176F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="X6+mPgO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLXLJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:09:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50359 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLXLJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:09:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so10948951wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RdypUHtVpyrXKR65bVS28+3XoOEuCJBu3A4odbUwyMY=;
        b=X6+mPgO38FcDxDSKvxTsDeK5mfP+qCl6zFTz5tJ5ih/4MJS9IzIX4dbbXRmccQLT+y
         N3d1gDxPRXtC1mogj4m1GLOidk+RPCOAc4Gu4x82m+Jzstf0NOlh4pRcjYJQTIsLQvZn
         8aYyW7PDELS5tw5omp0j7TftwPefKMg21wxDVxRnQkcOaryfM0CWGNOqjG7Nmc4K1nlV
         YrC9/sUjM8xuUxWWZtY+6Y6CR773JqMqvB9dDa/ldRoROwM7KcT2bVYutpe67YzzLG6L
         aTArFw3T4guIu5H57Aqr/y1NFpoZlPa+1soTqLL989SftVfe7WkA9bOQlHqfC5rV+fF7
         u+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdypUHtVpyrXKR65bVS28+3XoOEuCJBu3A4odbUwyMY=;
        b=WLY2qADoXeuSvXEKcQTrBUJnA6yluGMplOzZNNzY0NNKsIiYlZacKYLV+jDr8gIQAj
         Ws5XVl3774gagB0vyh9ZwMS/fUrXqOTLxDRFctz+fxVgMWPohyHl51qLHpB4BfhExXFA
         N5OCDyod+EwqoK+KnBy7ICL5pKOpMBRCq1JMlBlkwHOBJIOSkvnv1xIu6dgFce2XVmV/
         PSeNnRZ//sorHMKfWjYor93NRU5yhBPCGVoXYlNnwVJKDDgxM5PqWCp8yNJ1rUvllqZl
         lraelIqhbbZQxKeGVxkwd3MCQvYQ//5OkkUPpBKnVOOa3it75vALIwGHGLQS/6D/Pn2U
         mczQ==
X-Gm-Message-State: AJcUukeRf7pLb7BY45WTZhK+sCdeAkJYwPx5EqWxIEXXlPJ2bDthJs1D
        ZX9NUvv2qaOEqrywKO1FPfSyCg==
X-Google-Smtp-Source: ALg8bN4gGrTRwNOwGwrqICDcsFSrEAH68eRhY+NvGA2UFs8xjv265q7/0ZWk0urQdg2wUhAwHQwCPw==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr11999507wmq.151.1545649784083;
        Mon, 24 Dec 2018 03:09:44 -0800 (PST)
Received: from brauner.io (p5B2A6FBE.dip0.t-ipconnect.de. [91.42.111.190])
        by smtp.gmail.com with ESMTPSA id f2sm15758811wru.14.2018.12.24.03.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 03:09:43 -0800 (PST)
Date:   Mon, 24 Dec 2018 12:09:37 +0100
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1 1/2] binderfs: implement "max" mount option
Message-ID: <20181224110935.cop4v5kfcdkemtwo@brauner.io>
References: <20181223143550.10672-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181223143550.10672-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 03:35:49PM +0100, Christian Brauner wrote:
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

Right, I forgot to ask. Do we still have time to land this alongside the
other patches in 4.21? :)

Christian
