Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B5DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EDE2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JUy7xZ1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EDE2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLDTda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:33:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37750 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:33:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so17196609wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=U1ZYP6oYAAntHDYYsujvmJKRg1jgOj9qNI/7yXapawo=;
        b=JUy7xZ1y+ZHjNaY0AH8j9gg20kS6LbUmskvJBrXKCzG+yEqOH20s+A3rbBaoDFf3sI
         QcNN5/ify7QgiMjC1CSNSqpCoX21B0qwZLyQAXE/LwUXkv2OiGocZ2owihJBOtD5d11P
         UDs35/bUhcrsK6pKE+ubYJayEPTOoHM21HJXiJtfsMA1p0RX634H0ygbfKbHC8v8BwTA
         ztTlRagwwjr36ER4swjGaRRpelwQJM+UPMTAem7zv/lqigCDvR2MCoTQqBa+uNZo9atM
         OQHwB9XpQzr1f3eF2UgJyLC8TepoLU3HkLqtMUXeYTDLmUvrBrSCmLM3U7IN3jefW4hq
         0Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=U1ZYP6oYAAntHDYYsujvmJKRg1jgOj9qNI/7yXapawo=;
        b=HFFQY6gWGOyGAwPycK6Z9eCYcM2+U/D8brrBD6yqUYdy8upklI8fxfMThLKAw3sCeD
         /nHlonSsqYWYrM3sOqSuSj747jbjhKCixFu4VR3Qu1QFj+xriXTorQPs1S2plINMlHK2
         rpNoNcA8MlZF24pKjDO1nObVgZ0Wfuqydvm+BugkBrT6Jd7N30Ul273JthFVoZSDS/TG
         F1aelae/OO4Nh2lffFeU9vCsLP2pNMjy0PwA75Cw5XJaJaklTPOF/ulLMtLuflV+dio+
         KjgGJq9iOtlR5cl/q63rXIfOjDZ0nNEGWjgmB8MBrTJ1yCYz2huN+OT3FhqN7z+3Lqc1
         D8iw==
X-Gm-Message-State: AA+aEWYQpDD5kZ00wUmOAPWk0gAPTMpAMk20TbIDttnGRp8qsj/xlbo3
        trCIvNP/4vdtHzJSxgn/klQUbQ==
X-Google-Smtp-Source: AFSGD/X7r16gWudQW2YVxqV2zTsyBJntvrarll+US+93cB8FRkbTvOLXkx+FFZAWkdJo+Ni5nyeP/A==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr4659731wrt.241.1543952007805;
        Tue, 04 Dec 2018 11:33:27 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:cb1d:4ce:ea00:457b:c7f4:7108:f8c4])
        by smtp.gmail.com with ESMTPSA id z17sm15702072wrv.2.2018.12.04.11.33.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 11:33:27 -0800 (PST)
Message-ID: <5C06D686.50108@baylibre.com>
Date:   Tue, 04 Dec 2018 20:33:26 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Stephen Boyd <sboyd@kernel.org>, jbrunet@baylibre.com
CC:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson-gxbb: switch video clocks mux tables to static
References: <20181204125839.14505-1-narmstrong@baylibre.com> <154394543049.88331.11854270462393390489@swboyd.mtv.corp.google.com>
In-Reply-To: <154394543049.88331.11854270462393390489@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le 04/12/2018 18:43, Stephen Boyd a écrit :
> Quoting Neil Armstrong (2018-12-04 04:58:39)
>> Makes the following sparse warnings silent:
>> drivers/clk/meson/vid-pll-div.c:58:26: warning: symbol '_get_table_val' was not declared. Should it be static?
>> drivers/clk/meson/gxbb.c:1585:12: warning: symbol 'gxbb_vid_pll_parent_names' was not declared. Should it be static?
>> drivers/clk/meson/gxbb.c:1620:12: warning: symbol 'gxbb_vclk_parent_names' was not declared. Should it be static?
>> drivers/clk/meson/gxbb.c:1980:12: warning: symbol 'gxbb_cts_parent_names' was not declared. Should it be static?
>> drivers/clk/meson/gxbb.c:2036:12: warning: symbol 'gxbb_cts_hdmi_tx_parent_names' was not declared. Should it be static?
> 
> I fixed all of these already in the patch I sent you.

Sorry I misunderstood...


> 
>> @@ -1983,7 +1983,7 @@ static struct clk_fixed_factor gxbb_vclk2_div12 = {
>>  };
>>  
>>  static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> 
> I was talking about this mux_table_cts_sel array. Can this be const?
> 

Other mux tables aren't const, Jerome so you see a reason why they aren't const ?

Neil
