Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC2224004
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL2bPwtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC2224004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeGFOrK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:47:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42698 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeGFOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:47:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so23907551oib.9;
        Fri, 06 Jul 2018 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fz+P83tF14JDWJpW6ANNwFU4sUVStBxCutHtjOchY2s=;
        b=SL2bPwtg5GdkoLVQS1d8gYP/97SJ1oupHFyDYpIW8nCSkS7CMRIrzjagUUHiKS70u3
         RUzbaC/Gt7qwjl+qC2U3OmcUcSfh67oipy9dqp7gGF+hVN3xm34Ll7f1M8qYQyCCvzlE
         vAV6pxGmHGT8FF/ihYrcUpyhltEzGtoLq9IOtF3ASqa/qqflLaieAB0005aVjPO1oAOv
         LR+WGIQbhhk0GmNNj4WWs9FORQdEgSQCtR7eynDcwtCKU65OrFboygcL2r++/4rzF02N
         pSk03z8bj2uyhfxU7oWV3mjhrswFunm88xfqE8/zVefeotiSVdCZBG5zQ9yb6hw4wfSX
         2Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fz+P83tF14JDWJpW6ANNwFU4sUVStBxCutHtjOchY2s=;
        b=K3/915HmxW3phf3UmKF7plwktTnk8X97wPYwM+5LpenFfCo9gYjb+CWEuvJVKP4eU7
         1zG2KXmnVKMnNPXpeKmthlC8wo72aErWssmiIb0IzEaX903PDf4nUvkRXvPduakGdVpa
         ZBsYXJGyU572us7YwPMwKzh/61jFWSOKCsKpTIkN573Sv8AUyqi6jRdXn4L4FMy/In7e
         lxMeCfKUFCC48SuiaCnrhzOS94jIfF59mdWOWli8N29N5SJqnJTjo8NTpQSvqDiwjImO
         3E56T4YopURUy5mzFcfY6mlduwaEzGhDAzJ4nmB119Q/3fZ8tPx3UNd8Tbnez02hg+BO
         UzKw==
X-Gm-Message-State: APt69E0SSsSkdtABtX0e4kq3/LQ6TFliDmSWMGVxV7DWYQqpZ9tL4MGz
        pKt6F+uKWHHLwRtsqmazMBEbLOdf
X-Google-Smtp-Source: AAOMgpdX6TP+QUz/fTFFqs7/LMey/Ee/MLgkKDF8pXRhuuo0JS2BwC9xwrLFsNklg1Y6qeswI0/4JQ==
X-Received: by 2002:aca:4455:: with SMTP id r82-v6mr6318851oia.260.1530888428399;
        Fri, 06 Jul 2018 07:47:08 -0700 (PDT)
Received: from [192.168.88.47] (31.sub-166-167-68.myvzw.com. [166.167.68.31])
        by smtp.gmail.com with ESMTPSA id v85-v6sm1113156oie.57.2018.07.06.07.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 07:47:07 -0700 (PDT)
Subject: Re: [PATCH] ipv4: fib: avoid NULL dereference
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
References: <20180706142836.1822-1-mark.rutland@arm.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <3ad39534-400a-8d4e-ac50-94eb5655e565@gmail.com>
Date:   Fri, 6 Jul 2018 07:47:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180706142836.1822-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2018 07:28 AM, Mark Rutland wrote:
> In tnode_free() we iterate over a callback_head list with a while loop.
> At the start of the loop body we generate the next head pointer, and at
> the end of the loop body we generate the tn pointer for the next
> iteration of the loop by using container_of() on the head pointer to
> find the tnode, and deriving the kv pointer from this.
> 
> In the final iteration of the loop, this means that we derive a pointer
> from NULL, which is undefined behaviour, which UBSAN detects:

There is no dereference, your patch title is misleading.

UBSAN might be fooled, not the C compiler.


