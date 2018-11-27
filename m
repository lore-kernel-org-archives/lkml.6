Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA9DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F692208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5Yq8SvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F692208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeK1GjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:39:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35762 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeK1GjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:39:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so21175332ljb.2;
        Tue, 27 Nov 2018 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iouK7MCZWqMyAkyI3JN3bIC6orROKWtH3fkJSktxfYA=;
        b=T5Yq8SvZkun/JGNMbe/GBaEKX/XbUI5BM7/jfB2nyLn7mo517/DKvd+Og+wfvotPT0
         89hAS9CcMTcK03UGVEqNRnEYHgFPO8ZSC7d0Yys5thfpnBPUe+sR/+5FPcvytSNwyHiG
         KAaUogmzwa3r74DcWeTkmJEk94Ge7yqTzFunLYmYnuc6Tb6XI9Diu/uWVYv/1Su5SDZH
         5mPmE38WKLXLVQpcqcDzum01+fHjDgzBTrNgyimLNhLqffJeXCjPJVBu64vvEo6Lqg0S
         pWCel1aMcbx+DtHBvHeXfcB8/e9ogebRp9CZZiNixyNpVjU5PXCImZE/rZfcwDnQxzm0
         RRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iouK7MCZWqMyAkyI3JN3bIC6orROKWtH3fkJSktxfYA=;
        b=dSO4Jc+zmFYLCX7algLN10F7icM2oTNYdHK8pKtXZAR8AuCD/vwKvXjDPFgO51MO5a
         7hIb3ztJ2s8NhOvtdMDf3nKWAAAHU+Tiw7ldQXy/4Fgom59fd14VLne4dcVBpIs3B34F
         Uy9rpbBVyXqoaXYZPyqcZjYYAg1725ZBQhKCJ9WLHctfh4zPIBvLN/ezkEnaHe/WnGTs
         OUejLVXr3IZMqMtL9iaBPnjn+AoAfDSG4Hhi4GHAXU8yz6khYGtFnCteYaNCk5gBkASd
         0vStH61rSqHw6kZNuDvOF1QqVhpJZoQsHF9BBKbAPOYyerf1EgcRa7eWNfKDxcq0J9ZS
         Z4FA==
X-Gm-Message-State: AA+aEWYAdZpaw7Waw+82fzmyFeRQUhr9cVklXlod8/jPBdG1bbLF3kFL
        8lJqVFN12PHoDa+1hRzm2nXcZUwe
X-Google-Smtp-Source: AFSGD/WmyM7/6/PrPlsEv/oIJb9D39+dVCkXiyZZlIbroCO7MP3yo0Uq2dzSmIBF1x6yfFsoFcNxjg==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr20263211ljf.47.1543347610615;
        Tue, 27 Nov 2018 11:40:10 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.googlemail.com with ESMTPSA id b22sm803281lfg.32.2018.11.27.11.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 11:40:09 -0800 (PST)
Subject: Re: [PATCH V2] clk: tegra: Return the exact clock rate from
 clk_round_rate
To:     Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Robert Yang <decatf@gmail.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180925214940.15188-1-decatf@gmail.com>
 <153973003125.5275.211113451006447179@swboyd.mtv.corp.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <00e78319-7d97-e57e-9450-7e3ab7707ed8@gmail.com>
Date:   Tue, 27 Nov 2018 22:40:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <153973003125.5275.211113451006447179@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2018 1:47, Stephen Boyd wrote:
> Quoting Robert Yang (2018-09-25 14:49:40)
>> The current behavior is that clk_round_rate would return the same clock
>> rate passed to it for valid PLL configurations. This change will return
>> the exact rate the PLL will provide in accordance with clk API.
>>
>> Signed-off-by: Robert Yang <decatf@gmail.com>
>> ---
> 
> I'm waiting for someone from Nvidia/Tegra background to review this
> change.
> 

Apparently Peter is taking a pause. I think Thierry's ACK to V1 should be still valid here.

Also, if this helps:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
