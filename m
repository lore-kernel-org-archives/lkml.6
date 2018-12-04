Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D7BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298292082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298292082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeLDIYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:24:33 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:39507 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:24:33 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gU60K-0006gI-BV from Jiada_Wang@mentor.com ; Tue, 04 Dec 2018 00:24:28 -0800
Received: from [172.30.112.76] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec
 2018 00:24:24 -0800
Subject: Re: [PATCH linux-next v2 0/6] clk: renesas: adg: add AVB Clock
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20181203112200.18220-1-jiada_wang@mentor.com>
 <d63c751b-fab4-cf88-459e-efe5a3e83da4@mentor.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <fb9fee84-7508-03dc-c1e7-30de3d2ee958@mentor.com>
Date:   Tue, 4 Dec 2018 17:24:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d63c751b-fab4-cf88-459e-efe5a3e83da4@mentor.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir

Thanks for your comments

On 2018/12/03 21:11, Vladimir Zapolskiy wrote:
> Hi Jiada,
>
> On 12/03/2018 01:21 PM, jiada_wang@mentor.com wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> on R-Car SoCs there are AVB Counter Clocks, each clock has 12bits integral
>> and 8 bits fractional dividers which operates with S0D1ϕ clock.
>>
>> This patch-set adds 'adg' clock to R-Car Soc, and changes adg driver to
>> register avb clocks when clock-cells of rcar_sound node is 2.
>>
>> ---
>> v2:
>> - expends adg register size and register avb clocks instead of
>>    add new clk-avb driver
>> - Add adg clock
>>
>> v1: initial version
>>
>> Jiada Wang (2):
>>    dt-bindings: clock: add clock id for renesas adg clocks
>>    ASoC: rsnd: add avb clocks
>>
>> Takeshi Kihara (4):
>>    clk: renesas: r8a7795: Add ADG clock
>>    clk: renesas: r8a7796: Add ADG clock
>>    clk: renesas: r8a77990: Add ADG clocks
>>    clk: renesas: r8a77995: Add ADG clock
>>
> plural 'clocks' for r8a77990 vs. 'clock' in other cases, please unify subjects.
>
> You can consider to add the ADG clock description for r8a77965 / M3-N as well.
will unify the subjects and add ADG clock to r8a77965 in next version
>>   drivers/clk/renesas/r8a7795-cpg-mssr.c  |   1 +
>>   drivers/clk/renesas/r8a7796-cpg-mssr.c  |   1 +
>>   drivers/clk/renesas/r8a77990-cpg-mssr.c |   1 +
>>   drivers/clk/renesas/r8a77995-cpg-mssr.c |   1 +
>>   include/dt-bindings/clock/renesas-adg.h |  11 +
> The new header file added above is not needed in my opinion.
>
>>   sound/soc/sh/rcar/adg.c                 | 306 +++++++++++++++++++++++-
>>   sound/soc/sh/rcar/gen.c                 |   9 +
>>   sound/soc/sh/rcar/rsnd.h                |   9 +
>>   8 files changed, 330 insertions(+), 9 deletions(-)
>>   create mode 100644 include/dt-bindings/clock/renesas-adg.h
>>
> --
> Best wishes,
> Vladimir

