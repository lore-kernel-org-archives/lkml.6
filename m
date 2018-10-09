Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3BBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AD72077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX9e8Lh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AD72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJIQID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:08:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37122 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:08:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so615507lfa.4;
        Tue, 09 Oct 2018 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M7k23yshEGgl7vee0D6j7xgwN8ewzU7QsWSFCq/7EfQ=;
        b=pX9e8Lh+3UoKdJ2rzU5FfZTFCZ+N3ssKMW9c/A1VjHlgZ+5ebqKnl3lx2c3qk/VgxA
         JqyuT//eSnF3iMr4wQyakBpH/dTyri+GN+411Imw55YQNmazc5hI4Rr6cPKTC78lNMuf
         0Gd6wR5LTQchDFPGH1ju97F/TGTc8wD9uvCEZBzItoYVhV6Kv3lnYkkRjSpiKuqcZYEs
         MsCNORKpXMWpz/U0PGOsotASzdhnsK4uwPiuiu6/4aoYGQjmF1ypWBfGsQkF6uE0p5GQ
         xZOXwAoy7EeuwiCYvUPWMSvZbDaycwUjPs0Gw5VSvymWS3T67LdUbO0IL3ZJlRhXlw0Z
         h40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7k23yshEGgl7vee0D6j7xgwN8ewzU7QsWSFCq/7EfQ=;
        b=Dwh57eZDUWXjrHJFWV1vwsrtpE21nqTzA7pTbNstElM6z1wH6pedbydpFr7Q1O0OXm
         CacchilI2GHFOqDmWlFRnKZz0Pn1/i/aZtrGxFj5PnED8FhahvzHXpsGYRdNuYvdCL8g
         zsQWwCSdKtye3pgcgZfbA5G04qHQd7fuBJxZ3pE2RTJgdQSq3e4KygFEkJadTNpyyavV
         GcDzs/ANmIfYUdombiVZLD8mI6BfeMjxqZZZI6WKY7cCjbixVK+Mz3JI1EoIelOywqt/
         a48WTlxSB4z25ACkOCmSmnnS6ketZ+XVHlAeXUVdDEIJmSYAGOklP6XyDzCWK0mwIYxg
         lXrA==
X-Gm-Message-State: ABuFfohIk4tlO0NFoJa/VkquWvZ6HKSGIR69pvgkDhpWISfZUjA57G+O
        nEWglp73UhczlzQ4OV6B0OXxfWzI
X-Google-Smtp-Source: ACcGV63VlfC5MyjAaxVsuGLp1MXHVeyF7JxSyu0Nk2Di+4pOLBsDw+MxXmeu4hadICyjUPpLbhEWSw==
X-Received: by 2002:a19:d155:: with SMTP id i82-v6mr14556705lfg.127.1539075129621;
        Tue, 09 Oct 2018 01:52:09 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id h87-v6sm2756706lji.9.2018.10.09.01.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 01:52:08 -0700 (PDT)
Subject: Re: [PATCH v1 00/11] Continuing the work on coupled regulators
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181008175835.GJ5662@atomide.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <023bf68a-a909-8cd0-62ca-acc1914556aa@gmail.com>
Date:   Tue, 9 Oct 2018 11:52:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008175835.GJ5662@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 8:58 PM, Tony Lindgren wrote:
> * Dmitry Osipenko <digetx@gmail.com> [181005 15:43]:
>> 1. Re-worked the original "Add voltage balancing mechanism" patch from
>>    Maciej by:
>>         1) Fixing infinite loop within regulator_balance_voltage().
>>         2) Handling suspend_state_t properly.
>>         3) Fixing broken compilation of the patch.
> 
> Thanks for fixing these, this series no longer hangs for me
> on beagle-x15.

Thank you very much for testing once again!
