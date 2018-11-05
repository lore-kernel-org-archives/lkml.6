Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6152C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663CC2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnGHu7jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663CC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbeKFGxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:53:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35534 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:53:13 -0500
Received: by mail-it1-f194.google.com with SMTP id v11so8712030itj.0;
        Mon, 05 Nov 2018 13:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=es6sn83DsjZ2o3p3EMzKWdnO4TfOxjtYsgKkLaMwZW4=;
        b=QnGHu7jUyjhC82gNuz543MWkEKM0wLVVwXU6fqI27xDdVEc37Hfc/P6yLcoRNeFDZ8
         nnLuBi4BKEQF2fh3vBTMAUW5emapk8sNbbe20eJJ4kt8dXBX89gXdH6G0CwKolP48s50
         x8QOW3h9MfqCGx6mHXktB8jPqRXGxhWjiY7uLjnOXCiGTpWbgHX9xVYeo5Q9wgB2wyNG
         haaE/HcEBnJTvyjC3H3xLzfQBZ65NMYyYvkqrJH7HhQDWzM4Vx78cJ9I9l5z3MmKkvWy
         4wZRyVQWtM/5hfscVM6dhuL0JEi/GNtRMt+S6jxmu06bqJdZ9TCbMRe774Pie/a4zizH
         blwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es6sn83DsjZ2o3p3EMzKWdnO4TfOxjtYsgKkLaMwZW4=;
        b=DQrwv5O0vtu/RxQhjEmDObgfgyZSskE/9+qtYpAhqistDbfe4jI/nuuagMTyXL+1D9
         VuikqYe0/S2vbNqsRxXV6gggo99AH2TgCi7pTRIKgKELZNAoFIYTNVN2CgoHaYQRI/b0
         w3sN4s0nbKfYND8Vq2hCMi3bm1N4jm4zZVD61JmgNXb49j294tHTJ12Ey9iITMQdxvCJ
         iTibUjohTJ4+CEkQQmlATBRfM8WKqwU4hQMqi/dmQBM9OHXxRNmAfpExXladSqF3wHew
         KT4SM3OCQK9X7jyAsQHlbrmfXkt5qnGHORkejdwCkxycVQby84wlQ9nq/nhx+K70jtSV
         59og==
X-Gm-Message-State: AGRZ1gKP7/wnuUg3rlzc2vmETKPU0iIKdnITqtTfPYkCRfToWufcPGde
        zn0n/u1/XGt+zaE2UOwuLYOg1HxIr5Cdn1YDX9gh5bJo
X-Google-Smtp-Source: AJdET5c+zvxXMNNBsMZfbOmSZ/YNnH+GiXzvVuG0sRzbLdA2EIyWu+NoXJ/Omg3Z5/lmaIT7N7OQrpIxO5NCsWDmh30=
X-Received: by 2002:a02:4f9b:: with SMTP id r27-v6mr21812509jad.97.1541453492655;
 Mon, 05 Nov 2018 13:31:32 -0800 (PST)
MIME-Version: 1.0
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 5 Nov 2018 13:31:20 -0800
Message-ID: <CAEdQ38FckCWguy5MUYkjwhmc3eA30WXB5QNGaU2Yv8gjHvGc=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] alpha: system call table generation support
To:     firoz.khan@linaro.org
Cc:     linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 6:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.

Sounds like a worthy goal.

I tried applying the patches and it seems they haven't been rebased
since v4.18. My rebases are in
https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git/log/?h=for-linus

They seem to work for me, FWIW.

Is your plan to have the patches go through the separate architecture
trees, or go in together? I think I'd at least prefer for another
architecture to take the plunge before alpha.
