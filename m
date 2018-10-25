Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E976C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ADon7lba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB9D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJYWTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:19:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40008 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeJYWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:19:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so6837599lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyLaeutURMsSKLs8NSnjvB1CcUcdxUo120rQUpmvsuY=;
        b=ADon7lbaSdpRXgCfSduMZ9VxUVRaBe2eTVspxIprv5X3J9GegNcx+oZfpognAGMPnc
         3q2ogqLA+FZsfXdmjrPAmTA51SQGigootXk9pmLV0qWPAVE7/xJN577yw8B+TqP7bT5l
         iHOiJQnr5ZW3hKvZE9K5ICEy6nTdLyCVIhhDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyLaeutURMsSKLs8NSnjvB1CcUcdxUo120rQUpmvsuY=;
        b=G43YGv99pc//Cv0Vrmkue6+udUGLjnoAG+Y1jDwTV4APAqI+A9/kteWyjCVLWioWa6
         3kgJLA4DntOaHe067FNLnFCAvMZn/xiKernAcjXjVYIh3pNFEg8ZMine2wWboNefBxen
         nHJJfp6FcNqtIs86ouAptHVS3FC5plcKivwKYg9/PtiJT+Sz+J8nA8CzeQy2MEWAAGc0
         sJCUeFigGKiv0snfBpNDoyUATgX86wDISrkHicNFEpPPxZzh2n22p3lhu/tbdOCZOHnZ
         uY68kX6CUcA1qKRsHIOoJCysXDW0BhMb6evCZLG4G3xB30svA6+bvDLtxKCKMJxcovfj
         YOFg==
X-Gm-Message-State: AGRZ1gJBYohI9LJADC7zx2DY/IgN5hEiZCsJanua7sjQwQ7OrCvMPf5z
        9xOhsVMto8VwoOHXnEIY3M8oH+V7PRBaXlp+
X-Google-Smtp-Source: AJdET5fJlZTZxmK0FJ7ehyBCRUzEOopEvnajXCSkaJ1XUfcfQjS79wHTSljC2tC79TxYpL88gYd+Pg==
X-Received: by 2002:a19:e4dc:: with SMTP id x89mr1195999lfi.111.1540475177721;
        Thu, 25 Oct 2018 06:46:17 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k7-v6sm1133235ljg.77.2018.10.25.06.46.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:46:16 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p1-v6so8277312ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:46:16 -0700 (PDT)
X-Received: by 2002:a2e:9dc4:: with SMTP id x4-v6mr1419615ljj.133.1540475176306;
 Thu, 25 Oct 2018 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181025093233.GB3089@vkoul-mobl>
In-Reply-To: <20181025093233.GB3089@vkoul-mobl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:46:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSOnFYf=DvPdfmxiUL6+-3POEsV1cE3UNXjn93Bqym6w@mail.gmail.com>
Message-ID: <CAHk-=wiSOnFYf=DvPdfmxiUL6+-3POEsV1cE3UNXjn93Bqym6w@mail.gmail.com>
Subject: Re: [GIT PULL] dmaengine updates for v4.20/5.0
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:32 AM Vinod Koul <vkoul@kernel.org> wrote:
>
>  - Support for ColdFire mcf5441x edma controller
>  - Support for link list mode in sprd dma
>  - More users of managed dmaenginem_async_device_register API
>  - Cyclic mode support in owl dma driver
>  - DT updates for renesas drivers, dma-jz4780 updates and support for
>    JZ4770, JZ4740 and JZ4725B controllers
>  - Removal of deprecated dma_slave_config direction in dmaengine drivers,
>    few more users will be removed in next cycle and eventually users.
                                                                 ^^^^^
removed?

>  - Minor updates to idma64, ioat, pxa, ppc drivers

Pulled,

                      Linus
