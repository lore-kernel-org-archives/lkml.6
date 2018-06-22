Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A66C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97AB24001
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="esMg3X76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97AB24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeFVKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:05:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32834 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeFVKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:05:26 -0400
Received: by mail-io0-f196.google.com with SMTP id d185-v6so5668412ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpCnh9Lg9BFAXumd15tpsxRH8GNKpKS6tw3MhC5D0Uc=;
        b=esMg3X76fHKfQw+JryarLwe1myZcAjfceY6WlqQ1W7OHsi6+UCC6B45NVIlfY026tp
         XBYc3nb6BmICArWHiWIhNNh65L/t61MosjBda0mKz6+ShqHnA9w7Ljz2YcsyJFTRZrL4
         JS+lgjqf2aCA9xmoU1wW5LjrHLbKGR/YkEAf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpCnh9Lg9BFAXumd15tpsxRH8GNKpKS6tw3MhC5D0Uc=;
        b=nsDYnCeE1NHwSWabzlwQRH+nsbSIZM6X8oCj2zVn4RcDM6hS4iL7P/8PllcN9Ka2sl
         kpkr6VFT2SrpVWYyuJBbhRGahjYe6SFRg3x9q9h4JpZ+gTJu0GBdQqi5YvfsUtGqbHqB
         elpk1olJfCPIeOBqWLnkQJ+n9x57i9iLT4+ivtGT1WL9QHmc3hHAMODk15qQtV3kxm+/
         86N7cyhoG0+12f8nqT3l2HOhKuUWnvOfM0DB0w2m7JBsCQcEPm2ycGIo8f/W2fswd2gO
         dhL85xycCmr/c56osgPH2F4dqnknXeO4zfN48rAMTi+SE1oFEfhIl6m4EOnsEEriIVrA
         cMJw==
X-Gm-Message-State: APt69E25+8/g+Fob18E2gFbosmgp29JwfA63pT3l0Xc1gHTd0vWwz4pg
        HvnTQXUi+8O0Flpxcc+H2tEqJzCqVHT2WUjE+BQ=
X-Google-Smtp-Source: AAOMgpewMAe/exZixWTAv33NvElUa4cSNjJS/+50t/6or9oaKgQMTzEMFSHq2vvmdB3gTkk2zpCytz0dMKSfmEsb0l8=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr758176iog.238.1529661925694;
 Fri, 22 Jun 2018 03:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
 <20180622095608.GA12263@lst.de> <CA+55aFyW-zN4363TOwptyzZ=6S1fDeatZMe6hYa656AJmnhmXA@mail.gmail.com>
In-Reply-To: <CA+55aFyW-zN4363TOwptyzZ=6S1fDeatZMe6hYa656AJmnhmXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jun 2018 19:05:14 +0900
Message-ID: <CA+55aFxfdnFUkDQX6LCFXz=Q9_KbSy3bjqb6zCj9VKj6fA42VA@mail.gmail.com>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops -8.8% regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 7:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Get your act together. Don't uglify and slow down everything else just
> because you're concentrating only on aio.

.. and seriously, poll and select are timing-critical. There are many
real loads where they show up as *the* thing in kernel profiles.

aio is a distant distant second cousin. You need to make sure poll and
select are prioritized, and aio should be a "if we can do this
cleanly" case.

                Linus
