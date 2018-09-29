Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48898C64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70F2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A5h7qiJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70F2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI2ILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:11:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40503 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2ILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:11:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so5621226pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CgC6+3bG8es7YUXtegFzn0Q8NWTrAsVW+TnFegYC8eQ=;
        b=A5h7qiJKpv2cSwAq2KwGMrmOwSVfZCtTxIu1iKM5BnwTAeUNqqc/92kzD/Hrs4qZKW
         yi9o4+MXFZutWKiiWPC+mf7IhVfIZ2X8QvjHAZaa0uJmis8jMx5+XyYVy2VC/MgJiUWz
         /JEiCYaM5x9EKkDY8Nvinl7TAISg3fJNIdl9YXl+Yk2M+rsZkzMzl7ghVSxwdNBKncS1
         r1+2VCPyrYNMyvkWj/ujQLNnM2yqgax9cm6QtrGgiQqijBWf02gib9qOx2nI9ShPeICf
         h5D9A8wN7r8+tQWaRkWpZ5m5gIOVqo/4ZURAaz0LoTf6UDZTYWKeEMW29ErDqu+HU41k
         d7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CgC6+3bG8es7YUXtegFzn0Q8NWTrAsVW+TnFegYC8eQ=;
        b=rWw+ZDJNuUWaAZm7NyEWxcsEqGnlQ9Hh2M7aB8tE1gSvPnzH8zZEgZNUZMC4nbyBoB
         ft7wVXPLezrcJMzgUZo63NCSSbUKtOa09GSGBFxleK9+2zyfD4FyAEbNa9pN9RBXeAd5
         gBbxq/oExH5qHrGbZE6n9V8f5bwrzXz/ubBwoBZ6+Wf1MAd/oDiTx5KWi6vQgjBF1H5h
         D6JtceOilZjhgzPterdl9sZ0eWYov7U9Wfol3M1D8koURrs6jPbFaS8rdnDXcfKoTVEy
         5U7iiFQ1OJc9PmrHCknhxkdeLJqEImUKXVxKlCMvuHhKfVk7TGuSPMULr0BmJ//7PLc3
         4Tsw==
X-Gm-Message-State: ABuFfognyKN+BcEl7I3XQ+eRJuprcdVjfHttllHOupwAIdBNWGEv05Gb
        WBW3qTAJ+cdCsD6zVCR2N4+eqQ==
X-Google-Smtp-Source: ACcGV62nr5fT4OP31jmZuU6R2eaiD+3lq/XEzZPdVgdcvhsPbLiYWtCaxmpQUDKLIw0aILKGhfX6xQ==
X-Received: by 2002:a17:902:a989:: with SMTP id bh9-v6mr1086295plb.245.1538185502833;
        Fri, 28 Sep 2018 18:45:02 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n79-v6sm6636878pfk.19.2018.09.28.18.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:45:01 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:45:01 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 17:35:39 PDT (-0700)
Subject:     Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
In-Reply-To: <20180910133418.GA12330@infradead.org>
CC:     anup@brainfault.org, aou@eecs.berkeley.edu, jason@lakedaemon.net,
        marc.zyngier@arm.com, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        tglx@linutronix.de, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-0f237369-b7fb-47cd-a610-be4c577c3c4f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 06:34:18 PDT (-0700), Christoph Hellwig wrote:
> On Thu, Sep 06, 2018 at 04:15:14PM +0530, Anup Patel wrote:
>> This patch is doing two things:
>> 1. Allow IRQCHIP driver to provide IPI trigger mechanism
>
> And the big questions is why do we want that?  The last thing we
> want is for people to "innovate" on how they deliver IPIs.  RISC-V
> has defined an SBI interface for it to hide all the details, and
> we should not try to handle systems that are not SBI compliant.
>
> Eventuall we might want to revisit the SBI to improve on shortcomings
> if there are any, but we should not allow random irqchip drivers to
> override this.

I agree.  The whole point of the SBI is to provide an interface that everyone 
uses so we can the go figure out how to make this fast later.  If each platform 
has their own magic IPI hooks then this will end up being a mess.

We've got some schemes floating around to make the SBI fast (essentially an SBI 
VDSO), I'd prefer to push on that rather than adding a bunch of complexity 
here.

>
>> 2. Have more generic IPI handler in arch/riscv so that IRQCHIP driver
>> can call it
>
> And that is rather irrelevant without 1) above.
