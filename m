Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0422087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JXN3kYyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0422087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeGMO1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:27:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35548 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbeGMO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:27:41 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so31446896iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ieOcrNPktAL51H1cxSQWiZlNRZ6ulRu6w4Y7zhXAV8o=;
        b=JXN3kYyLbk5R8HTiyDJKbn1fdmZPXmu0qkiLNctXeYIfujaV7RaMUkb++S77bWHZ3o
         OCHrba2U6pPw/Oc7mOXO7E2iVweq1+jPejTaIGaV4kW7U05FHO4bkaSvZTRMrKFhQl9r
         k14TJ8QvYgR6iMGlQIv6Xuf/GZObkAAqXUOUkXXr9wSBQf9D5spC6TgEaSa5NuDPt1o3
         4VPLq6/bhAEquYduD998qoyuJ3BlXMcd2zR5As7xkOPORVAiCH8vhRqYSrtWHeQ0YXYH
         /LF/Nn7KbtWQ0wHM3/yNM9LNiTH8C49xD2Nr4c9+iCnnE4Hbki1RZtCOe1co9urfMtRV
         atTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ieOcrNPktAL51H1cxSQWiZlNRZ6ulRu6w4Y7zhXAV8o=;
        b=CABV0RRHTNZLJwCWXDqWzON2W8GNA1tsC5PHx/RRafOKSFlBubgsxQbKRHTb+TQlTE
         M8LBXVeD91xH5WdEkQkwXTT9cWk+HvR4AMvBILOIncrMY+VWU2xMxYojfmDLqM/1j/M5
         dPUiNjdQ3L/lEyTFsmjoXaO4mbL6NVKixqP9JezzHi/XBEFv+9btPtO/1fpz0mM/uuQe
         VsOHQdNkBWnmN7kpcATAlece6/mbrQo7azxkTc3G9ewYmhqFn6ZGTMyf298ignqw7Jgb
         HqceV7qOIQ5LxzR4n8s5e3tY8n+9M6Zm6bkVSM2vnd+RF00U19s4vJcSSbncWS7+Smsc
         30NA==
X-Gm-Message-State: APt69E2zpN/30vJ8gLjgV5oiIQvVd0Pt+fuYFYf5WfO54OhSSlkhyJCn
        Z9GBt/PEG5x+Mb9ScoHNfwkEpVo3y1c=
X-Google-Smtp-Source: AAOMgpcpzP3dosCsDU4rFzzJgkWdFVkcSJllG14v8uznK4sRK54GoQrbjeQNKvRLq7pQfC9aCLNBaQ==
X-Received: by 2002:a6b:c409:: with SMTP id y9-v6mr32466798ioa.77.1531491171448;
        Fri, 13 Jul 2018 07:12:51 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id z67-v6sm3849242itg.25.2018.07.13.07.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 07:12:50 -0700 (PDT)
Subject: Re: [PATCH] block: remove blkdev_entry_to_request() macro
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20180713140726.20897-1-vz@mleia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3437bf12-1fb8-9948-ef51-4be89533c5b2@kernel.dk>
Date:   Fri, 13 Jul 2018 08:12:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180713140726.20897-1-vz@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/18 8:07 AM, Vladimir Zapolskiy wrote:
> Remove blkdev_entry_to_request() macro, which remained unused through
> the observable history, also note that it repeats list_entry_rq() macro
> verbatim.

Applied, thanks.

-- 
Jens Axboe

