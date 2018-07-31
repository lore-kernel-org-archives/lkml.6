Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EB6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E66208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zKAAAtx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E66208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeGaIDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeGaIDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:03:42 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8CAA208A6;
        Tue, 31 Jul 2018 06:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533018301;
        bh=yAj0ixBW9aQK03dOHZYou3W2YheWE7EFc0Ubcm1j8EI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=zKAAAtx/xFBG0skwZj4h7CjMeBkZ9YfmrMsPa8f2QmFDr1O7ZT6Q45IC/0AVPDHf2
         7s97k6DKejRP80ceEqk8A328iG28GTzEn4HHuSehVrRFK3x8ZNUQmfnGRs94zcpYtz
         vVpnRKg98dJ/tgp0WAwo80Cox95JOUaWqJVGdSkE=
Received: by mail-wm0-f50.google.com with SMTP id t25-v6so1779183wmi.3;
        Mon, 30 Jul 2018 23:25:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlGyHcGbDPgyCIYsX5jAAVqZrOeBsnlQpcaWP1rN+r+JInOB6p5p
        iNinFSkYon+Bnh2zPjTSUxaD9AN3yHOjXlKKdXA=
X-Google-Smtp-Source: AAOMgpeDMKEmxAYOjQ20TT+99b39QmktiV485/vSjoBGRA/++tBfrxLZEwENAv/MInp+f9CCFOgpE8winOWzkEE8qKM=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr1218691wme.135.1533018299158;
 Mon, 30 Jul 2018 23:24:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 23:24:58
 -0700 (PDT)
In-Reply-To: <20180730132253.33633f56@canb.auug.org.au>
References: <20180730132253.33633f56@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 08:24:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdhzbKeu57CqbVaHWKDy1-UunewJg6NtrmQPVY5fdSxWw@mail.gmail.com>
Message-ID: <CAJKOXPdhzbKeu57CqbVaHWKDy1-UunewJg6NtrmQPVY5fdSxWw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the crypto tree with the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The resolution looks correct. The other way would be to amend the
commit 5d258b48efbd ("net: ethernet: Use existing define with
polynomial") in crypto tree and remove changes to freescale drivers.

Best regards,
Krzysztof

On 30 July 2018 at 05:22, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Herbert,
>
> Today's linux-next merge of the crypto tree got conflicts in:
>
>   drivers/net/ethernet/freescale/fec_main.c
>   drivers/net/ethernet/freescale/fs_enet/mac-fec.c
>
> between commits:
>
>   16f6e9835bcd ("net: ethernet: freescale: Use generic CRC32 implementation")
>   d805f6a86829 ("net: ethernet: fs-enet: Use generic CRC32 implementation")
>
> from the net-next tree and commit:
>
>   5d258b48efbd ("net: ethernet: Use existing define with polynomial")
>
> from the crypto tree.
>
> I fixed it up (I used the net-next tree versions (but kept the rmeoval
> of the CRC32_POLY and FEC_CRC_POLY defines) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
