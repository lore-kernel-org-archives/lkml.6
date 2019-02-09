Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2FC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA90E217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDAZophP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBIBos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:44:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40427 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBIBos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 20:44:48 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so13771518ita.5;
        Fri, 08 Feb 2019 17:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ll6utr+E4KfSWBkxlzzCxCgAe0VO4EUDQW3TXLdDpGY=;
        b=MDAZophPccpEBkwjEu0yNdj8ZjsQxHZoRWnzwamVRcFu8r7Ig0NhQlK0YvmzjRF5QR
         TgcKGXaP4ee1P+S/a0rQ2+7UiyxnPbjp7wIKXUfbI1A+R0bjOHRwHykEAbVrKlZ5XMRy
         lW4dGvuT+IedIGdh5nShDzxnMDdGO0txe51ksvaZbMsLRx23d76MnlG3BBi4Gmn69thl
         xWzvM2aGsPw94MO+MhX6e4G6gJeopOb0pawYb13EVs+xmYELU+XgOdMRl1pmrIiKuJsU
         tlFuRb0FOFESQgKh3xQyw6O3xR2F2JKb17js6wJUSX6C95W2N71tiA5RCxZ2f4L4Gh8H
         cqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll6utr+E4KfSWBkxlzzCxCgAe0VO4EUDQW3TXLdDpGY=;
        b=H7c37JpxJhWgeBxeIkA7IGAtIG6D8Afn7nmxJDYkw4ymtMHbrq7EyZlKIvkLbCDhbl
         O8ZwcayKALo4xVI6JcDJV7wf90DVnoweP7gZM8wvlKUH+U0x4r9fzSM42x1agNKkPRo/
         dt80S4t/uFDQVkVCx9eJ6rlszInmAoKOqHk6M4a7/4Sq7CQaOLlkK2FIM9whx+SZaO37
         D+EhDc9fxLGm685Af3uqwy/Whd//rGda8a9MNUFLpMz0lur8Qru7KygsBmzknQxQdxgg
         oLslt6Lc4KXZxq5uKLZhLICEjW6nKAAhnG1QOrtbs4M2IkSfpeJBvHN9Lr3JMxOjdneE
         hrrA==
X-Gm-Message-State: AHQUAuZpsXJsOP+ZiOuOFJVeAeJ6GMnTuOEcgoEotSNPBF7Qa+qFxKgE
        OvZI3+u+0AfhebZgMTJur69wO9iZJ7TgK5JMo3g=
X-Google-Smtp-Source: AHgI3IY6QR0TgFBSRnx7k50PrdwZjR9n6uuI2e6b4PsPo9m4Lv9EuBSpIZeO3O5wiWXMtobd9tOzC4xAVsLdS+zi4Xs=
X-Received: by 2002:a24:955:: with SMTP id 82mr788760itm.58.1549676686827;
 Fri, 08 Feb 2019 17:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-13-deepa.kernel@gmail.com>
 <87r2clku4j.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2clku4j.fsf@concordia.ellerman.id.au>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 8 Feb 2019 17:44:34 -0800
Message-ID: <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ccaulfie@redhat.com, Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        cluster-devel <cluster-devel@redhat.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You touched powerpc in the previous patch but not this one.
>
> That's because we use the asm-generic version I assume.

That is correct.

> Would be good to mention in the change log though to avoid any confusion.

I'm not sure how to do that now. It looks like the series has already
been applied to net-next with a couple of merge conflicts fixed.

-Deepa
