Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7146C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpQuiMu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfBYOdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:33:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35036 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfBYOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:33:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id p19so4601183plo.2;
        Mon, 25 Feb 2019 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQ9r2RBZ+85/ImiAgClXdYPtPzx0nYYgw1W6XY3TPJE=;
        b=qpQuiMu6xDgyxheyI9MqQESmWGAMWuDJU/A+EjNMCRtWGaLfu/7MFaASjzN6D92BGl
         bBMcvWqN4GcKPaZw3TCan9X0kIm5KJWJAiZ/IQtlaJWg4RTmRKA0kXWMZEXSrEp8LS+2
         yl16fnGnHAz+L91BqvU1xy5I5D7/uP2jnToTs+BF8kvnRhH4ovwKTbC1EaWhkITnw487
         cNSt34hzrxaik7atPE7XIecw89X7Bbww3Dl3+fmxcKqJwQuz2O3SgCZfGC+qMczHJXsi
         IVbImr8FED1CB9PsSWfDz2gYZ8ZlBQ+vrZdQrM+NfqP4brmfaLetyPdjqVx4nwIYyQpf
         jHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQ9r2RBZ+85/ImiAgClXdYPtPzx0nYYgw1W6XY3TPJE=;
        b=AHtdMPIIW8/CuVMCjx8tKwohysMHnOvmR9TKShuNVnJvhMPFXyGs7j5C4KwGYfMUO9
         TeO4e7eyttZq3fsYKJ4nuuYSEEeIcpPwVxIYSSMmfP0mcgfal5HxLjHqB1JuwAJFcDGo
         QOYBNqbBxLcEWws+hLytlUbvc3tH94M8YgIyn8wOeyt2HD0bXncnFtYNzvd2r7zTqckS
         /mQ5GMEg6c2/2iSvCEOvEs4RA+etISyIvVOz/rfBOfHV36YV+oAqU7yADAiKHO+ph/zR
         jF5jXgGjonmxSIMhF2a8aCmKex1ygijacco+0dVba85ocZDgT5/7v3Bkgiiu2RxVaXTW
         yo6A==
X-Gm-Message-State: AHQUAuaVBAGenLSGhvS9yNVNtk9drdiIjhoOGEkBqQ3JrZlFpDxXKgu4
        97lqegOHcIHzMdF2lNFXq4nYWRJWYdqyPaW9IiM=
X-Google-Smtp-Source: AHgI3IYvwvRjqb3V907OFLoy6yk0BZ+YSuQHd1W1XE2o85MwnPh733Onq3PQeXRPrW12Dz7QtXwQRXeKMXCxANf54mg=
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr20108458plb.172.1551105203242;
 Mon, 25 Feb 2019 06:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20190225141214.4848-1-Tianyu.Lan@microsoft.com> <20190225141944.GA13067@kroah.com>
In-Reply-To: <20190225141944.GA13067@kroah.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 25 Feb 2019 22:33:12 +0800
Message-ID: <CAOLK0pwRwSnX+r1sicky6RmiKZwF3W92fSNEQgbijvi5NG0a3g@mail.gmail.com>
Subject: Re: [Update PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 25, 2019 at 10:12:14PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
> > is equal with how many entries of union hv_gpa_page_range can be populated
> > into the input parameter page. The origin code lacks parenthesis around
> > PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixs: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")
>
> "Fixes"

Sorry, fix this in the V2.
-- 
Best regards
Tianyu Lan
