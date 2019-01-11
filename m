Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2366C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129F2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f/XbIiUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfAKAPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:15:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38130 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfAKAPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:15:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so6071646pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lrRYkQOX8oabBI7evmXJhlETKhOiCG5tJ57nJBVZseI=;
        b=f/XbIiUg+sKbMwHVCYO1u5rTsudsHeZsgVXAtIuG8QXpvvdyWs1xIDFJIEgnr7cq27
         vPbOApd2jwWdwhMSW6K53xmOkKq85kwxm5VCzRIRRxAKWM+ZvbHx8G9Uv/YvA7HTxuCK
         qRrv6fJCITronI4nz8ipRMrXhCi8E1WXqczyqZHC8B5fggZZphKkiMwt2FAauHQ/jYCE
         n2jrMeljN05Z0/GL3zQfiexo75lPpbvH39zNeAMBDv8bqE2MH0tSAIIKvriy0Rg/lOxN
         UwQkCj61ACmlHSwWoJ2lnkQeDhXaOq2DHlIsIerp5NDpqa+MhQuC4qLWd1J+Jp6L+zVw
         HGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lrRYkQOX8oabBI7evmXJhlETKhOiCG5tJ57nJBVZseI=;
        b=evb7KSPetuqMOu2o+PfSTz8S87M5LxHW5JTJdcxEBvboQYUhvByFXXjY4+gbaznQPs
         RMYYuAOXSrp7qFiK9Vk7FhntrxLG2SlYDx8tpTt5jXynPmS0zD/Trx9SVeFqYN5yodEU
         vqhsiyTqKyEEYsMkN27ilXloGOTUiER2ocbHLTJapWzVPfieVnA0hXivkxzF3QJhdmPB
         pG80W6zUGXTgKBRUSH3Aor2l3QiB6qbJsbRwHFqs56WsOzcJo61oZfuk0j37xmvWqy3a
         dP211vTEGSZLT7cxQmgpxdsEu6MGuA3E5Q0760Z8r/uKiJril3PFg+Mlzpr8W6rl/+I2
         30sA==
X-Gm-Message-State: AJcUukcQusBBi7c29Y/XJy7FeH6VlXr4Y1lY+iak09cjQjQKAHltzJCG
        XWbKTKqLfMlSvtdQIdupkma4dQ==
X-Google-Smtp-Source: ALg8bN53KR6/M8+Mt+5jqUyjitraKHDVbewmPsYnLuVNvTwlPDbyhBscf+tOeAMebs9YqWXTlpBzZg==
X-Received: by 2002:a63:9809:: with SMTP id q9mr11371259pgd.109.1547165708097;
        Thu, 10 Jan 2019 16:15:08 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id i5sm19828838pfg.34.2019.01.10.16.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:15:07 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound card
In-Reply-To: <6770759de6ed04ecabaa163eb550769d43dfc901.camel@baylibre.com>
References: <20180828122735.28919-1-jbrunet@baylibre.com> <7hmusmvw6z.fsf@baylibre.com> <6770759de6ed04ecabaa163eb550769d43dfc901.camel@baylibre.com>
Date:   Thu, 10 Jan 2019 16:15:06 -0800
Message-ID: <7htvigqcc5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Wed, 2018-09-12 at 21:49 -0700, Kevin Hilman wrote:
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>> 
>> > Compile the necessary drivers as modules, including codecs, for the
>> > s400 sound card.
>> > 
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> 
>> Applied to v4.20/defconfig.
>
> Hi Kevin,
>
> This patch was supposed to be merged for v4.20 but I'm still not seing it in
> the 5.0-rc1
>
> Could you tell me if there is a problem with it ?

No problem with the patch, just a problem with the maintainer.  Not sure
how/why this one slipped through the cracks.

Thanks for the ping, just sent a request to have it merge for v5.0-rc.

Kevin

