Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73298C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2ytwpH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC0A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK0D2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:28:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37101 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeK0D2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:28:10 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so28677929iti.2;
        Mon, 26 Nov 2018 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fl71CfqvxPlk7nHaasK0HbIEsS77+OcwFnQnwi9yvbQ=;
        b=R2ytwpH7ZMdFoqWxj8w89dls+TsE2oQrFXtNhtVBpTQZoGNuxEeJg1zc9Qb153v+Za
         8rRmxqF4QrPAriAk939QtY1MJ/xzg7T2komSrxI+VAGkySYW7GnVz68ypJXR7RlIEbfI
         sAMCa6KVeZrKLSJaHo50VYlyBYJc9wQTowgSD/M4lTlSzZ48/kK+wv8GXGqjg5/s/1Om
         x9ahNZbrPuoih7vp3u62RD1q5T1EPUjcZ21R/9WmeiEGiyZPSgFAZmZLJlMQQdzco1M3
         5UarxnMrVOhGT2ahvlxqlZeMp6VcQ18zignZXs9uPuU4kHBzCPZ6Yk1XYhFpd4ladUSm
         /R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fl71CfqvxPlk7nHaasK0HbIEsS77+OcwFnQnwi9yvbQ=;
        b=JXvzambYGV/HX1xbTgUjNHq3UgPWeljfhOi6b3ORZDhmZ6kItoMU2Ur65hbrs4tqye
         A/yl8vXafVVdv16CdMh3b6E++E7WluYMJId/CJFQtqlF0qrj0HQpiV37oSg4tHmSvpOs
         MAo37k1+9/epuPW2CPbAEg6s9C6BBoe3Mx8aTOL/Id9YlqaxlMM1QMpBp25xR5P0Zx7Z
         +CzEWtL1HVm45VqrGLdcg7awFVN74q8RMGJ5zRZkkn13gyY6Yxt8wTvmH+VkFJkTHDNI
         xVw0XwXTonINifX2KGaaeG1ivO95sp4T0oeMZGTBYZR25DmTLna5Vn10t4BKe7P0w/ec
         xKyA==
X-Gm-Message-State: AA+aEWYbanoo4tOt3zdUSKDOorp8uzKO9bsPxxTg+h5wTnSFDXG82eF/
        sBXE4afigec5hecAW6JMcnBOpWHZULePZwLydo0=
X-Google-Smtp-Source: AFSGD/UBZl4sNLDeAHLPtqC6FHZL58hqqKrWrew7Pl/2QvSn11oNvRMQSvEURJXwY/Y2smsbNy88oqivjTDjvsqE08w=
X-Received: by 2002:a02:781e:: with SMTP id p30mr8979014jac.85.1543250013402;
 Mon, 26 Nov 2018 08:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-7-deepa.kernel@gmail.com> <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
 <CABeXuvrV+xN3O8BSmJ7bGR+8uYmtrCk2YL37HQZrBSO8YSvzJQ@mail.gmail.com> <CAK8P3a3UVOeaYqwOiAMrziVcY6GpbCkDRGGAgFJKBJnB1e=v=w@mail.gmail.com>
In-Reply-To: <CAK8P3a3UVOeaYqwOiAMrziVcY6GpbCkDRGGAgFJKBJnB1e=v=w@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 26 Nov 2018 08:33:22 -0800
Message-ID: <CABeXuvp5KAhJmU69G54G1LAB69otk=svpuaV8vra_iuHa2VsBA@mail.gmail.com>
Subject: Re: [PATCH 6/8] socket: Add struct sock_timeval
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     willemdebruijn.kernel@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we want signed types to keep it closer to what we
> have today with 'timeval'. as long as linux/types.h is included
> first (it is).
>
> Between __s64 or long long, I don't think it makes a difference,
> so let's just go with Willem's suggestion. We already rely on
> 'long long' being exactly 64 bit wide in 'struct __kernel_timespec'
> as well.

Sure, I will change this to __s64.
I was also thinking we want signed types because it should be possible
to set system time before 1970.

> We could however debate whether 'sock_timeval' should
> be visible to user space in linux/tme.h like this, or if it
> should be put in a namespace like '__kernel_sock_timeval'
> to ensure it won't conflict with user space headers defining
> a type of the same name.

Good idea. I can rename it to __kernel_sock_timeval.

Thanks,
Deepa
