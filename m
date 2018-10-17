Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA8B2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYBdfRPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA8B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJQUKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:10:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33343 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:10:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id o21-v6so19627406lfe.0;
        Wed, 17 Oct 2018 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfgQ5QmqUMbZbWVYaiVLjgyar1JwKAYkP4nRpwCXNuQ=;
        b=nYBdfRPnHtO+pAGE78TuoRnY/ApRjm2SaU5782hYdOGazOuoDzDJMEpivvmpz41MTX
         vMC0M/VLoOb+dBasaBMGYLoacdpnoxQKzfy/bK+d3jGewgDYVov1Eqy5KrhBTMCL7bSH
         uK0odYRSRjZZCtLDrYfjaKtwp0YtN5IgWKEtVLbtJoTkg6WsaYWU2UH918F1UdAFIUQw
         yAcsT97vsPibXofaBIET989K5aHTBDyvXZMGxQjIPb1vldzJGUTNDKsXDHOkS54p4HOm
         QTGWcvRVoyckxZhh967HewoSCqP8bI/lsdcJiRVSoEnur1vIr0+IIIlZ7fm4d9zwbCUS
         LvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfgQ5QmqUMbZbWVYaiVLjgyar1JwKAYkP4nRpwCXNuQ=;
        b=bknyYXMeuMQaS172sYwvH+akNlVJdrHqrnkMFyw49fhNLguUxn5KsIo+41saLfKAZ9
         DSrFYMYxvWYG+gBkPINJdycrfUvGK/1UxK7PB6v1RQF3FhTfaWIQi76n764uVUFB9H/h
         kgo8bcVxLfW1pIWvJIkvKhPkDkLWZ5GYTtPgARx5F92f5+zDSE6PxJNfQ4UVO23R/tcG
         p4F9O6N2XmD0Dxalsc2qd+HjvSIOEFW7NTZoYGgSj/YRKqiQlNG24sgO8cQbYtVVy3Yz
         MgeQ7csftgdnGXtUi0Kl750f1UWcyvTVYJwRBzUT4a/w7oDSlVPhfNPB9Imy6rCCVt5J
         LSCA==
X-Gm-Message-State: ABuFfohYdj1EytMtwCp7Pg+Bol5A3/JsE5cqnvSNsC10HJ7M8wuBxsLT
        DXS02z2zF8msczxhovKIW38BtOMJ
X-Google-Smtp-Source: ACcGV61bNDc67wigdtBN2ziB6GmDmI7N3x8hq4pSJJc5Re7DRNX1ooXKUe5mhP6ERN8rYIBDeFHAzA==
X-Received: by 2002:a19:6f0a:: with SMTP id k10-v6mr16229160lfc.8.1539778488244;
        Wed, 17 Oct 2018 05:14:48 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id s11-v6sm4029377ljj.93.2018.10.17.05.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:14:47 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] clk: tegra: Add more rates to Tegra30 PLLX
 frequency table
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180830192045.11017-1-digetx@gmail.com>
 <20180830192045.11017-3-digetx@gmail.com>
 <1c4e20b2-9929-b163-b371-b32596b6189a@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <35dfef13-efaf-ec27-29b3-1b2a59ffcf28@gmail.com>
Date:   Wed, 17 Oct 2018 15:14:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1c4e20b2-9929-b163-b371-b32596b6189a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 11:59 AM, Jon Hunter wrote:
> 
> On 30/08/2018 20:20, Dmitry Osipenko wrote:
>> Add more predefined rates to the PLLX table, allowing to lower the rate
>> down to 312MHz. This gives more variations of frequency selection to the
>> CPUFREQ driver.
> 
> If these tables are pulled from some other NVIDIA kernel or a particular
> document, I always like to see a reference to where these came from so
> we can always refer back to them.

They are duplicates of T20 tables. But now this patch isn't actual and should be dropped because we will use other tables in the next iteration of the CPUFreq driver. Other patches still should be actual.
