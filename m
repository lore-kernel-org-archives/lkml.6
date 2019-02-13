Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C75C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E675B21B1A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh1HSCLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfBMCtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:49:25 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33366 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbfBMCtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:49:17 -0500
Received: by mail-lf1-f50.google.com with SMTP id q12so624431lfm.0;
        Tue, 12 Feb 2019 18:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vwvprjmJurUjra8us7UNgk0CKT8vgL+IaRmi2GqZ0w=;
        b=gh1HSCLhnPtLu6lnrg0T7RP+1b7Adathfo+yptaGjP0W5WBSi1g23mphy0af/Gx570
         y9lQPJp7Hntdd/i7956hLo6EDmuaXkqS/gMleaCQUA6HGhdrRayEcYNCZlW3G9+4c+oZ
         fHZs7lmbt+VtwZoyIazg4tPl8f2fhgYbnnqKzhpvzyfMB+Ek+GcIPuxKCUBsN9P95FGq
         jFqu+xj2azDgoazTRJxKs2KRhSKdRgNL0Y8/WcISQaXjjsVF/YlVqciyKSZy9heW+nBx
         pKwzAtSfmYX5GYcUAojCjUnqcglM7/ZRuVIyoqQIoUeaoWoM5a0MC38eC7MM3uuUYXwx
         1Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vwvprjmJurUjra8us7UNgk0CKT8vgL+IaRmi2GqZ0w=;
        b=kde/j2DvpRT+pGB4qIPWufrNT80zG9kTA2tiIPDph6KebflKBoRPLY+HxATwcL1fhC
         GKQaIoJhzFoHqdObWBnijpJ6+mel/It0X5HLgFBSTrN8uj1xn4CQBinJEQ/Eqhnaxxhr
         3kb9FKwRH2BymWnKNSupbOTGtpWzvtjBhYJnjhlW/kP0qwvtN1gPdhLPA2aMMQBhopQX
         k1ISD0N9hix/jM4Mu7gxpkWCE5lwyTiukbEFOMe8SPPoqaygWpuBz26+raUeMqkLMfpS
         bPgJyHexnNMs3XAw7JfgnfHRj+7p3w+fULvelPYLA5gef1Ee6uH367OOv6EGDbHqAFzM
         BvmQ==
X-Gm-Message-State: AHQUAuaS+FxAAY170huDPsXHVrQllnILOGVveza7k4NKhx6/eXYInqHS
        u9kcIkeuoW3n1d/siivlcnfQ1gGZUSf8Ihg3LXI=
X-Google-Smtp-Source: AHgI3IbRllIKbDxDFBHpq4IcnyDsDeumAnPNkH+ghRpGnb+jpyxAJsgdYrUkW3OnnhOSiGnD20UfPxIL6ye1BmwUeSg=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr3862616lfl.129.1550026154235;
 Tue, 12 Feb 2019 18:49:14 -0800 (PST)
MIME-Version: 1.0
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-2-git-send-email-laoar.shao@gmail.com> <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
 <CALOAHbAskuYhs3KQTJtT0Y7hjFcOyab-JpG4GCPENUxOk34-eA@mail.gmail.com> <CANn89i+2JB1UfdTmVMPMP-fEeYm9safcO49ygKn6fccEP1rpYA@mail.gmail.com>
In-Reply-To: <CANn89i+2JB1UfdTmVMPMP-fEeYm9safcO49ygKn6fccEP1rpYA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Feb 2019 18:49:02 -0800
Message-ID: <CAADnVQKhEshkWSDeYJ92pWnJjqawGSScBH+LU4iXsqwwxYjO9g@mail.gmail.com>
Subject: Re: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Lawrence Brakmo <brakmo@fb.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 6:15 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Do not add more debugging stuff unless you can demonstrate
> they actually allowed you to find a real bug and that you sent a
> public fix for it.
>
> Just adding "cool stuff" in TCP stack does not please me, it is only
> more complexity for unproven gain.

I agree.
I don't see why this debugging of 'abnormal TCP' cannot be done
with kprobes and tracepoints.
Instrumenting every tcp counter increment is overkill.
