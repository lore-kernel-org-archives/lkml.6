Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24C20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJFlg1ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfBEA3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:29:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfBEA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:29:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so712713plb.10;
        Mon, 04 Feb 2019 16:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bPNvbubqseSFASHxvB4scfC/38soZ5I/Uvz8zUdF/NA=;
        b=TJFlg1dsbAJcyIGVZ4oDDSqAlxWM9ApxSAb/3qOZygb+5irAPG7sMZgRuipxWHnQEl
         EngEBSK4HTj2eVIovnEFLXW5rVJXN36CtBPPwHLkHOw6hdWiLDTJX6jrspauowvRT6nL
         2BsDyC327vdqvRdZhc6msMz08G051uUbe/bGL3wW3SxkB2X7/8gJAplLUNU6I9wFuyCl
         qSnKSoR973ma/7q85ONXCpofArVnmqMv4vTWXtMM9p8NddkBd3OmdiKSGtxIHTILjSVd
         yb9YsihpejJCBflIbN5+iKgqe7glVHi66C+OrksKRBBy7GZjPwUJhyeGhynVQ3qqPayX
         ioUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bPNvbubqseSFASHxvB4scfC/38soZ5I/Uvz8zUdF/NA=;
        b=tChnLrfI5geqH2pEgFDmhbKWtguGvUcIouwfILltdttnQhFU2LQfpJt4OWvRCJNiLJ
         PMrfJh1aNJLWlkk4Xnw1+Gn+fUEOpmz+vr74oBlBbSO1QqW7+CblIygSSMQANjRwKO+M
         nMpa7ScH9cu6BgY3WFzYKD1kiSyCuxylcSqOL2gtZzkIRVr8sMxNvFBgLX4FlJzTJYOn
         YDrwb7h8P/YptjQxqPpvLU2VhABpC5TjGn94E3PBkS0weO1fVIAKAYX+T6mfcGFKF/lM
         7T8m6WbFKNuHIpxX9zFBfw2v0DqTk1F98a1yk0UdyQNU98ycyojF3pbE/p9QALmuAfsb
         TaAA==
X-Gm-Message-State: AHQUAubrSns66RhDUWQY3HHuWa/Gn+YYJOCKjTgIXhwPy9rFfKgFh6Qr
        2UrHirkeLarp9YAk1zqzPPTa7hdZ
X-Google-Smtp-Source: AHgI3Ia1lcUmUr1Qx+2gefaxBSa8LVe1KigfkK0f/xZP7ccwmpK3Qp8yFfOoNZdKAN7J/EdXrAM50w==
X-Received: by 2002:a17:902:e012:: with SMTP id ca18mr2217266plb.218.1549326573705;
        Mon, 04 Feb 2019 16:29:33 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id m67sm1815592pfm.73.2019.02.04.16.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 16:29:33 -0800 (PST)
Subject: Re: [PATCH] docs: kernel-doc: typo "documentaion"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549058656-11119-1-git-send-email-frowand.list@gmail.com>
 <20190202205620.GA13285@bombadil.infradead.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9dc7fd5f-3ed6-f36d-5b84-8fcd3c477181@gmail.com>
Date:   Mon, 4 Feb 2019 16:29:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190202205620.GA13285@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/19 12:56 PM, Matthew Wilcox wrote:
> On Fri, Feb 01, 2019 at 02:04:16PM -0800, frowand.list@gmail.com wrote:
>>    Include documentation for each *function* in *source*.
>> -  If no *function* if specified, the documentaion for all functions
>> +  If no *function* if specified, the documentation for all functions
>>    and types in the *source* will be included.
> 
> Could you fix the if/is mistake while you're at it?
> 


Jon,

Since you already accepted the patch, is it easy for you to revert the
patch and apply a v2 with the change Mathew pointed out?  If so, I will
do a v2.

-Frank
