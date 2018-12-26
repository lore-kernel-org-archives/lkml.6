Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA784C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF802173B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLZBfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:35:31 -0500
Received: from mx.socionext.com ([202.248.49.38]:35506 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeLZBfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:35:31 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Dec 2018 10:35:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 71B3C1800F6;
        Wed, 26 Dec 2018 10:35:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 26 Dec 2018 10:35:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C5FE740370;
        Wed, 26 Dec 2018 10:35:28 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A3C9A1205A0;
        Wed, 26 Dec 2018 10:35:28 +0900 (JST)
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
Date:   Wed, 26 Dec 2018 10:35:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2018/11/30 17:31, Stephen Boyd wrote:
>> +       init.num_parents = parents;
>> +       init.parent_names = parent_names;
>> +
>> +       mcm->cname = clk_name;
>> +       mcm->parent = 0;
>> +       mcm->hw.init = &init;
>> +
>> +       clk = clk_register(NULL, &mcm->hw);
>> +       if (IS_ERR(clk))
>> +               goto err_clk;
>> +
>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +       return;
>> +
>> +err_clk:
>> +       kfree(mcm);
>> +err_mcm:
>> +       kfree(parent_names);
>> +}
>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>> +                       m10v_clk_mux_setup);
> 
> Any chance you can use a platform driver?
> 

Excuse me to re-ask you.
Why do you recommend to use a platform driver? Is that current fad?

Thanks
Sugaya Taichi

