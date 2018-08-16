Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5FFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC93B208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMkCmRNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC93B208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbeHPEw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:52:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeHPEw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:52:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so1260080pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/taaNuNHQba/tSuIz2VcugNt/PU2GtGuNQfaHl68oo=;
        b=dMkCmRNr8nGkTwsZSpNramSH7zAN9eUAzXalCV0HvlANDR7d3dthhfMQpjtvVkRTaX
         uXt1KvDi8Hahq55KhQEYiwjpJxy65vfy55XyW5zboKBtnlKf4ku57eEiGbiGQOja19PR
         R5IjdOHpxZodyHxCOylBRKR+C0L0iyBu6dxj5m9OswEA0AMFSRAZF3sXdu6A3kaKxGtl
         u+TSbEteDAXVMCwSuTCzWB0sA98zt8YWeizHWRDe8RPDE2QTO7Aj/WatUxsizXgJ44LP
         H8pAXjUM1mNsSxw8rEHm9uYGGwNdME2kjfaifU2Wrsrz0zGEs3mee8edDzrHAi5+FGS0
         GfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/taaNuNHQba/tSuIz2VcugNt/PU2GtGuNQfaHl68oo=;
        b=Z4mPTDyIqnQWz+3rrS4qjudZLZQY6n9mMyL27ziqHLPE1FlAnJGfpHPkUPVZeZSkcc
         bzIgDrjyrNQKYHHaRk3Euo6sZFBe6yykIPLIczQnWZtO5qj7F+HObdLjeSTcWCJjGMtD
         zqI6NNZCN9VHFBtcSUhAQi34uCN7KSDQm5Fx73IlrNPNXBHvMq0D8TOE3sO9sGe19NA7
         I9qwXp9082hBP0HW6mQdfB6EHMaxWoYKpoRpjup2IhWq7JyBOdFUQX19cvbTGZhwOJgC
         HjvMPF+iVRNi4c83ByEVRR3T6+czAt/+mB15PZoa34suJaAk+mMoOVfLq85i6Ngdrxeq
         e5fg==
X-Gm-Message-State: AOUpUlE4SyZPby6u0ZyCeG1Ob7SBRzcJXhhGQnEF+OmfsWI5JfER5lX2
        XZQoNukFI3AMZerdcYzfsoU=
X-Google-Smtp-Source: AA+uWPysJigIEHBE/iQxhTvkJ7W+VjI49ipQJJVyIMTZy/7PJgu0KZGEeUbb/RAPo/R266l4uqGPTw==
X-Received: by 2002:a63:4763:: with SMTP id w35-v6mr27038991pgk.140.1534384649405;
        Wed, 15 Aug 2018 18:57:29 -0700 (PDT)
Received: from localhost ([39.7.50.150])
        by smtp.gmail.com with ESMTPSA id a17-v6sm35737629pfg.106.2018.08.15.18.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 18:57:27 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:57:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Peter Kalauskas <peskal@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
Message-ID: <20180816015724.GB2793@jagdpanzerIV>
References: <20180808223100.225086-1-peskal@google.com>
 <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
 <20180813073825.GA1062@jagdpanzerIV>
 <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
 <20180816014835.GA2793@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816014835.GA2793@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of corrections

On (08/16/18 10:48), Sergey Senozhatsky wrote:
> The problem is that strlcpy() copies as many bytes as the source string
> has, not as many bytes as destination string can fit.

I mean - strlcpy() expects that the 3rd argument will be sizeof(dst), but
we passed the wrong argument strlen(src), so we used strlcpy() like
if it was strncpy(). The difference between strncpy() and strlcpy() is in
the 3rd argument.

> IOW:
> 
> 	char dst[100];
> 	char src[1000];
> 	...
> 	strlcpy(dst, src, strlen(src));
> 
> where it should do
> 
> 	strlcpy(dst, src, strlen(dst));

			^^^ sizeof()

> A side note,
> There is sysfs_strcmp(), which takes care of that "user space may append

	^^^ sysfs_streq()

	-ss
