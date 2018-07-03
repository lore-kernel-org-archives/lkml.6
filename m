Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D31C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049B8250BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n2NoOr1p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BhPqNWwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049B8250BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeGCAiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:38:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34139 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbeGCAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:38:07 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so80697ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Hn+/LDj3lvCMWDNOGaCKR8EwpywY5muhww9sg6Q27wY=;
        b=n2NoOr1pZHFq+QyCga8vsFcnaFRB13y0xwgMpcM7rcdzpGCAtcosXnjIweRWWWkwTr
         C4meNFIAVZ/9TKqDsW5DIZOd2xVh91bTyUbpWRcGHur/t0cP3orZDC+W0F7BCh7g+WRL
         +Z6chuiIVzI8zZWc7k1VfuUTjI3ChX0m/Ie24sMMJ7Ja4i8VXqbtOFq6ltw9lyNSYucn
         9N/DV7IrZZO6m/jHOU/2tbf9EfuC0NFZnOsoUw7/7I00HAkj6puUCvtPTpqcriDe4wb9
         MbaSS40JosSy6PYXZG+yIX1E3YRYOxeHTRWB579vy+5XEPf/5Yq/ivOc0X4h/VkL9+Vn
         rdaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Hn+/LDj3lvCMWDNOGaCKR8EwpywY5muhww9sg6Q27wY=;
        b=BhPqNWwInt1UyXNMrqih6VWvoEvphUg9t8zt8u/PbRoHJvC5+k99t8UmOsRf37nZkL
         wl21W4aUIi0V6CuN2OKbXNcXBYLGXqVVDguLzoRnqXvrRqENVxOpCMKzOc+4erFbKYV7
         H6twYLIZE+ItSnd/eq2I+99DlFB2kjquFZ3yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Hn+/LDj3lvCMWDNOGaCKR8EwpywY5muhww9sg6Q27wY=;
        b=Wlt1NQKRc+GEGJ0oezj3JKM8MptGxx0Vu8EPHYctnFRK3de5qB9X0LYLpekj7gkE+w
         NQfMebRgcpbOQHIRwvojcNAnnZDJynSlyR5++HqY3r59u35XtA83l4dA6yxjsjK+CnK+
         l4xYrXM7LgZ40bR7OlCo0iUP9HICjagAs4693M0DVnakpKelvf+lR1DMBqA/lnYj646c
         lj2ZuJZTJz+8QyCDEQMxq7Tgip62nWD2NTxYxPeN8nVkGzRMDOq4Jdq6uTRkZO3S2QH+
         AbxshrMRPBYyH37KYYUj/DLnQsjEMC9Isn59793/0OGogGFabM92Ml7BAy4VC1szE0cV
         ybnQ==
X-Gm-Message-State: APt69E3OODCmcErolX39a1VURBsZdveKPykP0tYO3fv12Fq7oqm1fRk3
        4tfODhyX5FD3TosHS04wnF9Z0ydmiAqZXiHOU0iy7w==
X-Google-Smtp-Source: AAOMgpdX4++2g0uBLd8k0aRfUKj8a7Ja7JyT3MTGlY9Zd566cezOrEkqqgRVqe2TabzFkah9MCEDT70tvkkHjgzUXQk=
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr7074804ywa.416.1530578286868;
 Mon, 02 Jul 2018 17:38:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 17:38:06 -0700 (PDT)
In-Reply-To: <20180703002826.GB2438@bombadil.infradead.org>
References: <20180703000907.GA27014@beast> <20180703002826.GB2438@bombadil.infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 17:38:06 -0700
X-Google-Sender-Auth: lBzZJrdDSc5YLh7UhgI8hx7G2rs
Message-ID: <CAGXu5jK7eKqTyto+PQmfd6uOxHRJK+LdD2cVxemVHE0PjE-0hQ@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Documentation for roundup() vs round_up()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:28 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jul 02, 2018 at 05:09:07PM -0700, Kees Cook wrote:
>> + * The `const' hereprevents gcc-3.3 from calling __divdi3
>
> missing space

Argh, thanks!

-Kees

-- 
Kees Cook
Pixel Security
