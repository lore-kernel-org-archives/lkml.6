Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D332176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxd+oH/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeLTGyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:54:40 -0500
Received: from mail-yw1-f43.google.com ([209.85.161.43]:40552 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeLTGyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:54:39 -0500
Received: by mail-yw1-f43.google.com with SMTP id r130so267795ywg.7;
        Wed, 19 Dec 2018 22:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lqKU/JT0UlMuHcTgAnebCFEFmJKXublgQg6XBuFXI0=;
        b=Lxd+oH/OTmP12QOz4azaLPmq7dgQlyEH5OgkNtBeP74ZFNyOD2RfbJugHVTaqEVwQm
         M63M39AaVVxqwCDMfn6aNvOhXE16esCIXb0wxP4AdSruxF+guBH8c+NQ74zeyFW9T9qj
         pPfoROQzy3ZMKx74ZWsBSel1XSrTHpZfhLLGgdByuFDiCiUPuPDOpYKXOlmTwhVFSQQv
         N4G38wYRs8ONxZouMOjSr8xEWg36h4onYt2iM9+Nj0yrlefEFyvaqyRQAWqFHsqFsH8c
         rMf+TSgvrkawXwgE480OLri8NA52ZJCNk2OepjxyC7nAFUSVjqj17hpaP/XseOzGnMuE
         K+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lqKU/JT0UlMuHcTgAnebCFEFmJKXublgQg6XBuFXI0=;
        b=cJ6IGnXT+DhpoS6tU2J1FYjTlt5FnFPHEhmGjJpNlEL6FXUnEh3GOFpO3aSJScmx+e
         jR9k9Fabh8zlmR2xVSjh+6+Qg7Djiz7tV8DJTlGOriMH5ANNNbnJWMHRunJAmnX0/1Cw
         SQ5ihLogZtGT22W+4WzmB5q6jv8zKE9lbv+sP7GUt/SKP+swp4vVhneocWrtzzGefnel
         cUXs1J06dEbMUdh6mPsP0enAwpw4z/xRQLnRTb71T4IsiNx9BYUBYaAFXpB5WC78cne8
         6F/aKg3KPaIbMUx1AQnGROMFsJEPY4npPgrPpVXvrEA0YCLhoDNvWVPFTxmwUBjS1ARs
         2/oQ==
X-Gm-Message-State: AA+aEWbqe3mnXSSLTAX7JmNOoQsr+ixTs894mE64SqXLTtfJd/9J5PNu
        yIaQW267HUG0M5Np15cE85H4e4XPcfFQxsudsaA=
X-Google-Smtp-Source: AFSGD/WHR0RnEmw81bh3nMSGR767wvB1/0yZGJhYcD+0BoddGCfkl5le2zllYe2lj2yDLDMiuYykPPod1QOaVRem/3o=
X-Received: by 2002:a81:1b44:: with SMTP id b65mr25247268ywb.393.1545288878580;
 Wed, 19 Dec 2018 22:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20181220130744.1c8db488@canb.auug.org.au>
In-Reply-To: <20181220130744.1c8db488@canb.auug.org.au>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Thu, 20 Dec 2018 08:54:25 +0200
Message-ID: <CAJ3xEMiiRLCerdvOikn=xMqw+-Yu=UEm-YhdSMyXtCDzte0kcA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gavi Teitz <gavi@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 4:47 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
>
> between commit:
>
>   8956f0014ea5 ("net/mlx5e: Fix default amount of channels for VF representors")
>
> from the net tree and commit:
>
>   d9ee0491c2ff ("net/mlx5e: Use dedicated uplink vport netdev representor")
>
> from the net-next tree.
>
> I fixed it up (I just used the net-next tree version) and can carry the
> fix as necessary.  [..]

Yes, this is correct, thanks!
