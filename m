Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC948C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E892087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E892087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbeKLLyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:54:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46684 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbeKLLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:54:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so10912671qkf.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 18:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z+7Mjs3gE6ArwESe4etnnzBM2uOgMJVX5W/+n5WkpZU=;
        b=mCJNlO7X2D8MIOFT2of8GiiPmi82NHEOJgutwNKXSBEutUL7CvUlhQ58yHILJVZouf
         5pjv+fBLxvFuzGbENMIvdi9625kndaaVNr1+WtIbABh3TJS3oZlG73VvZ0iCdBEytOy5
         34f4ctf3em+zChXXnMUMgwKdjMqXfG2fXGKPYLNIEUOj5bPchSL5D6owtfSjkwXRcsWH
         H6TqOQBVHyWon0BCGB4kTywlrWpJKjT/u4vMCx10K9Zj3mkQkOxWuEQLCOHBQFZt4arA
         ReLL6ioJnGHokgLuC08v+tAobaFMNdkRAEa+eLzCJSMHDBhiRUOyFWZclIQJRPGWil/t
         ckGg==
X-Gm-Message-State: AGRZ1gJGxVnWpJmUIn5zitAcI9oNtfNRTXeW/f/v6zG/uDL+aOnh+G/d
        /JfgJwWPHfAtELF//1M9NIFwyQ==
X-Google-Smtp-Source: AJdET5cGhTJIg2z4Z5v1vRIKl5ZsUZwLobLi2GZAjGwWH5aT0z/0uFsxpdIGJcw12NuWBS7/T7zc3Q==
X-Received: by 2002:ac8:955:: with SMTP id z21-v6mr17012902qth.305.1541988234162;
        Sun, 11 Nov 2018 18:03:54 -0800 (PST)
Received: from [10.150.73.190] (97.sub-174-227-17.myvzw.com. [174.227.17.97])
        by smtp.gmail.com with ESMTPSA id 3sm6743879qkd.84.2018.11.11.18.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 18:03:53 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Vlastimil Babka <vbabka@suse.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
 <6a415f31-2bce-72fa-2ff0-5cbbd572347b@suse.cz>
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <94ee3c86-781f-e865-8b7a-aa6ebb9a2609@redhat.com>
Date:   Sun, 11 Nov 2018 21:03:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6a415f31-2bce-72fa-2ff0-5cbbd572347b@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 2:58 PM, Vlastimil Babka wrote:
> On 11/10/18 8:20 PM, Greg KH wrote:
>> On Sat, Nov 10, 2018 at 10:52:06AM -0800, Daniel Colascione wrote:
>>> Now that glibc is basically not adding any new system call wrappers,
>>
>> Why are they not doing that anymore?
> 
> FYI just noticed there's a topic relevant to this in LPC Toolchain MC:
> 
> https://linuxplumbersconf.org/event/2/contributions/149/

Yes, and Adhemerval put it there on purpose to continue the discussion
between glibc developers and kernel developers. Florian Weimer and I have
both provided input to that talk, so if something comes out of the talk
and you want to talk more, please just reach out.

I hope that kernel developers interested in this topic will attend
and discuss the various ways forward on certain interesting topics :-)

-- 
Cheers,
Carlos.
