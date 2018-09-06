Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97492075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GcZ2XvOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97492075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbeIFU2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:28:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39257 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbeIFU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:28:35 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 39c78035;
        Thu, 6 Sep 2018 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Dxm3pVP+yCo9w/F7ZNLQgtpezbI=; b=GcZ2Xv
        OkPKlJ8PyaW/Qk3SZTCrNDkeaM9vh1FaJCIwz8HhQjdTBrQmfNUg+dxX+ER1Ohgu
        ZSvxVMFwSDg/c9KNgKmOZzMlYlTfFsh37yqMmtULS+WKI9+BYKcCVB+kM2h8sAfd
        zMSe3Mj8PmTlxlwvG9E5lNsftfK/C6dkLJFcYksjnwMtZ4iyBP79zksvaQTemjoJ
        d3F2RxahKhMC38MWwP70uozVdmC2eGdxLkxK2Uh1t4onOD30+2NuK+pY/Rli5Wib
        w+SA+mqQ9oUrxEYGv8bXFYB2oqLtjVHOCcwU3h+BpV/Vp2deuVKWYhfZm1gdCFRO
        d+pwrH9aidU4Os4Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e5f98880 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 6 Sep 2018 15:36:21 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id l202-v6so21436799oig.7;
        Thu, 06 Sep 2018 08:52:25 -0700 (PDT)
X-Gm-Message-State: APzg51Bjd5dUHkYZUpIW6yHZ3imXZYxv4bkkcDQ4RDwCMmUlQ5M2CNc6
        jiKfhxHrEj1o1zBa1RHbfsqJ7ONbWAqotf30Ksw=
X-Google-Smtp-Source: ANB0VdazEdYtqK/gdhZwQJeIjHCRibmVujiNX80Rxe/+R5gCLrTOS0SzBaMMbkQ5r69hHSfiB4Xldymnn09dArQR8iw=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr3308879oif.71.1536249144535;
 Thu, 06 Sep 2018 08:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
 <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
 <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
 <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
 <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com> <alpine.DEB.2.21.1809061542330.1570@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809061542330.1570@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 6 Sep 2018 09:52:13 -0600
X-Gmail-Original-Message-ID: <CAHmME9pNd2WiLQy=EYOj+Pn-55OmaPk__=mzQq07Y5GX7-vJOA@mail.gmail.com>
Message-ID: <CAHmME9pNd2WiLQy=EYOj+Pn-55OmaPk__=mzQq07Y5GX7-vJOA@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Sep 6, 2018 at 9:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 1 Sep 2018, Jason A. Donenfeld wrote:
> > On Sat, Sep 1, 2018 at 2:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > I tend to think the right approach is to merge Jason's code and then
> > > make it better later.  Even with a totally perfect lazy FPU restore
> > > implementation on x86, we'll probably still need some way of dealing
> > > with SIMD contexts.  I think we're highly unlikely to ever a allow
> > > SIMD usage in all NMI contexts, for example, and there will always be
> > > cases where we specifically don't want to use all available SIMD
> > > capabilities even if we can.  For example, generating random numbers
> > > does crypto, but we probably don't want to do *SIMD* crypto, since
> > > that will force a save and restore and will probably fire up the
> > > AVX512 unit, and that's not worth it unless we're already using it for
> > > some other reason.
> > >
> > > Also, as Rik has discovered, lazy FPU restore is conceptually
> > > straightforward but isn't entirely trivial :)
> >
> > Sounds good. I'll move ahead on this basis.
>
> Fine with me.

Do you want to pull this single patch [01/17] into your tree now, and
then when I submit v3 of WireGuard and such, I can just drop this
patch from it, and then the rest will enter like usual networking
stuff through Dave's tree?

Jason
