Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E34920878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E34920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJBPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:02:06 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:35567 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:02:06 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7FuS-0002yu-GO from Jiada_Wang@mentor.com ; Tue, 02 Oct 2018 01:20:00 -0700
Received: from [172.30.112.170] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 2 Oct 2018 01:19:56 -0700
Subject: Re: [PATCH linux-next 10/10] ASoC: rsnd: Add kctrl to configure dai's
 busif
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20180927051229.18080-1-jiada_wang@mentor.com>
 <87h8iatqrn.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <abc5762e-8128-3a58-46e4-ca0f0072e7c0@mentor.com>
Date:   Tue, 2 Oct 2018 17:19:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8iatqrn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san


On 2018/09/28 9:29, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> ssi0, ssi1, ssi2, ssi3, ssi4 and ssi9 have busif0 to busif7,
>> currently only busif0 is used by all ssi.
>> But tdm split and tdm ex-split mode, which require busif1 to
>> busif7.
>>
>> This patch adds kctrl in ssi for dai-link, to make it possible
>> to configure the busif used by each dai-link.
>> Also adds rsnd_dma_addr_update() interface to make it possible
>> to update dma data address when there is change in condition
>> of dai connection.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> Do we really need to select BUSIF number by kctrl ??
> In other words, does *all* user need to know detail of SSI BUSIF connection ?
> I think it should be selected automatically somehow.
after some reconsideration, I think selection of BUSIF can be done 
automatically.

BUSIF other than 0 is only necessary when SSI works in TDM 
Split/Ex-Split mode.
but currently rcar audio doesn't support these modes,
I am planning in v2 update, add a dummy BUSIF selection function,
which only selects busif0 for now

Thanks,
Jiada


