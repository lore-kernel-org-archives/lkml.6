Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B792081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjgVkcLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B792081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKBTvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:51:03 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:36073 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeKBTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:51:03 -0400
Received: by mail-lf1-f50.google.com with SMTP id h192so1018040lfg.3;
        Fri, 02 Nov 2018 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riH81wFiSXqgKpOIvnPVfkQ/ORNgYeRhMkBeNGSB7mw=;
        b=IjgVkcLpLjR4E2j5ZkjStpoBkrxrngTL7ZVz7Z/n0qAmox2f988vw8aLndcpCRFfR2
         ovd4yzguRZvlU28un50OGrfWCSih6nkwbwnednvx9om18er7odZeZwkcicwBIm7xzYie
         IreM6MrlD+AyGsIxOvX93T638Sc1UnjGJxfEMaKUc8LtUiZHSW3XN0/R76YyhisyTxir
         mJpofY6AopZxKFgHpJObaEOSiqVZuuIF8taox+Qxyv43NWwY4XrSYl9iFykhh9dOhu3e
         TerZ+ZPZzXeUl9KiyQ7eKHCSvtU83hjreZOBhDF7Mv4Qyf195Jx+yh53Ylghl31sC38B
         VPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riH81wFiSXqgKpOIvnPVfkQ/ORNgYeRhMkBeNGSB7mw=;
        b=r6px56OlB9o+ecyk7Z12J02Rf18bIg8PeL7Ok7k20kNjMYKsxkFbAvKSYa6KIjsomW
         8ZU+03ypMTRaf4rSlPXTwG0ar7VPpuqhp4OLdxKUJqRrN3S0p+R9DNFP/9MXMjLEwBkm
         Mwcqx5eAVeteqStZi0hJoUkLUOOdosSTC5IXQU/NGGFb59ywt5iDdp1Kp0D6mBqMSR7F
         8qeTUisRZab29r3yWPN3CPNY9m0iYTDvC8eRWclNI9++0Mqs2JZQE9iJNEc9XDupgxxD
         rl6GUo4c51bQbLey0BgJ3HRNj+t+D6sab+t2jxKedALJfwBkQIRGzrjCBykg2ZXfca7j
         5CAg==
X-Gm-Message-State: AGRZ1gLSVv7cVVPKOWnx43jYEuerm1n/dG54DZiSn19BA/JKUfhHBR3+
        5LANm6PCYGgoAfdbRKW+4VLrPhu0wRxTFWm83GVIzkRK
X-Google-Smtp-Source: AJdET5cRwBvjAOEjRZbVcrjpdVotmYdA2qG0hBVxf/CCz+lfCYold68lGKgu54rcF54YU5HJYgo8qxMQ6qcNWVQ9onQ=
X-Received: by 2002:a19:f813:: with SMTP id a19mr6364464lff.67.1541155457994;
 Fri, 02 Nov 2018 03:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181102143018.09feb051@canb.auug.org.au>
In-Reply-To: <20181102143018.09feb051@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Nov 2018 11:44:07 +0100
Message-ID: <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 2
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Nov 2, 2018 at 4:33 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Please do not add any v4.21/v5.1 code to your linux-next included trees
> until after the merge window closes.

Is it OK to move forward the branch up to the point where it landed in
mainline, no? What about changes for this release that will be sent
for -rc2, -rc3... etc.?

Thanks!

Cheers,
Miguel
