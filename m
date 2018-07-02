Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF51C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7AD24997
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LMpIYfe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7AD24997
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeGBVLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:11:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55817 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeGBVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:11:17 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so226319itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HyDGOHMIxUFvsJFRDuq6RjKQRVLVf4ysR4DHfXb6l5A=;
        b=LMpIYfe92XjHrzN0KtpepADTR/Dima6u0N29ne+pYrqG873HAeyqbsKCgwoBYifXo+
         XYsjqdN9UFzTptakiMGwz16TvsdYr27v6PvluIql8ITqSUxGrHKrEqhlCRXMKEwJysk2
         efxVwmj7ydY/23gq8ctDNUmaDNKVrI9OhJfNj5y38YX+0hCrAP9dMnUBk0YPSjc2qHjK
         RmxmQZG+4Ybpw1kT0tT2FqGsOPDk4EOlQPmXcF6vJfZXL7r2r1BZS3pEVj8Y+HEYtoB6
         xFyJvUbfxaspV28lrbCJb4qDutTsSTfjp0ezERODZWGOXDelL7z5Nnd2ztH7CurldK4R
         7tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HyDGOHMIxUFvsJFRDuq6RjKQRVLVf4ysR4DHfXb6l5A=;
        b=LRIb2qMmaNlXfWOEtk9FmnUgOwECDNMgwp+M1Q6FQqF8NyFoo0NQG+heZaRajy3xcW
         zEUT76jAuHTmndmvv+bY5V3+QxumyjgZ4BfHT8O9OWEwooihmjpLXNQCUkwOZkTVnj/O
         BRwweN+NdGns4mLVGo+9J9JtsSnHH9AnIXAJahKtGxxUCHgIkdqvwYs+fFz6K61OTnjy
         GTZBtF1ynFcptZXyGIeGNfZPRZqT7uwb9TPMxLRtHxIsbzP+1qUYDrCQqr60G04SNynh
         RVe1kwzzU8bX3nT3hFMUfq6z7TJYYKFUZ+3s1Sl/fI4mS0ODWnreUwdj43kBnrhqMXny
         TMIA==
X-Gm-Message-State: APt69E0sbCMV7Ag/iLKAwy0MuiJCaoZYRTMhrA+KDgeKFnEyiBkAo/YB
        i7zKnAlNTm+pW2lv4IhBHB75Is0HdbE=
X-Google-Smtp-Source: AAOMgpf8f0fd380/fpM3yN1jDkCWtts6Dw/XwufLmB9GElLg83bOwXlpiF4rz8ELBxK4NIUlAQC9XQ==
X-Received: by 2002:a24:7650:: with SMTP id z77-v6mr7242119itb.113.1530565877005;
        Mon, 02 Jul 2018 14:11:17 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id l65-v6sm433221ita.8.2018.07.02.14.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:11:15 -0700 (PDT)
Subject: Re: [PATCH] block/loop: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702175206.GA18848@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd31987d-e2d9-6a34-a88f-baf1e6876c47@kernel.dk>
Date:   Mon, 2 Jul 2018 15:11:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702175206.GA18848@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 11:52 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied, thanks.

-- 
Jens Axboe

