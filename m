Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D9C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EFE24C87
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYxWAYL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EFE24C87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeFWQnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:43:47 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:45345 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeFWQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:43:44 -0400
Received: by mail-pf0-f180.google.com with SMTP id a22-v6so4570249pfo.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ef/0I1/LMqyAUyUyeNJoHcBudMy0R7a6803ylK4iFzY=;
        b=UYxWAYL7uZ2PCIrqmDotvA4KfN8FtoMhZCGiyTJCww4h17er+nbmt/f8YA1K1Nsa6j
         /zcW+Pmt1XZvuG6S4RjNhqp9Niy8wQIzz0yEczi0DvtCMLxDKyh3F8Uz8KN2jjF8VmKc
         NWeB05X1B5kliEdeMEjDyETNNRcVjIl5OOGPBZHa3xT+OE2cRH/BTwDtdtp9XW+TH34z
         R62ayGaZ+2YIxSUXUVJwigu14bc5o23MQaytnTTJhd8cnbWED2tKKZqDxUm08k110RFu
         uTSHCL4SLoS6YSrpeSiv50WOg+j5RReAlFHrOSjT3HRIjEgnPN5PDQ2t8xUalXXcsfdn
         L2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ef/0I1/LMqyAUyUyeNJoHcBudMy0R7a6803ylK4iFzY=;
        b=QZGFdR76K7wvWw+tusUxyHFC6g4sKUfsW/exffAPvN++oCu2jQwthKvfq0yxtzLhnn
         BF7CxfRFUvgEvblPrtNR+7Uv+p4BhIm9i1YVUOdXPw2AVRL2EG+UlpNxbDf//JA1nS1C
         PsWlSGocfBqe3cV7y9pLxIXdG1H9Zc8Jwx1n8iOwChtuOgfR7i91FJu1qfjw7Bdnl4hj
         POn3nxwYh0M8NwB3nrHwd3u7crzSPD/JIU4cT++YUOZUKBCjykR60saSBueva7ephK2K
         lGHMKM5qKiEnurbQ5D9pdBZDcLHadb+WLek3lPbJE4VNgO/RJuda7rk5xHoruxJTCHFL
         RbQA==
X-Gm-Message-State: APt69E3DifOOJHBkkR2y4EgyjKDSvT11d4TmIMyN39St0sethnMaNwqU
        W03JWIx16RIVJXnnGwPTImnA/w==
X-Google-Smtp-Source: ADUXVKIy1IgNM39n8UlfiyWGfDO8BQv2nRDWQ+N1cyF7Z/dnKBisbsB89o1CJvhuF9KKECA8OA0H5Q==
X-Received: by 2002:a62:660a:: with SMTP id a10-v6mr6495914pfc.156.1529772223825;
        Sat, 23 Jun 2018 09:43:43 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o12-v6sm4251824pgs.52.2018.06.23.09.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:43:42 -0700 (PDT)
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180623074650.GC18630@bombadil.infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <554b70ff-5a94-8338-6831-ce2efa1be287@roeck-us.net>
Date:   Sat, 23 Jun 2018 09:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623074650.GC18630@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/2018 12:46 AM, Matthew Wilcox wrote:

>>
>> Here is the culprit:
>>
>> genl_register_family(0x36dd7a) registering VFS_DQUOT
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
>>
>> It may be odd that fs/quota/netlink.c:quota_genl_family is not word
>> aligned, but on the other side I don't think there is a rule that
>> the function parameter to genl_register_family() - or the second
>> parameter of idr_alloc() - must be word aligned. Am I missing
>> something ? After all, it could be a pointer to the nth element
>> of a string, or the caller could on purpose allocate IDRs for
>> (ptr), (ptr + 1), and so on.
> 
> There actually is a rule that pointers passed to the IDR be aligned.
> It might not be written down anywhere ;-)  And I'm quite happy to lift
> that restriction; after all I don't want to force everybody to decorate
> definitions with __aligned(4).
> 

I am not sure if that is really correct, or at least I was unable to
find such a restriction documented or even mentioned anywhere. It is
true for radix trees, but even there the restriction used to be "even".
This was changed to "word aligned" with commit 3bcadd6fa6c4f, and the
offending commit here moves the "INTERNAL" bit from position 0 to 1.
This is quite a subtle change that was introduced over time. I'd be
not surprised if there are other more severe problems lurking in
the radix tree code and/or its users because of that.

Either case, I think the check for radix_tree_is_internal_node() in
idr_alloc_u32() is wrong. If anything, it should be radix_tree_exception().
If that was the case, the problem (and maybe other similar problems)
would have been found with commit 3bcadd6fa6c4f, not only now.

Guenter
