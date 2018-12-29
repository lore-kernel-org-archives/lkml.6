Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DA218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="POdfCrQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbeL2EpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:45:22 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:40795 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeL2EpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 23:45:21 -0500
Received: by mail-lj1-f169.google.com with SMTP id n18-v6so20097632lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 20:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dq+lfuIWh1P/Gp4hYiThICEmHXTujA3lNrXKZ1foSVM=;
        b=POdfCrQ7UE0Y2NTbxp161XO8XVymfUYDB/9i3WeYY2StQhKxSXYKTyKMdk/JZKtoGs
         6YiDm53DxXjVZ7ijwasBtP7eVg8Gq0T2kmg3Yz9BYKaSU+V+tmh17C5My1EAgclQ8zV1
         G24szgPzN4eCeskjAVvLbK5Z/wqTZaMDYQ5rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dq+lfuIWh1P/Gp4hYiThICEmHXTujA3lNrXKZ1foSVM=;
        b=PW661MwM+j/i/Q0QPuyr7YdHyP7JzKw7O66Is1z2JTvCEQh7cElao4c4mRF02l5QyB
         QL+l49S67TxidPdb+93o0u5+sa1SdsBz+cQDcubb66lIV9SDgkHlk+EY89la1A3d7ETi
         caNZqgpSaOEiHn9gGaSYcyj8Vv4ZgXP5PSNigiKFpKIH2ER7NuQ+newoxVmvbmTCQrR0
         rMKYfZQlpOna3u5C0oxRLJijU2HnGKn+TvMuH9qxBJKXmawvznyye/Yu/OuaQ6fApdjI
         70kzo/WHeKVzDjrU/n43wt/upO0AaSh4HpcDJBDILmJ+dH1NGyP552i389cOOUQMKTSW
         0KJQ==
X-Gm-Message-State: AJcUukecSrPlIEyEqe9XItV0l0OGuUyPyZ+0hVq0H0QQrS+Sz8lN1I50
        ONw7x35U1O2wjeQDLfg1NTWKdHYV9xE=
X-Google-Smtp-Source: ALg8bN5MoYYQGq1XO+phKXjz5+/jwkHAuXD57DhoA5BzSnX8g7yaawEuAndXzXpehhaJOFFqgXbc4w==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr16737041ljr.91.1546054789342;
        Fri, 28 Dec 2018 19:39:49 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8704274ljv.1.2018.12.28.19.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 19:39:48 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id s5-v6so20012614ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 19:39:48 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr17349302ljs.118.1546054787800;
 Fri, 28 Dec 2018 19:39:47 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812250652420.2714@namei.org> <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
 <alpine.LRH.2.21.1812291406530.29722@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812291406530.29722@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 19:39:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
Message-ID: <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 7:11 PM James Morris <jmorris@namei.org> wrote:
>
> I do this every development cycle, after requests from security subsystem
> maintainers to sync to -rc kernels.

Why?

A merge should have a *reason*.

                Linus
