Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A15C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787CF24003
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQstB8/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787CF24003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeGFOoE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:44:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43216 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeGFOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:44:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so8631082pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWvExVlqplFh0RG/urZZKxd6mUVVfYRmyv4fofPEcA0=;
        b=GQstB8/u0dRNPi2pbBJRgOck14YdMzKNRpcmkpif0qHz3q5krq7ux5eQ9H7LKpaUEo
         RWjrG2gruffJkYvV6HPa66jmtHoGqLxTlUSvY09jkwZIU2ROCvbEZpqT7THOcaH9iaJG
         uHsVf2t5Xl+OUyaVSdilED/Du4EVcNKba7FyPEK4ZFwECoxHFz2T+g7cldO6VWIJsqsf
         V/mRM9z28J4X3GlI6ix2ozmBp0S5Cka49Yc8C0MCZxzY9Kl/CYoDbp03TjXLhM3gguiv
         lnwvPgMEigZSNAvrOwk9KgpArfuenBgmBvfdS88J8XXXlgzXXx714eH/qjBFQQrDUINN
         xlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWvExVlqplFh0RG/urZZKxd6mUVVfYRmyv4fofPEcA0=;
        b=FAoVFw5TCi6a6Ftnre2XK4+yjpyuhDwk+1lLJb+IeKO8/qsUOaqNzTt6ekx0RZGJVi
         nORJGl5xD9ksje/wNO6o4p1NG9IQTDrGiVvZowuUHVdOLTtjrGVy9ndawbdfl2zJ8Zzr
         kzC0FvhQHIN0rQH5MuyS1fSaVZhgQujQVw0ReJqfysUnkCXH7tM14x6tgUHNbVMMQa7o
         4MFGBwwWIjMEnK17LooQuUmhQ6sGWSbZ6gVVMNpA9GASYH4Fv9D4vVdf+C8eozrtoF8m
         lcjhG2T2vHzoyf2KTzTzx4jlvMWxDOLkWgYVLli+w4TOeV8VlwQWXxOedWUEzkc/w+ew
         OmoQ==
X-Gm-Message-State: APt69E2kTz/jARCTxNlCqyVgdzZ3Q6fjYXOAGW/YJHEk1ZuoZxDmv69Y
        /7MJt8ksVLDoMOhQbpwhYrM=
X-Google-Smtp-Source: AAOMgpfVQafZjMPBTdD+HY2uVMtcW/UWaMk6S6mc/fL87VVIUxbIvgbiMlSXz93IHS7Mw99aGEYYNw==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr9862914pga.142.1530888243227;
        Fri, 06 Jul 2018 07:44:03 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id k13-v6sm28660900pfg.130.2018.07.06.07.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:44:02 -0700 (PDT)
Date:   Fri, 6 Jul 2018 23:44:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Colin Ian King <colin.king@canonical.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zmalloc: hide unused lock_zspage
Message-ID: <20180706144400.GB411@tigerII.localdomain>
References: <20180706130924.3891230-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130924.3891230-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/06/18 15:09), Arnd Bergmann wrote:
> 
> 
> Fixes: 0de664ada6b6 ("mm/zsmalloc.c: make several functions and a struct static")

This one is still in mmotm/linux-next. Do you mind if we just squash
them?

	-ss
