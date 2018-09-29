Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63752206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SuMIzlxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63752206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeI2Gq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:46:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2Gq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:46:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so5344701pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 17:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wfmKKXiwNohAQp1lrZp1NwcNw71FTSlA1awGwDmJ4nM=;
        b=SuMIzlxrXoVn2wWlTc6Z7xspq6QVsIkqCg5krK0WyVKRnrBq6cQlRX76qge4Au/S7j
         rzvcVEdc45couju6vEj0b+RdIkG9ngFf43Im5HGdyAjSkmPas5xLRWdmHx/XkoBO3SYn
         mW7N9Hu5+UeD6njV+azurghMqimYVF75WvD/7Dft9M2dHWjuQYR2aXDjfQC/8k1pbFtD
         ENNojzuGAmbh0tI9YwVGgzYBc2WhFwHrC4XYYZDwKS93cIi0d2d3AX3GhiS8RrHIoZG3
         Os5Z0/U7qh8Bc3ohmia9bUleRqnZTu9SII8I2hmLfSE+ihX0rW39zoiIeRZtwIQXLT0x
         YsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wfmKKXiwNohAQp1lrZp1NwcNw71FTSlA1awGwDmJ4nM=;
        b=KNho+vnPUD2Fq8QUiAax5D1IheEr4D2OPAv1ujAK5rEyB05G3pYVOyBQIcHh6K308t
         ivv6iyJ9CHzP8FJwEK5J+t2nk7wTKBuKJj2F98wiU6fqncH3PvkeRf4jgeySJ2mGPrac
         2WKYIfM3WZ7UwKmi+ibHJLsG+qD5dkx0zOl3Gdz0/9GgdH90n3rZMU+wNw6bI9AXIC9h
         IqFJcsF/FJHU1Z52XfhrV3CCCuihk+j+akc9QkvCGBDAnSx161saZ9CzBvHBEa1NFaC6
         hANhwRDgsa56Pu7dKvRyP2G/NdijmuhjtkcQWOkLDp5+OZCBwtdQ+L+6WcrAIXgZeBIx
         ChTw==
X-Gm-Message-State: ABuFfoh+Ed196c+wGRgDwaksPpFsiPtbbBsHr4UWvUB5QmAQSf0aTR//
        fsPhqpJw7aTnQbaILEzV+r7YRw==
X-Google-Smtp-Source: ACcGV62dKiwIjya9GWKlchDzn52kKgoOS+FbJKccNEYspsST0RMqqKTRXVq2zhT5pUYFjgbcBiZf3g==
X-Received: by 2002:a17:902:7842:: with SMTP id e2-v6mr401522pln.104.1538180446414;
        Fri, 28 Sep 2018 17:20:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s13-v6sm9855903pfj.105.2018.09.28.17.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 17:20:45 -0700 (PDT)
Date:   Fri, 28 Sep 2018 17:20:45 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 17:20:27 PDT (-0700)
Subject:     Re: [RFC 2/3] RISC-V:Support per-hart timebase-frequency
In-Reply-To: <20180917142308.GB15588@infradead.org>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, mark.rutland@arm.com,
        robh@kernel.org, Damien.LeMoal@wdc.com, marc.zyngier@arm.com,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-54e4fe3d-12d8-48c7-b1ea-df317fb3ff3a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 07:23:08 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Sep 14, 2018 at 02:54:55PM -0700, Atish Patra wrote:
>> Follow the updated DT specs and read the timebase-frequency
>> from the boot cpu. Keep the old DT reading as well for backward
>> compatibility. This patch is rework of old patch from Palmer.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> This setup looks a bit odd because it keeps blindly overwriting
> riscv_timebase for every cpu found.  Shouldn't we at least check that
> they all match for now as the rest of the port assumes that?

I agree.  There should be at least a warning if they don't match, but ideally 
we'd just support per-CPU timebases.  We have those systems already, they just 
don't boot Linux (at least, not yet :)).
