Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AA42098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AA42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJCWts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:49:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJCWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:49:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so1585960pfe.6;
        Wed, 03 Oct 2018 09:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4YtblVfSpRmfDxEHrLlXl4LeahSkGkCCXAgaj5VQ1g=;
        b=Vr2WXYD2OJuBKGsb1QueAFfCFr/me9H5t/RWcf9IKixdZk3rVIxLlZ5DEVqY6HOIil
         lXlceV2Rv0CF4lZPYaSiEJoQB/FZIwrqrMV+2Ta310iuDoBXj51TwJjvXjSdWWGiawgX
         on2g/55KpCzJfHT8hPeGatKNQO2Z2S6gur01y5ZCP0y93++NTXc0fxYnCuWg3S0SWTrc
         guPOVN6xzS513ryn7ZoeNrIo1rzOPeP0TaWI0O2Kk5PTKDyZiyJpd6dnVp+KD9hri19h
         4Ah9dUiA+Z4tiWHbfEdI8NJwbVNp0GpwphZ0pLntoRyVqdq4ma7Ib/JKxwiyR14PX3fy
         t6uQ==
X-Gm-Message-State: ABuFfohUdDwg1ywtRZl9YQ9u9OAhmHuWO5xYDLXnxmP989d1GYz+a753
        z4Yk9Ulxz0yFn2BasOz20PE=
X-Google-Smtp-Source: ACcGV61NnwdWrRZu6g1Q/HB9ucckXzHsDeLBN6moqhECfXXBVYRnES5ziMpIE2xpKOllYxqgpcuCvg==
X-Received: by 2002:a63:fe13:: with SMTP id p19-v6mr1934213pgh.265.1538582448343;
        Wed, 03 Oct 2018 09:00:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u9-v6sm5804193pfi.104.2018.10.03.09.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 09:00:47 -0700 (PDT)
Message-ID: <1538582446.205649.22.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Mark Brown <broonie@kernel.org>
Date:   Wed, 03 Oct 2018 09:00:46 -0700
In-Reply-To: <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
         <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 17:55 +-0200, Paolo Valente wrote:
+AD4 The problem, in particular, is that bfq is a complex beast, fighting
+AD4 against a jungle of I/O issues.  You have to be really into bfq, even
+AD4 to just know all of its features+ACE

This is a problem by itself. I don't know anyone who wants to have to deal
with I/O scheduler tunables.

Bart.

