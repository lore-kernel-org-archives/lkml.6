Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE71C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRtjWXDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC64820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbeGSOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:32:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38635 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:32:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so3690128pls.5;
        Thu, 19 Jul 2018 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WPrW7DOwPWR+JBnMfGE8j4e1SLB+96g5kPWfdkhAX2I=;
        b=nRtjWXDVZmLE5Pe02JsdEifEHqSI1xfTaZAjHAvsfcCnvI0fr8DXMkXRMZFtWDosMZ
         qLzMjAbapg2U2Q9G74DVGJkir85gJj4fr56i7hnMOrDi8Lpx18ne74oZMNqzARP3dnSk
         r+5+X7UK4aCrhnpUdm76amhogLMsYcOrlhlUToPjB7sTI6P5eyPxo34IhKoBQ6v2sVhu
         QgDCJ8jggJ2W4YaoccBKWu4CP9LCBUajFqKEDIHqNc1cQ1EXqpSimzVjRPSlcfqypHg4
         QZCLTx2RJDIHvLKatYSl3xIXLNdOMRDJe6MiZBQ2pWFHQnmQHH9MDxE4XGCvBQPd2M0A
         motw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPrW7DOwPWR+JBnMfGE8j4e1SLB+96g5kPWfdkhAX2I=;
        b=YWz9LKL0BNfkpFVQwHtryIXHs0KCS2ioLl7Ah8A00f7Bc48WTuYzv60Q21qxczwptE
         UFwdYA036XYeRvYs8p4lG7C02x/phM6YCpq33ljpgiHV5o8BTRZJq9Roa6+HQP8cuD7N
         elxX23IZeVUC8bDNxd4VAxfNfb2yeJgK/V3g6YM01NFPCBaD2tz+XiLgSuiCHeezp3Pt
         gSK3OP1cBZgGHFjH7svohsflLJw5l7xC47hy7Xr/kjYoGm92CqlgOq79N2wARPUEpsd8
         XG8tvAIYXLl29Ehw2eSrXrIMZQBqicgeEg9YqIFPGmphZ+25oHlhkwetTS4zNI3WBTbX
         m0yw==
X-Gm-Message-State: AOUpUlFFhPnCQopzWuTp6yVUj87HPl7XjCh2kHb0uQK/ambewHkOdj9m
        sUeRPbSC1sfXU9bBRcp4kts=
X-Google-Smtp-Source: AAOMgpcxMiSwrS2Qge3aOo2wRfUe4Ql3DxwKWuQmIfOdz3m28qHAiqM2+N29NRHoGNsZWyS/bjlngA==
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12-v6mr10161971plm.253.1532008172074;
        Thu, 19 Jul 2018 06:49:32 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id v82-v6sm20502214pfd.64.2018.07.19.06.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:49:31 -0700 (PDT)
Subject: Re: [PATCH V4 net-next 2/3] tcp: Add tcp_retransmit_stamp() helper
 routine
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180719011444.4694-3-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <dc623e0c-e624-c514-b297-5b7f24dcd984@gmail.com>
Date:   Thu, 19 Jul 2018 06:49:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180719011444.4694-3-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/18/2018 06:14 PM, Jon Maxwell wrote:
> Create a seperate helper routine as per Neal Cardwells suggestion. To
> be used by the final commit in this series and retransmits_timed_out().
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>


Signed-off-by: Eric Dumazet <edumazet@google.com>

