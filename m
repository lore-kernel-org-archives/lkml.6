Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4895CC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EE220643
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e0ekLYtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeLaRUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:20:09 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37935 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeLaRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:20:08 -0500
Received: by mail-pl1-f171.google.com with SMTP id e5so12836037plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pvsk2FxQRsHKJLA3eBX85r+qMuPjuQlru16o2peHBlQ=;
        b=e0ekLYttFnT1NQ1YxE0rKRE8rxZHvoMNkfv+HfNcs5ENtOABf2xbtQqooJ8c9s/6Ix
         2M/ztPXKWu2Wk+ANmiIKXoHPRt97T3cNOwW5OPaY7zjH1ca6nIjhP6LfDCkCGMQtQgWu
         pHuTRE2aj3iOMnbVUOMs0P1LKHVZ3wDwiQhIYY6wNb4OzgWLSnDv7vwx6m0LnxhjQa6l
         sYT4s2V94yIzYea+kHjccjQnneg3paDXKrVcU2e6mek1+eiraNVQhCM9tdZRBP875W0k
         QHDI6cyGLXLjGmNuEbyrb5AW+2Z7zUrEbE9fBrIVfVDUdzjLMpohT5mhUDe2cces8bia
         EUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pvsk2FxQRsHKJLA3eBX85r+qMuPjuQlru16o2peHBlQ=;
        b=T7BfCkY7Q4aWocMg4bhGGb60ayGn2LUQbvmhTy3NF/TsBSMuWJFwGhQUioqxe3IBZc
         W36M9appAO3dSwEk+MC57ZBgm0l1KAoFAMDRC0gZpRvJkJneNXpvJslP76NQTnA/XF6n
         izmXyApIQODkf87XmlO8l9f0Zxv5tpE4kUbv+dQEdOVlzsPYW+gyLwQvPwtHSpwCY1cJ
         yWqpKADzRbji4MZen9KgpxwFkKEuh6c1sTYNjjR5S4bliCDgWr0xcMerO0JlpZODl2Zu
         oDL28fBkfGFyftDhdlt4KPbiJlZ0m3TdzVdNsrGkGuPOapOtdupkGPe2ZMNKsj2wpH4g
         rfuw==
X-Gm-Message-State: AJcUukcYOsJYaYy2KSf5EoGLbMXlecFByxA+sXf9DFTaUssqWAP3ZlLV
        sdCYF+Y5EbZ+KhtNsUw6MEuRrgpA/saexQ==
X-Google-Smtp-Source: ALg8bN43Zvakz6S+5js+fOB5JNo4pvpSRdaq89BbqyORRdaTGa+BMqhpiDbhWSvgYycyhN1BMFsSkA==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr37452482plx.231.1546276806912;
        Mon, 31 Dec 2018 09:20:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r4sm97843514pgn.54.2018.12.31.09.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 09:20:05 -0800 (PST)
Subject: Re: [PATCH] block/amiflop: Don't log error message on invalid ioctl
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <980e56c9dd86f2f94ea1f33d8b6cb27fe10ca436.1546235049.git.fthain@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43d150c2-01fa-0853-549d-8559a9199e3a@kernel.dk>
Date:   Mon, 31 Dec 2018 10:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <980e56c9dd86f2f94ea1f33d8b6cb27fe10ca436.1546235049.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/18 10:44 PM, Finn Thain wrote:
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thanks.

-- 
Jens Axboe

