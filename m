Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5012420833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WBEiXbXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5012420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeGYTTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:19:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45260 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:19:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so5803224pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fRke3pFfUcZc5KOEOvnJABFrVK/sf3J8lDbuollegEo=;
        b=WBEiXbXTgxM2AtcZ4pdZePPjyMomvJul18vmLt7wq9sl9kWNefXHuBdQ+xIYX0Wagp
         4ZKjcaiC/DyQbK2fI1T0CeLlNqoqlZCxGRpA8P1AlACR46aYaPIVRgRFD9+7LsB2H5B/
         PtAI3LDpwLAS/V77Yozg6Vhu533ynBstILNI1hwOqDiiXUgNKI5BFgfe8b0HQ/gz1UgW
         vzJSPUPLxXZcarKKv4xrb4v6V2bcxbYBSmbZzXEZs7ncVgeRkrNuM1GCtnkvY4Muhzvi
         ewlf45rCmyFGpnueC4eRnqEgr34HbbzgzmAzev3jYKyv6BupcXoR3b6SGHc7PRourWR9
         ZfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRke3pFfUcZc5KOEOvnJABFrVK/sf3J8lDbuollegEo=;
        b=KbJOHZz9U2CexiHr9zTLkjePSmNsO+y3GOdSwj5Z8Wxzv5MmYU6or/nQ8ICzRUqHPj
         M/OO1+xFCrfYrJatuH/PRsz9krn6hxwBf3VqmxREf3GQlGqk8qPs3MBYlqQNcC/Y89CQ
         UR0JFJzsaF11kTlNNNyj+dTiEyCM3EuyyD7ULVKavQ9p+iB3g18dUON598j6195gmYQ3
         p5e74n0cSoQvEnqzGyGspEjE8jiUtW2pYQVzsd5F8CK32//jcrpgzaaaav1J5BzxY5RR
         U+yIPgW4l4YTRlAvl1DgTJRtdMmR9zVC4t5wEX365ZUoOcZ/cccNUaBIkYg9KyaAuwtS
         UbCA==
X-Gm-Message-State: AOUpUlFAsale6dDoV3c+ZuPKR6kAP8aSJ85F74RuTcZxzG5h4owVr7I1
        S4Bgs2EPGE6xJoYtClcswAEznEA6et4=
X-Google-Smtp-Source: AAOMgpdrF01ocfDY2EPCoSlee3F3EC4Y7iO96zzlkZntv2bJYSyPyxWN495ohwJ0SuB9KahYu3td5Q==
X-Received: by 2002:a62:57dc:: with SMTP id i89-v6mr23192442pfj.65.1532542015531;
        Wed, 25 Jul 2018 11:06:55 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:120:495d:1fbb:4da6:3a7? ([2620:10d:c090:380::2:f6ca])
        by smtp.gmail.com with ESMTPSA id b73-v6sm27394836pfl.152.2018.07.25.11.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 11:06:54 -0700 (PDT)
Subject: Re: [PATCH] xen/blkfront: remove unused macros
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com
References: <20180725074207.6808-1-jgross@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43625a4b-dee2-8d87-ec8f-283b9b9611b3@kernel.dk>
Date:   Wed, 25 Jul 2018 11:06:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180725074207.6808-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 12:42 AM, Juergen Gross wrote:
> Remove some macros not used anywhere.

Applied, thanks.

-- 
Jens Axboe

