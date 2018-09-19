Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC01ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF92150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vJuYezQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAF92150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeISRLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:11:09 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44849 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbeISRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:11:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c494487f;
        Wed, 19 Sep 2018 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=1DuACcH7vmbbW7HAskMfHYlKXPE=; b=vJuYez
        Q9qs9pdxFgsiithnw4fh1Ky2yLXuQe6JTSs8K5M52V3CR5Tcbxx5OEwzJkYDlbcN
        Oa6G/mm/xIPqlqXX6P0cDJC/bIbZm/p9KitucTj/ae9lB21DBQ5b9+p5H6d1M5QG
        4EHMNgssJCp1+hf9Dl7A7V/iQY4xF1Uk6PDfqOjxHzhHcgjLHUphsRLjIlICdo7F
        6aLsKdNWC0LwzEDwAyoFb01LUjU0bDb9DvPQX7+XErxd4fTNKU0PUpnzHEgwKnzX
        6s2nVfKis5VSHTkp0qiy8Wjrk+5VBOhHvtAhRuvzGvUGi770J+LHO3niAacT9Jcc
        B//rv/u9uV8wLyrA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f6a7b66e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 11:15:57 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id i12-v6so5430568otl.1;
        Wed, 19 Sep 2018 04:33:37 -0700 (PDT)
X-Gm-Message-State: APzg51AKoWdiYYoYBQpIXv9PskY0kqrHBzxEOJTaBPenZNdQJKle0Tt6
        +/7oXAOWyMLM/L1iZh19KvkvXTctXE6AFT3XzxQ=
X-Google-Smtp-Source: ANB0VdZZVo8k6VSsWG9HgnCP6isA8rcz6O6Xu54fJfnG9OIrGX/yq3BmJP1Rv0H1QsYC92L6Xc8Zp7Vhqj9sJ2aKkl0=
X-Received: by 2002:a9d:56b6:: with SMTP id o51-v6mr17662150oth.393.1537356816019;
 Wed, 19 Sep 2018 04:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-5-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809190017050.1468@nanos.tec.linutronix.de>
 <CAHmME9oARODJsrDbcNK7A22KrTRJP945hj9+oCJtQM6OjGF4Ag@mail.gmail.com> <alpine.DEB.2.21.1809190802160.1468@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809190802160.1468@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 13:33:24 +0200
X-Gmail-Original-Message-ID: <CAHmME9qEBz3bz0i5hENwSzGy5M+UVjYXGRnWcQtVpmjEUrMNZQ@mail.gmail.com>
Message-ID: <CAHmME9qEBz3bz0i5hENwSzGy5M+UVjYXGRnWcQtVpmjEUrMNZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/20] zinc: ChaCha20 x86_64 implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>, mingo@redhat.com,
        X86 ML <x86@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Sep 19, 2018 at 8:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Subset? Not really. Both MIT and BSD3-Clause are GPL2.0 compatible
> licenses. And if your intention is to have those files MIT/BSD only, yes
> then the single license identifier is the right thing. If you want it dual
> licensed then it should be expressed there clearly.

I always thought "GPL2 compatible" was the same as "subset" because of
the restrictions clause of GPL2. But IANAL, so for the avoidance of
doubt I'll take your advice and put both.

Jason
