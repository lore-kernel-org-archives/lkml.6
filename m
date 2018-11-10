Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D188720840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D188720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeKJPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:39:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37978 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbeKJPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:39:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8268A1420C12E;
        Fri,  9 Nov 2018 20:36:51 -0800 (PST)
Date:   Fri, 09 Nov 2018 20:36:50 -0800 (PST)
Message-Id: <20181109.203650.2137044253712054807.davem@davemloft.net>
To:     robh@kernel.org
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
References: <20181107223151.14991-3-robh@kernel.org>
        <20181108.191116.1317160901826988583.davem@davemloft.net>
        <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Nov 2018 20:36:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Nov 2018 14:30:01 -0600

> That is the intent. With this change we stop storing the full path for
> every node. Everywhere that needs the full path, generates it with the
> %pOF printf specifier. Other than users in arch/sparc converted in
> this series all the users of full_name have been converted already or
> use kbasename(full_name) so they work either way. BTW, I've found a
> couple more, so I'll be sending you a v2.
> 
> And of_pdt_build_full_name for !SPARC does need to be converted too,
> but I'll do that separately.

I would think that, for correctness, you'd need to adjust both functions
at the same time, no?
