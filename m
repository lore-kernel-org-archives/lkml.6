Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24E52083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcbENOmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24E52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIABlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:41:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39036 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeIABlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:41:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so6063316pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CZUL5Hfj48Fyz685witLNRWwWvkcPBYw9FWfhHa6uVo=;
        b=LcbENOmC0qrpvSID+PXyWxEfgESl83Q/dUazoozSkUnvChvEq5ErQTzZK7PH3U2BTL
         hsRvCU+Bzi0wc7cFuMA6OJMdjsZrBlqofJMub9tQbbPukpDSZ2TAdA8N4O9LjlcO7sZt
         mPoXdDKnBuL/L7WemI3Zc+AOUzdB9URbGOkvUTM1Yj9QjD0YVchJ7eYOG1hnx2HQE9h2
         avz6rfC7oan4xgI3OGERpoHkN7iM68fckllamO7Rgq6TJmBnxy5AaKpbQ8J2WKdmGwdY
         Wnf7iswJhUto013FsWm6yiJHmDimtiHQFYnbwr9csOuFrDlnBCT051Azbn9H1UpKV6Dy
         uVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CZUL5Hfj48Fyz685witLNRWwWvkcPBYw9FWfhHa6uVo=;
        b=BasuLlYZ6uDuLlgghSktU013HKlSwsZTjBgkRucOwLTlc/qTTxWdu1e4CFZVQa2qoO
         WrOnvpY5liL4yJ/fNfS6j8WS1nJrmkbH+gT3qskj/NV7MrMnCWwg1EjYVPLS202fUqow
         KU5pHyABbx2lIlTlGI16FUNhg3fJPspehTjlMvawFZLKTgM+NTUmLPIUfrbhvygtqnTa
         qCQ936ZZ43j0fk0CXMNhCrERp+pZXLFzCD5o536uVa+kxxz8e+T779X3TEJH2s8mG9M5
         jI8ShWN9InLzRg3Grj4iswcWc0w3I8vkQ+OjNbICs9OuUY9zX6/Cz/nuYQCtdryG/CPl
         6Q/Q==
X-Gm-Message-State: APzg51DCnn+S8taYvcJYL3Vfxx5jkABXtUMf/teyEG1NrXCnVXpztY9H
        iNSFT1r2qSlx0kkIgoBb3atG1w==
X-Google-Smtp-Source: ANB0VdZSc28f/0MTetnO12DHsPsIV/Ov7jTqFw5x8hJNLGnQY0XtubSec3G+RQOEpoJf4A8r42uOMg==
X-Received: by 2002:a62:2c53:: with SMTP id s80-v6mr15291126pfs.154.1535751099960;
        Fri, 31 Aug 2018 14:31:39 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id h82-v6sm26975041pfa.173.2018.08.31.14.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:31:39 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: check for kref overflow
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20180830230946.228701-1-drosen@google.com>
 <20180831004144.GC20664@kroah.com>
 <589c036d-450a-3f3b-8f5a-4148713d4bfb@google.com>
 <20180831155657.GA25066@kroah.com>
From:   Daniel Rosenberg <drosen@google.com>
Message-ID: <4b4e64a4-bf6f-b3d0-4221-2a0d3206a6a9@google.com>
Date:   Fri, 31 Aug 2018 14:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180831155657.GA25066@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 08:56 AM, Greg Kroah-Hartman wrote:
> On Thu, Aug 30, 2018 at 06:36:18PM -0700, Daniel Rosenberg wrote:
>> The sign off was on the 4.4.y version that I cherry-picked this from.
> Ah that wasn't obvious at all.  What is that git commit id?  You need to
> give us a hint as to what is going on when you do that :)
b84ec04bae905901("staging: android: ion: check for kref overflow") in 4.4.y
>> There was a trivial conflict moving it to 4.9, but it did not modify
>> any changed lines, so I hadn't thought that was worth noting on the
>> patch. I apologise if leaving the signed-off-by was incorrect here.
> Why did I only apply this to 4.4 and not 4.9 when the original patch was
> submitted?  That seems odd.
>
> thanks,
>
> greg k-h
I don't know. I had included it in the range of kernel versions it 
should be applied to in the original patch, and noted the minor conflict 
for later kernel versions. You added it in 3.18 and 4.4, and I assumed 
not 4.9 because of the conflict in applying the patch, so I sent this 
version.

b1fa6d8acb50c8e9 ("staging: android: ion: Pull out ion ioctls to a 
separate file") is the patch that causes the minor conflict in applying 
the original patch.
4c23cbff073f3b9b ("staging: android: ion: Remove import interface") is 
the patch that removes the affected code altogether in later kernels 
versions.
