Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeGaG7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:59:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbeGaG7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:59:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15CC7A9;
        Mon, 30 Jul 2018 22:21:08 -0700 (PDT)
Received: from mail-io0-f175.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFD483F5D0;
        Mon, 30 Jul 2018 22:21:08 -0700 (PDT)
Received: by mail-io0-f175.google.com with SMTP id l7-v6so11913448ioj.1;
        Mon, 30 Jul 2018 22:21:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlFfA1gIzJOERLpO4SN85eG7TqOgqKcJAKfDBPLRFp4bekkX0IEK
        0PXG5vGMvuZLZWIQXNzRds9GMaZWYTS9l8rJ/gc=
X-Google-Smtp-Source: AAOMgpdXrxsaSZkMXXcLHeQMF1OL5n22bcCZkbp2aGBU8kzf+IpRaifYSxT7PSQx0ZMl9PINQLQBDhc2COwGlCWW8pc=
X-Received: by 2002:a6b:2381:: with SMTP id j123-v6mr16722162ioj.251.1533014468067;
 Mon, 30 Jul 2018 22:21:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:88b8:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 22:21:07
 -0700 (PDT)
In-Reply-To: <20180730114056.GA17362@e107155-lin>
References: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
 <153270946725.48062.11195853363758024681@swboyd.mtv.corp.google.com>
 <CADGdYn5T2-B2UE9DX3wFHdvqfF85n0NAbKDBf2KHOQreRi=H+g@mail.gmail.com> <20180730114056.GA17362@e107155-lin>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Tue, 31 Jul 2018 10:51:07 +0530
X-Gmail-Original-Message-ID: <CADGdYn4RDqoNdTnj-975S4GhSkO7Nk75z0h5oJXqo5qdK0zC+g@mail.gmail.com>
Message-ID: <CADGdYn4RDqoNdTnj-975S4GhSkO7Nk75z0h5oJXqo5qdK0zC+g@mail.gmail.com>
Subject: Re: [PATCH] clk: scmi: Fix the rounding of clock rate
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 5:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Mon, Jul 30, 2018 at 11:03:51AM +0530, Amit Daniel Kachhap wrote:
>> Hi,
>>
>> On Fri, Jul 27, 2018 at 10:07 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>> > Quoting Amit Daniel Kachhap (2018-07-27 07:01:52)
>> >> This fix rounds the clock rate properly by using quotient and not
>> >> remainder in the calculation. This issue was found while testing HDMI
>> >> in the Juno platform.
>> >>
>> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> >
>> > Any Fixes: tag here?
>> Yes, This patch is tested with Linux v4.18-rc6 tag.
>>
>
> No Stephen meant the commit that this fixes, something like below:
>
> Fixes: 6d6a1d82eaef ("clk: add support for clocks provided by SCMI")
>
> so that it can get backported if required.

ok my mistake. Thanks for the clarification.

>
> --
> Regards,
> Sudeep
