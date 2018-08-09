Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE69C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA5721EB5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="s/glamRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA5721EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeHISnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:43:41 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45689 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbeHISnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:43:41 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so5187840iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SiJv7niuptIX5D5fvHTS9xl2vVxnPUO43bSzg+ckO6A=;
        b=s/glamRVGqrmIKy2xwkXN3M3tiMMNtfiqnbpZCJGUvSTPxUULIrLaaBjfJJvZVNNlv
         oKAYi8JFUJ4cudvyIDdT8vzBL2JkYWW5id3b2CLUc48Mak4QjhZM3z4fgd45NNCyDkSs
         FuX0XUgi8cMPkB7C98QZbUyfNUbSXzbXSGINpTXYC/K3l4Kswi2QPGx9JJ8K2+RIEgU5
         0PCfThhI4yODMyHHssLCK7mTdDUZCZSD4INpkF8I2pNTdr3P+mGkH8mzcr+1LEOf0cxO
         LFt00gpJKA82TncGp1YSoCsZ1S4QQPtzyfFb3ER3bwNjntOK0lcqCxSNRImogr1Vz/70
         WXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SiJv7niuptIX5D5fvHTS9xl2vVxnPUO43bSzg+ckO6A=;
        b=bbsSyNFM4K3bV6qfM1syn/Uwrf1wrLcMJBrl71rs+5UDVfCes5ciXsOf1d3uUmPIb5
         QcY+VECAcUje+yhNwhPKQPz1EWyhh9bVaZdDnElxK5rZqaKa0fsLd+PMjyl/gUoGkj9l
         dgaKGTur1kBZvEkDqSXR7lBZg0a6E1n2ea7dK0nQJx7Lg+Ot/VmXxFrHPgkbxW71jN5x
         MONqgBftjsEJaluD5aBcryOrDWICeIEx5GOVHYHlwAR8y5KgNtSPxnHfufTxfNWoixkv
         LWFkcTFgmlG5D4MBFc5MWD1Psj3qU4CZLO/jh+Y2ukQWgTCOi/XzU4l0yc4BS87ad2CU
         +C3g==
X-Gm-Message-State: AOUpUlFVvtQ+DLgcGLxKwqiubqbEkz0zkw5ygHT4M3HiPGrhaqUniJnY
        NBcYK83NcFWtf60qD5ydYN4QTwo9qdI=
X-Google-Smtp-Source: AA+uWPxVrWTCV2XQWS4RJE6eC4F4SgFq0LpxDwCFa5cmnkip7T3G1b75nxNB6IdjBD/eguSDPJPl7w==
X-Received: by 2002:a6b:a682:: with SMTP id p124-v6mr2364131ioe.267.1533831484709;
        Thu, 09 Aug 2018 09:18:04 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c12-v6sm2162038ioh.2.2018.08.09.09.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 09:18:03 -0700 (PDT)
Subject: Re: [PATCH] block: paride: pd: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180809155446.GA19883@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <159dd22f-d923-3c1c-e7e3-405c67094882@kernel.dk>
Date:   Thu, 9 Aug 2018 10:18:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180809155446.GA19883@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/18 9:54 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied, thanks.

-- 
Jens Axboe

