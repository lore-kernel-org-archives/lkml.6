Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9280208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSKaoXjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9280208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeFUFwm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:52:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33681 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeFUFwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:52:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so967136pfi.0;
        Wed, 20 Jun 2018 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xbpELsugNZF8rjInA45zjC7oTJelH8Om7FekrP4jTnI=;
        b=dSKaoXjCEMQIsD7+DthIJTftT3dncnwEzMduyFuM3Cx2dd23XvTGYt7/bw7A4avxum
         KL1RANsJkosRm32BqzQgqzZ+uyRwcwlt44npBkKdU9pT7x1w4oU2/GI/1j6deq9JCE2Q
         YsrFbSNNNeACWW31qQqAIFgr2KhXfjEKDw+z1HLVFGewhjT8y1N5UjYty+VTvR1OMcDm
         0ehqV7qFDx5MXUmJuZMoDC4DfK8YsJO9zgl7V3k4jAm1qVQs4ebc0oMkUs81cR7jg0Rn
         uz36prI1arZ3llosG9H4dGg2n8+9KOryO08SJ5zjF1uMPD3egQ/071ac9WK7piwg25uX
         1RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xbpELsugNZF8rjInA45zjC7oTJelH8Om7FekrP4jTnI=;
        b=Bm5W8q6n3QK2NUx+VklEsZ/z3pYGf0MHPhRoW6N1KPiJSAJdd5cTKOQyVzCw2Lxa+9
         QNsJ8684Kvf7YEmj5yfXVrpmzWHaO4kzrk8fnbUZoo7uEd9A13nOFgJ3OewE+8gxySjh
         CVA3gJ0Lxa6y2QBIR8USLWW/XkXUMPTJk2QKasmKYIfVKKywsEo9ZZLfQt+aG5Ikcojn
         m8LPau3XCL6+SYqNXHZW/FUgngKW++CsFIofk8ZcSgzpOYWgAQj4oLjNqeHCsYhsWcBB
         xO8UVvBlka9/wEVx61II3jAblS9eQc0XvgLygLotcq5UOD6RfdHsY+Y3HcCVWYhPduc4
         su3A==
X-Gm-Message-State: APt69E0oqRhsGFYMfQyMXy/abQ4otDsxQUNe8kST7HqvXzMBCc8rw7/F
        A+r52PFF/hjhRK0kwM42ygSIe/sKuy0=
X-Google-Smtp-Source: ADUXVKKDGaXcr8GJ3HOS8ZPYE76XYIUY+xWH8/FZrQIx0A47rwSjFSnAwYgVD14v+fSFUJbOWxMdwQ==
X-Received: by 2002:a62:d9c5:: with SMTP id b66-v6mr25886978pfl.41.1529560359469;
        Wed, 20 Jun 2018 22:52:39 -0700 (PDT)
Received: from [10.10.3.96] (s169.156.222.122.fls.vectant.ne.jp. [122.222.156.169])
        by smtp.gmail.com with ESMTPSA id z26-v6sm8322802pfd.60.2018.06.20.22.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 22:52:38 -0700 (PDT)
Subject: Re: [RFC PATCH] of: overlay: update phandle cache on overlay apply
 and remove
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alan Tull <atull@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1529251416-14814-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJdp16D4svB8Y7jurNVdHzVgz8_pkOKBA6mFyhXkqWi6w@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1bb4ef5c-5813-fbea-9536-48b339c1e010@gmail.com>
Date:   Wed, 20 Jun 2018 22:52:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJdp16D4svB8Y7jurNVdHzVgz8_pkOKBA6mFyhXkqWi6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/18 11:23, Rob Herring wrote:
> On Sun, Jun 17, 2018 at 10:03 AM,  <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> A comment in the review of the patch adding the phandle cache said that
>> the cache would have to be updated when modules are applied and removed.
>> This patch implements the cache updates.
>>
>> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
>> Reported-by: Alan Tull <atull@kernel.org>
>> Suggested-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> Compiles for one configuration.
>> NOT boot tested.
>> Not run through my normal process to check for new warnings, etc.
> 
> I'm assuming you will resend a non-RFC version for me to apply.

Yes, I will.

> 
> I think it would be a bit better if callers didn't have to do free and
> populate themselves, but just made an invalidate call (like a normal
> cache) and re-populating the cache could happen on demand. Or if it
> was done as a single call, you could just copy the old entries to the
> new larger array. But maybe there would be a race condition in doing
> that? In any case, all that could be a subsequent patch.

Yes, the unspoken, underlying issue is a race condition.  I'll update
the commit comment to explain the race issues a little bit.  And maybe
add a code comment if I can be concise enough.

-Frank

> 
> Rob
> 

