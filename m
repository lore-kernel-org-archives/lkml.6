Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09600C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66F3206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVuFUu51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAGMkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:40:05 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40386 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfAGMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:40:02 -0500
Received: by mail-wm1-f42.google.com with SMTP id f188so748944wmf.5;
        Mon, 07 Jan 2019 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ebx6AVn3EOurlnVK+pHcpaJ58g9esjyClckQbIc1QdY=;
        b=KVuFUu510PiqNmz2uUbbNdmZqs87T45o15S/r0aSEOT/KntPa0focz5g9hXMX5lBOh
         W4keJv24ckvUWWtw65bnTQp4NKEYv8Y2z36UBJuSJOQ9CaYNlHZeKI8j0jwRHoDh6KFv
         4P4INv7p9PFGeZo8T0cnZHp3OmEsKOqa825z4amGA8RilPj3ce4W3vqEAhII8UKxkHWs
         MRDV2xK8Z+o640mZpfamjFIXsQBz4V3YkAiTxJnqR9p2j2TNE4hbAs/POh3EQIKnndkV
         lddtq7m+h11ednIcnOtn9/syHV6tfwiFBamnPEau7KZE55FO5390zmgykuKCp/fu7d8Y
         IGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ebx6AVn3EOurlnVK+pHcpaJ58g9esjyClckQbIc1QdY=;
        b=Kf1ffc1UG61+dMq3sQMf8Ld2tZLuB1FbGTJCzBFSIoXm5bryEw0+zKL3Kvv4dkReyc
         8wDMdBdeFmdhQusLkgvRz7zLtgB+sFb+tJNZnn4o5GF1DY7v8aeIy65dYVSmVOAQ8X9W
         zYCZ72hazTdbYvME/QcW1Z+z4y+3vBjZhx16ZIPltKyxBRQbJHja3El/lfm5/E1mXuVq
         BxLLbgwndPR8sEozupa44PaPWVW5lVa3lXCoYGmNSiIVo4sPSYzzOlp26B8KRGfiY9S1
         rUG9y5pDqYy9YbKQQfQcGkRKCkO1zVsRZfyn7DVKpde74pom9tziAYmjYsaMIb5ClTpG
         F6Ig==
X-Gm-Message-State: AJcUukfQnzkVL3yGp2mVAHUX5qw0keWvvhiKwjm6UXqeADvQp3Bn8Q2+
        jiZsSDD6AK1yNt+/huTU3w==
X-Google-Smtp-Source: ALg8bN6lMGBM45t4HHOyhg3heX2Mv05EOvjqkC9QB6VOg7Tx7Z0jxyLOy80+bRht+tZQcQJETiwRYA==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr8384584wmb.5.1546864800661;
        Mon, 07 Jan 2019 04:40:00 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id c65sm7035713wma.24.2019.01.07.04.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 04:39:59 -0800 (PST)
Date:   Mon, 7 Jan 2019 15:39:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Mateusz =?utf-8?B?U3TEmXBpZcWE?= <mateusz.stepien@netrounds.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Old content of /proc/net after switching network
 namespace
Message-ID: <20190107123957.GA570@avx2>
References: <4749d3bd-eac9-2a3e-aa93-d76d2e015945@netrounds.com>
 <20190104110933.GA2682@avx2>
 <165a35df-0a38-3507-fb8d-0f4b45af0dc3@netrounds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <165a35df-0a38-3507-fb8d-0f4b45af0dc3@netrounds.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:54:26AM +0100, Mateusz Stępień wrote:
> Thank you for the quick response, unfortunately the patch does not work, 
> problem still persist.

OK, I reproduced the bug.

> I saw the other mail thread, and it looks like the proper solution 
> described by Al will take some time. I don't know if we can afford right 
> now to write a proper patch ourselves, also at least my understanding is 
> that this is a regression, so my question is: can we expect a proper 
> patch in a coming weeks? If not, will reverting the patch at fault have 
> any more negative side effects? Of course it will bring back the 
> behaviour it was supposed to fix, but are there any other issues?

Other issues, no.
