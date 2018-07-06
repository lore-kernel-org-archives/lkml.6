Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C4D24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C4D24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGFOt7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:49:59 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33086 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeGFOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:49:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A48A56093339;
        Fri,  6 Jul 2018 16:49:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vI2EM7P2lhBT; Fri,  6 Jul 2018 16:49:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 69973609333C;
        Fri,  6 Jul 2018 16:49:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mG7xLm8TB4Va; Fri,  6 Jul 2018 16:49:56 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 437396093339;
        Fri,  6 Jul 2018 16:49:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] mtd: stm32-quadspi: replace "%p" with "%pK"
Date:   Fri, 06 Jul 2018 16:49:55 +0200
Message-ID: <1574993.BxlVuaNddV@blindfold>
In-Reply-To: <20180706164732.5776df5a@bbrezillon>
References: <20180706130525.22223-1-benjamin.gaignard@st.com> <32602293.7BQn8HeLUA@blindfold> <20180706164732.5776df5a@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Juli 2018, 16:47:32 CEST schrieb Boris Brezillon:
> On Fri, 06 Jul 2018 16:44:44 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > Am Freitag, 6. Juli 2018, 15:05:25 CEST schrieb Benjamin Gaignard:
> > > The format specifier "%p" can leak kernel addresses.
> > > Use "%pK" instead.  
> > 
> > Does %pK really make sense for dev_dbg()?
> > When the driver is being debugged "leaking" is on purpose. :)
> 
> %p already gives you a hash of the pointer address. At least with %pK
> you can turn it off through a sysctl :).

Once again I mixed %p and %pK.
So then %pK is what we want. :D

Thanks,
//richard
