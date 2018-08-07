Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6BCC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BEB21A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dNtzGBpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BEB21A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeHGEub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:50:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56573 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHGEub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:50:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id bbdb5ac4;
        Tue, 7 Aug 2018 02:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZbHDkHFWMwT82INk5r23mnu6Mb4=; b=dNtzGB
        puLE54JidZB35dsIlj7MG6bjP/rsJvtflgPdKmMeCPsbvVLXXAEpa8/sarpw/A9O
        WgH9C/h2QDBMZCAebHmTnTR0y7G9Cx4YhtIVqnfDF53LsFVCi392Q031gFiSLIBu
        lJkGNZn9JFXV+3TZ+arIR/Crj1JthqVCxbyfVBEodqqV+Mn+yeZCl3uXsHYPTZpb
        UTW2y+RUIG4rNW4Yt3ctKqrCek070YVLzFByQAeB++KzRmEhClkREPewQ8KR10Qv
        vRgxtPmoeoee+f09rgwuR6qCFNUQpdKZ0Nz8/SrHSeyWOyXWHJxPkR4LotG3pSmw
        A81KqjkStDgOtKmA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8070c34e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 7 Aug 2018 02:26:15 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id d189-v6so25830704oib.6;
        Mon, 06 Aug 2018 19:38:24 -0700 (PDT)
X-Gm-Message-State: AOUpUlG4Yok4QqIbiyBV4avuah1jPleCG6emggLXEsxs2UqSwE+uaH/O
        eAo3ng2bIvJbwu1sIT0teXKftdmAQkbi8ZkSqzg=
X-Google-Smtp-Source: AAOMgpeGNh64ajJ0+XPHVW4vx9iQYXsCuCuSgAOD1+EbHQOtJ0kcOrIL926YV3EYSC/HJnPQyQDA068dqWbjw8njiRE=
X-Received: by 2002:aca:3e56:: with SMTP id l83-v6mr18439038oia.170.1533609504080;
 Mon, 06 Aug 2018 19:38:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:a025:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 19:38:23 -0700 (PDT)
In-Reply-To: <20180807011937.GA133621@gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806230437.21431-1-Jason@zx2c4.com>
 <20180807011937.GA133621@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 6 Aug 2018 22:38:23 -0400
X-Gmail-Original-Message-ID: <CAHmME9oTApV-zHD60QPryaoQf45ODpG25Da5FgB8c+LO162gWQ@mail.gmail.com>
Message-ID: <CAHmME9oTApV-zHD60QPryaoQf45ODpG25Da5FgB8c+LO162gWQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: remove speck
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/18, Eric Biggers <ebiggers@kernel.org> wrote:
>
> For context, in your commit message can you include a link to my email
> mentioning Android's Speck decision
> (https://marc.info/?l=linux-crypto-vger&m=153359499015659)?

Sure.

>
> Also: "speck" => "Speck".

Ack.

>
> Also I think the fscrypt code points should be reserved so they don't
> get reused for something else:
>
> #define FS_ENCRYPTION_MODE_SPECK128_256_XTS    7	/* removed */
> #define FS_ENCRYPTION_MODE_SPECK128_256_CTS    8	/* removed */

I thought about this too, but it occurred to me it's highly improbable
these were ever used, and I thought it shinier not to leave scars. But
if you feel strongly about it, no problem, I'll fix that up and send
in a v2 shortly.

>
> For the record, I think the statements Paul and I have made evaluating
> Speck from a technical perspective remain substantially accurate.

It wasn't my intention to relitigate this, hence the rather short
commit message. You said your thing, Tomer said his, and now I'm just
trying to clear out the leftover soda cans.

> We've also designed and proposed
> an alternative solution for the ARMv7 disk encryption use case, HPolyC.

This sounds like a nice and interesting outcome of the whole thing.
I'll certainly be looking forward to reading analyses of HPolyC as
they come out.
