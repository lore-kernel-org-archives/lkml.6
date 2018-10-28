Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FFC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBF82082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qP4HHhG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBF82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJ2Hwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:52:43 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37273 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeJ2Hwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:52:43 -0400
Received: by mail-ed1-f47.google.com with SMTP id u12-v6so2846177eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WwrqBidUGUlRgvK+K4Nts80VLeQFsRh+pg19z4w06tg=;
        b=qP4HHhG2FLJvhPJMeXhYm2hFJqBtAXgGE7CowSZjbUF5YZTQESExfjXW83cIwo1Y9H
         WLRhRRlXtcn9WlQ5Bvtj+PWuTN2PH35Dxz3Gpwx1rBuNCaNHIVtDoPaRXuHt6yQ5+LYa
         ntJgcNloHamICNz+2B/6L5MlX2jQ5MinSawMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WwrqBidUGUlRgvK+K4Nts80VLeQFsRh+pg19z4w06tg=;
        b=AY5bWpsM6vPSLjcGcuMPGwV464kDQy77GahydIymj47DNLKs89qrDLevkn+YmztvVk
         W7n+at6NKzKlbmW/H1Z9L86FklodlKCwjsujo4PCFiQd9P9cqIwpXo6nFgxu9YPRukT8
         2xonKuOsiWEXdJCvMKYIfWLWHFanD0R1aurr1N3mrsicj9BBy04aoDt3OecdvK1OCEwB
         AIHEsV9o7atjp/hJ/sBBFGpOjt225IatwHwgcjskd7ZPUcHo2nglzjF/u6nLA7wD3qHV
         qA1C6r6CIt+IJxl8/QDSMzpRuSP1NHtt5Il2X5YCV4pSpDW7dUXNNLayowVg+DsRZ6Er
         A7vg==
X-Gm-Message-State: AGRZ1gLn8ZcS1HO6M7TsO7OxDdyy0S+Bqpj9tNumAbRP4sv2x1L/xiwl
        Rto9OZet4Z0YdWnleZOKd+xRT0rjvOmMQw==
X-Google-Smtp-Source: AJdET5cI6mSUqrC9jaeRatNys8sni5Py/I9HvER/of4gZ0h+lvQVaLgWu7jnJKn254T3ebkCLjThcw==
X-Received: by 2002:a50:b7b7:: with SMTP id h52-v6mr11695018ede.17.1540767996293;
        Sun, 28 Oct 2018 16:06:36 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id h3-v6sm6221632ede.42.2018.10.28.16.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 16:06:35 -0700 (PDT)
Date:   Mon, 29 Oct 2018 00:06:27 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFR] Store tearing
Message-ID: <20181028230627.GA3420@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

memory-barriers.txt says:

  [on "store tearing"]

  "In fact, a recent bug (since fixed) caused GCC to incorrectly use
   this optimization in a volatile store.".

I was wondering if you could help me retrieve some reference/discussions
about this?

Thanks,
  Andrea
