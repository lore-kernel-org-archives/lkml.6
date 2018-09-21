Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC5ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBCC2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="2SSTC3Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBCC2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbeIUKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:24:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45995 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:24:35 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4c6e006c;
        Fri, 21 Sep 2018 04:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZJjIJotgPcYGxRkVzejYU8ccewk=; b=2SSTC3
        WffvVYax8+nX8sIe+6MpEM9faELxpogtgZKNke6oFhvHkipBbRtZYHK4+XM/DGPe
        nivJRq1WsnQOxLgerRu0X/x8msXuMUwoHCC1SszbXKq9cewWodh0FkrLmYXtYaLx
        945k1k5QK2isuzKs5I8MEq32RKxeOd8eqtjSLgJbKEjuizpbGQAFli0fSMC6HfmA
        NLcXT2qk/99m47To8D4fZP7M4mGs0uGLU3v7GU7ilH0l3YA+ZWVo1j08kKSvJhOQ
        jKOQRwckMCZrYbEOchZI4xQT3yBjLEGOoyVWPsfQw29F4euAw9pZnJBBZsjmrlFK
        8n1YOOSBbBgMGTCw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2ec26149 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 21 Sep 2018 04:19:38 +0000 (UTC)
Received: by mail-oi0-x22c.google.com with SMTP id m11-v6so10331346oic.2;
        Thu, 20 Sep 2018 21:37:30 -0700 (PDT)
X-Gm-Message-State: APzg51AFRxdOLaL6d3kZCJQDtgQ11u6SN0ry8zsx6o8TsrZjxQo4OVkQ
        sS1mX6vu5dYqA827+i8HNwvTbOIUzcPCXhjChds=
X-Google-Smtp-Source: ANB0VdZ50Rxudb/uA6f5hQnJyiKDnYwuX+WN9hxRxI9/m1AsKl6Tol2MLZMBq2sAW8jjqQQ0q+Z4+xwMPfddnUbunyI=
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr617279oih.244.1537504349629;
 Thu, 20 Sep 2018 21:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
 <20180921031255.GB11109@lunn.ch> <8FA361E3-FBCB-469E-88DC-F4085BD91175@amacapital.net>
 <CAHmME9rF=FfOf-_EOB-BeT-BM=B9Q9YzFAoUimaPiM2RKb5sGA@mail.gmail.com> <CAKv+Gu-sciHeWVij8hWGF78HV_CLddMv7Xdf1GRSY+6B2yt48A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-sciHeWVij8hWGF78HV_CLddMv7Xdf1GRSY+6B2yt48A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Sep 2018 06:32:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9rws6zqA+LCp6D9i9-VYEb5xidCpZ7_HXdrQq+W2yRdcQ@mail.gmail.com>
Message-ID: <CAHmME9rws6zqA+LCp6D9i9-VYEb5xidCpZ7_HXdrQq+W2yRdcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Sep 21, 2018 at 6:30 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Did any of the fuzzing/testing you mention in the cover letter occur
> on the kernel versions of these algorithms?

Yes, of course.

Jason
