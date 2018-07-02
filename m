Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B9BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3373020881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S8RHRNPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3373020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeGBO24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:28:56 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:38571 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeGBO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:28:53 -0400
Received: by mail-io0-f175.google.com with SMTP id v26-v6so2656488iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jxG3PqlAx6qsa6bKK5ZKyMFufj60WJawB1dbYWADp8=;
        b=S8RHRNPjDVQoY0+DRVaQAXsxG2El1cCsUhSigr1/g41F+v6YiN+yt/Xi268D4M0I6x
         YJjOkje6L/nZnSBBbAQJslc8h2os6DRKeBHxdIxZSbiP+eZBviEMJaP9uvN/Ta839yKg
         gHcm/6eO1TklkGkCxHszQ8EmeO/ig4w5bQ9fXrTwBdw/TXmjYjMKhSNBXlP/p1aV34lb
         2Q9e22t+09UXZTw0WBxhiL+xgOdhqUV1hcSc4FWCzG0fzdBY5dZ+yaZkXunFVLYit4iE
         Vv9w9iLEQ/k82EgmKJoKYoYE6oyJP0bH/+r9QycraUFVzosz7gvh7SpDdOCMrUNAdR7S
         EiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jxG3PqlAx6qsa6bKK5ZKyMFufj60WJawB1dbYWADp8=;
        b=tYX9HK2fzDRIXH8+qEzbBmS/n8CHqHaIHbhKulGhl8/MpmQbookazngQTFAe7NxBFE
         mMrqo9qi6W/3mjQodohLSBrmxBCOmf4a9j/erz4m6fV3ylhlNVuP4MY20t4+PvYJhqsT
         GbuStpjGk+OO6Iel5786DOYyT9jwvWKHQNllNF6jENZQFOKrj62CtT+ESooSDMw7Jx3k
         hf7aT2FqfHr9v/2E+ufhdwgQA9jt/IfwB3o1gE9CfFMBepwXI86DoxPsdTbb9QFYb1ZU
         zZ/yv+lh8/zdlemcVxDnXSPTIr5a/yyIJarYA3kqHs5BLnRxNCqgNPyuyzP8I/YdQZjx
         mshw==
X-Gm-Message-State: APt69E1CWSysxLA7ODdjRtVRHCa+3CnnXX+BNs6M/w6pvyCIDYk2N9EB
        m857teITXOjX2+8fsTd2n4i7zEkVSQg=
X-Google-Smtp-Source: AAOMgpd+7STw1EuCu0ZcdFci7/dcuYkUzftM1sCUCsciR9z/rLYzKkTItM60LTgDx3BrKG5GpqHEYw==
X-Received: by 2002:a6b:a7c9:: with SMTP id q192-v6mr21043130ioe.116.1530541732646;
        Mon, 02 Jul 2018 07:28:52 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r23-v6sm7051704ior.17.2018.07.02.07.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:28:51 -0700 (PDT)
Subject: Re: [PATCH] paride: remove redundant variable n
To:     Colin King <colin.king@canonical.com>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702081419.12207-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <213e1e8a-d962-c4bf-cfbe-69ebb5628747@kernel.dk>
Date:   Mon, 2 Jul 2018 08:28:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702081419.12207-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 2:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable n is being assigned but is never used hence it is redundant
> and can be removed. Also put spacing between variables in declaration
> to clean up checkpatch warnings.
> 
> Cleans up clang warning:
> warning: variable 'n' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe

