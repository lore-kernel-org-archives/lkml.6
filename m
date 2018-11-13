Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF97C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39913216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mPGSuz4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39913216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbeKNCkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:40:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbeKNCkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:40:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id u5-v6so8788183wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=Q9pmRdrIsN1EQcBJ1plK2T6f3OE7mZTtAuqHZPWCbro=;
        b=mPGSuz4CxHBzasLe784ZLip0AEr2Vno5rXdwOimjrdTmcf7BWrEJ+wOiw5BX3FUhEo
         c9Gdy4mL4YnC6mKVQJGIlIqUFrYR088Bjy/C60gkf6nm/Ql/BvqShVEGWTxiRRao/rVz
         e+qci6h7fAEdb/7whw0no3jDzDs06ZtlEaKKQmtILZjuI9/fHwJXCQQ31t2pMsv9xmEY
         N76GQa7x/OkyT3XUjoGgsZc9MuUdz3AUesJZulYHQjb8BCrv+tb2bJepwFNzIvtFpUUf
         TfRJGD3+IEiAGnknQdhmH1gPhZ6PtEYOTn//pyaSgHBbqcM99qPgMyfgf+3KWxTAEKyj
         wxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=Q9pmRdrIsN1EQcBJ1plK2T6f3OE7mZTtAuqHZPWCbro=;
        b=MsgvEFKSeFhvGz0fNcssXg1SWbJDIqxr1B68OzuZzqu2PluRkwNxGxSzdD6W5iuOc8
         hzqY4uWXimMt2YyY5FImyHpMWqSy8xHQqJvlupMb64y2my5RRYFIhDQGtczAGX7vY6Y1
         g1nj6OCWh+vRS4hs1Itsriq1w4byfM4I+5CRQgdf4zDxmWQ3a7I1eEVu01Byn50w9j5i
         2mQ+GiPw+JsPm9+76f44sTgvDqGidfOCzQxkNnLvv7blt7qFjMDO8M4/sMfNQZd0BgTW
         hr0atcF7C7euzqqRJRtstbp//0fqXsUp10Ypk0T3tDC4jeqZx8q4lL3sUSYWQEmTX1O+
         VZeg==
X-Gm-Message-State: AGRZ1gKb+YqleD6a/+eryuP/G5nV3W9s19EMuJhRCuLdsK8OCMEhnY6o
        0b7TGAbM5hsQgN+BBLWW65kE6A==
X-Google-Smtp-Source: AJdET5coMDnm7xxvJ72SHUvMJa8sB+lkfwwx7v+vTUTyIKV3bMe0jYaH4gHXhO9DTSGv6MxvUHg2eA==
X-Received: by 2002:a5d:6204:: with SMTP id y4-v6mr5730310wru.105.1542127271298;
        Tue, 13 Nov 2018 08:41:11 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:cb1d:4ce:ea00:2c41:ee84:3757:1dd3])
        by smtp.gmail.com with ESMTPSA id h9-v6sm28697866wrw.90.2018.11.13.08.41.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 08:41:10 -0800 (PST)
Message-ID: <5BEAFEA5.6060902@baylibre.com>
Date:   Tue, 13 Nov 2018 17:41:09 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     stable@vger.kernel.org
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
References: <20181105230820.3562-1-jbrunet@baylibre.com> <5BEAFE05.9070905@baylibre.com>
In-Reply-To: <5BEAFE05.9070905@baylibre.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/11/2018 17:38, Neil Armstrong a écrit :
> Hi Stable team,
> 
> Le 06/11/2018 00:08, Jerome Brunet a écrit :
>> From: Christian Hewitt <christianshewitt@gmail.com>
>>
>> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
>> with reboot; e.g. a ~60 second delay between issuing reboot and the
>> board power cycling (and in some OS configurations reboot will fail
>> and require manual power cycling).
>>
>> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
>> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
>> Co-Processor seems to depend on FCLK_DIV3 being operational.
>>
>> Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
>> meson: add fdiv clock gates"), this clock was modeled and left on by
>> the bootloader.
>>
>> We don't have precise documentation about the SCPI Co-Processor and
>> its clock requirement so we are learning things the hard way.
>>
>> Marking this clock as critical solves the problem but it should not
>> be viewed as final solution. Ideally, the SCPI driver should claim
>> these clocks. We also depends on some clock hand-off mechanism
>> making its way to CCF, to make sure the clock stays on between its
>> registration and the SCPI driver probe.
>>
>> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> 
> Could this patch go into the next 4.18 stable release since it hit linus master with commit id e2576c8bdfd462c34b8a46c0084e7c30b0851bf4 ?

I forgot, but it should also go into the next 4.19 stable release aswell.

Neil

> Thanks,
> Neil
> 
>> ---
>>  drivers/clk/meson/gxbb.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>> index 9309cfaaa464..4ada9668fd49 100644
>> --- a/drivers/clk/meson/gxbb.c
>> +++ b/drivers/clk/meson/gxbb.c
>> @@ -506,6 +506,18 @@ static struct clk_regmap gxbb_fclk_div3 = {
>>  		.ops = &clk_regmap_gate_ops,
>>  		.parent_names = (const char *[]){ "fclk_div3_div" },
>>  		.num_parents = 1,
>> +		/*
>> +		 * FIXME:
>> +		 * This clock, as fdiv2, is used by the SCPI FW and is required
>> +		 * by the platform to operate correctly.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) The SCPI generic driver claims and enable all the clocks
>> +		 *    it needs
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_IS_CRITICAL,
>>  	},
>>  };
>>  
>>
