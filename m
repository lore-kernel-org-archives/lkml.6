Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE363C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F942146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwDjgCEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F942146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLFS3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:29:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44366 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeLFS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:29:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so1436052wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0NaZAcuUcKs3rDmTTBoyewiFljJ1a7xNnUVaA9keIjU=;
        b=VwDjgCEuc9LIF16vp2V4+onnSgHG7jioDhWM2BHan1wcUomYniDPBRzvjFL3BPpvAV
         KtdrmCxrGgaM8aX6M+5470L7GL3CSPNA1npakFNoC/MAZjr5aF5RpSSfuTZ9HohwIxhx
         4U52DWC/pJlO2ASsT9+49jxFCT2oPaUfuMCK7C2T2g2I/DdLqlAoisDPow1WTF9rbXWH
         V+S2FKSfoVDen3duYnmemAWP+mf3ipP8AmusjkIiNdfMKUchN/HeFTWD4weup7aT7lqO
         OcL7BqvEs+R0uoJ12ZIyf3kijPUHEvlpn+0DkM+fuGNxuwPU2SJoSXkla4Jyfwyjiku7
         bfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0NaZAcuUcKs3rDmTTBoyewiFljJ1a7xNnUVaA9keIjU=;
        b=gTjv0yv+Kqt6eS5VUNpUc2sCqJKx0AXp2h6aNbbLcDMYMeaqxCBa8VwZo4a3ZMH4PX
         3aYblu/VsxltlnCo7vTAYtJGYUZ5eFbTDEYb6TdO6Bsdy99HbmOsQi5QbfFY99KBXP5O
         J01VKzshMaRH1BH95TcgBaegMmiks7aiOaHGzHmZ/PEGbloFIOUhDKl9JE/we76CS1+n
         SwwOK1QenHsvUp3yr9PJqpgQ33ppEjsYPFXAqQIghWW9u+DGTBD4xJgfnKugMh5actum
         KzQDKMnY6e7/I9805ta+aDp5xOjb0dX63XTL6gdcJV2H9fGbyPk8iqtQKNN9sKl0gM8E
         O7fw==
X-Gm-Message-State: AA+aEWZNc9YOrxb/IkZpK5aK0UkD+tPq3zH/SniEbLm/Q09TO9UZkXaW
        jjRNQrHFyeI6F/n4O1nOwEY=
X-Google-Smtp-Source: AFSGD/UDMK8jwJZyiSduq543k0KsmWeQjrfTL45Tbtc28L7Iqk7WenEBryS4LpQQvyv8K/LtsWJODg==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr25741337wrt.63.1544120981444;
        Thu, 06 Dec 2018 10:29:41 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id s66sm2082513wmf.34.2018.12.06.10.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:29:40 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181206184351.4d9ece54@redhat.com>
Date:   Thu, 6 Dec 2018 10:29:35 -0800
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9F9D621-445E-4F3C-95FE-3963A3DAEF98@gmail.com>
References: <20181206153720.10702-1-hch@lst.de>
 <20181206184351.4d9ece54@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 6, 2018, at 9:43 AM, Jesper Dangaard Brouer <brouer@redhat.com> =
wrote:
>=20
> On Thu,  6 Dec 2018 07:37:19 -0800
> Christoph Hellwig <hch@lst.de> wrote:
>=20
>> Hi all,
>>=20
>> a while ago Jesper reported major performance regressions due to the
>> spectre v2 mitigations in his XDP forwarding workloads.  A large part
>> of that is due to the DMA mapping API indirect calls.
>>=20
>> It turns out that the most common implementation of the DMA API is =
the
>> direct mapping case, and now that we have merged almost all duplicate
>> implementations of that into a single generic one is easily feasily =
to
>> direct calls for this fast path.
>>=20
>> This patch adds a check if we are using dma_direct_ops in each fast =
path
>> DMA operation, and just uses a direct call instead.  For the XDP =
workload
>> this increases the number of packets per second from 7,438,283 to
>> 9,610,088, so it provides a very significant speedup.
>=20
> Full test report avail here:
> =
https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_tes=
t_hellwig_direct_dma.org
>=20
>=20
>> Note that the patch depends on a lot of work either queued up in the
>> DMA mapping tree, or still out on the list from review, so to =
actually
>> try the patch you probably want this git tree:
>>=20
>>=20
>>    git://git.infradead.org/users/hch/misc.git dma-direct-calls
>>=20
>> Gitweb:
>>=20
>>    =
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct=
-calls

Did you happen to see my RFC for "automatic" indirect call promotion?=20

	https://lkml.org/lkml/2018/10/18/175

I hope to get v1 based on Josh responses next week.

